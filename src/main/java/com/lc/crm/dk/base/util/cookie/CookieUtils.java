package com.lc.crm.dk.base.util.cookie;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtils {
    public static String getCookie(HttpServletRequest req, String key) {
        Cookie cookie[] = req.getCookies();
        if (cookie != null) {
            for (int i = 0; i < cookie.length; i++) {
                if (cookie[i].getName().equals(key)) {
                    return cookie[i].getValue();
                }
            }
        }
        return null;
    }

    public static void addCookie(HttpServletResponse response, String key, String val) {
        Cookie c = new Cookie(key, val);
        c.setPath("/");
        //100年
        c.setMaxAge(3600 * 24 * 100);
        response.addCookie(c);
    }

    public static void delCookie(HttpServletResponse response, String key) {
        Cookie cookie = new Cookie(key, null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    public static void delAllCookie(HttpServletRequest request, HttpServletResponse response) {
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            cookie.setMaxAge(0);
            cookie.setPath("/");
            response.addCookie(cookie);
        }
    }
}
