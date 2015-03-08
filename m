From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: elan_i2c - Remove duplicate repeat code
Date: Sun, 8 Mar 2015 14:14:26 -0700
Message-ID: <20150308211426.GC23193@dtor-ws>
References: <1425804245-23954-1-git-send-email-dusonlin@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:43024 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbbCHVOa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Mar 2015 17:14:30 -0400
Content-Disposition: inline
In-Reply-To: <1425804245-23954-1-git-send-email-dusonlin@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Duson Lin <dusonlin@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

On Sun, Mar 08, 2015 at 04:44:05PM +0800, Duson Lin wrote:
> Remove duplicate "repeat--" from function elan_initialize.
> 
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index f24078b..4b970e2 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -198,7 +198,6 @@ static int elan_initialize(struct elan_tp_data *data)
>  		if (!error)
>  			return 0;
>  
> -		repeat--;
>  		msleep(30);
>  	} while (--repeat > 0);
>  
> -- 
> 1.7.10.4
> 

-- 
Dmitry
