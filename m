From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Input: mma8450: add device tree probe support
Date: Sat, 30 Jul 2011 21:07:25 -0600
Message-ID: <20110731030725.GD24334@ponder.secretlab.ca>
References: <1311265551-23233-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51044 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab1GaQCl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Jul 2011 12:02:41 -0400
Received: by wwe5 with SMTP id 5so4901356wwe.1
        for <linux-input@vger.kernel.org>; Sun, 31 Jul 2011 09:02:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311265551-23233-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Sammy He <r62914@freescale.com>, Eric Miao <eric.miao@linaro.org>, Dmitry Torokhov <dtor@mail.ru>

On Fri, Jul 22, 2011 at 12:25:51AM +0800, Shawn Guo wrote:
> It adds device tree probe support for mma8450 driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sammy He <r62914@freescale.com>
> Cc: Eric Miao <eric.miao@linaro.org>
> Cc: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  .../devicetree/bindings/input/fsl-mma8450.txt      |   11 +++++++++++
>  drivers/input/misc/mma8450.c                       |    8 ++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/fsl-mma8450.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/fsl-mma8450.txt b/Documentation/devicetree/bindings/input/fsl-mma8450.txt
> new file mode 100644
> index 0000000..a00c94c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/fsl-mma8450.txt
> @@ -0,0 +1,11 @@
> +* Freescale MMA8450 3-Axis Accelerometer
> +
> +Required properties:
> +- compatible : "fsl,mma8450".
> +
> +Example:
> +
> +accelerometer: mma8450@1c {
> +	compatible = "fsl,mma8450";
> +	reg = <0x1c>;
> +};
> diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
> index 20f8f92..6c76cf7 100644
> --- a/drivers/input/misc/mma8450.c
> +++ b/drivers/input/misc/mma8450.c
> @@ -24,6 +24,7 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/input-polldev.h>
> +#include <linux/of_device.h>
>  
>  #define MMA8450_DRV_NAME	"mma8450"
>  
> @@ -229,10 +230,17 @@ static const struct i2c_device_id mma8450_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mma8450_id);
>  
> +static const struct of_device_id mma8450_dt_ids[] = {
> +	{ .compatible = "fsl,mma8450", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mma8450_dt_ids);
> +
>  static struct i2c_driver mma8450_driver = {
>  	.driver = {
>  		.name	= MMA8450_DRV_NAME,
>  		.owner	= THIS_MODULE,
> +		.of_match_table = mma8450_dt_ids,
>  	},
>  	.probe		= mma8450_probe,
>  	.remove		= __devexit_p(mma8450_remove),
> -- 
> 1.7.4.1
> 
