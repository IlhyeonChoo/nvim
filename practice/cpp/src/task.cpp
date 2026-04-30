#include "task.hpp"

#include <algorithm>
#include <cctype>
#include <limits>

namespace nevipractice {
namespace {

char ToUpperAscii(unsigned char ch) {
  // 연습 키: std::toupper 위에서 K로 문서 hover, gd로 선언 이동을 시도한다.
  return static_cast<char>(std::toupper(ch));
}

bool HasTag(const Task& task, std::string_view tag) {
  // 연습 키: task.tags 위에서 completion을 확인하고 gr로 tags 필드 참조를 본다.
  return std::find(task.tags.begin(), task.tags.end(), tag) != task.tags.end();
}

}  // namespace

std::string PriorityName(Priority priority) {
  // 연습 키: switch 블록을 접고 펼치며 Treesitter 기반 구조 이동을 연습한다.
  switch (priority) {
    case Priority::kLow:
      return "low";
    case Priority::kMedium:
      return "medium";
    case Priority::kHigh:
      return "high";
  }
  return "unknown";
}

std::string NormalizeTitle(std::string_view raw_title) {
  // 연습 키: 함수 이름 위에서 <leader>cr rename, K hover, gr references를 확인한다.
  std::string text(raw_title);
  const auto first = std::find_if_not(text.begin(), text.end(), [](unsigned char ch) {
    return std::isspace(ch) != 0;
  });
  const auto last = std::find_if_not(text.rbegin(), text.rend(), [](unsigned char ch) {
    return std::isspace(ch) != 0;
  }).base();

  if (first >= last) {
    return "Untitled task";
  }

  std::string compact(first, last);
  compact.front() = ToUpperAscii(static_cast<unsigned char>(compact.front()));
  return compact;
}

int ScoreTask(const Task& task, int available_minutes) {
  // 연습 키: 이 줄에 <leader>db로 breakpoint를 걸고 <leader>dc로 codelldb 실행을 시작한다.
  // 연습 키: 멈춘 뒤 <leader>dO step over, <leader>di step into, <leader>dw debug hover를 사용한다.
  int score = 0;
  if (task.priority == Priority::kHigh) {
    score += 100;
  } else if (task.priority == Priority::kMedium) {
    score += 50;
  } else {
    score += 10;
  }

  if (task.estimate_minutes <= available_minutes) {
    score += 30;
  } else {
    score -= task.estimate_minutes - available_minutes;
  }

  if (HasTag(task, "refactor")) {
    score += 5;
  }

  // TODO(연습): Python 예제와 비교하면서 중복된 점수 규칙을 정리해 본다.
  return score;
}

const Task* SelectNextTask(const std::vector<Task>& tasks, int available_minutes) {
  // 연습 키: best_task 위에서 K로 타입을 확인하고 <leader>ca로 code action 후보를 본다.
  const Task* best_task = nullptr;
  int best_score = std::numeric_limits<int>::min();

  for (const auto& task : tasks) {
    if (task.done) {
      continue;
    }

    const int current_score = ScoreTask(task, available_minutes);
    if (current_score > best_score) {
      best_task = &task;
      best_score = current_score;
    }
  }

  return best_task;
}

std::vector<Task> BuildSampleTasks() {
  // 연습 키: Task 초기화 항목에서 <Tab> completion과 surround로 따옴표 변경을 연습한다.
  return {
      {"  inspect clangd diagnostics  ", Priority::kHigh, 25, {"cpp", "lsp"}, false},
      {"practice codelldb launch", Priority::kMedium, 45, {"debug"}, false},
      {"write markdown table", Priority::kLow, 15, {"markdown"}, false},
      {"refactor scoring logic", Priority::kHigh, 50, {"refactor"}, false},
  };
}

void InspectDiagnostics() {
  // 이 지역 변수는 clangd warning 이동 연습용이다.
  // 연습 키: warning 위에서 <leader>cd로 line diagnostics를 열고 ]w/[w로 warning 사이를 이동한다.
  int unused_minutes = 42;
}

}  // namespace nevipractice
