package com.project.service;

import java.util.List;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.domain.RecommendVO;

public interface AdminService {
	
	//데이터 생성
	public void insert(AdminVO board);
	
	//삭제여부(remove)가 'n'인 데이터 전체 조회(페이징)
	public List<AdminVO> getListWithPaging(Criteria cri);
	
	//전체 데이터 개수 조회
	public int getTotal(Criteria cri);
	
	//전체 데이터 개수 조회
	public int countList();
	
	//데이터 한개 조회
	public AdminVO selectOne(Long bnum);
	
	//데이터 수정
	public void update(AdminVO board);
	
	//삭제여부(remove)가 'y'인 데이터 전체 조회
	public List<AdminVO> removeList();
	
	//삭제여부(remove)를 'y'로 변경
	public void updateY(Long bnum);
	
	//삭제여부(remove)를 'n'로 변경
	public void updateN(Long bnum);
	
	//데이터 삭제
	public void delete(Long bnum);
	
	//조회수 증가
	public boolean plusCnt(Long bnum);

	//게시글 추천
	public void rec_insert(RecommendVO rec);
	
	//게시글 추천수
	public int rec_count(Long bnum);
	
	//추천 데이터 삭제(게시글 삭제될 때)
	public void deleteRec(Long bnum);

}
