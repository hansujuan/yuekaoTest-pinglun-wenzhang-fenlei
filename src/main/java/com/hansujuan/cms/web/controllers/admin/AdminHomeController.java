/**
 * 
 */
package com.hansujuan.cms.web.controllers.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hansujuan.cms.core.Page;
import com.hansujuan.cms.domain.Article;
import com.hansujuan.cms.domain.User;
import com.hansujuan.cms.service.ArticleService;
import com.hansujuan.cms.web.controllers.PassportController;

/**
 * 说明:
 * 
 * @author howsun ->[howsun.zhang@gmail.com]
 * @version 1.0
 *
 * 2019年3月29日 下午6:54:11
 */
@Controller
@RequestMapping("/admin")
public class AdminHomeController {

	@Resource
	private ArticleService aService;
	
	public static Logger log = LoggerFactory.getLogger(PassportController.class);
	
	@RequestMapping({"/", "/index"})
	public String home(){
		return "admin/home";
	}
	
	@RequestMapping("/articles")
	public String showArticles(Model model,HttpSession session,@RequestParam(defaultValue="1")Integer pageIndex
			){
		Page page = new Page(pageIndex, 3);
		Article article = new Article();
		/*User user = new User();
		user.setNickname(nickname);
		article.setTitle(title);
		article.setAuthor(user);
		article.setStatus(status);
		article.setContent(content);
		article.setCreated(created);*/
		
//		System.out.println(article);
		
		List<Article> list = aService.gets(article, page,null);
		model.addAttribute("slist", list);
		model.addAttribute("page", page);
		return "admin/article_list";
	}
	
	@RequestMapping("/checkArticle")
	@ResponseBody
	public String checkArticle(Integer id,Integer status){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("status", status);
		String string = aService.updateStatusCheckArticle(map);
		return string;
	}
	
	@RequestMapping("/remenArticle")
	@ResponseBody
	public String remenArticle(Integer id,Integer hot){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("hot", hot);
		String string = aService.remenArticle(map);
		return string;
	}
}
