From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: drv2667: Fix misuse of regmap_update_bits
Date: Tue, 29 Nov 2016 17:39:40 -0800
Message-ID: <20161130013940.GD20680@dtor-ws>
References: <1480438754-14794-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1480438754-14794-3-git-send-email-florian.vaussard@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35995 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751726AbcK3Bjn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 20:39:43 -0500
Content-Disposition: inline
In-Reply-To: <1480438754-14794-3-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Florian Vaussard <florian.vaussard@heig-vd.ch>

On Tue, Nov 29, 2016 at 05:59:14PM +0100, Florian Vaussard wrote:
> Using regmap_update_bits(..., mask, 1) with 'mask' following (1 << k)
> and k greater than 0 is wrong. Indeed, _regmap_update_bits will perform
> (mask & 1), which results in 0 if LSB of mask is 0. Thus the call
> regmap_update_bits(..., mask, 1) is in reality equivalent to
> regmap_update_bits(..., mask, 0).
> 
> In such a case, the correct use is regmap_update_bits(..., mask, mask).
> 
> This driver is performing such a mistake with the DRV2667_STANDBY mask,
> which equals (1 << 6). Fix the driver to make it consistent with the
> API, and fix the alignment problem at the same time. Please note that
> this change is untested, as I do not have this piece of hardware.
> Testers are welcome!
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>

Applied, thank you.

> ---
>  drivers/input/misc/drv2667.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
> index d5ba748..2849bb6 100644
> --- a/drivers/input/misc/drv2667.c
> +++ b/drivers/input/misc/drv2667.c
> @@ -256,7 +256,7 @@ static void drv2667_close(struct input_dev *input)
>  	cancel_work_sync(&haptics->work);
>  
>  	error = regmap_update_bits(haptics->regmap, DRV2667_CTRL_2,
> -				DRV2667_STANDBY, 1);
> +				   DRV2667_STANDBY, DRV2667_STANDBY);
>  	if (error)
>  		dev_err(&haptics->client->dev,
>  			"Failed to enter standby mode: %d\n", error);
> @@ -415,7 +415,7 @@ static int __maybe_unused drv2667_suspend(struct device *dev)
>  
>  	if (haptics->input_dev->users) {
>  		ret = regmap_update_bits(haptics->regmap, DRV2667_CTRL_2,
> -				DRV2667_STANDBY, 1);
> +					 DRV2667_STANDBY, DRV2667_STANDBY);
>  		if (ret) {
>  			dev_err(dev, "Failed to set standby mode\n");
>  			regulator_disable(haptics->regulator);
> -- 
> 2.5.5
> 

-- 
Dmitry
