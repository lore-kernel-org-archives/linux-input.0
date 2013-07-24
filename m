From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: egalax_ts - Provide a .remove function
Date: Wed, 24 Jul 2013 14:08:23 -0700
Message-ID: <1706568.zcsuYSPDks@dtor-d630.eng.vmware.com>
References: <1374698769-25664-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:64526 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab3GXVI2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jul 2013 17:08:28 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so854240pdj.1
        for <linux-input@vger.kernel.org>; Wed, 24 Jul 2013 14:08:27 -0700 (PDT)
In-Reply-To: <1374698769-25664-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: shawn.guo@linaro.org, linux-input@vger.kernel.org

Hi Fabio,

On Wednesday, July 24, 2013 05:46:09 PM Fabio Estevam wrote:
> Provide a .remove function so that we can unregister the input device.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/input/touchscreen/egalax_ts.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/egalax_ts.c
> b/drivers/input/touchscreen/egalax_ts.c index ef5fcb0..e46be61 100644
> --- a/drivers/input/touchscreen/egalax_ts.c
> +++ b/drivers/input/touchscreen/egalax_ts.c
> @@ -234,6 +234,16 @@ static int egalax_ts_probe(struct i2c_client *client,
>  	return 0;
>  }
> 
> +static int egalax_ts_remove(struct i2c_client *client)
> +{
> +	struct egalax_ts *ts = i2c_get_clientdata(client);
> +
> +	input_unregister_device(ts->input_dev);
> +	kfree(ts);


The egalax_ts driver has been converted to devm* infrastructure, using kfree() 
to free memory not only unnecessary, but wrong.

Thanks.

-- 
Dmitry
