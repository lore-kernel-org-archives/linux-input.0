From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] rotary encoder: Add wake up support
Date: Thu, 29 Jan 2015 11:49:53 +0100
Message-ID: <20150129104953.GC5312@localhost>
References: <1421164262-28261-1-git-send-email-sylvain.rochet@finsecur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34039 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722AbbA2Ktz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 05:49:55 -0500
Received: by mail-lb0-f172.google.com with SMTP id l4so26690570lbv.3
        for <linux-input@vger.kernel.org>; Thu, 29 Jan 2015 02:49:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421164262-28261-1-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Rochet <sylvain.rochet@finsecur.com>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>

On Tue, Jan 13, 2015 at 04:51:02PM +0100, Sylvain Rochet wrote:
> This patch add wake up support for rotary encoders.
> New DT property: rotary-encoder,wakeup
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
>  Documentation/input/rotary-encoder.txt             |  1 +
>  drivers/input/misc/rotary_encoder.c                | 36 ++++++++++++++++++++++
>  include/linux/rotary_encoder.h                     |  1 +
>  4 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index 3315495..468d545 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -15,6 +15,7 @@ Optional properties:
>  - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
>    greater than the specified steps or smaller than 0. For absolute axis only.
>  - rotary-encoder,half-period: Makes the driver work on half-period mode.
> +- rotary-encoder,wakeup: Boolean, rotary encoder can wake-up the system.

As Dmitry already mentioned this should probably just be
"wakeup-source".

[...]

> +static SIMPLE_DEV_PM_OPS(rotary_encoder_pm_ops, rotary_encoder_suspend, rotary_encoder_resume);

Please break this line to stay within 80 cols.

> +
>  static struct platform_driver rotary_encoder_driver = {
>  	.probe		= rotary_encoder_probe,
>  	.remove		= rotary_encoder_remove,
>  	.driver		= {
>  		.name	= DRV_NAME,
> +		.pm	= &rotary_encoder_pm_ops,
>  		.of_match_table = of_match_ptr(rotary_encoder_of_match),
>  	}
>  };
> diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
> index 3f594dc..72b3fc9 100644
> --- a/include/linux/rotary_encoder.h
> +++ b/include/linux/rotary_encoder.h
> @@ -11,6 +11,7 @@ struct rotary_encoder_platform_data {
>  	bool relative_axis;
>  	bool rollover;
>  	bool half_period;
> +	int wakeup;			/* configure the rotary-encoder as a wake-up source */

This should be bool.

I also suggest you rename the variable wakeup_source and drop the
verbose comment.

Looks good otherwise.

Thanks,
Johan
