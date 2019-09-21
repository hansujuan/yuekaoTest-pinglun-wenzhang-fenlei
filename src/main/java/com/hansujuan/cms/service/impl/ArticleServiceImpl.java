/**
 * 
 */
package com.hansujuan.cms.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.hansujuan.cms.core.Page;
import com.hansujuan.cms.dao.ArticleMapper;
import com.hansujuan.cms.domain.Article;
import com.hansujuan.cms.service.ArticleService;

/**
 * 说明:
 * 
 * @author howsun ->[howsun.zhang@gmail.com]
 * @version 1.0
 *
 * 2019年4月21日 下午9:06:07
 */
@Service
@Transactional
public class ArticleServiceImpl implements ArticleService {

	@Resource
	ArticleMapper articleMapper;

	@Override
	@Transactional(propagation = Propagation.NOT_SUPPORTED, readOnly = true)
	public List<Article> gets(Article conditions, Page page, LinkedHashMap<String, Boolean> orders) {
		List<Article> articles = articleMapper.selects(conditions, orders, page);
		if(page != null && page.getPageCount() == 0){
			int totalCount = articleMapper.count(conditions);
			page.setTotalCount(totalCount);
		}
		return articles;
	}

	public int insert(Article article) {
		return articleMapper.insert();
	}

	public int insertArticle(Article article) {
		return articleMapper.insertArticle(article);
	}

	public List<Article> selectArticleAll(Integer id) {
		return articleMapper.selectArticleAll(id);
	}

	public List<Article> selectArticleAlls() {
		return articleMapper.selectArticleAlls();
	}

	public int deleteArticleUpdateDeleted(Integer id) {
		return articleMapper.deleteArticleUpdateDeleted(id);
	}

	public Article selectArticleAllByArticleId(Integer id) {
		return articleMapper.selectArticleAllByArticleId(id);
	}

	public int updateArticlesById(Article article) {
		return articleMapper.updateArticlesById(article);
	}

	public int deletePhotos(Map<String, Object> map) {
		return articleMapper.deletePhotos(map);
	}

	public String updateStatusCheckArticle(Map<String, Object> map) {
		int i = articleMapper.updateStatusCheckArticle(map);
		if(i>0){
			return "succ";
		}
		return null;
	}

	public String remenArticle(Map<String, Object> map) {
		int i = articleMapper.updateRemenArticle(map);
		if(i>0){
			return "succ";
		}
		return null;
	}

	public Article selectArticleByIdComment(Integer id) {
		return articleMapper.selectArticleByIdComment(id);
	}

	public int updateHits(Integer id) {
		return articleMapper.updateHits(id);
	}

	public int updateComments(Integer id) {
		return articleMapper.updateComments(id);
	}

	public Article selectOneByPreNum(Map<String, Object> map) {
		return articleMapper.selectOneByPreNum(map);
	}

	public List<Article> selectListByArticleId(Integer channelId) {
		return articleMapper.selectListByArticleId(channelId);
	}
	
	
}
