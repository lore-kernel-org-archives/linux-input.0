From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/2] Input: axp20x-pek: add support for AXP221 PEK
Date: Wed, 16 Aug 2017 17:46:15 -0700
Message-ID: <20170817004615.GF25491@dtor-ws>
References: <cover.634526c9e3d069f72bc162cdcaa9bb7c822d346a.1502271751.git-series.quentin.schulz@free-electrons.com>
 <d683600a390ba25187ff7d260a2efb3c00cc4b5f.1502271751.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34400 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbdHQAv5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Aug 2017 20:51:57 -0400
Content-Disposition: inline
In-Reply-To: <d683600a390ba25187ff7d260a2efb3c00cc4b5f.1502271751.git-series.quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: wens@csie.org, lee.jones@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com

On Wed, Aug 09, 2017 at 11:45:55AM +0200, Quentin Schulz wrote:
> The AXP221 has different values for startup time bits from the AXP20X.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thank you.

> ---
>  drivers/input/misc/axp20x-pek.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
> index f616fe5..a542906 100644
> --- a/drivers/input/misc/axp20x-pek.c
> +++ b/drivers/input/misc/axp20x-pek.c
> @@ -56,6 +56,13 @@ static const struct axp20x_time startup_time[] = {
>  	{ .time = 2000, .idx = 3 },
>  };
>  
> +static const struct axp20x_time axp221_startup_time[] = {
> +	{ .time = 128,  .idx = 0 },
> +	{ .time = 1000, .idx = 1 },
> +	{ .time = 2000, .idx = 2 },
> +	{ .time = 3000, .idx = 3 },
> +};
> +
>  static const struct axp20x_time shutdown_time[] = {
>  	{ .time = 4000,  .idx = 0 },
>  	{ .time = 6000,  .idx = 1 },
> @@ -70,6 +77,13 @@ static const struct axp20x_info axp20x_info = {
>  	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
>  };
>  
> +static const struct axp20x_info axp221_info = {
> +	.startup_time = axp221_startup_time,
> +	.startup_mask = AXP20X_PEK_STARTUP_MASK,
> +	.shutdown_time = shutdown_time,
> +	.shutdown_mask = AXP20X_PEK_SHUTDOWN_MASK,
> +};
> +
>  static ssize_t axp20x_show_attr(struct device *dev,
>  				const struct axp20x_time *time,
>  				unsigned int mask, char *buf)
> @@ -382,6 +396,9 @@ static const struct platform_device_id axp_pek_id_match[] = {
>  	{
>  		.name = "axp20x-pek",
>  		.driver_data = (kernel_ulong_t)&axp20x_info,
> +	}, {
> +		.name = "axp221-pek",
> +		.driver_data = (kernel_ulong_t)&axp221_info,
>  	},
>  };
>  
> -- 
> git-series 0.9.1

-- 
Dmitry
