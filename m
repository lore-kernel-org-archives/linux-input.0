From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/7] input/i_am335x_tsc: removed unused variable in titsc_irq()
Date: Wed, 22 May 2013 22:44:40 +0100
Message-ID: <519D3C48.1060609@kernel.org>
References: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de> <1369256897-25984-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39308 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab3EVVon (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 May 2013 17:44:43 -0400
In-Reply-To: <1369256897-25984-3-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Patil Rachna <rachna@ti.com>

 Check the patch title for the missing letter t.  It jumped out at me.

On 05/22/2013 10:08 PM, Sebastian Andrzej Siewior wrote:
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index e778ffd..a85818b 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -319,7 +319,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>  	unsigned int z1, z2, z;
>  	unsigned int fsm;
>  	unsigned int diffx = 0, diffy = 0;
> -	int i;
>  
>  	status = titsc_readl(ts_dev, REG_IRQSTATUS);
>  	if (status & IRQENB_FIFO0THRES) {
> 
