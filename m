From: Martin Kepplinger <martink@posteo.de>
Subject: Re: [PATCH] Input: edt-ft5x06: Delete an error message for a failed
 memory allocation in edt_ft5x06_ts_probe()
Date: Mon, 22 Jan 2018 08:00:47 +0100
Message-ID: <850ca75e-6b13-8e08-b97e-2512e0841152@posteo.de>
References: <45f8a6c2-423b-5bc1-6512-c5b954c5620b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:34746 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbeAVHAw (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 02:00:52 -0500
Received: from submission (posteo.de [89.146.220.130])
        by mout01.posteo.de (Postfix) with ESMTPS id B74DD20F51
        for <linux-input@vger.kernel.org>; Mon, 22 Jan 2018 08:00:50 +0100 (CET)
In-Reply-To: <45f8a6c2-423b-5bc1-6512-c5b954c5620b@users.sourceforge.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-input@vger.kernel.org, Andi Shyti <andi@etezian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?= <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, Simon Budig <simon.budig@kernelconcepts.de>, =?UTF-8?Q?Stefan_Sch=c3=b6fegger?= <stefan.schoefegger@ginzinger.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

On 2018-01-21 20:19, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 21 Jan 2018 20:10:03 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Martin Kepplinger <martink@posteo.de>

> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index c53a3d7239e7..9d2799c90150 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -978,10 +978,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
>  
>  	tsdata = devm_kzalloc(&client->dev, sizeof(*tsdata), GFP_KERNEL);
> -	if (!tsdata) {
> -		dev_err(&client->dev, "failed to allocate driver data.\n");
> +	if (!tsdata)
>  		return -ENOMEM;
> -	}
>  
>  	chip_data = of_device_get_match_data(&client->dev);
>  	if (!chip_data)
> 

