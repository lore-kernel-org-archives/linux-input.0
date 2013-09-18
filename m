From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: pxa27x_keypad: fix NULL pointer dereference
Date: Wed, 18 Sep 2013 08:17:53 -0700
Message-ID: <20130918151752.GA6325@core.coreip.homeip.net>
References: <1379516624-3789-1-git-send-email-mikedunn@newsguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:41885 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3IRPSA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 11:18:00 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so7209212pdi.33
        for <linux-input@vger.kernel.org>; Wed, 18 Sep 2013 08:17:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1379516624-3789-1-git-send-email-mikedunn@newsguy.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Dunn <mikedunn@newsguy.com>
Cc: linux-input@vger.kernel.org, Chao Xie <chao.xie@marvell.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Marek Vasut <marex@denx.de>

On Wed, Sep 18, 2013 at 08:03:44AM -0700, Mike Dunn wrote:
> A NULL pointer dereference exception occurs in the driver probe function when
> device tree is used.  The pdata pointer will be NULL in this case, but the code
> dereferences it in all cases.  When device tree is used, a platform data
> structure is allocated and initialized, and in all cases this pointer is copied
> to the driver's private data, so the variable being tested should be accessed
> through the driver's private data structure.
> 
> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>

Applied, thank you.

> ---
> Changelog:
> v2:
> Initialize pdata for DT case, instead of referencing through keypad struct.
> 
>  drivers/input/keyboard/pxa27x_keypad.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index 134c3b4..d02bdb2 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -788,8 +788,10 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
>  
>  	if (pdata)
>  		error = pxa27x_keypad_build_keycode(keypad);
> -	else
> +	else {
>  		error = pxa27x_keypad_build_keycode_from_dt(keypad);
> +		pdata = keypad->pdata;
> +	}
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to build keycode\n");
>  		goto failed_put_clk;
> -- 
> 1.8.1.5
> 

-- 
Dmitry
