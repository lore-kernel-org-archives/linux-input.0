From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 1/2] hid-lenovo: Add support for X1 Tablet special
 keys and LED control
Date: Wed, 14 Sep 2016 17:32:47 +0200
Message-ID: <20160914153247.GL25951@mail.corp.redhat.com>
References: <b8f9c56c-2dfc-8895-2f2a-e17a34be06d2@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763714AbcINPc6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 11:32:58 -0400
Content-Disposition: inline
In-Reply-To: <b8f9c56c-2dfc-8895-2f2a-e17a34be06d2@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lukas@wunner.de, Andrew Duggan <aduggan@synaptics.com>, perex@perex.cz, vinod.koul@intel.com, hui.wang@canonical.com, rafael.j.wysocki@intel.com, jikos@kernel.org

Hi Dennis,

On Sep 14 2016 or thereabouts, Dennis Wassenberg wrote:
> The Lenovo X1 Tablet Cover is connected via USB. It constists of
> 1 device with 3 usb interfaces. Interface 0 represents keyboard,
> interface 1 the function / special keys and LED control, interface 2
> is the Synaptics touchpad and pointing stick.
> 
> This driver will bind to interfaces 0 and 1 and handle function / special keys
> including LED control.
> HID: add device id for Lenovo X1 Tablet Cover
> 
> Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
> ---
> Changes v1 -> v2 (suggested by Benjamin Tissoires):
>  * Squashed add of device IDs for Lenovo Thinkpad X1 Tablet Cover together with add of support for Lenovo Thinkpad X1 Tablet Cover into one patch
> 

I wanted to review the first version, but got sidetracked.

So here it comes :)

> 
>  drivers/hid/hid-core.c     |   1 +
>  drivers/hid/hid-ids.h      |   1 +
>  drivers/hid/hid-lenovo.c   | 549 +++++++++++++++++++++++++++++++++++++++++++++

This seems to be too big for a single patch. Especially when you have
actually several changes that could be split for easier reviewing (LED,
special keys and keys stuck at least).

>  include/linux/hid-lenovo.h |  15 ++
>  4 files changed, 566 insertions(+)
>  create mode 100644 include/linux/hid-lenovo.h
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 6add0b6..ba6a200 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2111,6 +2111,7 @@ void hid_disconnect(struct hid_device *hdev)
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM6533) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },

I know it's hard given the existing code, but please try to keep the
list sorted and insert your device in the appropriate place.

