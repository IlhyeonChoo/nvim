"""Python DAP의 Launch file 설정으로 실행해 볼 진입점."""

from __future__ import annotations

from .pipeline import build_sample_tasks, format_report, normalize_title, select_next_task, summarize_workload


def main() -> None:
    """샘플 작업을 정리하고 다음 작업을 출력한다."""
    # 연습 키: main 안에서 <leader>db로 breakpoint를 걸고 DAP Launch file을 선택한다.
    tasks = build_sample_tasks()
    for task in tasks:
        # 연습 키: normalize_title 위에서 gd로 구현으로 이동하고, 'a mark 이동으로 돌아온다.
        task.title = normalize_title(task.title)

    next_task = select_next_task(tasks, available_minutes=35)
    summary = summarize_workload(tasks)

    print(format_report(tasks))
    print("")
    print(f"다음 작업: {next_task.label() if next_task else '없음'}")
    print(f"우선순위별 합계: {summary}")


if __name__ == "__main__":
    # 연습 키: 이 줄에서 <leader>dc로 디버그 실행을 시작하거나 <leader>dl로 마지막 실행을 반복한다.
    main()
