package com.project.service;

import java.util.List;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;

public interface MainService {
	
		//조회수 순으로 조회하기
		public List<AdminVO> selectCnt();
		
		//추천수 순으로 조회하기
		public List<AdminVO> selectRec();
		
		//각 지역별 데이터 조회
		public List<AdminVO> selectArea(Criteria cri);
		
		//각 지역별 데이터 개수(remove='n'인 것만)
		public int areaCnt(Criteria cri);	
		
		//전체 데이터 개수 조회
		public int getTotal(Criteria cri);


}
