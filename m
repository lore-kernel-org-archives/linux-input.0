From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 2/2] input: rotary encoder: Add wake up support
Date: Tue, 13 Oct 2015 14:39:48 +0200
Message-ID: <20151013123948.GI8067@localhost>
References: <1444677212-9590-1-git-send-email-sylvain.rochet@finsecur.com>
 <1444677212-9590-3-git-send-email-sylvain.rochet@finsecur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35907 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbbJMMjw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 08:39:52 -0400
Received: by lbcao8 with SMTP id ao8so18162022lbc.3
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 05:39:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444677212-9590-3-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Rochet <sylvain.rochet@finsecur.com>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Mon, Oct 12, 2015 at 09:13:32PM +0200, Sylvain Rochet wrote:
> This patch adds wake up support to GPIO rotary encoders.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>

Hmm. I have not yet reviewed the changes you did in v4.

> ---
>  drivers/input/misc/rotary_encoder.c | 39 +++++++++++++++++++++++++++++++++++++
>  include/linux/rotary_encoder.h      |  1 +
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index f27f81e..0d86dc4 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c

> @@ -280,6 +283,10 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>  		goto exit_free_irq_b;
>  	}
>  
> +	device_set_wakeup_capable(&pdev->dev, true);

You should continue to use the platform data to determine whether the
device is capable of wakeup or not.

> +	if (pdata->wakeup_source)
> +		device_wakeup_enable(&pdev->dev);
> +

Just stick to

	device_init_wakeup(&pdev->dev, pdata->wakeup_source);

as in v3.

Johan
