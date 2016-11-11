From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 05/10] mfd: da9061: MFD core support
Date: Fri, 11 Nov 2016 10:37:34 +0000
Message-ID: <20161111103734.GD13638@dell>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <bf02595c2fa32ba0c4311e2d480321b811fc9cf5.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bf02595c2fa32ba0c4311e2d480321b811fc9cf5.1477501000.git.stwiss.opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On Wed, 26 Oct 2016, Steve Twiss wrote:

> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> MFD support for DA9061 is provided as part of the DA9062 device driver.
> 
> The registers header file adds two new chip variant IDs defined in DA9061
> and DA9062 hardware. The core header file adds new software enumerations
> for listing the valid DA9061 IRQs and a da9062_compatible_types enumeration
> for distinguishing between DA9061/62 devices in software.
> 
> The core source code adds a new .compatible of_device_id entry. This is
> extended from DA9062 to support both "dlg,da9061" and "dlg,da9062". The
> .data entry now holds a reference to the enumerated device type.
> 
> A new regmap_irq_chip model is added for DA9061 and this supports the new
> list of regmap_irq entries. A new mfd_cell da9061_devs[] array lists the
> new sub system components for DA9061. Support is added for a new DA9061
> regmap_config which lists the correct readable, writable and volatile
> ranges for this chip.
> 
> The probe function uses the device tree compatible string to switch on the
> da9062_compatible_types and configure the correct mfd cells, irq chip and
> regmap config.
>  
> Kconfig is updated to reflect support for DA9061 and DA9062 PMICs.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> This patch applies against linux-next and v4.8
> 
> v1 -> v2
>  - Patch renamed from [PATCH V1 01/10] to [PATCH V2 05/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Fixed typo in the commit message "readble" to "readable"
>  - Removed the explicit cross-check to decide if there is a conflict
>    between the device tree compatible string and the hardware definition.
>    This patch assumes the device tree is correctly written and therefore
>    removes the need for a hardware/DT sanity check.
>  - Removed extra semicolon in drivers/mfd/da9062-core.c:877
>  - Re-write compatible entries into numerical order
> 
> Lee,
> 
> This patch adds support for the DA9061 PMIC. This is done as part of the
> existing DA9062 device driver by extending the of_device_id match table.
> This in turn allows new MFD cells, irq chip and regmap definitions to
> support DA9061.
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  drivers/mfd/Kconfig                  |   5 +-
>  drivers/mfd/da9062-core.c            | 427 +++++++++++++++++++++++++++++++++--
>  include/linux/mfd/da9062/core.h      |  27 ++-
>  include/linux/mfd/da9062/registers.h |   2 +
>  4 files changed, 441 insertions(+), 20 deletions(-)

[...]

> +static struct resource da9061_core_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_regulators_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_LDO_LIM, 1, "LDO_LIM", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_thermal_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_TEMP, 1, "THERMAL", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_wdt_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_WDG_WARN, 1, "WD_WARN", IORESOURCE_IRQ),
> +};
> +
> +static struct resource da9061_onkey_resources[] = {
> +	DEFINE_RES_NAMED(DA9061_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
> +};

These should al be: DEFINE_RES_IO_NAMED()

[...]

>  };
> @@ -142,7 +257,7 @@ static const struct mfd_cell da9062_devs[] = {
>  		.name		= "da9062-watchdog",
>  		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
>  		.resources	= da9062_wdt_resources,
> -		.of_compatible  = "dlg,da9062-wdt",
> +		.of_compatible  = "dlg,da9062-watchdog",

This should be a separate change.

>  	},
>  	{
>  		.name		= "da9062-thermal",
> @@ -200,7 +315,8 @@ static int da9062_clear_fault_log(struct da9062 *chip)
>  
>  static int da9062_get_device_type(struct da9062 *chip)
>  {
> -	int device_id, variant_id, variant_mrc;
> +	int device_id, variant_id, variant_mrc, variant_vrc;
> +	char *type;
>  	int ret;
>  
>  	ret = regmap_read(chip->regmap, DA9062AA_DEVICE_ID, &device_id);
> @@ -208,6 +324,7 @@ static int da9062_get_device_type(struct da9062 *chip)
>  		dev_err(chip->dev, "Cannot read chip ID.\n");
>  		return -EIO;
>  	}
> +

Sneaky!

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
