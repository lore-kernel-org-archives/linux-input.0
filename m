From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
Date: Fri, 05 Feb 2010 13:35:52 +0300
Message-ID: <4B6BF488.3070107@ru.mvista.com>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f228.google.com ([209.85.219.228]:37591 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0BEKg1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 05:36:27 -0500
Received: by ewy28 with SMTP id 28so4093465ewy.28
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2010 02:36:25 -0800 (PST)
In-Reply-To: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

Hello.

Eric Miao wrote:

> commit 31cec413e534520111716802833675f53ac99b0b
> Author: Eric Miao <eric.y.miao@gmail.com>
> Date:   Thu Feb 4 16:41:28 2010 -0800
>
>     input: schedule corgi_ssp and corgi_ts to be removed
>
>     Cc: Richard Purdie <rpurdie@rpsys.net>
>     Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>   

   Some grammar nitpicking...

> diff --git a/Documentation/feature-removal-schedule.txt
> b/Documentation/feature-removal-schedule.txt
> index 5860583..e16529e 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -554,3 +554,15 @@ Why:	We now have a generic GPIO based matrix
> keyboard driver that
>  	and so are difficult to maintain.
>  Who:	Eric Miao <eric.y.miao@gmail.com>
>
> +----------------------------
> +
> +What:	corgi_ssp and corgi_ts driver
> +When:	2.6.35
> +Files:	arch/arm/mach-pxa/corgi_ssp.c, drivers/input/touchscreen/corgi_ts.c
> +Why:	The corgi touchscreen is now deprecated in favour of the generic
> +	ads7846.c driver. The noise reduction technique used in corgi_ts.c
> +	that to wait til vsync before ADC sampling is also

   that's?


>  inte grated into
>   

    integrated.

> +	ads7846 driver now. Provided that the original driver is no generic
>   

   not generic

> +	and difficult to maintain, will be removed later.
>   

   it will.

> +Who:	Eric Miao <eric.y.miao@gmail.com>
> +
>   

WBR, Sergei

