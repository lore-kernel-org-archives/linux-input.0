From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Add touchpad support for Sony's NSG-MR5U and
 NSG-MR7U remotes
Date: Tue, 21 Mar 2017 15:06:45 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211506060.31814@cbobk.fhfr.pm>
References: <20170211050004.GA3944@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757258AbdCUOnn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 10:43:43 -0400
In-Reply-To: <20170211050004.GA3944@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Kelner <tsopdump@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Frank Praznik <frank.praznik@gmail.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Simon Wood <simon@mungewell.org>

On Fri, 10 Feb 2017, Todd Kelner wrote:

> Sony's NSG-MR5U and NSG-MR7U remote controls have a full keyboard and a
> touchpad.  The keyboard is already supported by the existing Linux kernel
> and drivers but the touchpad is not recognized.  This patch adds the code
> needed to bring full functionality to the touchpad.
> 
> Note that these remotes use the vendor code for SMK even though they are
> Sony branded.
> 
> Known Limitations:
> - The accelerometer is not supported by these changes
> - The microphone in the NSG-MR7U is not supported by these changes
> - When the Drag (Fn) key is used as a mouse button, the button is
>   automatically released when the key begins repeating. There are two
>   workarounds for this.  1) Use the button behind the touchpad instead of
>   using the Drag (Fn) key, or 2) Disable the key repeat functionality or
>   increase the key repeat delay.

Adding Frank, Roderick and Simon to CC in case they have any comments.

