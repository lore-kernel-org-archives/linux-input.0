From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: stop scanning PDT after blank page
Date: Tue, 22 Jul 2014 23:10:01 -0700
Message-ID: <20140723061001.GE25004@core.coreip.homeip.net>
References: <1394244256-16950-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:38183 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbaGWGKJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 02:10:09 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so1055350pad.24
        for <linux-input@vger.kernel.org>; Tue, 22 Jul 2014 23:10:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1394244256-16950-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Fri, Mar 07, 2014 at 06:04:16PM -0800, Christopher Heiny wrote:
> When scanning the Page Descriptor Table, the end of the PDT is marked by a
> page where the first PDT entry is empty.  Stop scanning when we find this
> page.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>


Applied, thank you.

> 
> ---
>  drivers/input/rmi4/rmi_driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 2172c80..dd3ccf5 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -505,7 +505,8 @@ static int rmi_scan_pdt_page(struct rmi_device *rmi_dev,
>  			return retval;
>  	}
>  
> -	return data->f01_bootloader_mode ? RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
> +	return (data->f01_bootloader_mode || addr == pdt_start) ?
> +					RMI_SCAN_DONE : RMI_SCAN_CONTINUE;
>  }
>  
>  static int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,

-- 
Dmitry
