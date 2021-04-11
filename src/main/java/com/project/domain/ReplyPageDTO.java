package com.project.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@AllArgsConstructor
@Getter
@ToString
public class ReplyPageDTO {
	// 해당 DTO 사용 안함
	// 페이징은 jsp 페이지에서 전부 진행
	private int replyCnt; // 댓글 숫자
	private List<ReplyVO> list; // 자료 반환용
}
