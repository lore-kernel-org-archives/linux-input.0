From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: wacom - set stylus_in_proximity when pen is
 in range
Date: Thu, 29 May 2014 00:09:37 -0700
Message-ID: <20140529070937.GD11817@core.coreip.homeip.net>
References: <1401232664-9699-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49752 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbaE2HJk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 03:09:40 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so12414795pab.38
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 00:09:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401232664-9699-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, May 27, 2014 at 04:17:44PM -0700, Ping Cheng wrote:
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>
> Tested-by: Jason Gerecke <killertofu@gmail.com>

Applied, thank you.

> ---
>  drivers/input/tablet/wacom_wac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 24c0733..c98e51c 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -484,6 +484,8 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
>  		input_report_key(input, BTN_TOUCH, 0);
>  		input_report_abs(input, ABS_PRESSURE, 0);
>  		input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
> +		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
> +			wacom->shared->stylus_in_proximity = true;
>  	}
>  
>  	/* Exit report */
> -- 
> 1.9.1
> 

-- 
Dmitry
