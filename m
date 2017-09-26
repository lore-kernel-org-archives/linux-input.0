From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sa1111ps2 - extend test delay
Date: Tue, 26 Sep 2017 09:57:26 -0700
Message-ID: <20170926165726.GE14833@dtor-ws>
References: <E1dwsgD-0006Hy-5u@rmk-PC.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37185 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966076AbdIZQ5a (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 26 Sep 2017 12:57:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id e69so5223506pfg.4
        for <linux-input@vger.kernel.org>; Tue, 26 Sep 2017 09:57:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1dwsgD-0006Hy-5u@rmk-PC.armlinux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: linux-input@vger.kernel.org

On Tue, Sep 26, 2017 at 05:25:53PM +0100, Russell King wrote:
> A 2us delay is too small for the bus to settle after writing to the
> register.  Extend to 10us which gives more reliable results.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied, thank you.

> ---
>  drivers/input/serio/sa1111ps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
> index f1c036260d25..f9e5c793f4f0 100644
> --- a/drivers/input/serio/sa1111ps2.c
> +++ b/drivers/input/serio/sa1111ps2.c
> @@ -212,7 +212,7 @@ static unsigned int ps2_test_one(struct ps2if *ps2if,
>  
>  	writel_relaxed(PS2CR_ENA | mask, ps2if->base + PS2CR);
>  
> -	udelay(2);
> +	udelay(10);
>  
>  	val = readl_relaxed(ps2if->base + PS2STAT);
>  	return val & (PS2STAT_KBC | PS2STAT_KBD);
> -- 
> 2.7.4
> 

-- 
Dmitry
