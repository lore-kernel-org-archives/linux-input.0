From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: egalax: potential NULL dereference on error
Date: Sat, 19 Dec 2015 09:21:49 -0800
Message-ID: <20151219172149.GA27255@dtor-ws>
References: <20151219105824.GA3749@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151219105824.GA3749@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszormenyi@sicom.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dan,

On Sat, Dec 19, 2015 at 01:58:24PM +0300, Dan Carpenter wrote:
> We didn't check input_allocate_device() for failures so it could lead to
> a NULL deref.
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

This is my screwup. The original code had the "if (!egalax ||
!input_dev)" check but I was considering using devm (but then decided
against it) but forget to adjust the check back. I'll put it back in.

Thank you for noticing!

-- 
Dmitry
