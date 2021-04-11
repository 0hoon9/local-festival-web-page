package com.project.service;

import java.util.ArrayList;

import com.project.domain.FavoriteVO;

public interface FavoriteService {
	
	// 즐겨찾기 등록을 위한 메서드
	public String register_favorite_service(FavoriteVO fv);
	
	// 즐겨찾기 읽어오기 위한 메서드
	public ArrayList<FavoriteVO> read_favorite_service(String user_id);
	
	// 즐겨찾기 삭제를 위한 메서드
	public void delete_favorite_service(FavoriteVO fv);
	
	// 페이징을 위해 즐겨찾기 갯수 반환 메서드
	public int for_paging_service(String user_id);

}
