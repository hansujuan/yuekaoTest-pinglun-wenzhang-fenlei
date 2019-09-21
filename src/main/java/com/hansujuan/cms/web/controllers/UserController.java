/**
 * 
 */
package com.hansujuan.cms.web.controllers;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

import com.hansujuan.cms.core.Page;
import com.hansujuan.cms.domain.Article;
import com.hansujuan.cms.domain.Category;
import com.hansujuan.cms.domain.Channel;
import com.hansujuan.cms.domain.User;
import com.hansujuan.cms.service.ArticleService;
import com.hansujuan.cms.service.ChannelCategoryService;
import com.hansujuan.cms.utils.FileUtils;
import com.hansujuan.cms.web.Constant;

/**
 * 说明:
 * 
 * @author howsun ->[howsun.zhang@gmail.com]
 * @version 1.0
 *
 * 2018年1月10日 下午2:40:38
 */
@Controller
@RequestMapping("/my")
public class UserController {

	@Resource
	private ArticleService as;
	
	@Resource
	private ChannelCategoryService ccs;
	
	@RequestMapping({"/", "/index", "/home"})
	public String home(){
		return "user-space/home";
	}
	
	@RequestMapping({"/profile"})
	public String profile(){
		return "user-space/profile";
	}
	
	
	@RequestMapping("/blog/edit")
	public String showArticlejsp(Model model,Integer id){
		if(id==null || id==0){
			model.addAttribute("article", new Article());
			
		}else{
			Article article = as.selectArticleAllByArticleId(id);
			model.addAttribute("article", article);
		}
		List<Channel> channels = ccs.getChannels();
		model.addAttribute("channels", channels);
		return "user-space/blog_edit";
	}
	
	@RequestMapping("/blog/save")
	public String issueArticle(@Valid Article bolg,BindingResult result,MultipartFile photo,String hots,HttpSession session) throws IllegalStateException, IOException{
		String upload = FileUtils.upload(photo);
		bolg.setPicture(upload);
		
		if(bolg.getId()==null || bolg.getId()==0){
			if(result.hasErrors()){
				return "user-space/blog_edit";
			}
			if("on".equals(hots)){
				bolg.setHot(true);
			}
			
			User user = (User) session.getAttribute(Constant.LOGIN_USER);
				if(user == null ){
					return "passport/login";
				}
			bolg.setAuthor(user);
			bolg.setCreated(new Date());
			bolg.setStatus(0);
			bolg.setHits(0);
			bolg.setHot(false);
			bolg.setDeleted(false);
			int i = as.insertArticle(bolg);
		}else{
			if("on".equals(hots)){
				bolg.setHot(true);
			}
			User user = (User) session.getAttribute(Constant.LOGIN_USER);
			if(user == null ){
				return "passport/login";
			}
			bolg.setAuthor(user);
			bolg.setUpdated(new Date());
			as.updateArticlesById(bolg);
		}
		
		
		return "redirect:/my/blogs";
	}
	
	@RequestMapping("/blogs")
	public String showblogs(Model model,HttpSession session,@RequestParam(defaultValue="1")Integer pageIndex){
		User user = (User) session.getAttribute(Constant.LOGIN_USER);
		if(user == null ){
			return "passport/login";
		}
		Article article = new Article();
		article.setAuthor(user);
		Page page = new Page(pageIndex, 10);
		List<Article> list = as.gets(article, page, null);
		/*for (Article article2 : list) {
			System.out.println(article2);
		}*/
		model.addAttribute("list", list);
		return "user-space/blog_list";
	}
	
	@RequestMapping("/showCateStories")
	@ResponseBody
	public List<Category> showCateStories(Integer cid){
		List<Category> list = ccs.getCategories(cid);
		return list;
	}
	
	@RequestMapping("/blog/remove")
	@ResponseBody
	public boolean removeArticle(Integer id){
		int i = as.deleteArticleUpdateDeleted(id);
		return true;
	}
	
	@RequestMapping("/showPicture")
	public void showPicture(String picture,HttpServletRequest request,HttpServletResponse response){
		FileUtils.lookImg(picture, request, response);
	}
	
	@RequestMapping("/deletePhoto")
	public String deletePhoto(String picture,Integer id){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("picture", picture);
		map.put("id", id);
		int i = as.deletePhotos(map);
		
		return "redirect:/my/blogs";
	}
	
	
}
