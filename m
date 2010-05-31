From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/2] input/tps6507x-ts: dereferencing before checking
Date: Mon, 31 May 2010 12:17:23 -0700
Message-ID: <20100531191723.GE30712@core.coreip.homeip.net>
References: <20100531120122.GR5483@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43421 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093Ab0EaTRn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 May 2010 15:17:43 -0400
Content-Disposition: inline
In-Reply-To: <20100531120122.GR5483@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Todd Fischer <todd.fischer@ridgerun.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, May 31, 2010 at 02:01:22PM +0200, Dan Carpenter wrote:
> This patch moves the dereference after the check for NULL.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
> index 5de80a1..b99db09 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -355,10 +355,11 @@ static int __devexit tps6507x_ts_remove(struct platform_device *pdev)
>  {
>  	struct tps6507x_dev *tps6507x_dev = platform_get_drvdata(pdev);
>  	struct tps6507x_ts *tsc = tps6507x_dev->ts;
> -	struct input_dev *input_dev = tsc->input_dev;
> +	struct input_dev *input_dev;
>  
>  	if (!tsc)
>  		return 0;
> +	input_dev = tsc->input_dev;
>  

Why would tsc ever be NULL?

Also I really do not like that pdev's driver data that is supposed to be
driver-private data is being used by the parent. Parent should be using
it's own drvdata and leave child's data alone. We should probably do in
platform code what I2C is about to do and clear drvdata on unbind
automatically to prevent this kind of misuse.

-- 
Dmitry
