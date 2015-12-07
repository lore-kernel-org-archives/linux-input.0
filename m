From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 2/2] input: gt801_2plus1 - Add initial
 support for Goodix GT801 2+1
Date: Mon, 7 Dec 2015 09:34:43 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1512070933400.2037@localhost6.localdomain6>
References: <201512071608.oGt2n0Wn%fengguang.wu@intel.com>
Reply-To: julia.lawall-L2FTfq7BK8M@public.gmane.org
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sunxi+bncBDZJXP7F6YLRBJEJSWZQKGQE6G5JARI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <201512071608.oGt2n0Wn%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: linux-input@vger.kernel.org

It looks like braces may be mising.  Please check.

julia

On Mon, 7 Dec 2015, kbuild test robot wrote:

> Hi Priit,
> 
> [auto build test WARNING on mripard/sunxi/for-next]
> [also build test WARNING on next-20151203]
> [cannot apply to input/next v4.4-rc4]
> 
> url:    https://github.com/0day-ci/linux/commits/Priit-Laes/input-Driver-for-Goodix-GT801-2-1-touchscreen/20151207-152831
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi/for-next
> :::::: branch date: 46 minutes ago
> :::::: commit date: 46 minutes ago
> 
> >> drivers/input/touchscreen/gt801_2plus1.c:119:3-30: code aligned with following code on line 120
> 
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout d66df313f96e04572821e49cada65cb5c1bea9e2
> vim +119 drivers/input/touchscreen/gt801_2plus1.c
> 
> d66df313 Priit Laes 2015-12-07  113  		return;
> d66df313 Priit Laes 2015-12-07  114  
> d66df313 Priit Laes 2015-12-07  115  	/* Build touch map */
> d66df313 Priit Laes 2015-12-07  116  	touch_num = 0;
> d66df313 Priit Laes 2015-12-07  117  	for (i = 0; (touch_raw != 0) && (i < ts->max_touch_num); i++) {
> d66df313 Priit Laes 2015-12-07  118  		if (touch_raw & 1)
> d66df313 Priit Laes 2015-12-07 @119  			touch_map[touch_num++] = i;
> d66df313 Priit Laes 2015-12-07 @120  			touch_raw >>= 1;
> d66df313 Priit Laes 2015-12-07  121  	}
> d66df313 Priit Laes 2015-12-07  122  
> d66df313 Priit Laes 2015-12-07  123  	/* Calculate checksum */
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
