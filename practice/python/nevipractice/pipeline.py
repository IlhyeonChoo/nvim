"""LSP, DAP, 리팩터링, diagnostics 연습을 위한 작업 처리 코드."""

from __future__ import annotations

from collections import defaultdict

from .models import Priority, Task


def normalize_title(raw_title: str) -> str:
    """제목 양쪽 공백을 줄이고 첫 글자를 대문자로 만든다."""
    # 연습 키: 함수 이름 위에서 gr로 참조를 보고, <leader>cr로 이름을 바꿔 본다.
    compact = " ".join(raw_title.strip().split())
    if not compact:
        return "Untitled task"
    return compact[0].upper() + compact[1:]


def build_sample_tasks() -> list[Task]:
    """디버거와 completion을 연습할 샘플 작업을 만든다."""
    # 연습 키: Task 위에서 gd로 class 정의로 이동하고, K로 생성자 정보를 확인한다.
    return [
        Task("  inspect lazyvim plugins  ", Priority.HIGH, 25, ["nvim", "lsp"]),
        Task("practice python dap", Priority.MEDIUM, 40, ["debug", "python"]),
        Task("write markdown table", Priority.LOW, 15, ["markdown"]),
        Task("refactor repeated scoring", Priority.HIGH, 50, ["refactor"]),
    ]


def summarize_workload(tasks: list[Task]) -> dict[Priority, int]:
    """우선순위별 예상 작업 시간을 합산한다."""
    # 연습 키: summary 위에서 <leader>cr rename, ]d/[d diagnostics 이동을 연습한다.
    summary: dict[Priority, int] = defaultdict(int)
    for task in tasks:
        if not task.done:
            summary[task.priority] += task.estimate_minutes
    return dict(summary)


def score_task(task: Task, available_minutes: int) -> int:
    """중단점을 걸고 한 줄씩 실행하기 좋은 점수 계산 함수."""
    # 연습 키: 이 줄에 <leader>db로 breakpoint를 걸고 <leader>dc로 실행을 시작한다.
    # 연습 키: 멈춘 뒤 <leader>dO step over, <leader>di step into, <leader>dw debug hover를 사용한다.
    score = 0

    if task.priority == Priority.HIGH:
        score += 100
    elif task.priority == Priority.MEDIUM:
        score += 50
    else:
        score += 10

    if task.estimate_minutes <= available_minutes:
        score += 30
    else:
        score -= task.estimate_minutes - available_minutes

    if "refactor" in task.tags:
        score += 5

    # TODO(연습): 우선순위 점수 계산을 별도 함수로 분리해 본다.
    return score


def select_next_task(tasks: list[Task], available_minutes: int) -> Task | None:
    """현재 시간 안에서 가장 먼저 처리할 작업을 고른다."""
    # 연습 키: best_task 위에서 K로 Optional 타입을 확인하고 <leader>ca로 code action 후보를 본다.
    best_task: Task | None = None
    best_score = -1

    for task in tasks:
        if task.done:
            continue

        current_score = score_task(task, available_minutes)
        if current_score > best_score:
            best_task = task
            best_score = current_score

    return best_task


def format_report(tasks: list[Task]) -> str:
    """quickfix, search, surround 연습에 쓸 여러 줄 보고서를 만든다."""
    # 연습 키: 문자열 따옴표 위에서 surround 변경을 연습하고, gr로 label 호출 참조를 확인한다.
    lines = ["Neovim practice task report", ""]
    for task in tasks:
        lines.append(f"- {task.label()} ({task.estimate_minutes}분)")
    return "\n".join(lines)


def diagnostic_examples() -> None:
    """LSP 진단 표시를 일부러 확인하기 위한 함수다.

    이 함수는 기본 실행 흐름에서 호출하지 않는다. 타입 오류 표시,
    hover, diagnostics 이동을 연습할 때 열어 본다.
    """
    # 연습 키: 타입 오류 위치에서 <leader>cd로 line diagnostics를 열고 ]d/[d로 진단 사이를 이동한다.
    estimated_minutes: int = "45"
    print(f"진단 연습용 값: {estimated_minutes}")
