From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: keypad-omap - Cleanup header file
Date: Fri, 27 Dec 2013 17:15:07 -0800
Message-ID: <20131228011507.GC14188@core.coreip.homeip.net>
References: <1388145788-6253-1-git-send-email-sachin.kamat@linaro.org>
 <1388145788-6253-2-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36330 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab3L1BPK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Dec 2013 20:15:10 -0500
Received: by mail-pa0-f42.google.com with SMTP id lj1so9817571pab.15
        for <linux-input@vger.kernel.org>; Fri, 27 Dec 2013 17:15:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1388145788-6253-2-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org

On Fri, Dec 27, 2013 at 05:33:08PM +0530, Sachin Kamat wrote:
> Commit 2203747c9771 ("ARM: omap: move platform_data definitions")
> moved the file to the current location but forgot to remove the pointer
> to its previous location. Clean it up. While at it also change the header
> file protection macros appropriately.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Applied both, thanks Sachin.

> ---
>  include/linux/platform_data/keypad-omap.h |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/platform_data/keypad-omap.h b/include/linux/platform_data/keypad-omap.h
> index a6b21eddb212..c3a3abae98f0 100644
> --- a/include/linux/platform_data/keypad-omap.h
> +++ b/include/linux/platform_data/keypad-omap.h
> @@ -1,14 +1,12 @@
>  /*
> - *  arch/arm/plat-omap/include/mach/keypad.h
> - *
>   *  Copyright (C) 2006 Komal Shah <komal_shah802003@yahoo.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> -#ifndef ASMARM_ARCH_KEYPAD_H
> -#define ASMARM_ARCH_KEYPAD_H
> +#ifndef __KEYPAD_OMAP_H
> +#define __KEYPAD_OMAP_H
>  
>  #ifndef CONFIG_ARCH_OMAP1
>  #warning Please update the board to use matrix-keypad driver
> -- 
> 1.7.9.5
> 

-- 
Dmitry
