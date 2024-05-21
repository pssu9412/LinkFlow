package com.mm.linkflow.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.mm.linkflow.dto.AttachDto;
import com.mm.linkflow.dto.BoardCategoryDto;
import com.mm.linkflow.dto.BoardDto;
import com.mm.linkflow.dto.MemberDto;
import com.mm.linkflow.dto.PageInfoDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Repository
public class BoardDao {
	
	private final SqlSessionTemplate sqlSession;

	public List<BoardCategoryDto> selectBoardType(MemberDto loginUser) {
		return sqlSession.selectList("boardMapper.selectBoardCategory", loginUser);
	}

	public int selectBoardListCount(String boardType) {
		return sqlSession.selectOne("boardMapper.selectBoardListCount", boardType);
	}
	
	public List<BoardDto> selectNoticeBoardList(String boardType) {
		return sqlSession.selectList("boardMapper.selectNoticeBoardList", boardType);
	}

	public List<BoardDto> selectBoardList(PageInfoDto pi, String boardType) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("boardMapper.selectBoardList", boardType, rowBounds);
	}
	
	public List<BoardDto> selectNewNoticeList() {
		
		RowBounds rowBounds= new RowBounds( 0, 5 );
		
		return sqlSession.selectList("boardMapper.selectBoardList", "CATEGORY-8", rowBounds);
	}

	public int insertBoard(BoardDto board) {
		return sqlSession.insert("boardMapper.insertBoard", board);
	}

	public int updateIncreaseCount(int no) {
		return sqlSession.update("boardMapper.updateIncreaseCount", no);
	}

	public BoardDto selectBoard(int no) {
		return sqlSession.selectOne("boardMapper.selectBoard", no);
	}

	public int updateBoard(BoardDto board) {
		return sqlSession.update("boardMapper.updateBoard", board);
	}

	public int selectSearchListCount(Map<String, String> search) {
		return sqlSession.selectOne("boardMapper.selectSearchListCount", search);
	}

	public List<BoardDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds= new RowBounds( offset, limit );
		
		return sqlSession.selectList("boardMapper.selectSearchList", search, rowBounds);
	}

	public List<BoardDto> selectTempSaveList(String userId) {
		return sqlSession.selectList("boardMapper.selectTempSaveList",userId);
	}
	

}