> 
> Signed-off-by: Todd Kelner <tsopdump@gmail.com>
> ---
>  drivers/hid/hid-core.c |   2 +
>  drivers/hid/hid-ids.h  |   2 +
>  drivers/hid/hid-sony.c | 130 +++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 125 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index cff060b..4dfef41 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2054,6 +2054,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_PS3_BDREMOTE) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE) },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_MOTION_CONTROLLER) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 54bd22d..864ec34 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -904,6 +904,8 @@
>  
>  #define USB_VENDOR_ID_SMK		0x0609
>  #define USB_DEVICE_ID_SMK_PS3_BDREMOTE	0x0306
> +#define USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE	0x0368
> +#define USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE	0x0369
>  
>  #define USB_VENDOR_ID_SONY			0x054c
>  #define USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE	0x024b
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index f405b07..5bd4d61 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -9,6 +9,7 @@
>   *  Copyright (c) 2006-2013 Jiri Kosina
>   *  Copyright (c) 2013 Colin Leitner <colin.leitner@gmail.com>
>   *  Copyright (c) 2014-2016 Frank Praznik <frank.praznik@gmail.com>
> + *  Copyright (c) 2017 Todd Kelner
>   */
>  
>  /*
> @@ -54,6 +55,8 @@
>  #define NAVIGATION_CONTROLLER_BT  BIT(10)
>  #define SINO_LITE_CONTROLLER      BIT(11)
>  #define FUTUREMAX_DANCE_MAT       BIT(12)
> +#define NSG_MR5U_REMOTE_BT        BIT(13)
> +#define NSG_MR7U_REMOTE_BT        BIT(14)
>  
>  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
>  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
> @@ -70,8 +73,11 @@
>  				MOTION_CONTROLLER)
>  #define SONY_BT_DEVICE (SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_BT |\
>  			MOTION_CONTROLLER_BT | NAVIGATION_CONTROLLER_BT)
> +#define NSG_MRXU_REMOTE (NSG_MR5U_REMOTE_BT | NSG_MR7U_REMOTE_BT)
>  
>  #define MAX_LEDS 4
> +#define NSG_MRXU_MAX_X 1667
> +#define NSG_MRXU_MAX_Y 1868
>  
>  /*
>   * The Sixaxis reports both digital and analog values for each button on the
> @@ -1063,7 +1069,7 @@ struct motion_output_report_02 {
>  #define DS4_INPUT_REPORT_BATTERY_OFFSET  30
>  #define DS4_INPUT_REPORT_TOUCHPAD_OFFSET 33
>  
> -#define DS4_TOUCHPAD_SUFFIX " Touchpad"
> +#define TOUCHPAD_SUFFIX " Touchpad"
>  
>  static DEFINE_SPINLOCK(sony_dev_list_lock);
>  static LIST_HEAD(sony_device_list);
> @@ -1383,6 +1389,75 @@ static void dualshock4_parse_report(struct sony_sc *sc, u8 *rd, int size)
>  	}
>  }
>  
> +static void nsg_mrxu_parse_report(struct sony_sc *sc, u8 *rd, int size)
> +{
> +	int n, offset;
> +	u8 active;
> +
> +	/*
> +	 * The NSG-MRxU multi-touch trackpad data starts at offset 1 and
> +	 *   the touch-related data starts at offset 2.
> +	 * For the first byte, bit 0 is set when touchpad button is pressed.
> +	 * Bit 3 is set when a touch is active and the drag (Fn) key is pressed.
> +	 * This drag key is mapped to BTN_LEFT.
> +	 * Bit 4 is set when only the first touch point is active.
> +	 * Bit 6 is set when only the second touch point is active.
> +	 * Bits 5 and 7 are set when both touch points are active.
> +	 * The next 3 bytes are two 12 bit X/Y coordinates for the first touch.
> +	 * The following byte, offset 5, has the touch width and length.
> +	 *   Bits 0-4=X (width), bits 5-7=Y (length).
> +	 * A signed relative X coordinate is at offset 6.
> +	 * The bytes at offset 7-9 are the second touch X/Y coordinates.
> +	 * Offset 10 has the second touch width and length.
> +	 * Offset 11 has the relative Y coordinate.
> +	 */
> +	offset = 1;
> +
> +	input_report_key(sc->touchpad, BTN_LEFT, rd[offset] & 0x0F);
> +	active = (rd[offset] >> 4);
> +
> +	offset++;
> +
> +	for (n = 0; n < 2; n++) {
> +		u16 x, y;
> +		u8 contactx, contacty;
> +		unsigned int rel_axis;
> +
> +		x = rd[offset] | ((rd[offset+1] & 0x0F) << 8);
> +		y = ((rd[offset+1] & 0xF0) >> 4) | (rd[offset+2] << 4);
> +
> +		input_mt_slot(sc->touchpad, n);
> +		input_mt_report_slot_state(sc->touchpad, MT_TOOL_FINGER, active & 0x03);
> +
> +		if (active & 0x03) {
> +			contactx = rd[offset+3] & 0x0F;
> +			contacty = rd[offset+3] >> 4;
> +			input_report_abs(sc->touchpad, ABS_MT_TOUCH_MAJOR,
> +				max(contactx, contacty));
> +			input_report_abs(sc->touchpad, ABS_MT_TOUCH_MINOR,
> +				max(contactx, contacty));
> +			input_report_abs(sc->touchpad, ABS_MT_ORIENTATION,
> +				(bool) (contactx > contacty));
> +			input_report_abs(sc->touchpad, ABS_MT_POSITION_X, x);
> +			input_report_abs(sc->touchpad, ABS_MT_POSITION_Y,
> +				NSG_MRXU_MAX_Y - y);
> +			if (n == 0)
> +				rel_axis = REL_X;
> +			else
> +				rel_axis = REL_Y;
> +
> +			input_report_rel(sc->touchpad, rel_axis, rd[offset+4]);
> +		}
> +
> +		offset += 5;
> +                active >>= 2;
> +	}
> +
> +	input_mt_sync_frame(sc->touchpad);
> +
> +	input_sync(sc->touchpad);
> +}
> +
>  static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
>  		u8 *rd, int size)
>  {
> @@ -1459,6 +1534,10 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
>  		}
>  
>  		dualshock4_parse_report(sc, rd, size);
> +
> +	} else if (sc->quirks & NSG_MRXU_REMOTE && rd[0] == 0x02) {
> +		nsg_mrxu_parse_report(sc, rd, size);
> +		return 1;
>  	}
>  
>  	if (sc->defer_initialization) {
> @@ -1529,30 +1608,43 @@ static int sony_register_touchpad(struct sony_sc *sc, int touch_count,
>  	sc->touchpad->id.product = sc->hdev->product;
>  	sc->touchpad->id.version = sc->hdev->version;
>  
> -	/* Append a suffix to the controller name as there are various
> -	 * DS4 compatible non-Sony devices with different names.
> -	 */
> -	name_sz = strlen(sc->hdev->name) + sizeof(DS4_TOUCHPAD_SUFFIX);
> +	/* Append a suffix to the controller name to make it more unique */
> +	name_sz = strlen(sc->hdev->name) + sizeof(TOUCHPAD_SUFFIX);
>  	name = kzalloc(name_sz, GFP_KERNEL);
>  	if (!name) {
>  		ret = -ENOMEM;
>  		goto err;
>  	}
> -	snprintf(name, name_sz, "%s" DS4_TOUCHPAD_SUFFIX, sc->hdev->name);
> +	snprintf(name, name_sz, "%s" TOUCHPAD_SUFFIX, sc->hdev->name);
>  	sc->touchpad->name = name;
>  
> -	ret = input_mt_init_slots(sc->touchpad, touch_count, 0);
> -	if (ret < 0)
> -		goto err;
> +	if (!(sc->quirks & NSG_MRXU_REMOTE)) {
> +		ret = input_mt_init_slots(sc->touchpad, touch_count, 0);
> +		if (ret < 0)
> +			goto err;
> +	}
>  
>  	/* We map the button underneath the touchpad to BTN_LEFT. */
>  	__set_bit(EV_KEY, sc->touchpad->evbit);
>  	__set_bit(BTN_LEFT, sc->touchpad->keybit);
> +	__clear_bit(BTN_MIDDLE, sc->touchpad->keybit);
> +	__clear_bit(BTN_RIGHT, sc->touchpad->keybit);
>  	__set_bit(INPUT_PROP_BUTTONPAD, sc->touchpad->propbit);
>  
>  	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_X, 0, w, 0, 0);
>  	input_set_abs_params(sc->touchpad, ABS_MT_POSITION_Y, 0, h, 0, 0);
>  
> +	if (sc->quirks & NSG_MRXU_REMOTE) {
> +		__set_bit(EV_REL, sc->touchpad->evbit);
> +		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MAJOR, 0, 15, 0, 0);
> +		input_set_abs_params(sc->touchpad, ABS_MT_TOUCH_MINOR, 0, 15, 0, 0);
> +		input_set_abs_params(sc->touchpad, ABS_MT_ORIENTATION, 0, 1, 0, 0);
> +
> +		ret = input_mt_init_slots(sc->touchpad, touch_count, INPUT_MT_POINTER);
> +		if (ret < 0)
> +			goto err;
> +	}
> +
>  	ret = input_register_device(sc->touchpad);
>  	if (ret < 0)
>  		goto err;
> @@ -2586,6 +2678,20 @@ static int sony_input_configured(struct hid_device *hdev,
>  		}
>  
>  		sony_init_output_report(sc, dualshock4_send_output_report);
> +	} else if (sc->quirks & NSG_MRXU_REMOTE) {
> +		/*
> + 		 * The NSG-MRxU touchpad supports 2 touches and has a
> + 		 * resolution of 1667x1868
> + 		 */
> +		ret = sony_register_touchpad(sc, 2,
> +			NSG_MRXU_MAX_X, NSG_MRXU_MAX_Y);
> +		if (ret) {
> +			hid_err(sc->hdev,
> +			"Unable to initialize multi-touch slots: %d\n",
> +			ret);
> +			goto err_stop;
> +		}
> +
>  	} else if (sc->quirks & MOTION_CONTROLLER) {
>  		sony_init_output_report(sc, motion_send_output_report);
>  	} else {
> @@ -2830,6 +2936,12 @@ static const struct hid_device_id sony_devices[] = {
>  	/* Nyko Core Controller for PS3 */
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SINO_LITE, USB_DEVICE_ID_SINO_LITE_CONTROLLER),
>  		.driver_data = SIXAXIS_CONTROLLER_USB | SINO_LITE_CONTROLLER },
> +	/* SMK-Link NSG-MR5U Remote Control */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR5U_REMOTE),
> +		.driver_data = NSG_MR5U_REMOTE_BT },
> +	/* SMK-Link NSG-MR7U Remote Control */
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SMK, USB_DEVICE_ID_SMK_NSG_MR7U_REMOTE),
> +		.driver_data = NSG_MR7U_REMOTE_BT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, sony_devices);
> -- 
> 2.7.4
> 

-- 
Jiri Kosina
SUSE Labs

