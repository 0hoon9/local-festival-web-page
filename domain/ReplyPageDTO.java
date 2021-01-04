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
	private int replyCnt; //��� ����
	private List<ReplyVO> list; //��� ���, ���ڵ� �� �迭
}
