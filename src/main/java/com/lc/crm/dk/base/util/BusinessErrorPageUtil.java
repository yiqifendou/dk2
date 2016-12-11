package com.lc.crm.dk.base.util;

import org.springframework.ui.Model;

/**
 * Created by yiqifendou on 2016/12/10.
 */
public class BusinessErrorPageUtil {
    public static String toErrorPage(Model model,String errMsg){
        model.addAttribute("errMsg",errMsg);
        return "errorPages/errorExt";
    }
}
