package com.hansujuan.cms.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hansujuan.cms.dao.CommentMapper;
import com.hansujuan.cms.domain.Article;
import com.hansujuan.cms.domain.Comment;
import com.hansujuan.cms.service.CommentService;

/**
 * @作者 hsj
 * @日期 2019年9月19日
 */
@Service
@Transactional
public class CommentServiceImpl implements CommentService {

	@Resource
	private CommentMapper commentMapper;

	public Comment selectCommentsByArticleId(Integer id) {
		return commentMapper.selectCommentsByArticleId(id);
	}

	public boolean addComment(Comment comment) {
		int i = commentMapper.addComment(comment);
		if(i>0){
			return true;
		}
		return false;
	}

	public List<Comment> selectOneCommentByArticleId(Integer id) {
		return commentMapper.selectOneCommentByArticleId(id);
	}

	public int updateComments(Integer id) {
		return commentMapper.updateComments(id);
	}

	public Article selectOneByPreNum(Map<String, Object> map) {
		return commentMapper.selectOneByPreNum(map);
	}
	
	
}
