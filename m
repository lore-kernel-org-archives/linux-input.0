From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zet6223 - Export OF device ID as module aliases
Date: Mon, 20 Feb 2017 15:28:47 -0800
Message-ID: <20170220232847.GA36910@dtor-ws>
References: <20170220200855.9951-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36118 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdBTX2v (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Feb 2017 18:28:51 -0500
Content-Disposition: inline
In-Reply-To: <20170220200855.9951-1-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Jelle van der Waa <jelle@vdwaa.nl>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org

On Mon, Feb 20, 2017 at 05:08:55PM -0300, Javier Martinez Canillas wrote:
> The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
> device was registered via OF, this means that exporting the OF device ID
> table device aliases in the module is not needed. But in order to change
> how the core reports modaliases to user-space, it's better to export it.
> 
> Before this patch:
> 
> $ modinfo drivers/input/touchscreen/zet6223.ko | grep alias
> alias:          i2c:zet6223
> 
> After this patch:
> 
> $ modinfo drivers/input/touchscreen/zet6223.ko | grep alias
> alias:          of:N*T*Czeitec,zet6223C*
> alias:          of:N*T*Czeitec,zet6223
> alias:          i2c:zet6223
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> ---
> 
>  drivers/input/touchscreen/zet6223.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/zet6223.c b/drivers/input/touchscreen/zet6223.c
> index e7fb00b511ec..19ffcc7b886c 100644
> --- a/drivers/input/touchscreen/zet6223.c
> +++ b/drivers/input/touchscreen/zet6223.c
> @@ -245,6 +245,7 @@ static const struct of_device_id zet6223_of_match[] = {
>  	{ .compatible = "zeitec,zet6223" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, zet6223_of_match);
>  
>  static const struct i2c_device_id zet6223_id[] = {
>  	{ "zet6223", 0},
> -- 
> 2.9.3
> 

-- 
Dmitry
