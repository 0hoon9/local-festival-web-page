package com.project.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.project.domain.Criteria;
import com.project.domain.ReplyVO;
import com.project.mapper.MemberMapper;
import com.project.mapper.ReplyMapper;

import lombok.Setter;

@Service
public class ReplyServiceImple implements ReplyService{

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public ArrayList<ReplyVO> reply_read_service(Long bnum) {
		return mapper.reply_read(bnum);
	}
	
	@Override
	public ArrayList<ReplyVO> reply_read_with_paging_service(Criteria cri, Long bnum) {
		return mapper.reply_read_with_paging(cri, bnum);
	}
	
	@Override
	public int reply_count_service(Long bnum) {
		return mapper.reply_count(bnum);
	}

	@Override
	public boolean reply_write_service(ReplyVO rv) {
		return mapper.reply_write(rv);
	}

	@Override
	public boolean reply_del_service(Long rnum) {
		return mapper.reply_del(rnum);
	}

	@Override
	public String reply_user_search_service(Long rnum) {
		return mapper.reply_user_search(rnum);
	}

}
