"""Neovim에서 test 탐색과 jump를 연습하기 위한 unittest."""

from __future__ import annotations

import unittest

from nevipractice.models import Priority, Task
from nevipractice.pipeline import normalize_title, select_next_task, summarize_workload


class PipelineTest(unittest.TestCase):
    def test_normalize_title_compacts_spaces(self) -> None:
        # 연습 키: 테스트 이름 위에서 gr로 참조를 확인하고 <leader>cr로 rename을 연습한다.
        self.assertEqual(normalize_title("  practice   lsp  "), "Practice lsp")

    def test_summarize_workload_skips_done_tasks(self) -> None:
        # 연습 키: Priority.HIGH 위에서 gd로 enum 정의로 이동하고 K로 hover를 확인한다.
        tasks = [
            Task("A", Priority.HIGH, 10, [], done=False),
            Task("B", Priority.HIGH, 20, [], done=True),
            Task("C", Priority.LOW, 5, [], done=False),
        ]
        self.assertEqual(summarize_workload(tasks), {Priority.HIGH: 10, Priority.LOW: 5})

    def test_select_next_task_prefers_high_priority(self) -> None:
        # 연습 키: selected 위에서 <leader>ca를 눌러 타입 관련 code action 후보를 확인한다.
        tasks = [
            Task("small", Priority.LOW, 5, []),
            Task("important", Priority.HIGH, 50, ["refactor"]),
        ]
        selected = select_next_task(tasks, available_minutes=20)
        self.assertIsNotNone(selected)
        self.assertEqual(selected.title, "important")


if __name__ == "__main__":
    unittest.main()
