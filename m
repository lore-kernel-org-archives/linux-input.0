From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] HID: wacom: add full support of the Wacom Bamboo PAD
Date: Wed, 18 Feb 2015 14:58:16 +1000
Message-ID: <20150218045816.GA20995@jelly.redhat.com>
References: <1424201233-4158-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424201233-4158-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: josep.sanchez.ferreres@est.fib.upc.edu, ACHARD.Frederic.frederic.achard@free.fr, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Feb 17, 2015 at 02:27:13PM -0500, Benjamin Tissoires wrote:
> The stylus of this device works just fine out of the box.
> The touch is seen by default as a mouse with relative events and some
> gestures.
> Switching the default in raw mode allows us to retrieve the touch data
> and have a consistent user experience accross all the multitouch touchpads.
> 
> Note that the buttons of this devices are reported through the touch
> interface. There is no 'Pad' interface. It seemed more natural to have
> the BTN_LEFT and BTN_RIGHT reported with the touch because they are
> placed under the touch interface and it looks like they belong to the
> touch part.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi,
> 
> several things before we can merge this:
> 
> Josep, Frederic:
> Would you mind testing this patch with your Bamboo pads? I bought the wireless
> variant and the USB one has a different ProductID. Hopefully, it will go
> smoothly with the current patch.
> 
> Peter, Ping, Jason:
> Given the nature of the device, I did not exported the 2 buttons as a separate
> pad device.
> Do you back me up with this choice?

yeah, agree - this looks more like a touchpad than a touch-enabled tablet.

Cheers,
   Peter
 
