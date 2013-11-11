From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mma8450 - add missing i2c_set_clientdata() in
 mma8450_probe()
Date: Sun, 10 Nov 2013 23:37:04 -0800
Message-ID: <20131111073704.GD7645@core.coreip.homeip.net>
References: <CAPgLHd-02-tPeJghvYq+ZB9_MxdRKQ7Kvdqf2YdB=0wg9MoXow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62923 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab3KKHhH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 02:37:07 -0500
Received: by mail-pa0-f42.google.com with SMTP id kp14so4995512pab.15
        for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 23:37:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPgLHd-02-tPeJghvYq+ZB9_MxdRKQ7Kvdqf2YdB=0wg9MoXow@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: grant.likely@linaro.org, rob.herring@calxeda.com, wfp5p@virginia.edu, broonie@opensource.wolfsonmicro.com, javier@dowhile0.org, sebastien.royen@armadeus.com, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Mon, Nov 11, 2013 at 02:24:20PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add missing i2c_set_clientdata() in mma8450_probe(), otherwise
> calling i2c_get_clientdata() in mma8450_remove() returns NULL.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Applied, thank you.

> ---
>  drivers/input/misc/mma8450.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
> index f330969..92c43a1 100644
> --- a/drivers/input/misc/mma8450.c
> +++ b/drivers/input/misc/mma8450.c
> @@ -204,6 +204,8 @@ static int mma8450_probe(struct i2c_client *c,
>  		goto err_free_mem;
>  	}
>  
> +	i2c_set_clientdata(c, m);
> +
>  	return 0;
>  
>  err_free_mem:
> 

-- 
Dmitry
