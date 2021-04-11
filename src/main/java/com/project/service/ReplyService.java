package com.project.service;

import java.util.ArrayList;

import org.springframework.http.ResponseEntity;

import com.project.domain.Criteria;
import com.project.domain.ReplyVO;

public interface ReplyService {
	
	// 댓글 읽어오기 위한 메서드
	public ArrayList<ReplyVO> reply_read_service(Long bnum);
	
	// 페이징을 위한 댓글 읽어오기 위한 메서드
	public ArrayList<ReplyVO> reply_read_with_paging_service(Criteria cri, Long bnum);
	
	// 댓글 쓰기를 위한 메서드
	public boolean reply_write_service(ReplyVO rv);
	
	// 댓글 삭제를 위한 메서드
	public boolean reply_del_service(Long rnum);
	
	// 댓글 세기 위한 메서드
	public int reply_count_service(Long bnum);

	// 댓글쓴 사람 찾는 메서드
	public String reply_user_search_service(Long rnum);
	
}
