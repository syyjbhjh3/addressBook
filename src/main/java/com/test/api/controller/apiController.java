package com.test.api.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.api.entity.AddressBook;
import com.test.api.mapping.Message;
import com.test.api.mapping.Message.StatusEnum;
import com.test.api.repo.AddressBookJpaRepo;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping(value = "/address")
public class apiController {
	
	@Autowired
	private AddressBookJpaRepo repo;
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	@GetMapping("/search")
	public @ResponseBody Message searchAddressBook() throws Exception {
		Message message = new Message();
		
		List<AddressBook> addressBook = repo.findAll();
		message.setStatus(StatusEnum.OK);
        message.setMessage("저장성공");
        message.setData(addressBook);
		
        return message;
	}
	
	@GetMapping("/save")
	public @ResponseBody Message saveAddressBook(HttpServletRequest httpServletRequest) throws Exception {
		Message message = new Message();
		
		try {
			AddressBook addressBook = AddressBook.builder()
									 .no(Long.parseLong(httpServletRequest.getParameter("no").toString()))
									 .name(httpServletRequest.getParameter("name").toString())
									 .age(Integer.parseInt(httpServletRequest.getParameter("age").toString()))
									 .phone_num(httpServletRequest.getParameter("phone_num").toString())
									 .build();		
			repo.save(addressBook);
			message.setStatus(StatusEnum.OK);
	        message.setMessage("수정성공");
		}catch (NumberFormatException e) { // No Null이라 error 발생시
			AddressBook addressBook = AddressBook.builder()
									 .name(httpServletRequest.getParameter("name").toString())
									 .age(Integer.parseInt(httpServletRequest.getParameter("age").toString()))
									 .phone_num(httpServletRequest.getParameter("phone_num").toString())
									 .build();		
			repo.save(addressBook);
			message.setStatus(StatusEnum.OK);
			message.setMessage("등록성공");
		}catch (Exception e) {
			message.setStatus(StatusEnum.INTERNAL_SERER_ERROR);
	        message.setMessage("저장실패");
	        
	        e.printStackTrace();
		}
        return message;
	}

	@GetMapping("/delete")
	public @ResponseBody Message deleteAddressBook(HttpServletRequest httpServletRequest) throws Exception {
		Message message = new Message();
		
		repo.deleteById(Long.parseLong(httpServletRequest.getParameter("no").toString()));
		
		message.setStatus(StatusEnum.OK);
        message.setMessage("삭제");
		return message;
	}
}
