From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v1] Input: tegra-kbc - enable key interrupt for wakeup
Date: Thu, 19 Jan 2012 11:17:33 +0530
Message-ID: <4F17AE75.6000605@ti.com>
References: <1326925981-14723-1-git-send-email-riyer@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50077 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751589Ab2ASFrm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Jan 2012 00:47:42 -0500
In-Reply-To: <1326925981-14723-1-git-send-email-riyer@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>
Cc: dmitry.torokhov@gmail.com, swarren@nvidia.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 19 January 2012 04:03 AM, Rakesh Iyer wrote:
> Enable keypress interrupt to support wakeup from low power state.
>
> Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
> ---
>  drivers/input/keyboard/tegra-kbc.c |   17 +++++++++++++++++
>  1 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index a136e2e..b307a46 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -48,6 +48,7 @@
>  #define KBC_FIFO_TH_CNT_SHIFT(cnt)	(cnt << 14)
>  #define KBC_DEBOUNCE_CNT_SHIFT(cnt)	(cnt << 4)
>  #define KBC_CONTROL_FIFO_CNT_INT_EN	(1 << 3)
> +#define KBC_CONTROL_KEYPRESS_INT_EN	(1 << 1)
>  #define KBC_CONTROL_KBC_EN		(1 << 0)
>  
>  /* KBC Interrupt Register */
> @@ -356,6 +357,18 @@ static void tegra_kbc_set_fifo_interrupt(struct tegra_kbc *kbc, bool enable)
>  	writel(val, kbc->mmio + KBC_CONTROL_0);
>  }
>  
> +static void tegra_kbc_set_keypress_interrupt(struct tegra_kbc *kbc, bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(kbc->mmio + KBC_CONTROL_0);
> +	if (enable)
> +		val |= KBC_CONTROL_KEYPRESS_INT_EN;
> +	else
> +		val &= ~KBC_CONTROL_KEYPRESS_INT_EN;
> +	writel(val, kbc->mmio + KBC_CONTROL_0);
> +}
> +
>  static void tegra_kbc_keypress_timer(unsigned long data)
>  {
>  	struct tegra_kbc *kbc = (struct tegra_kbc *)data;
> @@ -831,6 +844,8 @@ static int tegra_kbc_suspend(struct device *dev)
>  		msleep(30);
>  
>  		kbc->keypress_caused_wake = false;
> +		/* Enable keypress interrupt before going into suspend. */
> +		tegra_kbc_set_keypress_interrupt(kbc, true);
>  		enable_irq(kbc->irq);
>  		enable_irq_wake(kbc->irq);
>  	} else {
> @@ -852,6 +867,8 @@ static int tegra_kbc_resume(struct device *dev)
>  	if (device_may_wakeup(&pdev->dev)) {
>  		disable_irq_wake(kbc->irq);
>  		tegra_kbc_setup_wakekeys(kbc, false);
> +		/* We will use fifo interrupts for key detection. */
> +		tegra_kbc_set_keypress_interrupt(kbc, false);
Why do yo disable on resume why not have it enabled always?

>  
>  		/* Restore the resident time of continuous polling mode. */
>  		writel(kbc->cp_to_wkup_dly, kbc->mmio + KBC_TO_CNT_0);

