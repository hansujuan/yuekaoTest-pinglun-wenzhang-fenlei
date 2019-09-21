package com.hansujuan.cms.service;

import java.util.List;
import java.util.Map;

import com.hansujuan.cms.domain.Article;
import com.hansujuan.cms.domain.Comment;

/**
 * @作者 hsj
 * @日期 2019年9月19日
 */
public interface CommentService{

	public Comment selectCommentsByArticleId(Integer id);

	public boolean addComment(Comment comment);

	public List<Comment> selectOneCommentByArticleId(Integer id);

	public int updateComments(Integer id);

	public Article selectOneByPreNum(Map<String, Object> map);

}
