package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/json/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	///Constructor
	public PurchaseRestController() {
		System.out.println(this.getClass());
	}
	
	@PostMapping("addPurchase")
	public Map addPurchase(@RequestBody Purchase purchase) throws Exception {
		System.out.println(purchase);
		purchaseService.addPurchase(purchase);
		Map map = new HashMap();
		map.put("CRUD", "Create");
		map.put("Result", "OK");
		return map;
	}
	
	@PostMapping("updatePurchase")
	public List updatePurchase(@RequestBody Purchase purchase) throws Exception {
		System.out.println(purchase);
		purchaseService.updatePurchase(purchase);
		List list = new ArrayList();
		list.add("OK");
		list.add("Pour");
		return list;
	}
 
	

}