> Jiri:
> As mentioned to Josep and Frederic, this has not been tested against the USB
> (wired) version of the device. So please wait at least for one tested-by before
> considering including this patch.
> 
> Thanks everyone!
> Benjamin
> 
>  drivers/hid/wacom_sys.c | 23 ++++++++++++++++++
>  drivers/hid/wacom_wac.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/wacom_wac.h |  3 +++
>  3 files changed, 88 insertions(+)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index e1ec192..ef4d147 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -410,6 +410,9 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
>  		else if (features->type == WACOM_27QHDT) {
>  			return wacom_set_device_mode(hdev, 131, 3, 2);
>  		}
> +		else if (features->type == BAMBOO_PAD) {
> +			return wacom_set_device_mode(hdev, 2, 2, 3);
> +		}
>  	} else if (features->device_type == BTN_TOOL_PEN) {
>  		if (features->type <= BAMBOO_PT && features->type != WIRELESS) {
>  			return wacom_set_device_mode(hdev, 2, 2, 2);
> @@ -1417,6 +1420,20 @@ static int wacom_probe(struct hid_device *hdev,
>  			goto fail_allocate_inputs;
>  	}
>  
> +	/*
> +	 * Bamboo Pad has a generic hid handling for the Pen, and we switch it
> +	 * into debug mode for the touch part.
> +	 * We ignore the other interfaces.
> +	 */
> +	if (features->type == BAMBOO_PAD) {
> +		if (features->pktlen == WACOM_PKGLEN_PENABLED) {
> +			features->type = HID_GENERIC;
> +		} else if (features->pktlen != WACOM_PKGLEN_BP_TOUCH) {
> +			error = -ENODEV;
> +			goto fail_shared_data;
> +		}
> +	}
> +
>  	/* set the default size in case we do not get them from hid */
>  	wacom_set_default_phy(features);
>  
> @@ -1451,6 +1468,12 @@ static int wacom_probe(struct hid_device *hdev,
>  		features->y_max = 4096;
>  	}
>  
> +	/*
> +	 * Same thing for Bamboo PAD
> +	 */
> +	if (features->type == BAMBOO_PAD)
> +		features->device_type = BTN_TOOL_FINGER;
> +
>  	if (hdev->bus == BUS_BLUETOOTH)
>  		features->quirks |= WACOM_QUIRK_BATTERY;
>  
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 1a65079..8627581 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1826,6 +1826,49 @@ static int wacom_bpt_irq(struct wacom_wac *wacom, size_t len)
>  	return 0;
>  }
>  
> +static int wacom_bamboo_pad_irq(struct wacom_wac *wacom, size_t len)
> +{
> +	struct input_dev *input = wacom->input;
> +	unsigned char *data = wacom->data;
> +	unsigned char *finger_data, prefix;
> +	unsigned id;
> +	int x, y;
> +	bool valid;
> +
> +	/* bit 2 in data[1] is set when there is touch information available */
> +	if ((len != WACOM_PKGLEN_BP_TOUCH) ||
> +	    (data[0] != WACOM_REPORT_BP_TOUCH) ||
> +	    !(data[1] & 0x02))
> +		return 0;
> +
> +	prefix = data[9];
> +
> +	for (id = 0; id < wacom->features.touch_max; id++) {
> +		valid = !!(prefix & BIT(id)) &&
> +			!wacom->shared->stylus_in_proximity;
> +
> +		input_mt_slot(input, id);
> +		input_mt_report_slot_state(input, MT_TOOL_FINGER, valid);
> +
> +		if (!valid)
> +			continue;
> +
> +		finger_data = data + 10 + id * 3;
> +		x = finger_data[0] | ((finger_data[1] & 0x0f) << 8);
> +		y = (finger_data[2] << 4) | (finger_data[1] >> 4);
> +
> +		input_report_abs(input, ABS_MT_POSITION_X, x);
> +		input_report_abs(input, ABS_MT_POSITION_Y, y);
> +	}
> +
> +	input_mt_sync_frame(input);
> +
> +	input_report_key(input, BTN_LEFT, prefix & 0x40);
> +	input_report_key(input, BTN_RIGHT, prefix & 0x80);
> +
> +	return 1;
> +}
> +
>  static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
>  {
>  	unsigned char *data = wacom->data;
> @@ -1962,6 +2005,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
>  		sync = wacom_bpt_irq(wacom_wac, len);
>  		break;
>  
> +	case BAMBOO_PAD:
> +		sync = wacom_bamboo_pad_irq(wacom_wac, len);
> +		break;
> +
>  	case WIRELESS:
>  		sync = wacom_wireless_irq(wacom_wac, len);
>  		break;
> @@ -2300,6 +2347,13 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
>  					      0, 0);
>  		}
>  		break;
> +	case BAMBOO_PAD:
> +		__clear_bit(ABS_MISC, input_dev->absbit);
> +		input_mt_init_slots(input_dev, features->touch_max,
> +				    INPUT_MT_POINTER);
> +		__set_bit(BTN_LEFT, input_dev->keybit);
> +		__set_bit(BTN_RIGHT, input_dev->keybit);
> +		break;
>  	}
>  	return 0;
>  }
> @@ -2953,6 +3007,12 @@ static const struct wacom_features wacom_features_0x30C =
>  	{ "Wacom ISDv5 30C", .type = WACOM_24HDT, /* Touch */
>  	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30A, .touch_max = 10,
>  	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
> +static const struct wacom_features wacom_features_0x318 =
> +	{ "Wacom USB Bamboo PAD", 4095, 4095, /* Touch */
> +	  .type = BAMBOO_PAD, 35, 48, .touch_max = 4 };
> +static const struct wacom_features wacom_features_0x319 =
> +	{ "Wacom Wireless Bamboo PAD", 4095, 4095, /* Touch */
> +	  .type = BAMBOO_PAD, 35, 48, .touch_max = 4 };
>  static const struct wacom_features wacom_features_0x323 =
>  	{ "Wacom Intuos P M", 21600, 13500, 1023, 31,
>  	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
> @@ -3101,6 +3161,8 @@ const struct hid_device_id wacom_ids[] = {
>  	{ USB_DEVICE_WACOM(0x314) },
>  	{ USB_DEVICE_WACOM(0x315) },
>  	{ USB_DEVICE_WACOM(0x317) },
> +	{ USB_DEVICE_WACOM(0x318) },
> +	{ USB_DEVICE_WACOM(0x319) },
>  	{ USB_DEVICE_WACOM(0x323) },
>  	{ USB_DEVICE_WACOM(0x32A) },
>  	{ USB_DEVICE_WACOM(0x32B) },
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 021ee1c..bf43e0f 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -33,6 +33,7 @@
>  #define WACOM_PKGLEN_MTTPC	40
>  #define WACOM_PKGLEN_DTUS	68
>  #define WACOM_PKGLEN_PENABLED	 8
> +#define WACOM_PKGLEN_BP_TOUCH	32
>  
>  /* wacom data size per MT contact */
>  #define WACOM_BYTES_PER_MT_PACKET	11
> @@ -67,6 +68,7 @@
>  #define WACOM_REPORT_24HDT		1
>  #define WACOM_REPORT_WL			128
>  #define WACOM_REPORT_USB		192
> +#define WACOM_REPORT_BP_TOUCH		16
>  
>  /* device quirks */
>  #define WACOM_QUIRK_MULTI_INPUT		0x0001
> @@ -122,6 +124,7 @@ enum {
>  	BAMBOO_PT,
>  	WACOM_24HDT,
>  	WACOM_27QHDT,
> +	BAMBOO_PAD,
>  	TABLETPC,   /* add new TPC below */
>  	TABLETPCE,
>  	TABLETPC2FG,
> -- 
> 2.1.0
> 
