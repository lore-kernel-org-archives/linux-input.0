From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: touchscreen: ar1021_i2c: replace magic number
 with definition
Date: Fri, 28 Apr 2017 10:06:13 -0700
Message-ID: <20170428170613.GB4949@dtor-ws>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
 <1493295756-17812-2-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34326 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032344AbdD1RGQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 13:06:16 -0400
Content-Disposition: inline
In-Reply-To: <1493295756-17812-2-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 27, 2017 at 02:22:36PM +0200, Martin Kepplinger wrote:
> We now have a few of this device's definitions. Let's avoid magic numbers
> and use them.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 2a76231..edd5268 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -44,7 +44,7 @@ static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
>  		goto out;
>  
>  	/* sync bit set ? */
> -	if ((data[0] & 0x80) == 0)
> +	if ((data[0] & AR1021_TOUCH) == 0)

I'd rather have it as "(data & BIT(7))". This constant does not provide
any better meaning than number 0x80. At least the latter shows that we
test the MSB or the first byte, while the former obfuscates it.

Thanks.

-- 
Dmitry
