From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - force a module ignore ABS mode
Date: Thu, 11 May 2017 18:02:39 -0700
Message-ID: <20170512010239.GB513@dtor-ws>
References: <1481526663-2730-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34378 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbdELBCn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 May 2017 21:02:43 -0400
Content-Disposition: inline
In-Reply-To: <1481526663-2730-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

On Mon, Dec 12, 2016 at 03:11:03PM +0800, KT Liao wrote:
> One Elan sample which sample version is 0x74 and hw_version is 0x04 has a bug in abs mode, so let it run in default mode
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index db7d1d6..f1c2d10 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1687,6 +1687,13 @@ int elantech_init(struct psmouse *psmouse)
>  			     etd->samples[0], etd->samples[1], etd->samples[2]);
>  	}
>  
> +	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
> +		/*This module has a bug in absolute mode, let it be defualt mode  */
> +		psmouse_info(psmouse,
> +			     "This module only active in default mode\n");
> +		goto init_fail;
> +	}
> +
>  	if (elantech_set_absolute_mode(psmouse)) {
>  		psmouse_err(psmouse,
>  			    "failed to put touchpad into absolute mode.\n");
> -- 
> 2.7.4
> 

-- 
Dmitry
