From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: s3c2410_ts - fix s3c2410ts_probe error path
Date: Thu, 2 Sep 2010 08:54:53 -0700
Message-ID: <20100902155453.GA16914@core.coreip.homeip.net>
References: <1283415916.19272.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44149 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab0IBPzA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Sep 2010 11:55:00 -0400
Content-Disposition: inline
In-Reply-To: <1283415916.19272.1.camel@mola>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Arnaud Patard <arnaud.patard@rtp-net.org>, Simtec Electronics <linux@simtec.co.uk>, linux-input@vger.kernel.org

On Thu, Sep 02, 2010 at 04:25:16PM +0800, Axel Lin wrote:
> Use input_free_device() to free devices that have not been registered.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks Axel.

> ---
>  drivers/input/touchscreen/s3c2410_ts.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index 6085d12..8feb7f3 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -350,7 +350,7 @@ static int __devinit s3c2410ts_probe(struct platform_device *pdev)
>   err_tcirq:
>  	free_irq(ts.irq_tc, ts.input);
>   err_inputdev:
> -	input_unregister_device(ts.input);
> +	input_free_device(ts.input);
>   err_iomap:
>  	iounmap(ts.io);
>   err_clk:
> -- 
> 1.7.2
> 
> 
> 

-- 
Dmitry
