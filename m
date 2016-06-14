From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] input: touchscreen: Add generic driver for Silead
 touchscreens
Date: Tue, 14 Jun 2016 18:27:20 -0500
Message-ID: <20160614232720.GA28035@rob-hp-laptop>
References: <1465814810-7151-1-git-send-email-djaniboe@gmail.com>
 <1465814810-7151-2-git-send-email-djaniboe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36685 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbcFNX1W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2016 19:27:22 -0400
Content-Disposition: inline
In-Reply-To: <1465814810-7151-2-git-send-email-djaniboe@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Jansen <djaniboe@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Robert Dolca <robert.dolca@gmail.com>, Gregor Riepl <onitake@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>, Wessel Blokzijl <wesselb94@gmail.com>

On Mon, Jun 13, 2016 at 12:46:50PM +0200, Daniel Jansen wrote:
> From: Robert Dolca <robert.dolca@intel.com>
> 
> This driver adds support for Silead touchscreens. It has been tested
> with GSL1680 and GSL3680 touch panels.
> 
> It supports ACPI and device tree enumeration. Screen resolution,
> the maximum number of fingers supported and firmware name are
> configurable.
> 
> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> Signed-off-by: Daniel Jansen <djaniboe@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes since v3
> - Check for the hw reporting more touches than expected
> - Fix input_mt_assign_slots usage
> - Remove unnecessary defines.
> - Shorten lines to be under 80 characters.
> - Move closing block comment to new line.
> - Add device tree bindings document for silead_gsl1680.
> - Use dev->driver->acpi_match_table instead of silead_ts_acpi_match
> - Replaced sprintf in default firmware file name generator with snprintf
> - Add missing input_mt_sync_frame() call
> - Fix device tree support
> 
> Changes since v2
> - removed device properties requirements
>        - max x and y default to 4095
>        - max fingers default to 10
>        - firmware name uses the HID / device name
>        - power named GPIO optional with fallback to indexed GPIO
>          (without it there is no pm support in the driver)
> - finger tracking in the kernel using slot assignment
> - add device property for x/y inverting and xy swapping
> 
> Changes since v1
> - changed device tree properties names
> - removed cast for `void *id`
> - removed ifdef from suspend and resume and use __maybe_unused
> - remove ifdef from ACPI_PTR
> - renamed ret to error
> - removed input_set_capability for EV_ABS
> - fixed endianess issues
> - added mask for y in order to use only 12 bits
> - using the 4 MSb for touch ID instead of LSb (bug)
> - using the 4 LSB for X instead of MSb (bug)
> ---
>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  39 ++
>  drivers/input/touchscreen/Kconfig                  |  13 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/silead.c                 | 652 +++++++++++++++++++++
>  4 files changed, 705 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>  create mode 100644 drivers/input/touchscreen/silead.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> new file mode 100644
> index 0000000..d0164be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> @@ -0,0 +1,39 @@
> +* GSL 1680 touchscreen controller
> +
> +Required properties:
> +- compatible		  : "silead,gsl1680"
> +- reg			  : I2C slave address of the chip (0x40)
> +- interrupt-parent	  : a phandle pointing to the interrupt controller
> +			    serving the interrupt for this chip
> +- interrupts		  : interrupt specification for the gsl1680 interrupt
> +- wake-gpios		  : GPIO specification for the WAKE input

What direction is this?

> +- touchscreen-size-x	  : horizontal resolution of touchscreen (in pixels)
> +- touchscreen-size-y	  : vertical resolution of touchscreen (in pixels)
> +- touchscreen-max-fingers : maximal input values given to inputsystem
> +
> +Optional properties:
> +- touchscreen-inverted-x  : X axis is inverted (boolean)
> +- touchscreen-inverted-y  : Y axis is inverted (boolean)
> +- touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> +			    Swapping is done after inverting the axis
> +
> +Example:
> +
> +i2c@00000000 {
> +
> +	gsl1680: touchscreen@40 {
> +		compatible = "silead,gsl1680";
> +		reg = <0x40>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>;
> +		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
> +		touchscreen-size-x = <480>;
> +		touchscreen-size-y = <800>;
> +		touchscreen-max-fingers = <5>;
> +		touchscreen-inverted-x;
> +		touchscreen-swapped-x-y;
> +	};
> +
> +	/* ... */
> +};
> +
