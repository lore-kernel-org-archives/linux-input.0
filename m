From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [v1] Input: tegra-kbc - modify keypress wakeup logic.
Date: Fri, 6 May 2011 22:56:42 -0700
Message-ID: <20110507055641.GA5291@core.coreip.homeip.net>
References: <1304382188-29530-1-git-send-email-riyer@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:34885 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab1EGF4t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 May 2011 01:56:49 -0400
Content-Disposition: inline
In-Reply-To: <1304382188-29530-1-git-send-email-riyer@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: riyer@nvidia.com
Cc: rydberg@euromail.se, amartin@nvidia.com, olof@lixom.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Rakesh,

On Mon, May 02, 2011 at 05:23:08PM -0700, riyer@nvidia.com wrote:
> From: Rakesh Iyer <riyer@nvidia.com>
> 
> Modify wakeup logic so either all keypresses wake the system or none do.
> 
> Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
> ---
> v1: Modify wakeup logic so either all keypresses wake the system or none do.
> 
>  arch/arm/mach-tegra/include/mach/kbc.h |    4 +---
>  drivers/input/keyboard/tegra-kbc.c     |   28 ++++------------------------
>  2 files changed, 5 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/arch/arm/mach-tegra/include/mach/kbc.h
> index bd99744..6b8e934 100644
> --- a/arch/arm/mach-tegra/include/mach/kbc.h
> +++ b/arch/arm/mach-tegra/include/mach/kbc.h
> @@ -50,14 +50,12 @@ struct tegra_kbc_platform_data {
>  	unsigned int debounce_cnt;
>  	unsigned int repeat_cnt;
>  
> -	unsigned int wake_cnt; /* 0:wake on any key >1:wake on wake_cfg */
> -	const struct tegra_kbc_wake_key *wake_cfg;
> -
>  	struct tegra_kbc_pin_cfg pin_cfg[KBC_MAX_GPIO];
>  	const struct matrix_keymap_data *keymap_data;
>  
>  	bool wakeup;
>  	bool use_fn_map;
>  	bool use_ghost_filter;
> +	bool wake_on_keypress;

Why do we need new wake_on_keypress flag if we already have 'wakeup'?
What besides a keypress can be used as a wakeup source with this device?

Thanks.

-- 
Dmitry
