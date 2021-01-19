package com.project.mapper;

import java.util.List;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;

public interface MainMapper {
	
	//조회수 순으로 조회하기
	public List<AdminVO> selectCnt();
	
	//추천수 순으로 조회하기
	public List<AdminVO> selectRec();
	
	//각 지역별 데이터 개수(remove='n'인 것만)
	public int areaCnt(String area);
	
	//전체 데이터 조회
	public int getTotalCount(Criteria cri);

}
