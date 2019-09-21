package com.hansujuan.cms.web.controllers;

import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hansujuan.cms.core.Page;
import com.hansujuan.cms.domain.Article;
import com.hansujuan.cms.domain.Comment;
import com.hansujuan.cms.domain.User;
import com.hansujuan.cms.service.ArticleService;
import com.hansujuan.cms.service.CommentService;
import com.hansujuan.cms.web.Constant;

/**
 * @作者 hsj
 * @日期 2019年9月19日
 */
@Controller
public class CommentController {

	@Resource
	private CommentService commentService;
	
	@Resource
	private ArticleService articleService;
	
	
	@RequestMapping("/blog/{id}")
	public String showComments(@PathVariable("id")Integer id,Model model,@RequestParam(required=false,defaultValue="1")Integer pageNum,
			Integer preNum){
		Map<String, Object> map= new HashMap<String, Object>();
		Article article = articleService.selectArticleByIdComment(id);
		
		PageHelper.startPage(pageNum, 10);
		List<Comment> list = commentService.selectOneCommentByArticleId(id);
		PageInfo<Comment> pages = new PageInfo<Comment>(list);
		Integer channelId = article.getChannel().getId();
		
//		上一篇：
//		下一篇：
		List<Article> articlesList = articleService.selectListByArticleId(channelId);
		Article minArticle = articlesList.get(0);
		Article maxArticle = articlesList.get(articlesList.size()-1);
		if(preNum!= null){
			map.put("channelId", channelId);
			map.put("preNum", preNum);
			map.put("articleId", id);
			Article articlea = articleService.selectOneByPreNum(map);
			if(articlea != null){
				article = articlea;
			}
		}
		/*for (Article article2 : articlesList) {
			System.out.println(article2);
		}*/
		model.addAttribute("pages", pages);
		model.addAttribute("minArticle", minArticle);
		model.addAttribute("maxArticle", maxArticle);
		model.addAttribute("articlesList", articlesList);
		model.addAttribute("blog", article);
//		添加访问量
		articleService.updateHits(id);
		Article conditions = new Article();
//		点击率排行榜：
		LinkedHashMap<String, Boolean> orders = new LinkedHashMap<String, Boolean>();
		orders.clear();
		orders.put("hits", false);
		Page page = new Page(1, 3);
		
		List<Article> hitBlogs = articleService.gets(conditions, page, orders);
		model.addAttribute("hitBlogs", hitBlogs);
//		评论排行榜：
		orders.clear();
		orders.put("commentnum", false);
		List<Article> commentnumBlogs = articleService.gets(conditions, page, orders);
		model.addAttribute("commentnumBlogs", commentnumBlogs);
		return "blog";
	}
	
	@RequestMapping("/my/comment/{id}")
	@ResponseBody
	public boolean addComment(@PathVariable("id")Integer id,HttpSession session,String content){
		
		User user = (User) session.getAttribute(Constant.LOGIN_USER);
		Article article = new Article(id);
		Comment comment = new Comment();
		comment.setUser(user);
		comment.setArticle(article);
		comment.setCreated(new Date());
		comment.setContent(content);
		boolean b = commentService.addComment(comment);
		
		articleService.updateComments(id);
		return b;
	}
	
	
}
