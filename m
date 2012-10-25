From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] tps6507: remove bogus unreachable code
Date: Thu, 25 Oct 2012 11:03:48 -0700
Message-ID: <20121025180348.GA24594@core.coreip.homeip.net>
References: <20121025142845.16911.4538.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:63019 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab2JYSDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 14:03:53 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so899552dak.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 11:03:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121025142845.16911.4538.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Todd Fischer <todd.fischer@ridgerun.com>
Cc: linux-input@vger.kernel.org

On Thu, Oct 25, 2012 at 03:28:51PM +0100, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> tsc->polling is write only and the poll local is meaningless
> 

Alan,

I could apply the patch, but a touchscreen driver without interrupt
support is not too useful...

Todd,

Is there a more mature version of this driver?

Thanks.

> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/input/touchscreen/tps6507x-ts.c |   25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index f7eda3d..27f95ad 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -42,7 +42,6 @@ struct tps6507x_ts {
>  	struct device		*dev;
>  	char			phys[32];
>  	struct delayed_work	work;
> -	unsigned		polling;	/* polling is active */
>  	struct ts_event		tc;
>  	struct tps6507x_dev	*mfd;
>  	u16			model;
> @@ -168,7 +167,6 @@ static void tps6507x_ts_handler(struct work_struct *work)
>  	struct input_dev *input_dev = tsc->input_dev;
>  	int pendown;
>  	int schd;
> -	int poll = 0;
>  	s32 ret;
>  
>  	ret =  tps6507x_adc_conversion(tsc, TPS6507X_TSCMODE_PRESSURE,
> @@ -209,24 +207,14 @@ static void tps6507x_ts_handler(struct work_struct *work)
>  		input_report_abs(input_dev, ABS_PRESSURE, tsc->tc.pressure);
>  		input_sync(input_dev);
>  		tsc->pendown = 1;
> -		poll = 1;
>  	}
>  
>  done:
>  	/* always poll if not using interrupts */
> -	poll = 1;
> -
> -	if (poll) {
> -		schd = schedule_delayed_work(&tsc->work,
> -					msecs_to_jiffies(tsc->poll_period));
> -		if (schd)
> -			tsc->polling = 1;
> -		else {
> -			tsc->polling = 0;
> -			dev_err(tsc->dev, "re-schedule failed");
> -		}
> -	} else
> -		tsc->polling = 0;
> +	schd = schedule_delayed_work(&tsc->work,
> +				msecs_to_jiffies(tsc->poll_period));
> +	if (!schd)
> +		dev_err(tsc->dev, "re-schedule failed");
>  
>  	ret = tps6507x_adc_standby(tsc);
>  }
> @@ -324,10 +312,7 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
>  	schd = schedule_delayed_work(&tsc->work,
>  				     msecs_to_jiffies(tsc->poll_period));
>  
> -	if (schd)
> -		tsc->polling = 1;
> -	else {
> -		tsc->polling = 0;
> +	if (!schd) {
>  		dev_err(tsc->dev, "schedule failed");
>  		goto err2;
>  	 }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
