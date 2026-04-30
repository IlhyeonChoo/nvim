#pragma once

#include <string>
#include <string_view>
#include <vector>

namespace nevipractice {

enum class Priority {
  // 연습 키: 각 enum 값 위에서 K로 hover, gr로 참조 목록을 확인한다.
  kLow,
  kMedium,
  kHigh,
};

struct Task {
  // 연습 키: 필드 이름 위에서 <leader>cr로 rename을 실행하고 task.cpp/main.cpp 참조를 확인한다.
  std::string title;
  Priority priority;
  int estimate_minutes;
  std::vector<std::string> tags;
  bool done = false;
};

// Neogen으로 함수 주석을 다시 생성해 볼 수 있는 선언들이다.
// 연습 키: 함수 선언 위에서 <leader>cD 또는 <leader>cG로 주석 생성을 연습한다.
// 연습 키: 선언 위에서 gd로 구현으로 이동하고, <leader>ch로 header/source 전환을 확인한다.
std::string PriorityName(Priority priority);
std::string NormalizeTitle(std::string_view raw_title);
int ScoreTask(const Task& task, int available_minutes);
const Task* SelectNextTask(const std::vector<Task>& tasks, int available_minutes);
std::vector<Task> BuildSampleTasks();
void InspectDiagnostics();

}  // namespace nevipractice
