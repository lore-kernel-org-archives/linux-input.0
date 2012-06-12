From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 5/9] Input: tegra-kbc - add clk_prepare/clk_unprepare
Date: Tue, 12 Jun 2012 00:30:06 -0700
Message-ID: <20120612073006.GB9766@core.coreip.homeip.net>
References: <1338870583-8704-1-git-send-email-pgaikwad@nvidia.com>
 <1338870583-8704-6-git-send-email-pgaikwad@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56257 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab2FLHaO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jun 2012 03:30:14 -0400
Content-Disposition: inline
In-Reply-To: <1338870583-8704-6-git-send-email-pgaikwad@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, swarren@wwwdotorg.org, linux@arm.linux.org.uk, olof@lixom.net, ccross@android.com, linux-input@vger.kernel.org

On Tue, Jun 05, 2012 at 09:59:39AM +0530, Prashant Gaikwad wrote:
> Use clk_prepare/clk_unprepare as required by the generic clk framework.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>

Acked-by: Dmitry Torokhov <dtor@mail.ru>

> ---
> Please ignore previous versions. Updated commit message and
> maintainers properly in this version. No other change.
> 
> This patch should go through Tegra tree since other patches to port tegra
> to generic clock framework are dependent on it. Posting here to get ack from
> the maintainers.
> 
>  drivers/input/keyboard/tegra-kbc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index 4ffe64d..2c1c9ed 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -492,7 +492,7 @@ static int tegra_kbc_start(struct tegra_kbc *kbc)
>  	unsigned int debounce_cnt;
>  	u32 val = 0;
>  
> -	clk_enable(kbc->clk);
> +	clk_prepare_enable(kbc->clk);
>  
>  	/* Reset the KBC controller to clear all previous status.*/
>  	tegra_periph_reset_assert(kbc->clk);
> @@ -556,7 +556,7 @@ static void tegra_kbc_stop(struct tegra_kbc *kbc)
>  	disable_irq(kbc->irq);
>  	del_timer_sync(&kbc->timer);
>  
> -	clk_disable(kbc->clk);
> +	clk_disable_unprepare(kbc->clk);
>  }
>  
>  static int tegra_kbc_open(struct input_dev *dev)
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
