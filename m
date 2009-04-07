From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] hiddraw.c missing unlocks in unlocked_ioctl
Date: Tue, 7 Apr 2009 16:35:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904071635000.5327@wotan.suse.de>
References: <Pine.LNX.4.64.0903311200080.4103@usbsys.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60875 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbZDGOfM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Apr 2009 10:35:12 -0400
In-Reply-To: <Pine.LNX.4.64.0903311200080.4103@usbsys.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 31 Mar 2009, Dan Carpenter wrote:

> There were 2 places that returned directly instead of releasing their 
> locks.  I sent a fix for this file earlier but ended up missing these 
> spots.  I think what happened is that I have improved my checker script 
> since then...  Or maybe I just screwed up.
> 
> regards,
> dan carpenter
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> --- orig/drivers/hid/hidraw.c	2009-03-30 21:16:07.000000000 +0300
> +++ devel/drivers/hid/hidraw.c	2009-03-30 21:18:37.000000000 +0300
> @@ -274,8 +274,10 @@
>  
>  				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWNAME(0))) {
>  					int len;
> -					if (!hid->name)
> -						return 0;
> +					if (!hid->name) {
> +						ret = 0;
> +						break;
> +					}
>  					len = strlen(hid->name) + 1;
>  					if (len > _IOC_SIZE(cmd))
>  						len = _IOC_SIZE(cmd);
> @@ -286,8 +288,10 @@
>  
>  				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWPHYS(0))) {
>  					int len;
> -					if (!hid->phys)
> -						return 0;
> +					if (!hid->phys) {
> +						ret = 0;
> +						break;
> +					}
>  					len = strlen(hid->phys) + 1;
>  					if (len > _IOC_SIZE(cmd))
>  						len = _IOC_SIZE(cmd);

Applied, thanks Dan.

-- 
Jiri Kosina
SUSE Labs
