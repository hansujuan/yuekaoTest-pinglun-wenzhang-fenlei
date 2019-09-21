/**
 * 
 */
package com.hansujuan.cms.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hansujuan.cms.core.Page;
import com.hansujuan.cms.domain.Article;


/**
 * 说明:
 * 
 * @author howsun ->[howsun.zhang@gmail.com]
 * @version 1.0
 *
 * 2019年3月16日 下午9:18:02
 */
public interface ArticleMapper {

	/**
	 * 功能说明：保存文章<br>
	 * @param article
	 * void
	 */
	public void save(Article article);
	

	/**
	 * 功能说明：递增访问量<br>
	 * @param id
	 * void
	 */
	public void increaseHit(int id);
	
	
	/**
	 * 功能说明：查询文章<br>
	 * @return
	 * List<Article>
	 */
	public List<Article> selects(@Param("article") Article article, @Param("order") LinkedHashMap<String, Boolean> orders, @Param("page") Page page);
	
	
	/**
	 * 功能说明：统计<br>
	 * @param article
	 * @return
	 * int
	 */
	public int count(@Param("article") Article article);
	
	
	public int insert();
	
	public int insertArticle(Article article);
	
	public List<Article> selectArticleAll(Integer id);


	public List<Article> selectArticleAlls();
	
	public int deleteArticleUpdateDeleted(Integer id);
	
	public Article selectArticleAllByArticleId(Integer id);
	
	public int updateArticlesById(Article article);
	
	public int deletePhotos(Map<String, Object> map);
	
	public int updateStatusCheckArticle(Map<String, Object> map);

	public int updateRemenArticle(Map<String, Object> map);
	
	public Article selectArticleByIdComment(Integer id);

	public int updateHits(Integer id);

	public int updateComments(Integer id);
	
	public Article selectOneByPreNum(Map<String, Object> map);
	
	public List<Article> selectListByArticleId(Integer channelId);
}
