From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 21/36] Revert " [Driver][Qualcomm 1070][CLOCK] Modify the
 AXI bus speed"
Date: Mon, 26 Jul 2010 01:46:55 -0700
Message-ID: <20100726084655.GA27151@core.coreip.homeip.net>
References: <1280133045-25945-1-git-send-email-wayne.lin@quantatw.com>
 <1280133045-25945-21-git-send-email-wayne.lin@quantatw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44212 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0GZIrC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:47:02 -0400
Received: by pvc7 with SMTP id 7so4324652pvc.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:47:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280133045-25945-21-git-send-email-wayne.lin@quantatw.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wayne Lin <00601wayne@gmail.com>
Cc: linux-input@vger.kernel.org, wayne <wayne.lin@quantatw.com>

On Mon, Jul 26, 2010 at 04:30:30PM +0800, Wayne Lin wrote:
> From: wayne <wayne.lin@quantatw.com>
> 
> This reverts commit 9ab35ce7ead42adf500950c6492fdd8aae173f5e.

You really need to sanitize your patch series before posting and not
simply dump your internal tree with all its history.

> ---
>  arch/arm/mach-msm/acpuclock-8x50a.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/acpuclock-8x50a.c b/arch/arm/mach-msm/acpuclock-8x50a.c
> index beaac14..fab4c27 100644
> --- a/arch/arm/mach-msm/acpuclock-8x50a.c
> +++ b/arch/arm/mach-msm/acpuclock-8x50a.c
> @@ -106,7 +106,7 @@ struct clkctl_acpu_speed acpu_freq_tbl[] = {
>  	{ 0,  921600, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x18, 1225 },
>  	{ 0,  960000, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x19, 1225 },
>  	{ 1,  998400, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x1A, 1225 },
> -	{ 1, 1190400, ACPU_PLL_3, 0, 0, 0, 0, 192000, 1, 0x1F, 1225 },
> +	{ 1, 1190400, ACPU_PLL_3, 0, 0, 0, 0, 128000, 1, 0x1F, 1225 },
>  	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
>  };
>  
> -- 
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
