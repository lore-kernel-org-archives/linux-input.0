From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 1/7] X86 drivers: Introduce msi-wmi driver
Date: Sat, 12 Dec 2009 17:37:36 +0000
Message-ID: <9b2b86520912120937i548b1158k50f517af7fd5ed21@mail.gmail.com>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
	 <1260451099-25620-2-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1260451099-25620-2-git-send-email-anisse@astier.eu>
Sender: linux-acpi-owner@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>
List-Id: linux-input@vger.kernel.org

Hi Anisse

I think there are a few theoretical issues remaining in this driver
(although I've not read your followup patches, I just checked the
subject lines).

On 12/10/09, Anisse Astier <anisse@astier.eu> wrote:
> +config MSI_WMI
> +	tristate "MSI WMI extras"
> +	depends on ACPI_WMI
> +	depends on INPUT

I think this driver depends on BACKLIGHT_CLASS_DEVICE as well.

> +	help
> +	 Say Y here if you want to support WMI-based hotkeys on MSI laptops.
> +
> +	 To compile this driver as a module, choose M here: the module will
> +	 be called msi-wmi.
> +


> +static int bl_get(struct backlight_device *bd)
> +{
> +	int level, err, ret = 0;
> +
> +	/* Instance 1 is "get backlight", cmp with DSDT */
> +	err = msi_wmi_query_block(1, &ret);
> +	if (err)
> +		printk(KERN_ERR DRV_PFX "Could not query backlight: %d\n", err);

It looks like we continue despite this error, and return 0?  I think
an error code would be more appropriate.  It would definitely be
better to use an explicit return statement here (and not set ret = 0
beforehand).

In reality the current backlight class doesn't support error codes...
but I figure it's better to give userspace an obviously wrong number,
rather than falsely claiming we know that the blacklight is set to 0.


> +	dprintk("Get: Query block returned: %d\n", ret);
> +	for (level = 0; level < ARRAY_SIZE(backlight_map); level++) {
> +		if (backlight_map[level] == ret) {
> +			dprintk("Current backlight level: 0x%X - index: %d\n",
> +				backlight_map[level], level);
> +			break;
> +		}
> +	}
> +	if (level == ARRAY_SIZE(backlight_map)) {
> +		printk(KERN_ERR DRV_PFX "get: Invalid brightness value: 0x%X\n",
> +		       ret);
> +		return -EINVAL;
> +	}
> +	return level;
> +}

> +static int bl_set_status(struct backlight_device *bd)
> +{
> +	int bright = bd->props.brightness;
> +	if (bright >= ARRAY_SIZE(backlight_map) || bright < 0)
> +		return -EINVAL;
> +
> +	/* Instance 0 is "set backlight" */
> +	return msi_wmi_set_block(0, backlight_map[bright]);
> +}
> +
> +static struct backlight_ops msi_backlight_ops = {
> +	.get_brightness	= bl_get,
> +	.update_status	= bl_set_status,
> +};

> +static void msi_wmi_notify(u32 value, void *context)
> +{
> +	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> +	static struct key_entry *key;
> +	union acpi_object *obj;
> +	ktime_t cur;
> +
> +	wmi_get_event_data(value, &response);
> +
> +	obj = (union acpi_object *)response.pointer;
> +
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +		int eventcode = obj->integer.value;
> +		dprintk("Eventcode: 0x%x\n", eventcode);
> +		key = msi_wmi_get_entry_by_scancode(eventcode);
> +		if (key) {
> +			cur = ktime_get_real();
> +			/* Ignore event if the same event happened in a 50 ms
> +			   timeframe -> Key press may result in 10-20 GPEs */
> +			if (ktime_to_us(ktime_sub(cur, key->last_pressed))
> +			    < 1000 * 50) {
> +				dprintk("Suppressed key event 0x%X - "
> +					"Last press was %lld us ago\n",
> +					 key->code,
> +					 ktime_to_us(ktime_sub(cur,
> +						       key->last_pressed)));
> +				return;
> +			}
> +			key->last_pressed = cur;
> +
> +			switch (key->type) {
> +			case KE_KEY:
> +				/* Brightness is served via acpi video driver */
> +				if (!backlight &&
> +				    (key->keycode == KEY_BRIGHTNESSUP ||
> +				     key->keycode == KEY_BRIGHTNESSDOWN))
> +					break;

Given backlight == NULL, this will mysteriously prevent users from
remapping the volume keys to use as a brightness control.  I think it
would be better to check the original scancodes.

Also, can you please confirm that the ACPI BIOS does _not_ change the
brightness level in response to these keys?  If it does, the driver
should really use backlight_force_update() instead of generating
KEY_BRIGHTNESS* events.

> +				dprintk("Send key: 0x%X - "
> +					"Input layer keycode: %d\n", key->code,
> +					 key->keycode);
> +				input_report_key(msi_wmi_input_dev,
> +						 key->keycode, 1);
> +				input_sync(msi_wmi_input_dev);
> +				input_report_key(msi_wmi_input_dev,
> +						 key->keycode, 0);
> +				input_sync(msi_wmi_input_dev);
> +				break;
> +			}
> +		} else
> +			printk(KERN_INFO "Unknown key pressed - %x\n",
> +			       eventcode);
> +	} else
> +		printk(KERN_INFO DRV_PFX "Unknown event received\n");
> +	kfree(response.pointer);
> +}

Regards
Alan
