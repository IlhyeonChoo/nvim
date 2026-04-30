#include "task.hpp"

#include <iostream>

int main() {
  // 연습 키: main 첫 줄에 <leader>db로 breakpoint를 걸고 <leader>dc로 실행한다.
  auto tasks = nevipractice::BuildSampleTasks();
  for (auto& task : tasks) {
    // 연습 키: NormalizeTitle 위에서 gd로 구현으로 이동하고 gr로 호출 위치를 확인한다.
    task.title = nevipractice::NormalizeTitle(task.title);
  }

  const nevipractice::Task* next_task = nevipractice::SelectNextTask(tasks, 35);
  for (const auto& task : tasks) {
    // 연습 키: 긴 출력문에서 visual selection과 surround를 연습한다.
    std::cout << "- " << nevipractice::PriorityName(task.priority) << ": " << task.title << " ("
              << task.estimate_minutes << " minutes)\n";
  }

  if (next_task != nullptr) {
    std::cout << "\nNext task: " << next_task->title << "\n";
  }

  return 0;
}
