package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.domain.RecommendVO;
import com.project.mapper.AdminMapper;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService{
	
	private AdminMapper mapper;

	@Override
	public void insert(AdminVO board) {
		mapper.insert(board);
	}
	
	public List<AdminVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}
	
	@Override
	public int countList() {
		return mapper.countList();
	}
	
	@Override
	public AdminVO selectOne(Long bnum) {
		return mapper.selectOne(bnum);
	}

	@Override
	public void update(AdminVO board) {
		mapper.update(board);
	}

	@Override
	public List<AdminVO> removeList() {
		return mapper.removeList();
	}

	@Override
	public void updateY(Long bnum) {
		mapper.updateY(bnum);
	}

	@Override
	public void updateN(Long bnum) {
		mapper.updateN(bnum);
	}
	
	@Override
	public void delete(Long bnum) {
		mapper.delete(bnum);
	}

	@Override
	public boolean plusCnt(Long bnum) {
		return mapper.plusCnt(bnum);
	}

	@Override
	public void rec_insert(RecommendVO rec) {
		mapper.rec_insert(rec);
	}

	@Override
	public int rec_count(Long bnum) {
		return mapper.rec_count(bnum);
	}

	@Override
	public void deleteRec(Long bnum) {
		mapper.deleteRec(bnum);
	}

	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri); 
	}


}
