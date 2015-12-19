From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [patch] Input: egalax: potential NULL dereference on error
Date: Sat, 19 Dec 2015 12:04:56 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1512191204430.2055@localhost6.localdomain6>
References: <20151219105824.GA3749@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:8041 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbbLSLE7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 06:04:59 -0500
In-Reply-To: <20151219105824.GA3749@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-15?Q?B=F6sz=F6rm=E9nyi_Zolt=E1n?= <zboszormenyi@sicom.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sat, 19 Dec 2015, Dan Carpenter wrote:

> We didn't check input_allocate_device() for failures so it could lead to
> a NULL deref.

The patch does several other things...

julia

> 
> Fixes: 6b0f8f9c52ef ('Input: add eGalaxTouch serial touchscreen driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/input/touchscreen/egalax_ts_serial.c b/drivers/input/touchscreen/egalax_ts_serial.c
> index a078c1c..8becd26 100644
> --- a/drivers/input/touchscreen/egalax_ts_serial.c
> +++ b/drivers/input/touchscreen/egalax_ts_serial.c
> @@ -104,10 +104,13 @@ static int egalax_connect(struct serio *serio, struct serio_driver *drv)
>  	int error;
>  
>  	egalax = kzalloc(sizeof(struct egalax), GFP_KERNEL);
> +	if (!egalax)
> +		return -ENOMEM;
> +
>  	input_dev = input_allocate_device();
> -	if (!egalax) {
> +	if (!input_dev) {
>  		error = -ENOMEM;
> -		goto err_free_mem;
> +		goto err_free_egalax;
>  	}
>  
>  	egalax->serio = serio;
> @@ -145,8 +148,8 @@ err_close_serio:
>  	serio_close(serio);
>  err_reset_drvdata:
>  	serio_set_drvdata(serio, NULL);
> -err_free_mem:
>  	input_free_device(input_dev);
> +err_free_egalax:
>  	kfree(egalax);
>  	return error;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