>  	{ }
>  };
>  
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3466f0d..1f08fb5 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -615,6 +615,7 @@
>  #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
>  #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
>  #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
> +#define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
>  
>  #define USB_VENDOR_ID_LG		0x1fd2
>  #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 1ac4ff4..4251aac 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -3,9 +3,11 @@
>   *  - ThinkPad USB Keyboard with TrackPoint (tpkbd)
>   *  - ThinkPad Compact Bluetooth Keyboard with TrackPoint (cptkbd)
>   *  - ThinkPad Compact USB Keyboard with TrackPoint (cptkbd)
> + *  - ThinkPad X1 Cover USB Keyboard with TrackPoint and Touchpad (tpx1cover)
>   *
>   *  Copyright (c) 2012 Bernhard Seibold
>   *  Copyright (c) 2014 Jamie Lentin <jm@lentin.co.uk>
> + *  Copyright (c) 2016 Dennis Wassenberg <dennis.wassenberg@secunet.com>
>   */
>  
>  /*
> @@ -19,11 +21,19 @@
>  #include <linux/sysfs.h>
>  #include <linux/device.h>
>  #include <linux/hid.h>
> +#include <linux/hid-lenovo.h>
>  #include <linux/input.h>
>  #include <linux/leds.h>
>  
>  #include "hid-ids.h"
>  
> +struct led_table_entry {
> +	struct led_classdev *dev;
> +	uint8_t state;
> +};
> +
> +static struct led_table_entry hid_lenovo_led_table[HID_LENOVO_LED_MAX];

Ouch. Please no static arrays containing random devices. The device is
USB, so you could have several of its kind plugged at once.

So, please include this array in the driver data in the hid device, and
if you need a list of hid device connected, use an actual list of struct
hid_device.
Well, you can also use a list of struct led_table_entry if you add a
field with the type, and iterate over the list for each call on the API
in case there are 2 or more LEDs of the same type.

> +
>  struct lenovo_drvdata_tpkbd {
>  	int led_state;
>  	struct led_classdev led_mute;
> @@ -42,6 +52,37 @@ struct lenovo_drvdata_cptkbd {
>  	int sensitivity;
>  };
>  
> +struct lenovo_drvdata_tpx1cover {
> +	uint16_t led_state;
> +	uint8_t fnlock_state;
> +	uint8_t led_present;
> +	struct led_classdev led_mute;
> +	struct led_classdev led_micmute;
> +	struct led_classdev led_fnlock;
> +};
> +
> +int hid_lenovo_led_set(int led_num, bool on)

You are declaring an enum for LEDs, I'd prefer see it used here (so you
have to give it a name first).

> +{
> +	struct led_classdev *dev;
> +
> +	if (led_num >= HID_LENOVO_LED_MAX)
> +		return -EINVAL;
> +
> +	dev = hid_lenovo_led_table[led_num].dev;
> +	hid_lenovo_led_table[led_num].state = on;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (!dev->brightness_set)
> +		return -ENODEV;
> +
> +	dev->brightness_set(dev, on ? LED_FULL : LED_OFF);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hid_lenovo_led_set);
> +
>  #define map_key_clear(c) hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
>  
>  static const __u8 lenovo_pro_dock_need_fixup_collection[] = {
> @@ -86,6 +127,84 @@ static int lenovo_input_mapping_tpkbd(struct hid_device *hdev,
>  	return 0;
>  }
>  
> +static int lenovo_input_mapping_tpx1cover(struct hid_device *hdev,
> +		struct hid_input *hi, struct hid_field *field,
> +		struct hid_usage *usage, unsigned long **bit, int *max)
> +{
> +	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER) {
> +		switch (usage->hid & HID_USAGE) {
> +		case 0x0001: // Unknown keys -> Idenditied by usage index!

Why don't use directly usage->hid and check for HID_CP_CONSUMERCONTROL (0x000c0001)?

Note that here you are working with keys while previously it was LED.
Split in 2 patches please.


> +			map_key_clear(KEY_UNKNOWN);

why?
If the key doesn't seem to be used, please don't map it and return -1.

> +			switch (usage->usage_index) {
> +			case 0x8:

It feels weird to have an hexadecimal representation when dealing with
indexes.

> +				input_set_capability(hi->input, EV_KEY, KEY_FN);

You should consider using map_key_clear(KEY_FN); instead. This way the
event handling code will be cheaper.

Rince, wash reapeat in the following cases.

> +				break;
> +
> +			case 0x9:
> +				input_set_capability(hi->input, EV_KEY, KEY_MICMUTE);
> +				break;
> +
> +			case 0xa:
> +				input_set_capability(hi->input, EV_KEY, KEY_CONFIG);
> +				break;
> +
> +			case 0xb:
> +				input_set_capability(hi->input, EV_KEY, KEY_SEARCH);
> +				break;
> +
> +			case 0xc:
> +				input_set_capability(hi->input, EV_KEY, KEY_SETUP);
> +				break;
> +
> +			case 0xd:
> +				input_set_capability(hi->input, EV_KEY, KEY_SWITCHVIDEOMODE);
> +				break;
> +
> +			case 0xe:
> +				input_set_capability(hi->input, EV_KEY, KEY_RFKILL);
> +				break;
> +
> +			default:
> +				return -1;
> +			}
> +
> +			return 1;
> +
> +		case 0x006f: // Consumer.006f ---> Key.BrightnessUp
> +			map_key_clear(KEY_BRIGHTNESSUP);

Why are you overriding the existing behavior from hid-input if you are
using the same code?

Just return 0 and hid-input will set the values for you.

Rince, wash repeat for the rest of the cases.

> +			return 1;
> +
> +		case 0x0070: // Consumer.0070 ---> Key.BrightnessDown
> +			map_key_clear(KEY_BRIGHTNESSDOWN);
> +			return 1;
> +
> +		case 0x00b7:// Consumer.00b7 ---> Key.StopCD
> +			map_key_clear(KEY_STOPCD);
> +			return 1;
> +
> +		case 0x00cd: // Consumer.00cd ---> Key.PlayPause
> +			map_key_clear(KEY_PLAYPAUSE);
> +			return 1;
> +
> +		case 0x00e0: // Consumer.00e0 ---> Absolute.Volume
> +			return 0;
> +		case 0x00e2: // Consumer.00e2 ---> Key.Mute
> +			map_key_clear(KEY_MUTE);
> +			return 1;
> +
> +		case 0x00e9: // Consumer.00e9 ---> Key.VolumeUp
> +			map_key_clear(KEY_VOLUMEUP);
> +			return 1;
> +
> +		case 0x00ea: // Consumer.00ea ---> Key.VolumeDown
> +			map_key_clear(KEY_VOLUMEDOWN);
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int lenovo_input_mapping_cptkbd(struct hid_device *hdev,
>  		struct hid_input *hi, struct hid_field *field,
>  		struct hid_usage *usage, unsigned long **bit, int *max)
> @@ -172,6 +291,9 @@ static int lenovo_input_mapping(struct hid_device *hdev,
>  	case USB_DEVICE_ID_LENOVO_CBTKBD:
>  		return lenovo_input_mapping_cptkbd(hdev, hi, field,
>  							usage, bit, max);
> +	case USB_DEVICE_ID_LENOVO_X1_COVER:
> +		return lenovo_input_mapping_tpx1cover(hdev, hi, field,
> +							usage, bit, max);
>  	default:
>  		return 0;
>  	}
> @@ -362,6 +484,143 @@ static int lenovo_event_cptkbd(struct hid_device *hdev,
>  	return 0;
>  }
>  
> +static enum led_brightness lenovo_led_brightness_get_tpx1cover(
> +			struct led_classdev *led_cdev)
> +{
> +	struct device *dev = led_cdev->dev->parent;
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
> +	int led_nr = 0;

Would be even better to use the enum.

> +
> +	if (led_cdev == &drv_data->led_mute)
> +		led_nr = 0;
> +	else if (led_cdev == &drv_data->led_micmute)
> +		led_nr = 1;
> +	else if (led_cdev == &drv_data->led_fnlock)
> +		led_nr = 2;
> +	else
> +		return LED_OFF;
> +
> +	return drv_data->led_state & (1 << led_nr)
> +				? LED_FULL
> +				: LED_OFF;
> +}
> +
> +static void lenovo_led_brightness_set_tpx1cover(struct led_classdev *led_cdev,
> +			enum led_brightness value)
> +{
> +	struct device *dev = led_cdev->dev->parent;
> +	struct hid_device *hdev = to_hid_device(dev);
> +	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
> +	struct hid_report *report;
> +	int led_nr = -1;

Likewise, the enum would be nice

> +	int led_nr_hw = -1;
> +
> +	if (led_cdev == &drv_data->led_mute) {
> +		led_nr = 0;
> +		led_nr_hw = 0x64;

Are you sure you are not overriding bits in 0x44?

If you reorder the enum, I'd say the led_nr_hw could be represented as:
((led_nr + 1) << 4) | 0x44

So I think this is too much to be just a coincidence.

> +	} else if (led_cdev == &drv_data->led_micmute) {
> +		led_nr = 1;
> +		led_nr_hw = 0x74;
> +	} else if (led_cdev == &drv_data->led_fnlock) {
> +		led_nr = 2;
> +		led_nr_hw = 0x54;
> +	} else {
> +		hid_warn(hdev, "Invalid LED to set.\n");
> +		return;
> +	}
> +
> +	if (value == LED_OFF)
> +		drv_data->led_state &= ~(1 << led_nr);
> +	else
> +		drv_data->led_state |= 1 << led_nr;
> +
> +	report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[9];
> +	if (report) {
> +		report->field[0]->value[0] = led_nr_hw;
> +		report->field[0]->value[1] = (drv_data->led_state & (1 << led_nr))
> +			? 0x02 : 0x01;
> +		hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> +	}
> +}
> +
> +static int lenovo_event_tpx1cover(struct hid_device *hdev,
> +		struct hid_field *field, struct hid_usage *usage, __s32 value)
> +{
> +	int ret = 0;
> +
> +	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_CONSUMER
> +		&& (usage->hid & HID_USAGE) == 0x0001) {
> +
> +		if (usage->usage_index == 0x8 && value == 1) {
> +			struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
> +
> +			if (drv_data && drv_data->led_present) {
> +				drv_data->fnlock_state = lenovo_led_brightness_get_tpx1cover(
> +						&drv_data->led_fnlock) == LED_OFF ? 1 : 0;
> +				lenovo_led_brightness_set_tpx1cover(
> +					&drv_data->led_fnlock,
> +					drv_data->fnlock_state ? LED_FULL : LED_OFF);
> +			}

This looks like a different semantic change where you sync the actual LED with the incoming event.
This is not something we usually do from the kernel but rely on the
userspace to do it for us. Not sure about the FN lock state though.

Anyway, if this needs to be there, it should have its own patch

> +		}
> +
> +		if (usage->usage_index == 0x9 && value == 1) {
> +			input_event(field->hidinput->input, EV_KEY, KEY_MICMUTE, 1);
> +			input_sync(field->hidinput->input);
> +			input_event(field->hidinput->input, EV_KEY, KEY_MICMUTE, 0);
> +			input_sync(field->hidinput->input);
> +			ret = 1;

Aren't you notified when the key is released?

If so, you should just drop the change because you used map_key_clear
above and hid-input will simply do the right thing for you.

If you are not notified, this is big enough a difference to have its own
patch.

Rince wash repeat

> +		}
> +
> +		if (usage->usage_index == 0xa && value == 1) {
> +			input_event(field->hidinput->input, EV_KEY, KEY_CONFIG, 1);
> +			input_sync(field->hidinput->input);
> +			input_event(field->hidinput->input, EV_KEY, KEY_CONFIG, 0);
> +			input_sync(field->hidinput->input);
> +
> +			ret = 1;
> +		}
> +
> +		if (usage->usage_index == 0xb && value == 1) {
> +			input_event(field->hidinput->input, EV_KEY, KEY_SEARCH, 1);
> +			input_sync(field->hidinput->input);
> +			input_event(field->hidinput->input, EV_KEY, KEY_SEARCH, 0);
> +			input_sync(field->hidinput->input);
> +
> +			ret = 1;
> +		}
> +
> +		if (usage->usage_index == 0xc && value == 1) {
> +			input_event(field->hidinput->input, EV_KEY, KEY_SETUP, 1);
> +			input_sync(field->hidinput->input);
> +			input_event(field->hidinput->input, EV_KEY, KEY_SETUP, 0);
> +			input_sync(field->hidinput->input);
> +
> +			ret = 1;
> +		}
> +
> +		if (usage->usage_index == 0xd && value == 1) {
> +			input_event(field->hidinput->input, EV_KEY, KEY_SWITCHVIDEOMODE, 1);
> +			input_sync(field->hidinput->input);
> +			input_event(field->hidinput->input, EV_KEY, KEY_SWITCHVIDEOMODE, 0);
> +			input_sync(field->hidinput->input);
> +
> +			ret = 1;
> +		}
> +
> +		if (usage->usage_index == 0xe && value == 1) {
> +			input_event(field->hidinput->input, EV_KEY, KEY_RFKILL, 1);
> +			input_sync(field->hidinput->input);
> +			input_event(field->hidinput->input, EV_KEY, KEY_RFKILL, 0);
> +			input_sync(field->hidinput->input);
> +
> +			ret = 1;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
>  		struct hid_usage *usage, __s32 value)
>  {
> @@ -369,6 +628,8 @@ static int lenovo_event(struct hid_device *hdev, struct hid_field *field,
>  	case USB_DEVICE_ID_LENOVO_CUSBKBD:
>  	case USB_DEVICE_ID_LENOVO_CBTKBD:
>  		return lenovo_event_cptkbd(hdev, field, usage, value);
> +	case USB_DEVICE_ID_LENOVO_X1_COVER:
> +		return lenovo_event_tpx1cover(hdev, field, usage, value);
>  	default:
>  		return 0;
>  	}
> @@ -731,6 +992,251 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
>  	return ret;
>  }
>  
> +static int lenovo_probe_tpx1cover_configure(struct hid_device *hdev)
> +{
> +	struct hid_report *report = hdev->report_enum[HID_OUTPUT_REPORT].report_id_hash[9];
> +	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
> +
> +	if (!drv_data)
> +		return -ENODEV;

Can this really happen?

> +
> +	if (!report)
> +		return -ENOENT;
> +
> +	report->field[0]->value[0] = 0x54;
> +	report->field[0]->value[1] = 0x20;
> +	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> +	hid_hw_wait(hdev);
> +
> +	report->field[0]->value[0] = 0x54;
> +	report->field[0]->value[1] = 0x08;
> +	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> +	hid_hw_wait(hdev);
> +
> +	report->field[0]->value[0] = 0xA0;
> +	report->field[0]->value[1] = 0x02;
> +	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> +	hid_hw_wait(hdev);
> +
> +	lenovo_led_brightness_set_tpx1cover(&drv_data->led_mute,
> +		hid_lenovo_led_table[HID_LENOVO_LED_MUTE].state ? LED_FULL : LED_OFF);
> +	hid_hw_wait(hdev);
> +
> +	lenovo_led_brightness_set_tpx1cover(&drv_data->led_micmute,
> +		hid_lenovo_led_table[HID_LENOVO_LED_MICMUTE].state ? LED_FULL : LED_OFF);
> +	hid_hw_wait(hdev);
> +
> +	lenovo_led_brightness_set_tpx1cover(&drv_data->led_fnlock, LED_FULL);
> +
> +	return 0;
> +}
> +
> +static int lenovo_probe_tpx1cover_special_functions(struct hid_device *hdev)
> +{
> +	struct device *dev = &hdev->dev;
> +	struct lenovo_drvdata_tpx1cover *drv_data = NULL;
> +
> +	size_t name_sz = strlen(dev_name(dev)) + 16;
> +	char *name_led = NULL;
> +
> +	struct hid_report *report;
> +	bool report_match = 1;
> +
> +	int ret = 0;
> +
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 2, 0, 3);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 3, 0, 16);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_OUTPUT_REPORT, 9, 0, 2);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 32, 0, 1);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 84, 0, 1);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 100, 0, 1);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 116, 0, 1);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 132, 0, 1);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 144, 0, 1);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 162, 0, 1);
> +	report_match &= report ? 1 : 0;

It feels weird to have you check if those reports are actually long
enough. I think this is related to checking which interface you have,
but you should be able to reduce the list to only those you are actually
using (report id "9" seems like a good candidate).

And please add a comment why you are checking some specific report IDs.

> +
> +	if (!report_match) {
> +		ret = -ENODEV;
> +		goto err;

just return -ENODEV here.

> +	}
> +
> +	drv_data = devm_kzalloc(&hdev->dev,
> +			sizeof(struct lenovo_drvdata_tpx1cover),
> +			GFP_KERNEL);
> +
> +	if (!drv_data) {
> +		hid_err(hdev,
> +			"Could not allocate memory for tpx1cover driver data\n");
> +		ret = -ENOMEM;
> +		goto err;

Just return -ENODEV too, the devres manager will kfree drv_data for you.

> +	}
> +
> +	name_led = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
> +	if (!name_led) {
> +		hid_err(hdev, "Could not allocate memory for mute led data\n");
> +		ret = -ENOMEM;
> +		goto err_cleanup;

likewise

> +	}
> +	snprintf(name_led, name_sz, "%s:amber:mute", dev_name(dev));
> +
> +	drv_data->led_mute.name = name_led;
> +	drv_data->led_mute.brightness_get = lenovo_led_brightness_get_tpx1cover;
> +	drv_data->led_mute.brightness_set = lenovo_led_brightness_set_tpx1cover;
> +	drv_data->led_mute.dev = dev;
> +	hid_lenovo_led_table[HID_LENOVO_LED_MUTE].dev = &drv_data->led_mute;
> +	led_classdev_register(dev, &drv_data->led_mute);

Isn't devm_led_class_register working?

That would be nice because you could drop all of your cleanup paths

> +
> +
> +	name_led = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
> +	if (!name_led) {
> +		hid_err(hdev,
> +			"Could not allocate memory for mic mute led data\n");
> +		ret = -ENOMEM;
> +		goto err_cleanup;

ditto

> +	}
> +	snprintf(name_led, name_sz, "%s:amber:micmute", dev_name(dev));
> +
> +	drv_data->led_micmute.name = name_led;
> +	drv_data->led_micmute.brightness_get = lenovo_led_brightness_get_tpx1cover;
> +	drv_data->led_micmute.brightness_set = lenovo_led_brightness_set_tpx1cover;
> +	drv_data->led_micmute.dev = dev;
> +	hid_lenovo_led_table[HID_LENOVO_LED_MICMUTE].dev = &drv_data->led_micmute;
> +	led_classdev_register(dev, &drv_data->led_micmute);
> +
> +
> +	name_led = devm_kzalloc(&hdev->dev, name_sz, GFP_KERNEL);
> +	if (!name_led) {
> +		hid_err(hdev,
> +			"Could not allocate memory for FN lock led data\n");
> +		ret = -ENOMEM;
> +		goto err_cleanup;

ditto

> +	}
> +
> +	snprintf(name_led, name_sz, "%s:amber:fnlock", dev_name(dev));
> +
> +	drv_data->led_fnlock.name = name_led;
> +	drv_data->led_fnlock.brightness_get = lenovo_led_brightness_get_tpx1cover;
> +	drv_data->led_fnlock.brightness_set = lenovo_led_brightness_set_tpx1cover;
> +	drv_data->led_fnlock.dev = dev;
> +	hid_lenovo_led_table[HID_LENOVO_LED_FNLOCK].dev = &drv_data->led_fnlock;
> +	led_classdev_register(dev, &drv_data->led_fnlock);

ditto

> +
> +	drv_data->led_state = 0;
> +	drv_data->fnlock_state = 1;
> +	drv_data->led_present = 1;
> +
> +	hid_set_drvdata(hdev, drv_data);
> +
> +	return lenovo_probe_tpx1cover_configure(hdev);
> +
> +err_cleanup:

Shouldn't be required if you use devm_led_classdev_register().

> +	if (drv_data->led_fnlock.name) {
> +		led_classdev_unregister(&drv_data->led_fnlock);
> +		devm_kfree(&hdev->dev, (void *) drv_data->led_fnlock.name);
> +	}
> +
> +	if (drv_data->led_micmute.name) {
> +		led_classdev_unregister(&drv_data->led_micmute);
> +		devm_kfree(&hdev->dev, (void *) drv_data->led_micmute.name);
> +	}
> +
> +	if (drv_data->led_mute.name) {
> +		led_classdev_unregister(&drv_data->led_mute);
> +		devm_kfree(&hdev->dev, (void *) drv_data->led_mute.name);
> +	}
> +
> +	if (drv_data)
> +		kfree(drv_data);
> +
> +err:
> +	return ret;
> +}
> +
> +static int lenovo_probe_tpx1cover_touch(struct hid_device *hdev)
> +{
> +	struct hid_report *report;
> +	bool report_match = 1;
> +	int ret = 0;
> +
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 2, 0, 2);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 2, 1, 2);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 11, 0, 61);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 12, 0, 61);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 16, 0, 3);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_INPUT_REPORT, 16, 1, 2);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_OUTPUT_REPORT, 9, 0, 20);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_OUTPUT_REPORT, 10, 0, 20);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 14, 0, 1);
> +	report_match &= report ? 1 : 0;
> +	report = hid_validate_values(hdev, HID_FEATURE_REPORT, 15, 0, 3);
> +	report_match &= report ? 1 : 0;

Feels weird too (especially if there is no comment explaining why you
are doing those checks).

> +
> +	if (!report_match)
> +		ret = -ENODEV;
> +
> +	return ret;
> +}
> +
> +static int lenovo_probe_tpx1cover(struct hid_device *hdev)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Probing for special function keys and LED control -> usb intf 1
> +	 * Probing for touch input -> usb intf 2 (handled by rmi4 driver)
> +	 * Other (keyboard) -> usb intf 0
> +	 */
> +	if (!lenovo_probe_tpx1cover_special_functions(hdev)) {
> +		// special function keys and LED control

No C++ style comments please.

> +		ret = 0;
> +	} else if (!lenovo_probe_tpx1cover_touch(hdev)) {
> +		// handled by rmi
> +		ret = -ENODEV;

I don't quite get how the touch can be handled if you just return
-ENODEV here. Given that the device has been added to
hid_have_special_driver, if you don't claim the device, no one else will
unless you add the ID in the other HID driver.

> +	} else {
> +		// keyboard

Why is that keyboard chunk not given it's own probe function?

> +		struct lenovo_drvdata_tpx1cover *drv_data;
> +
> +		drv_data = devm_kzalloc(&hdev->dev,
> +					sizeof(struct lenovo_drvdata_tpx1cover),
> +					GFP_KERNEL);
> +
> +		if (!drv_data) {
> +			hid_err(hdev,
> +				"Could not allocate memory for tpx1cover driver data\n");
> +			ret = -ENOMEM;
> +			goto out;

no need for a goto here. Just a plain return -ENOMEM should be good
enough.

> +		}
> +
> +		drv_data->led_state = 0;
> +		drv_data->led_present = 0;
> +		drv_data->fnlock_state = 0;
> +		hid_set_drvdata(hdev, drv_data);
> +
> +		ret = 0;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>  static int lenovo_probe_cptkbd(struct hid_device *hdev)
>  {
>  	int ret;
> @@ -803,6 +1309,9 @@ static int lenovo_probe(struct hid_device *hdev,
>  	case USB_DEVICE_ID_LENOVO_CBTKBD:
>  		ret = lenovo_probe_cptkbd(hdev);
>  		break;
> +	case USB_DEVICE_ID_LENOVO_X1_COVER:
> +		ret = lenovo_probe_tpx1cover(hdev);
> +		break;
>  	default:
>  		ret = 0;
>  		break;
> @@ -843,6 +1352,42 @@ static void lenovo_remove_cptkbd(struct hid_device *hdev)
>  			&lenovo_attr_group_cptkbd);
>  }
>  
> +static void lenovo_remove_tpx1cover(struct hid_device *hdev)
> +{
> +	struct lenovo_drvdata_tpx1cover *drv_data = hid_get_drvdata(hdev);
> +
> +	if (!drv_data)
> +		return;
> +
> +	if (drv_data->led_present) {
> +		if (drv_data->led_fnlock.name) {
> +			hid_lenovo_led_table[HID_LENOVO_LED_FNLOCK].dev = NULL;
> +
> +			led_classdev_unregister(&drv_data->led_fnlock);
> +			devm_kfree(&hdev->dev, (void *) drv_data->led_fnlock.name);

Calling yourself devm_kfree usually means there is something wrong.
Here, if you used devm_led_*, you could just drop the entire remove
function.

> +		}
> +
> +		if (drv_data->led_micmute.name) {
> +			hid_lenovo_led_table[HID_LENOVO_LED_MICMUTE].dev = NULL;
> +
> +			led_classdev_unregister(&drv_data->led_micmute);
> +			devm_kfree(&hdev->dev, (void *) drv_data->led_micmute.name);
> +		}
> +
> +		if (drv_data->led_mute.name) {
> +			hid_lenovo_led_table[HID_LENOVO_LED_MUTE].dev = NULL;
> +
> +			led_classdev_unregister(&drv_data->led_mute);
> +			devm_kfree(&hdev->dev, (void *) drv_data->led_mute.name);
> +		}
> +	}
> +
> +	if (drv_data)
> +		devm_kfree(&hdev->dev, drv_data);
> +
> +	hid_set_drvdata(hdev, NULL);
> +}
> +
>  static void lenovo_remove(struct hid_device *hdev)
>  {
>  	switch (hdev->product) {
> @@ -853,6 +1398,9 @@ static void lenovo_remove(struct hid_device *hdev)
>  	case USB_DEVICE_ID_LENOVO_CBTKBD:
>  		lenovo_remove_cptkbd(hdev);
>  		break;
> +	case USB_DEVICE_ID_LENOVO_X1_COVER:
> +		lenovo_remove_tpx1cover(hdev);
> +		break;
>  	}
>  
>  	hid_hw_stop(hdev);
> @@ -883,6 +1431,7 @@ static int lenovo_input_configured(struct hid_device *hdev,
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
>  	{ }
>  };
>  
> diff --git a/include/linux/hid-lenovo.h b/include/linux/hid-lenovo.h
> new file mode 100644
> index 0000000..d0b0145
> --- /dev/null
> +++ b/include/linux/hid-lenovo.h
> @@ -0,0 +1,15 @@
> +
> +#ifndef __HID_LENOVO_H__
> +#define __HID_LENOVO_H__
> +
> +
> +enum {
> +	HID_LENOVO_LED_MUTE,

I'd rather have a name for the enum (so you can reuse it), and also have
each enum given its numerical value (or at least the first and last.

> +	HID_LENOVO_LED_MICMUTE,
> +	HID_LENOVO_LED_FNLOCK,
> +	HID_LENOVO_LED_MAX,
> +};
> +
> +int hid_lenovo_led_set(int led_num, bool on);
> +
> +#endif /* __HID_LENOVO_H_ */
> -- 
> 1.i9.1


Cheers,
Benjamin
