From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mcs_touchkey: fix incorrect input device name
Date: Wed, 21 May 2014 08:26:47 -0700
Message-ID: <20140521152647.GA27151@core.coreip.homeip.net>
References: <537C509E.10705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:38607 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaEUP0v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 11:26:51 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so1513141pbb.34
        for <linux-input@vger.kernel.org>; Wed, 21 May 2014 08:26:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537C509E.10705@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: linux-input@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Beomho,

On Wed, May 21, 2014 at 04:07:10PM +0900, Beomho Seo wrote:
> This patch fix a typo error at input device name.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/input/keyboard/mcs_touchkey.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index 1da8e0b..375b05c 100644
> --- a/drivers/input/keyboard/mcs_touchkey.c
> +++ b/drivers/input/keyboard/mcs_touchkey.c
> @@ -147,7 +147,7 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  	}
>  	dev_info(&client->dev, "Firmware version: %d\n", fw_ver);
> 
> -	input_dev->name = "MELPAS MCS Touchkey";
> +	input_dev->name = "MELFAS MCS Touchkey";

Hmm, we have the same spelling in mcs5000_ts.c...

Thanks.

>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;
>  	input_dev->evbit[0] = BIT_MASK(EV_KEY);
> -- 
> 1.7.9.5

-- 
Dmitry
