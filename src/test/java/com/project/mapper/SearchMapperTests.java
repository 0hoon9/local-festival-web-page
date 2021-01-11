package com.project.mapper;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SearchMapperTests {
	@Setter(onMethod_=@Autowired)
	private AdminMapper mapper;
	
	//@Test
	public void testAdmin() {
		AdminVO admin = new AdminVO();
		admin.setBnum(1L);
		admin.setTitle("제목" );
		admin.setContent("내용");
		admin.setWriter("저자");
		admin.setRegDate(new Date());
		admin.setUpdateDate(new Date());
		admin.setArea("서율");
		admin.setStartDate("2020");
		admin.setEndDate("2020");
		admin.setImg("img");
		admin.setThumbImg("thumb");
		admin.setRemove("n");
		admin.setCnt(0L);
		admin.setStartDate("200101");
		admin.setEndDate("201231");
		mapper.insert(admin);
	}
	
	@Test
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("목");
		
		List<AdminVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
	}
}
