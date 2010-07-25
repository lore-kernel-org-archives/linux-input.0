From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/8] touchscreen: fix sign bug
Date: Sun, 25 Jul 2010 23:32:41 +0200
Message-ID: <20100725213240.GA2613@sortiz-mobl>
References: <1279219435-12128-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:44177 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab0GYVcl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Jul 2010 17:32:41 -0400
Content-Disposition: inline
In-Reply-To: <1279219435-12128-1-git-send-email-segooon@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kulikov Vasiliy <segooon@gmail.com>
Cc: kernel-janitors@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Luotao Fu <l.fu@pengutronix.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Vasiliy,

On Thu, Jul 15, 2010 at 10:43:54PM +0400, Kulikov Vasiliy wrote:
> platform_get_irq_byname() can return negative results, it is not seen to
> unsigned ts_irq. Make it signed.
Patch applied to my mfd tree, thanks.

Cheers,
Samuel.


> Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
> index 77f4374..656148e 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -269,7 +269,7 @@ static int __devinit stmpe_input_probe(struct platform_device *pdev)
>  	struct input_dev *idev;
>  	struct stmpe_ts_platform_data *ts_pdata = NULL;
>  	int ret = 0;
> -	unsigned int ts_irq;
> +	int ts_irq;
>  
>  	ts_irq = platform_get_irq_byname(pdev, "FIFO_TH");
>  	if (ts_irq < 0)
> -- 
> 1.7.0.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
