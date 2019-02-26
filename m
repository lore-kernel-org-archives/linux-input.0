From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Tue, 26 Feb 2019 11:20:59 +0200
Message-ID: <20190226092059.GV9224@smile.fi.intel.com>
References: <20190221105609.5710-1-ronald@innovation.ch>
 <20190221105609.5710-3-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190221105609.5710-3-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Feb 21, 2019 at 02:56:09AM -0800, Ronald Tschalär wrote:
> The keyboard and trackpad on recent MacBook's (since 8,1) and
> MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> of USB, as previously. The higher level protocol is not publicly
> documented and hence has been reverse engineered. As a consequence there
> are still a number of unknown fields and commands. However, the known
> parts have been working well and received extensive testing and use.
> 
> In order for this driver to work, the proper SPI drivers need to be
> loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> reason enabling this driver in the config implies enabling the above
> drivers.

> +config KEYBOARD_APPLESPI
> +	tristate "Apple SPI keyboard and trackpad"

> +	depends on ACPI && SPI && EFI

I would rather want to see separate line for SPI...

> +	depends on X86 || COMPILE_TEST

...like here

	depends on SPI

> +	imply SPI_PXA2XX
> +	imply SPI_PXA2XX_PCI
> +	imply MFD_INTEL_LPSS_PCI
> +	help
> +	  Say Y here if you are running Linux on any Apple MacBook8,1 or later,
> +	  or any MacBookPro13,* or MacBookPro14,*.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called applespi.

/* Perhaps a comment here that this mimics struct drm_rect */

> +struct applespi_tp_info {
> +	int	x_min;
> +	int	y_min;
> +	int	x_max;
> +	int	y_max;
> +};

...see above

> +static inline bool applespi_check_write_status(struct applespi_data *applespi,
> +					       int sts)
> +{
> +	static u8 status_ok[] = { 0xac, 0x27, 0x68, 0xd5 };
> +
> +	if (sts < 0) {
> +		dev_warn(DEV(applespi), "Error writing to device: %d\n", sts);
> +		return false;
> +	}
> +
> +	if (memcmp(applespi->tx_status, status_ok, APPLESPI_STATUS_SIZE)) {

> +		dev_warn(DEV(applespi), "Error writing to device: %*ph\n",

Hmm... DEV() is too generic name for custom macro. And frankly I don't think
it's good to have in the first place.

> +			 APPLESPI_STATUS_SIZE, applespi->tx_status);
> +		return false;
> +	}
> +
> +	return true;
> +}

> +static void applespi_set_bl_level(struct led_classdev *led_cdev,
> +				  enum led_brightness value)
> +{
> +	struct applespi_data *applespi =
> +		container_of(led_cdev, struct applespi_data, backlight_info);
> +	unsigned long flags;
> +	int sts;
> +
> +	spin_lock_irqsave(&applespi->cmd_msg_lock, flags);
> +

> +	if (value == 0)
> +		applespi->want_bl_level = value;
> +	else
> +		/*
> +		 * The backlight does not turn on till level 32, so we scale
> +		 * the range here so that from a user's perspective it turns
> +		 * on at 1.
> +		 */
> +		applespi->want_bl_level =
> +			((value * KBD_BL_LEVEL_ADJ) / KBD_BL_LEVEL_SCALE +
> +			 KBD_BL_LEVEL_MIN);


Fir multi-line conditionals the style is
	if () {
	} else {
	}

> +
> +	sts = applespi_send_cmd_msg(applespi);
> +
> +	spin_unlock_irqrestore(&applespi->cmd_msg_lock, flags);
> +}

> +static void
> +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> +{
> +	unsigned char tmp;

> +	unsigned long *modifiers =
> +			(unsigned long *)&keyboard_protocol->modifiers;

I would leave it on one online despite checkpatch warning (also, instead of
(unsigned long *) the (void *) might be used as a small trick).

> +
> +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> +	    !applespi_controlcodes[fnremap - 1])
> +		return;
> +
> +	tmp = keyboard_protocol->fn_pressed;
> +	keyboard_protocol->fn_pressed = test_bit(fnremap - 1, modifiers);
> +	if (tmp)

> +		__set_bit(fnremap - 1, modifiers);
> +	else
> +		__clear_bit(fnremap - 1, modifiers);

Oh, this is not good. modifiers should be really unsigned long bounary,
otherwise it is potential overflow.

Best to fix is to define them as unsigned long in the first place.

> +}

> +					   applespi->last_keys_fn_pressed[i]);
> +		input_report_key(applespi->keyboard_input_dev, key, 0);
> +		applespi->last_keys_fn_pressed[i] = 0;
> +	}

> +	for (i = 0; i < MAX_MODIFIERS; i++) {

> +		u8 *modifiers = &keyboard_protocol->modifiers;
> +
> +		if (test_bit(i, (unsigned long *)modifiers))

Oh, this is not good idea, see above.

> +	if (touchpad_dimensions[0]) {
> +		int x, y, w, h;
> +

> +		if (sscanf(touchpad_dimensions, "%dx%d+%u+%u", &x, &y, &w, &h)
> +				== 4) {

I would leave this on one line. Or use temporary variable

	int ret;

	ret = sscanf();
	if (ret ...) {

> +			dev_info(DEV(applespi),
> +				 "Overriding touchpad dimensions from module param\n");
> +			applespi->tp_info.x_min = x;
> +			applespi->tp_info.y_min = y;
> +			applespi->tp_info.x_max = x + w;
> +			applespi->tp_info.y_max = y + h;
> +		} else {
> +			dev_warn(DEV(applespi),
> +				 "Invalid touchpad dimensions '%s': must be in the form XxY+W+H\n",
> +				 touchpad_dimensions);
> +			touchpad_dimensions[0] = '\0';
> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko
