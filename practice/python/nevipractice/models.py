"""작은 작업 관리 예제로 LSP와 completion을 연습한다."""

from __future__ import annotations

from dataclasses import dataclass
from enum import StrEnum


class Priority(StrEnum):
    """작업 우선순위를 표현한다."""

    # 연습 키: 각 enum 값 위에서 K로 hover, gr로 참조 목록을 확인한다.
    LOW = "low"
    MEDIUM = "medium"
    HIGH = "high"


@dataclass(slots=True)
class Task:
    """Neovim 이동, rename, docstring 생성을 연습하기 좋은 데이터 모델."""

    # 연습 키: 필드 이름 위에서 <leader>cr로 rename을 실행하고 다른 파일의 참조가 바뀌는지 확인한다.
    # 연습 키: title 또는 priority를 입력하다가 <Tab>으로 completion 후보를 확정한다.
    title: str
    priority: Priority
    estimate_minutes: int
    tags: list[str]
    done: bool = False

    def label(self) -> str:
        """상태줄이나 목록에 보여줄 짧은 라벨을 만든다."""
        # 연습 키: done 위에서 gd로 dataclass 필드 정의로 이동하고, 'a mark 이동으로 돌아온다.
        status = "완료" if self.done else "진행"
        return f"[{status}] {self.priority.value.upper()} - {self.title}"

    def is_short(self, limit_minutes: int = 30) -> bool:
        """주어진 시간 안에 끝낼 수 있는 작업인지 확인한다."""
        # 연습 키: limit_minutes 위에서 K로 타입 정보를 확인하고 gK로 signature help를 확인한다.
        return self.estimate_minutes <= limit_minutes
