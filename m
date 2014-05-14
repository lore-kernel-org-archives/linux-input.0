From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Request a shared interrupt for AMBA KMI devices.
Date: Tue, 13 May 2014 23:19:20 -0700
Message-ID: <20140514061920.GB13621@core.coreip.homeip.net>
References: <1399553053-20305-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:54146 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbaENGTY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 02:19:24 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so1272416pbc.32
        for <linux-input@vger.kernel.org>; Tue, 13 May 2014 23:19:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1399553053-20305-1-git-send-email-broonie@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Mark Brown <broonie@linaro.org>

On Thu, May 08, 2014 at 01:44:13PM +0100, Mark Brown wrote:
> From: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> Recent ARM boards have the KMI devices share one interrupt line rather
> than having dedicated IRQs. Update the driver to take that into account.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Applied, thank you.

> ---
>  drivers/input/serio/ambakmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
> index 762b08432de0..8b748d99b934 100644
> --- a/drivers/input/serio/ambakmi.c
> +++ b/drivers/input/serio/ambakmi.c
> @@ -79,7 +79,8 @@ static int amba_kmi_open(struct serio *io)
>  	writeb(divisor, KMICLKDIV);
>  	writeb(KMICR_EN, KMICR);
>  
> -	ret = request_irq(kmi->irq, amba_kmi_int, 0, "kmi-pl050", kmi);
> +	ret = request_irq(kmi->irq, amba_kmi_int, IRQF_SHARED, "kmi-pl050",
> +			  kmi);
>  	if (ret) {
>  		printk(KERN_ERR "kmi: failed to claim IRQ%d\n", kmi->irq);
>  		writeb(0, KMICR);
> -- 
> 2.0.0.rc2
> 

-- 
Dmitry
