package com.project.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.domain.FavoriteVO;
import com.project.mapper.AdminMapper;
import com.project.mapper.FavoriteMapper;
import com.project.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class FavoriteServiceImple implements FavoriteService{
	
	@Setter(onMethod_ = @Autowired)
	private FavoriteMapper mapper;
	
	@Override
	public String register_favorite_service(FavoriteVO fv) {
		if(mapper.find_favorite(fv) != 0) {
			return "fail";
		} else {
			mapper.register_favorite(fv);
			return "success";
		}
	}

	@Override
	public ArrayList<FavoriteVO> read_favorite_service(String user_id) {
		return mapper.read_favorite(user_id);
	}

	@Override
	public void delete_favorite_service(FavoriteVO fv) {
		mapper.delete_favorite(fv);
	}

	@Override
	public int for_paging_service(String user_id) {
		return mapper.for_paging(user_id);
	}
}
