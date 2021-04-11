package com.project.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.ResponseEntity;

import com.project.domain.Criteria;
import com.project.domain.ReplyVO;

public interface ReplyMapper {
	
	// 댓글 읽어오기 위한 메서드
	public ArrayList<ReplyVO> reply_read(Long bnum);
	
	// 페이징을 위해 댓글을 읽어오는 메서드
	public ArrayList<ReplyVO> reply_read_with_paging(@Param("cri") Criteria cri, @Param("bnum") Long bnum);

	// 댓글 작성을 위한 메서드
	public boolean reply_write(ReplyVO rv);
	
	// 댓글 삭제를 위한 메서드
	public boolean reply_del(Long rnum);
	
	// 글 하나에 달린 댓글 개수 반환 메서드
	public int reply_count(Long bnum);
	
	// 댓글 쓴 사람 찾는 메서드(삭제를 위해 필요)
	public String reply_user_search(Long rnum);
}
