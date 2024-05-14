package com.mm.linkflow.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.BoardDao;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.service.service.BoardService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

	private final BoardDao boardDao;
	
	@Override
	public List<BoardCategoryDto> selectBoardType(MemberDto loginUser) {
		return boardDao.selectBoardType(loginUser);
	}

}