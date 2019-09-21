package com.hansujuan.cms.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.hansujuan.cms.core.Page;
import com.hansujuan.cms.domain.Article;

/**
 * 说明:
 * 
 * @author howsun ->[howsun.zhang@gmail.com]
 * @version 1.0
 *
 * 2019年3月28日 下午4:48:47
 */
public interface ArticleService {

	/**
	 * 功能说明：<br>
	 * @param conditions
	 * @param page
	 * @param orders  排序，默认按创建时间倒排序
	 * @return
	 * List<Article>
	 */
	public abstract List<Article> gets(Article conditions, Page page, LinkedHashMap<String, Boolean> orders);
	
	public int insert(Article article);
	
	public int insertArticle(Article article);
	
	public List<Article> selectArticleAll(Integer id);

	public abstract List<Article> selectArticleAlls();
	
	public int deleteArticleUpdateDeleted(Integer id);
	
	public Article selectArticleAllByArticleId(Integer id);
	
	public int updateArticlesById(Article article);
	
	public int deletePhotos(Map<String, Object> map);

	public String updateStatusCheckArticle(Map<String, Object> map);

	public String remenArticle(Map<String, Object> map);
	
	public Article selectArticleByIdComment(Integer id);

	public abstract int updateHits(Integer id);

	public abstract int updateComments(Integer id);
	
	public Article selectOneByPreNum(Map<String, Object> map);
	
	public List<Article> selectListByArticleId(Integer channelId);
}