From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input synaptics-rmi4 trivial: rmi_f01.c tidy-up
Date: Thu, 9 Jan 2014 00:11:32 -0800
Message-ID: <20140109081132.GC27160@core.coreip.homeip.net>
References: <1389139662-6590-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:43966 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaAIILg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 03:11:36 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so2705455pbb.4
        for <linux-input@vger.kernel.org>; Thu, 09 Jan 2014 00:11:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1389139662-6590-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tue, Jan 07, 2014 at 04:07:42PM -0800, Christopher Heiny wrote:
> This has two trivial changes:
> 
> 1) use CONFIG_PM_SLEEP instead of CONFIG_PM for consistency.
> 
> 2) Update the copyright date.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> ---
>  drivers/input/rmi4/rmi_f01.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index 628b082..d547633 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2011-2012 Synaptics Incorporated
> + * Copyright (c) 2011-2014 Synaptics Incorporated
>   * Copyright (c) 2011 Unixphere
>   *
>   * This program is free software; you can redistribute it and/or modify it
> @@ -138,7 +138,7 @@ struct f01_data {
>  	int irq_count;
>  	int num_of_irq_regs;
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  	bool suspended;
>  	bool old_nosleep;
>  #endif

-- 
Dmitry
