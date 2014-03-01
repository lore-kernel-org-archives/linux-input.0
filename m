From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4: Trivial F11 tidy up
Date: Sat, 1 Mar 2014 10:41:40 -0800
Message-ID: <20140301184140.GA11122@core.coreip.homeip.net>
References: <1393366096-5524-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:59861 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756082AbaCZU0E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Mar 2014 16:26:04 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so2357542pdb.28
        for <linux-input@vger.kernel.org>; Wed, 26 Mar 2014 13:26:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1393366096-5524-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>

On Tue, Feb 25, 2014 at 02:08:16PM -0800, Christopher Heiny wrote:
> Delete an unused symbol and update copyright date.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Applied, thank you.

> 
> --
> 
>  drivers/input/rmi4/rmi_f11.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 2aa7d17..9cc1406 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2011-2013 Synaptics Incorporated
> + * Copyright (c) 2011-2014 Synaptics Incorporated
>   * Copyright (c) 2011 Unixphere
>   *
>   * This program is free software; you can redistribute it and/or modify it
> @@ -7,8 +7,6 @@
>   * the Free Software Foundation.
>   */
>  
> -#define FUNCTION_DATA f11_data
> -
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>

-- 
Dmitry
