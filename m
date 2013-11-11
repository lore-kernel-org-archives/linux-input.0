From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mpu3050 - add missing i2c_set_clientdata() in
 mpu3050_probe()
Date: Sun, 10 Nov 2013 23:34:47 -0800
Message-ID: <20131111073447.GC7645@core.coreip.homeip.net>
References: <CAPgLHd-ujkwTBn=hUH6SxfhHpYHyGqvrkcyuRTFkXmWtqE2Zjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:55941 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3KKHeu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 02:34:50 -0500
Received: by mail-pb0-f50.google.com with SMTP id xb12so768603pbc.23
        for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 23:34:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPgLHd-ujkwTBn=hUH6SxfhHpYHyGqvrkcyuRTFkXmWtqE2Zjg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, wfp5p@virginia.edu, broonie@opensource.wolfsonmicro.com, javier@dowhile0.org, rmk+kernel@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Mon, Nov 11, 2013 at 02:18:54PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add missing i2c_set_clientdata() in mpu3050_probe(), otherwise
> calling i2c_get_clientdata() in mpu3050_remove() returns NULL.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thank you.

> ---
>  drivers/input/misc/mpu3050.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
> index dce0d95..6983ffb 100644
> --- a/drivers/input/misc/mpu3050.c
> +++ b/drivers/input/misc/mpu3050.c
> @@ -383,6 +383,7 @@ static int mpu3050_probe(struct i2c_client *client,
>  
>  	pm_runtime_enable(&client->dev);
>  	pm_runtime_set_autosuspend_delay(&client->dev, MPU3050_AUTO_DELAY);
> +	i2c_set_clientdata(client, sensor);
>  
>  	return 0;
>  
> 

-- 
Dmitry
