package com.hansujuan.cms.web.controllers.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hansujuan.cms.domain.Category;
import com.hansujuan.cms.domain.Channel;
import com.hansujuan.cms.service.ChannelCategoryService;



/**
 * @作者 hsj
 * @日期 2019年9月9日
 */
@Controller
@RequestMapping("/channelCategory")
public class CateStoryController {

	@Resource
	private ChannelCategoryService ccs;
	
	@RequestMapping("/categories")
	public String getCategories(Model model){
		List<Channel> channels = ccs.getChannels();
		
		model.addAttribute("channels", channels);
		
		return "/admin/home";
	}
	
	@RequestMapping("/getChannels")
	@ResponseBody
	public List<Channel> getChannels(){
		List<Channel> channels = ccs.getChannels();
		return channels;
	}
	
	@RequestMapping("/saveOrUpdateCatetory")
	@ResponseBody
	public String saveOrUpdateCatetory(Integer cid,String catename,Integer cateid){
		if (cateid == null || "".equals(cateid)) {
			Category category = new Category();
			category.setName(catename);
			category.setChannel(new Channel(cid));
			ccs.saveCategory(category);
		}else{
			ccs.removeCategory(cateid);
			Category category = new Category();
			category.setName(catename);
			category.setChannel(new Channel(cid));
			ccs.saveCategory(category);
		}
		return "succ";
	}
	
	@RequestMapping("/toUpdateCatestory")
	@ResponseBody
	public Map<String, Object> toUpdateCatestory(Integer id){
		Map<String, Object> map = new HashMap<String, Object>();
		List<Channel> channels = ccs.getChannels();
		Category category = ccs.getCategory(id);
		Channel channel = ccs.getChannel(category.getChannel().getId());
		map.put("category", category);
		map.put("channel", channel);
		map.put("channels", channels);
		return map;
	}
	
	@RequestMapping("/delcatestory")
	@ResponseBody
	public String delcatestory(Integer id){
		ccs.removeCategory(id);
		return "succ";
	}
	
	@RequestMapping("/delChannel")
	@ResponseBody
	public String delChannel(Integer id){
		ccs.removeChannel(id);
		return "succ";
	}
	
	@RequestMapping("/getChannel")
	@ResponseBody
	public Channel getChannel(Integer id){
		Channel channel = ccs.getChannel(id);
		
		return channel;
	}
	
	@RequestMapping("/updateChannel")
	@ResponseBody
	public String updateChannel(Integer cids,String cnames){
		Channel channel = new Channel(cids, cnames);
		int i = ccs.updateChannel(channel);
		if(i>0){
			return "succ";
		}
		return "error";
	}
}
