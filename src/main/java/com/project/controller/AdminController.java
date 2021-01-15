package com.project.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.domain.AdminVO;
import com.project.domain.Criteria;
import com.project.domain.PageMaker;
import com.project.domain.RecommendVO;
import com.project.service.AdminService;
import com.project.utils.UploadFileUtils;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/*")
@Slf4j
public class AdminController {
	@Setter(onMethod_=@Autowired)
	private AdminService service;
	
	//@Autowired와 유사
	//빈의 이름를 사용해서 주입할 빈 객체를 찾음(servlet-context.xml에서 설정)
	@Resource(name="uploadPath")
	private String uploadPath;
	
	//관리자페이지 메인
	@GetMapping("/main")
	public void main() {
		log.info("=====관리자 메인페이지=====");
	}
	
	//관리자페이지 데이터등록
	@GetMapping("/board/insert")
	public void insert() {
		log.info("=====관리자 게시글등록 페이지=====");
	}
	
	//관리자페이지 데이터등록
	@PostMapping("/board/insert")
	public String insert2(AdminVO admin, MultipartFile file) throws Exception {
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		//resources폴더에 imgUpload폴더 생성, 파일이 저장될 기본폴더
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		//위의 폴더를 기준으로 연웡일 폴더 생성
		String fileName = null;

		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
		//파일 인풋박스에 첨부된 파일이 있다면(=첨부된 파일 이름이 있다면)
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			admin.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			//파일경로+파일이름 저장
			admin.setThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
			//썸네일파일경로+파일이름 저장
		} else {
			admin.setImg("");
			admin.setThumbImg("");
			//fileName = uploadPath + File.separator + "images" + File.separator + "none.png"
			//이미지 첨부안하면 해당 값이 데이터에 저장
		}

		//파일용 인풋박스에 등록된 파일의 정보를 가져오고, 
		//UploadFileUtils.java를 통해 폴더를 생성한 후 원본 파일과 썸네일을 저장한 뒤, 
		//이 경로를 데이터 베이스에 전달하기 위해 AdminVO에 입력(set)
		System.out.println("admin객체: "+admin);
		System.out.println("파일정보: "+file);
		service.insert(admin);
		//insert.jsp에서 넘어온 데이터를 insert메소드의 파라미터로 전달
		
		log.info("=====관리자 게시글 등록=====");
		
		return "redirect:/admin/board/getList";
		//전체조회페이지로 이동
	}
	
	//ck에디터에서 파일 업로드
	@PostMapping("/admin/ckUpload")
	public void postCKEditorImgUpload(HttpServletResponse res, @RequestParam MultipartFile upload) throws Exception {
	 
		 //랜덤문자 생성
		 UUID uuid = UUID.randomUUID();
		 
		 OutputStream out = null;
		 PrintWriter printWriter = null;
		   
		 //인코딩
		 res.setCharacterEncoding("utf-8");
		 res.setContentType("text/html;charset=utf-8");
		 
		 try {
		  
			  String fileName = upload.getOriginalFilename(); //파일이름 가져오기
			  byte[] bytes = upload.getBytes();
			  
			  //업로드 경로
			  String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uuid + "_" + fileName;
			  //파일명이 똑같을 경우를 대비해 uuid사용
			  
			  //경로에 파일저장
			  out = new FileOutputStream(new File(ckUploadPath));
			  out.write(bytes);
			  out.flush(); //out에 저장된 데이터를 전송하고 초기화
			  
			  String fileUrl = "/ckUpload/" + uuid + "_" + fileName; //파일 업로드했을때 url
			  printWriter = res.getWriter();
			  
			  //업로드시 메시지출력(json형태여야 서버에 전송됨)
			  printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
			  
			  log.info("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
			 
			  printWriter.flush();
			  
			  log.info("=====관리자 게시글 등록(ck에디터에서 파일업로드)=====");
		 } 
		 
		 catch (IOException e) {
			 e.printStackTrace(); 
		 } 
		 
		 finally {
			  try {
			   if(out != null) { out.close(); }
			   if(printWriter != null) { printWriter.close(); }
			  } catch(IOException e) { e.printStackTrace(); }
		 }	 
		 return;
	}
	
	//관리자페이지 삭제여부(remove)가 'n'인 전체데이터 조회(페이징)
	@GetMapping("board/getList")
	public void getList(Model model, Criteria cri) {
		log.info("=====관리자 전체게시글 조회=====");
		log.info("=====현재페이지: "+cri.getPage()+"페이지=====");
		
		//오늘날짜구하기
		Date now = new Date();
		model.addAttribute("now", now);
		log.info("=====오늘날짜: " +now+"=====");
		System.out.println("cri는? "+cri);
		//페이징처리
//		PageMaker pageMaker = new PageMaker();
//	    pageMaker.setCri(cri);
//	    pageMaker.setTotalCount(service.countList()); //총 데이터 개수를 전달
		int total = service.getTotal(cri);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", new PageMaker(cri, total));
	}
	
	//관리자페이지 한개데이터 조회/수정
	@GetMapping({"/board/selectOne", "/board/update"})
	public void selectOne(@RequestParam("bnum") Long bnum, Model model) {
		log.info("=====관리자 "+bnum+"번 게시글 조회/수정=====");
		
		model.addAttribute("board", service.selectOne(bnum));
		//model객체를 이용해 key값 board에 selectOne메소드 저장
		
		service.plusCnt(bnum);
		//조회수+1
	}
	
	//게시글 추천
	@ResponseBody
	@PostMapping("/selectOne/insertRec")
	public void insertRecommend(RecommendVO rec) {
		service.rec_insert(rec);
		
		log.info("=====회원id '"+rec.getUser_id()+"'의 게시글 "+rec.getBnum()+"번 추천=====");
	}
	
	//게시글 추천수
	@ResponseBody
	@GetMapping("/selectOne/countRec")
	public int countRecommend(@RequestParam("bnum") Long bnum) {
		int count = service.rec_count(bnum);
		log.info("=====게시글 "+bnum+"번 추천수:"+count+"=====");
		return count;
	}

	//관리자페이지 데이터수정
	@PostMapping("board/update")
	public String update(AdminVO admin, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, MultipartFile file, HttpServletRequest req) throws Exception {
		
		//새로운 파일이 등록되었는지 확인
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			
		  //기존 파일을 삭제
		  new File(uploadPath + req.getParameter("img")).delete();
		  new File(uploadPath + req.getParameter("thumbImg")).delete();
		  
		  //새로 첨부한 파일을 등록
		  String imgUploadPath = uploadPath + File.separator + "imgUpload";
		  String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		  String fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		  
		  admin.setImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		  admin.setThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		  
		 } else {  //새로운 파일이 등록되지 않았다면
		  //기존 이미지를 그대로 사용
		  admin.setImg(req.getParameter("img"));
		  admin.setThumbImg(req.getParameter("thumbImg"));
		 }
		
		service.update(admin);
		//update.jsp에서 넘어온 데이터를 update메소드의 파라미터로 전달
		
		log.info("=====관리자 게시글 수정=====");
		
		//리다이렉트시 각 정보 포함
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/admin/board/getList";
		//전체조회페이지로 이동
	}
	
	//관리자페이지 삭제여부(remove)가 'y'인 전체데이터 조회
	@GetMapping("board/removeList")
	public void removeList(Model model) {
		log.info("=====관리자 삭제게시글 조회=====");
		model.addAttribute("list", service.removeList());
		//model객체를 이용해 key값 list에 removeList메소드 저장
	}
	
	//관리자페이지 삭제여부를 'y'으로 변경
	@PostMapping("/board/updateY")
	public String updateY(@RequestParam("bnum") Long bnum) {

		service.updateY(bnum);
		//bnum을 이용해서 삭제여부 'y'로 변경
		
		log.info("=====관리자 "+bnum+"번 게시글 삭제여부 'y'로 변경=====");
		
		return "redirect:/admin/board/getList";
		//전체조회페이지로 이동
	}
	
	//관리자페이지 선택한 게시글 삭제여부를 'y'으로 변경
	@ResponseBody
	@PostMapping("/getList/selectDelete")
	public void selectDelete(@RequestParam(value="chbox[]") List<String> chArr, AdminVO admin) {
		
		Long bnum;
		
		for(String i : chArr) {   
			bnum = Long.parseLong(i);
			admin.setBnum(bnum);
			service.updateY(bnum);
			log.info("=====관리자 "+bnum+"번 게시글 삭제여부 'y'로 변경=====");
		}
	}
	
	//관리자페이지 선택한 게시글 삭제여부를 'n'으로 변경(복원)
	@ResponseBody
	@PostMapping("/getList/selectRestore")
	public void selectRestore(@RequestParam(value="chbox[]") List<String> chArr, AdminVO admin) {
		
		Long bnum;
		
		for(String i : chArr) {   
			bnum = Long.parseLong(i);
			admin.setBnum(bnum);
			service.updateN(bnum);
			log.info("=====관리자 "+bnum+"번 게시글 삭제여부 'N'로 변경=====");
		}
	}
	
	//관리자페이지 선택한 게시글 데이터 삭제
	@ResponseBody
	@PostMapping("/getList/selectDelete2")
	public void selectDelete2(@RequestParam(value="chbox[]") List<String> chArr, AdminVO admin) {
		
		Long bnum;
		
		for(String i : chArr) {   
			bnum = Long.parseLong(i);
			admin.setBnum(bnum);
			service.deleteRec(bnum); //게시글의 추천데이터도 삭제
			service.delete(bnum);
			log.info("=====관리자 "+bnum+"번 게시글 삭제=====");
		}

	}
	
	///////////////
	
	//관리자페이지 회원정보 조회
	@GetMapping("/member/memberList")
	public void memberList() {
		
	}
	
	//테스트
	@GetMapping("/test")
	public void test() {
		
	}
}
