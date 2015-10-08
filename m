From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v7 2/9] Input: goodix - reset device at init
Date: Thu, 08 Oct 2015 12:54:05 +0200
Message-ID: <8618206.7jshXjkP9U@wuerfel>
References: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com> <1444299575-17417-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444299575-17417-3-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 08 October 2015 13:19:28 Irina Tirdea wrote:
> After power on, it is recommended that the driver resets the device.
> The reset procedure timing is described in the datasheet and is used
> at device init (before writing device configuration) and
> for power management. It is a sequence of setting the interrupt
> and reset pins high/low at specific timing intervals. This procedure
> also includes setting the slave address to the one specified in the
> ACPI/device tree.
> 
> This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> driver gt9xx.c for Android (publicly available in Android kernel
> trees for various devices).
> 
> For reset the driver needs to control the interrupt and
> reset gpio pins (configured through ACPI/device tree). For devices
> that do not have the gpio pins declared, the functionality depending
> on these pins will not be available, but the device can still be used
> with basic functionality.
> 
> For both device tree and ACPI, the interrupt gpio pin configuration is
> read from the "irq-gpio" property and the reset pin configuration is
> read from the "reset-gpio" property. For ACPI 5.1, named properties
> can be specified using the _DSD section. If there is no _DSD section
> in the ACPI table, the driver will fall back to using indexed gpio
> pins declared in the _CRS section.

Would it help to use a plain "gpios" property here to always look
up the lines by index?

> +/*
> + * Some platforms specify the gpio pins for interrupt and reset properly
> + * in ACPI, but cannot use the interrupt pin as output due to their specific
> + * HW configuration.
> + */
> +static const struct dmi_system_id goodix_no_gpio_pins_support[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		.ident = "Onda v975w",
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
> +			DMI_MATCH(DMI_PRODUCT_UUID,
> +				  "03000200-0400-0500-0006-000700080009"),
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
> +		}
> +	},

I think lists like this in drivers should be avoided if at all possible,
it just leads to other people adding their platform in the lists as
opposed to fixing their boot loaders.

Can you find another way to detect at runtime whether it works, and
print a warning if it doesn't? If there is no way to detect that kind
of device, we should probably have another property that the driver
can read to determine this, so we can avoid adding each system here.

> +	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
> +	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
> +	if (error)
> +		return error;

If the "interrupt" gpio is used as an output, maybe it has the wrong
name? Is that the name from the goodix datasheet (that would be ok)
or something you picked?

	Arnd
