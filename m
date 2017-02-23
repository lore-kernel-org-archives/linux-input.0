From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: synaptics_i2c - Add OF device ID table
Date: Thu, 23 Feb 2017 00:31:43 -0800
Message-ID: <20170223083143.GD18639@dtor-ws>
References: <20170221181254.14748-1-javier@osg.samsung.com>
 <20170221181254.14748-2-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33382 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdBWIkG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 03:40:06 -0500
Content-Disposition: inline
In-Reply-To: <20170221181254.14748-2-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, Aniroop Mathur <a.mathur@samsung.com>, linux-input@vger.kernel.org

On Tue, Feb 21, 2017 at 03:12:53PM -0300, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.

This driver is for touchpad controller on a specific device, and as far
as I understand, for a specific firmware. I am not sure if it will ever
be reused.

Igor, maybe we need to drop it altogether?

> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/input/mouse/synaptics_i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
> index cb2bf203f4ca..8538318d332c 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -652,9 +652,18 @@ static const struct i2c_device_id synaptics_i2c_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, synaptics_i2c_id_table);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id synaptics_i2c_of_match[] = {
> +	{ .compatible = "synaptics,synaptics_i2c", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, synaptics_i2c_of_match);
> +#endif
> +
>  static struct i2c_driver synaptics_i2c_driver = {
>  	.driver = {
>  		.name	= DRIVER_NAME,
> +		.of_match_table = of_match_ptr(synaptics_i2c_of_match),
>  		.pm	= &synaptics_i2c_pm,
>  	},
>  
> -- 
> 2.9.3
> 

-- 
Dmitry
