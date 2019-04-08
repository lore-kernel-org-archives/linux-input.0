From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/2] Input: add Apple SPI keyboard and trackpad driver.
Date: Mon, 8 Apr 2019 15:33:43 +0300
Message-ID: <20190408123343.GO9224@smile.fi.intel.com>
References: <20190407050358.2976-1-ronald@innovation.ch>
 <20190407050358.2976-3-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190407050358.2976-3-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Apr 06, 2019 at 10:03:58PM -0700, Ronald Tschalär wrote:
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

Thank you for an update, my comments below.

> +static void applespi_debug_update_dimensions(struct applespi_data *applespi,
> +					     const struct tp_finger *f)
> +{
> +	#define UPDATE_DIMENSIONS(val, op, last) \
> +		do { \
> +			if (le16_to_int(val) op last) \
> +				last = le16_to_int(val); \
> +		} while (0)

I do not see how this is better than min()/max()/min_t()/max_t().

> +
> +	UPDATE_DIMENSIONS(f->abs_x, <, applespi->tp_dim_min_x);
> +	UPDATE_DIMENSIONS(f->abs_x, >, applespi->tp_dim_max_x);
> +	UPDATE_DIMENSIONS(f->abs_y, <, applespi->tp_dim_min_y);
> +	UPDATE_DIMENSIONS(f->abs_y, >, applespi->tp_dim_max_y);
> +
> +	#undef UPDATE_DIMENSIONS
> +}

> +static void
> +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> +{
> +	unsigned char tmp;

What about

	u8 bit = BIT(fnremap - 1);

> +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> +	    !applespi_controlcodes[fnremap - 1])

> +		return;
> +
> +	tmp = keyboard_protocol->fn_pressed;
> +	keyboard_protocol->fn_pressed =
> +			!!(keyboard_protocol->modifiers & BIT(fnremap - 1));

	... & bit);

and so on?

> +	if (tmp)
> +		keyboard_protocol->modifiers |= BIT(fnremap - 1);
> +	else
> +		keyboard_protocol->modifiers &= ~BIT(fnremap - 1);
> +}

> +static void
> +applespi_handle_keyboard_event(struct applespi_data *applespi,
> +			       struct keyboard_protocol *keyboard_protocol)
> +{
> +	int i, j;
> +	unsigned int key;
> +	bool still_pressed;
> +	bool is_overflow;

Perhaps reversed xmas tree order?

> +
> +	compiletime_assert(ARRAY_SIZE(applespi_controlcodes) ==
> +			   sizeof_field(struct keyboard_protocol, modifiers) * 8,
> +			   "applespi_controlcodes has wrong number of entries");
> +
> +	/* check for rollover overflow, which is signalled by all keys == 1 */
> +	is_overflow = true;
> +
> +	for (i = 0; i < MAX_ROLLOVER; i++) {
> +		if (keyboard_protocol->keys_pressed[i] != 1) {
> +			is_overflow = false;
> +			break;
> +		}
> +	}
> +

> +	if (is_overflow)
> +		return;


Isn't it simple

	if (i == MAX_ROLLOVER)

w/o need of additional variable?

> +	/* remap fn key if desired */
> +	applespi_remap_fn_key(keyboard_protocol);
> +
> +	/* check released keys */
> +	for (i = 0; i < MAX_ROLLOVER; i++) {
> +		still_pressed = false;
> +		for (j = 0; j < MAX_ROLLOVER; j++) {
> +			if (applespi->last_keys_pressed[i] ==
> +			    keyboard_protocol->keys_pressed[j]) {
> +				still_pressed = true;
> +				break;
> +			}
> +		}
> +
> +		if (still_pressed)
> +			continue;

Similar idea here.

> +
> +		key = applespi_code_to_key(applespi->last_keys_pressed[i],
> +					   applespi->last_keys_fn_pressed[i]);
> +		input_report_key(applespi->keyboard_input_dev, key, 0);
> +		applespi->last_keys_fn_pressed[i] = 0;
> +	}

> +	/* check pressed keys */
> +	for (i = 0; i < MAX_ROLLOVER; i++) {
> +		if (keyboard_protocol->keys_pressed[i] <
> +				ARRAY_SIZE(applespi_scancodes) &&
> +		    keyboard_protocol->keys_pressed[i] > 0) {
> +			key = applespi_code_to_key(
> +					keyboard_protocol->keys_pressed[i],
> +					keyboard_protocol->fn_pressed);
> +			input_report_key(applespi->keyboard_input_dev, key, 1);
> +			applespi->last_keys_fn_pressed[i] =
> +					keyboard_protocol->fn_pressed;
> +		}
> +	}
> +
> +	/* check control keys */
> +	for (i = 0; i < ARRAY_SIZE(applespi_controlcodes); i++) {
> +		if (keyboard_protocol->modifiers & BIT(i))
> +			input_report_key(applespi->keyboard_input_dev,
> +					 applespi_controlcodes[i], 1);
> +		else
> +			input_report_key(applespi->keyboard_input_dev,
> +					 applespi_controlcodes[i], 0);
> +	}
> +
> +	/* check function key */
> +	if (keyboard_protocol->fn_pressed && !applespi->last_fn_pressed)
> +		input_report_key(applespi->keyboard_input_dev, KEY_FN, 1);
> +	else if (!keyboard_protocol->fn_pressed && applespi->last_fn_pressed)
> +		input_report_key(applespi->keyboard_input_dev, KEY_FN, 0);
> +	applespi->last_fn_pressed = keyboard_protocol->fn_pressed;
> +
> +	/* done */
> +	input_sync(applespi->keyboard_input_dev);
> +	memcpy(&applespi->last_keys_pressed, keyboard_protocol->keys_pressed,
> +	       sizeof(applespi->last_keys_pressed));
> +}

