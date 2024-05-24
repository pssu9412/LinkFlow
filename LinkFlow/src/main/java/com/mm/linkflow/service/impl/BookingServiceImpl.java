package com.mm.linkflow.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.mm.linkflow.dao.BookingDao;
import com.mm.linkflow.dto.AssetsDto;
import com.mm.linkflow.dto.BookingDto;
import com.mm.linkflow.dto.PageInfoDto;
import com.mm.linkflow.service.service.BookingService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class BookingServiceImpl implements BookingService {
	
	private final BookingDao bkDao;

	@Override
	public int selectBkCount(String userId) {
		return bkDao.selectBkCount(userId);
	}

	@Override
	public List<BookingDto> selectMyBkList(PageInfoDto pi, String userId) {
		return bkDao.selectMyBkList(pi,userId);
	}


	@Override
	public int selectMySearchCount(Map<String, String> search) {
		return bkDao.selectMySearchCount(search);
	}

	@Override
	public List<BookingDto> selectMySearchList(Map<String, String> search, PageInfoDto pi) {
		return bkDao.selectMySearchList(search, pi);
	}

	
	@Override
	public int modifyBooking(BookingDto bk) {
		return bkDao.modifyBooking(bk);
	}

	@Override
	public int cancleBooking(BookingDto bk) {
		return bkDao.cancleBooking(bk);
	}


	@Override
	public List<AssetsDto> selectDetailAssList(String supName) {
		return bkDao.selectDetailAssList(supName);
	}
	
	@Override
	public BookingDto selectDetailMyBk(String bkNo) {
		return bkDao.selectDetailMyBk(bkNo);
	}

	@Override
	public int selectSupCount() {
		return bkDao.selectSupCount();
	}

	@Override
	public List<AssetsDto> selectSuppliesList(PageInfoDto pi) {
		return bkDao.selectSuppliesList(pi);
	}

	@Override
	public int selectAssCount() {
		return bkDao.selectAssCount();
	}

	@Override
	public List<AssetsDto> selectAssetsList(PageInfoDto pi) {
		return bkDao.selectAssetsList(pi);
	}

	@Override
	public int insertAssets(Map<String,Object> mp) {
		return bkDao.insertAssets(mp);
	}

	@Override
	public int modAssets(Map<String,Object> mp) {
		return bkDao.modAssets(mp);
	}

	@Override
	public int delAssets(String assetsNo) {
		return bkDao.delAssets(assetsNo);
	}

	@Override
	public int searchBkCount(Map<String,String> search) {
		return bkDao.selectSearchBkCount(search);
	}

	@Override
	public List<AssetsDto> selectSearchSupList(PageInfoDto pi,Map<String,String> search) {
		return bkDao.selectSearchSupList(search,pi);
	}


	@Override
	public int selectSearchAssCount(Map<String,String> search) {
		return bkDao.selectSearchAssCout(search);
	}

	@Override
	public List<AssetsDto> selectSearchAssetsList(PageInfoDto pi,Map<String,String> search) {
		return bkDao.selectSearchAssList(pi,search);
	}

	@Override
	public int insertBooking(BookingDto bk) {
		return 0;
	}

	@Override
	public int modBooking(BookingDto bk) {
		return 0;
	}

	@Override
	public int selectSupWaitCount() {
		return bkDao.selectSupWaitCount();
	}

	@Override
	public List<BookingDto> selectSupWaitList(PageInfoDto pi) {
		return bkDao.selectSupWaitList(pi);
	}

	@Override
	public int selectSupStatusCount(Map<String, String> search) {
		return 0;
	}

	@Override
	public List<BookingDto> selectSipStatusList(PageInfoDto pi, Map<String, String> search) {
		return null;
	}

	
	

}
