From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] usbtouchscreen: option to swap X and Y axes
Date: Sat, 20 Sep 2008 04:45:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0809200444570.27884@twin.jikos.cz>
References: <40101cc30809181016l632de30en6ff56b1fe9fe36ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:42692 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbYITCpw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Sep 2008 22:45:52 -0400
In-Reply-To: <40101cc30809181016l632de30en6ff56b1fe9fe36ff@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matteo Croce <technoboy85@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 18 Sep 2008, Matteo Croce wrote:

> Here there is a patch to invert the X and Y axes, as my controller swaps it:
> 
> Signed-off-by: Matteo Croce <matteo@openwrt.org>
> 
> --- a/drivers/input/touchscreen/usbtouchscreen.c	2008-09-18
> 18:50:44.294868149 +0200
> +++ b/drivers/input/touchscreen/usbtouchscreen.c	2008-09-18
> 18:50:44.226867816 +0200
> @@ -56,8 +56,16 @@
>  #define DRIVER_DESC		"USB Touchscreen Driver"
> 
>  static int swap_xy;
> +static int invert_x;
> +static int invert_y;
> +
>  module_param(swap_xy, bool, 0644);
> +module_param(invert_x, bool, 0644);
> +module_param(invert_y, bool, 0644);
> +
>  MODULE_PARM_DESC(swap_xy, "If set X and Y axes are swapped.");
> +MODULE_PARM_DESC(invert_x, "If set X axe is inverted.");
> +MODULE_PARM_DESC(invert_y, "If set Y axe is inverted.");

If this is done just by certain devices, maybe VID/PID-based autodetection 
might be much more user friendly than using module parameter?

-- 
Jiri Kosina
SUSE Labs