> +static int
> +applespi_register_touchpad_device(struct applespi_data *applespi,
> +				  struct touchpad_info_protocol *rcvd_tp_info)
> +{
> +	const struct applespi_tp_info *tp_info;
> +	struct input_dev *touchpad_input_dev;
> +	int sts;
> +
> +	/* set up touchpad dimensions */
> +	tp_info = applespi_find_touchpad_info(rcvd_tp_info->model_no);
> +	if (!tp_info) {

> +		dev_warn(&(applespi)->spi->dev,

I'm not sure what parens are helping with (here and everywhere with device parameter)?

> +			 "Unknown touchpad model %x - falling back to MB8 touchpad\n",
> +			 rcvd_tp_info->model_no);
> +		tp_info = &applespi_tp_models[0].tp_info;
> +	}

> +	return 0;
> +}

> +static int applespi_probe(struct spi_device *spi)
> +{
> +	struct applespi_data *applespi;
> +	acpi_status acpi_sts;
> +	int sts, i;
> +	unsigned long long gpe, usb_status;
> +
> +	/* check if the USB interface is present and enabled already */

> +	acpi_sts = acpi_evaluate_integer(ACPI_HANDLE(&spi->dev), "UIST", NULL,
> +					 &usb_status);

... see below ...

> +	if (ACPI_SUCCESS(acpi_sts) && usb_status) {
> +		/* let the USB driver take over instead */
> +		dev_info(&spi->dev, "USB interface already enabled\n");
> +		return -ENODEV;
> +	}
> +
> +	/* allocate driver data */
> +	applespi = devm_kzalloc(&spi->dev, sizeof(*applespi), GFP_KERNEL);
> +	if (!applespi)
> +		return -ENOMEM;
> +
> +	applespi->spi = spi;

> +	applespi->handle = ACPI_HANDLE(&spi->dev);

AFAICS this is local variable, why put it in the data structure?
And above you are not using this, btw.

> +	} else {
> +		struct dentry *ret;
> +
> +		ret = debugfs_create_bool("enable_tp_dim", 0600,
> +					  applespi->debugfs_root,
> +					  &applespi->debug_tp_dim);
> +		if (IS_ERR(ret))

> +			dev_warn(&(applespi)->spi->dev,
> +				 "Error creating debugfs entry enable_tp_dim (%ld)\n",
> +				 PTR_ERR(ret));

Can ret be NULL?

dev_dbg() looks more appropriate.

> +
> +		ret = debugfs_create_file("tp_dim", 0400,
> +					  applespi->debugfs_root, applespi,
> +					  &applespi_tp_dim_fops);
> +		if (IS_ERR(ret))

> +			dev_warn(&(applespi)->spi->dev,
> +				 "Error creating debugfs entry tp_dim (%ld)\n",
> +				 PTR_ERR(ret));

Ditto.

> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
