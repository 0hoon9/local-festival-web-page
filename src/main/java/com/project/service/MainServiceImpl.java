package com.project.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.mapper.MainMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor	
public class MainServiceImpl implements MainService {
	
	private MainMapper mapper;

	@Override
	public List<AdminVO> selectCnt() {
		return mapper.selectCnt();
	}

	@Override
	public List<AdminVO> selectRec() {
		return mapper.selectRec();
	}

	@Override
	public int areaCnt(String area) {
		return mapper.areaCnt(area);
	}
	
	@Override
	public int getTotal(Criteria cri) {
		return mapper.getTotalCount(cri); 
	}

}
