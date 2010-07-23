From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch -next] input: adxl34x: fix leak and use after free
Date: Thu, 22 Jul 2010 23:44:35 -0700
Message-ID: <20100723064435.GC20532@core.coreip.homeip.net>
References: <20100722085552.GW17585@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47334 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0GWGoj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Jul 2010 02:44:39 -0400
Content-Disposition: inline
In-Reply-To: <20100722085552.GW17585@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, Chris Verges <chrisv@cyberswitching.com>, Luotao Fu <l.fu@pengutronix.de>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Thu, Jul 22, 2010 at 10:55:52AM +0200, Dan Carpenter wrote:
> These are a couple smatch issues.  In the original code, if only one of
> the allocation fails we leak the other variable so we should goto
> out_free_mem.
> 
> Also there was a use after free if debugging was enabled and so I moved
> the kfree() down a line.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 

Applied, thanks Dan.

> diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
> index bb9c10f..e925d12 100644
> --- a/drivers/input/misc/adxl34x.c
> +++ b/drivers/input/misc/adxl34x.c
> @@ -709,7 +709,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
>  	input_dev = input_allocate_device();
>  	if (!ac || !input_dev) {
>  		err = -ENOMEM;
> -		goto err_out;
> +		goto err_free_mem;
>  	}
>  
>  	ac->fifo_delay = fifo_delay_default;
> @@ -904,9 +904,9 @@ int adxl34x_remove(struct adxl34x *ac)
>  	sysfs_remove_group(&ac->dev->kobj, &adxl34x_attr_group);
>  	free_irq(ac->irq, ac);
>  	input_unregister_device(ac->input);
> +	dev_dbg(ac->dev, "unregistered accelerometer\n");
>  	kfree(ac);
>  
> -	dev_dbg(ac->dev, "unregistered accelerometer\n");
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(adxl34x_remove);

-- 
Dmitry
