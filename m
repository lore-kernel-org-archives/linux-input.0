From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH v3] input: goodix: Add device tree support
Date: Fri, 6 Mar 2015 14:53:59 +0100
Message-ID: <20150306145359.8d14c4e244acdf645c0c159b@ao2.it>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	<1425576761-25208-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:43224 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398AbbCFNyE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Mar 2015 08:54:04 -0500
In-Reply-To: <1425576761-25208-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>

On Thu,  5 Mar 2015 20:32:41 +0300
Aleksei Mamlin <mamlinav@gmail.com> wrote:

> This patch adds device tree support and binding information for Goodix
> GT9xx series touchscreen controller.
> It also adds support for 5-finger chips, like GT911 and GT912, which
> can be found on ARM tablets, like Wexler TAB7200 and MSI Primo73.
> 
> Changes since v2:
> * Split to two patches:
>   The first one for use max number of touches from device config.
>   The second one adds device tree support.
> 
> Changes since v1:
> * Merge patches into single patch.
> * Use max touch number from config instead of hardcoding.
> * Update description in Kconfig.
> 

Hi Aleksei,

patch history usually goes after the '---' marker, as an annotation, not
in the the commit message itself.

> Datasheets can be found here:
> https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  .../bindings/input/touchscreen/goodix.txt          | 29 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/input/touchscreen/Kconfig                  |  5 ++--
>  drivers/input/touchscreen/goodix.c                 | 21 +++++++++++++++-
>  4 files changed, 53 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> new file mode 100644
> index 0000000..8ba98ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -0,0 +1,29 @@
> +Device tree bindings for Goodix GT9xx series touchscreen controller
> +
> +Required properties:
> +
> + - compatible		: Should be "goodix,gt911"
> +				 or "goodix,gt9110"
> +				 or "goodix,gt912"
> +				 or "goodix,gt927"
> +				 or "goodix,gt9271"
> +				 or "goodix,gt928"
> +				 or "goodix,gt967"
> + - reg			: I2C address of the chip. Should be 0x5d or 0x14
> + - interrupt-parent	: Interrupt controller to which the chip is connected
> + - interrupts		: Interrupt to which the chip is connected

These touch-screens supports two lines, an interrupt line and a reset
line; and they may be both bound to gpio pins, not necessarily to
system interrupts. The fields you specified above should be enough to
cover at least the case of a gpio driven interrupt line, I just wanted
to highlight the situation.

A gpio-reset property can be added in future when the driver will
actually make use of it.

JFTR, in the Android drivers the reset operation is sometimes called a
"guitar reset", the two lines are set and unset following the sequence
shown in the datasheet in order to change the device status
(interrupted, operational), on x86 this function can be transparently
performed by ACPI, on my device it is in fact done when calling the
PS0 method.

What is the situation on your ARM devices? Are you going to make use of
the reset line explicitly at some point? I am just curious.

> +
> +Example:
> +
> +	i2c@00000000 {
> +		/* ... */
> +
> +		gt928@5d {
> +			compatible = "goodix,gt928";
> +			reg = <0x5d>;
> +			interrupt-parent = <&gpio>;
> +			interrupts = <0 0>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 389ca13..ab6852d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -76,6 +76,7 @@ geniatech	Geniatech, Inc.
>  giantplus	Giantplus Technology Co., Ltd.
>  globalscale	Globalscale Technologies, Inc.
>  gmt	Global Mixed-mode Technology, Inc.
> +goodix	Shenzhen Huiding Technology Co., Ltd.
>  google	Google, Inc.
>  gumstix	Gumstix, Inc.
>  gw	Gateworks Corporation
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 5891752..2adf724 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -297,11 +297,12 @@ config TOUCHSCREEN_FUJITSU
>  
>  config TOUCHSCREEN_GOODIX
>  	tristate "Goodix I2C touchscreen"
> -	depends on I2C && ACPI
> +	depends on I2C
>  	help
>  	  Say Y here if you have the Goodix touchscreen (such as one
>  	  installed in Onda v975w tablets) connected to your
> -	  system.
> +	  system. It also supports 5-finger chip models, which can be
> +	  found on ARM tablets, like Wexler TAB7200 and MSI Primo73.
>  
>  	  If unsure, say N.
>  
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index a3e2057..efba6a3 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -23,6 +23,8 @@
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/of.h>
>  #include <asm/unaligned.h>
>  
>  struct goodix_ts_data {
> @@ -375,11 +377,27 @@ static const struct i2c_device_id goodix_ts_id[] = {
>  	{ }
>  };
>  
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id goodix_acpi_match[] = {
>  	{ "GDIX1001", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
> +#endif
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id goodix_of_match[] = {
> +	{ .compatible = "goodix,gt911" },
> +	{ .compatible = "goodix,gt9110" },
> +	{ .compatible = "goodix,gt912" },
> +	{ .compatible = "goodix,gt927" },
> +	{ .compatible = "goodix,gt9271" },
> +	{ .compatible = "goodix,gt928" },
> +	{ .compatible = "goodix,gt967" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, goodix_of_match);
> +#endif
>  
>  static struct i2c_driver goodix_ts_driver = {
>  	.probe = goodix_ts_probe,
> @@ -387,7 +405,8 @@ static struct i2c_driver goodix_ts_driver = {
>  	.driver = {
>  		.name = "Goodix-TS",
>  		.owner = THIS_MODULE,
> -		.acpi_match_table = goodix_acpi_match,
> +		.acpi_match_table = ACPI_PTR(goodix_acpi_match),
> +		.of_match_table = of_match_ptr(goodix_of_match),
>  	},
>  };
>  module_i2c_driver(goodix_ts_driver);
> -- 
> 2.0.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
