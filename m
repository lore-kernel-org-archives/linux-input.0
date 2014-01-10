From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics-rmi4 - rmi_driver.h tidy up
Date: Thu, 9 Jan 2014 22:28:04 -0800
Message-ID: <20140110062804.GB24123@core.coreip.homeip.net>
References: <1389319178-27751-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:61856 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaAJG2H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jan 2014 01:28:07 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so217892pdi.7
        for <linux-input@vger.kernel.org>; Thu, 09 Jan 2014 22:28:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389319178-27751-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, Jan 09, 2014 at 05:59:38PM -0800, Christopher Heiny wrote:
> This is a trivial change to remove an unused macro, and change CONFIG_PM to
> CONFIG_PM_SLEEP.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/rmi4/rmi_driver.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> index 4d82b90..ad3ee33 100644
> --- a/drivers/input/rmi4/rmi_driver.h
> +++ b/drivers/input/rmi4/rmi_driver.h
> @@ -24,8 +24,6 @@
>  	.attrs = _attrs,  \
>  }
>  
> -#define attrify(nm) (&dev_attr_##nm.attr)
> -
>  #define PDT_PROPERTIES_LOCATION 0x00EF
>  #define BSR_LOCATION 0x00FE
>  
> @@ -62,7 +60,7 @@ struct rmi_driver_data {
>  	u8 bsr;
>  
>  	bool enabled;
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  	bool suspended;
>  	struct mutex suspend_mutex;
>  

-- 
Dmitry
