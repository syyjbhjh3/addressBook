package com.test.api.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.test.api.mapping.Message;
import com.test.api.mapping.Message.StatusEnum;
import com.test.api.repo.AddressBookJpaRepo;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;

@Api(tags = {"Order Processing"})
@RequiredArgsConstructor
@RestController
@RequestMapping(value = "/address")
public class apiController {
	
	@Autowired
	private AddressBookJpaRepo repo;
	
	@GetMapping("/")
	public String index() {
		return "index";
	}
	
	@ApiOperation(value = "등록", notes = "등록")
	@GetMapping("/insert")
	public Message insertAddressBook(@ApiParam(value = "등록", required = true) @RequestBody Map<String, String> param) throws Exception {
		Message message = new Message();
		message.setStatus(StatusEnum.OK);
        message.setMessage("등록");
        return message;
	}

	@ApiOperation(value = "수정", notes = "수정")
	@GetMapping("/update")
	public Message updateAddressBook(@ApiParam(value = "수정", required = true) @RequestBody Map<String, String> param) throws Exception {
		Message message = new Message();
		message.setStatus(StatusEnum.OK);
        message.setMessage("수정");
		return message;
	}

	@ApiOperation(value = "삭제", notes = "삭제")
	@GetMapping("/delete")
	public Message deleteAddressBook(@ApiParam(value = "삭제", required = true) @RequestBody Map<String, String> param) throws Exception {
		Message message = new Message();
		message.setStatus(StatusEnum.OK);
        message.setMessage("삭제");
		return message;
	}
}
