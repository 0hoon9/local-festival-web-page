package com.project.mapper;

import java.util.ArrayList;

import com.project.domain.FavoriteVO;
import com.project.domain.ReplyVO;

public interface FavoriteMapper {
	
	// 즐겨찾기 등록을 위한 메서드
	public void register_favorite(FavoriteVO fv);
	
	// 즐겨찾기 중복 확인용 메서드
	public int find_favorite(FavoriteVO fv);
	
	// 즐겨찾기 자료 반환해주는 메서드
	public ArrayList<FavoriteVO> read_favorite(String user_id);
	
	// 즐겨찾기 삭제하는 메서드
	public void delete_favorite(FavoriteVO fv);
	
	// 즐겨찾기 페이징을 위해 즐겨찾기 갯수 세서 반환해주는 메서드
	public int for_paging(String user_id);
	
}
