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
	private int replyCnt; //´ñ±Û °¹¼ö
	private List<ReplyVO> list; //´ñ±Û ¸ñ·Ï, ·¹ÄÚµå ÃÑ ¹è¿­
}
