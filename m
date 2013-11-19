From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 26/31] Input: tegra-kbc - use reset framework
Date: Tue, 19 Nov 2013 13:17:21 -0800
Message-ID: <20131119211721.GB14888@core.coreip.homeip.net>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-27-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33835 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab3KTOh1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Nov 2013 09:37:27 -0500
Content-Disposition: inline
In-Reply-To: <1384548866-13141-27-git-send-email-swarren@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Stephen Warren <swarren@nvidia.com>, treding@nvidia.com, pdeschrijver@nvidia.com, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Fri, Nov 15, 2013 at 01:54:21PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's clock driver now provides an implementation of the common
> reset API (include/linux/reset.h). Use this instead of the old Tegra-
> specific API; that will soon be removed.
> 
> Cc: treding@nvidia.com
> Cc: pdeschrijver@nvidia.com
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Dmitry Torokhov <dtor@mail.ru>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
> This patch is part of a series with strong internal depdendencies. I'm
> looking for an ack so that I can take the entire series through the Tegra
> and arm-soc trees. The series will be part of a stable branch that can be
> merged into other subsystems if needed to avoid/resolve dependencies.
> ---
>  drivers/input/keyboard/tegra-kbc.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index 8508879f6faf..9757a58bc897 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -31,7 +31,7 @@
>  #include <linux/clk.h>
>  #include <linux/slab.h>
>  #include <linux/input/matrix_keypad.h>
> -#include <linux/clk/tegra.h>
> +#include <linux/reset.h>
>  #include <linux/err.h>
>  
>  #define KBC_MAX_KPENT	8
> @@ -116,6 +116,7 @@ struct tegra_kbc {
>  	u32 wakeup_key;
>  	struct timer_list timer;
>  	struct clk *clk;
> +	struct reset_control *rst;
>  	const struct tegra_kbc_hw_support *hw_support;
>  	int max_keys;
>  	int num_rows_and_columns;
> @@ -373,9 +374,9 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
>  	clk_prepare_enable(kbc->clk);
>  
>  	/* Reset the KBC controller to clear all previous status.*/
> -	tegra_periph_reset_assert(kbc->clk);
> +	reset_control_assert(kbc->rst);
>  	udelay(100);
> -	tegra_periph_reset_deassert(kbc->clk);
> +	reset_control_assert(kbc->rst);
>  	udelay(100);
>  
>  	tegra_kbc_config_pins(kbc);
> @@ -663,6 +664,12 @@ static int tegra_kbc_probe(struct platform_device *pdev)
>  		return PTR_ERR(kbc->clk);
>  	}
>  
> +	kbc->rst = devm_reset_control_get(&pdev->dev, "kbc");
> +	if (IS_ERR(kbc->rst)) {
> +		dev_err(&pdev->dev, "failed to get keyboard reset\n");
> +		return PTR_ERR(kbc->rst);
> +	}
> +
>  	/*
>  	 * The time delay between two consecutive reads of the FIFO is
>  	 * the sum of the repeat time and the time taken for scanning
> -- 
> 1.8.1.5
> 

-- 
Dmitry
