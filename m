From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] HID: input: enable Totem on the Dell Canvas 27
Date: Tue, 14 Nov 2017 18:50:43 +1000
Message-ID: <20171114085043.GA29518@jelly>
References: <20171110102635.325-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:60739 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdKNIw4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 03:52:56 -0500
Content-Disposition: inline
In-Reply-To: <20171110102635.325-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mario Limonciello <Mario.Limonciello@dell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

sorry, this one got stuck in my outbox.

On Fri, Nov 10, 2017 at 11:26:35AM +0100, Benjamin Tissoires wrote:
> The Dell Canvas 27 has a tool that can be put on the surface and acts
> as a dial. The firmware processes the detection of the tool and forward
> regular HID reports with X, Y, Azimuth, rotation, width/height.
> 
> The firmware also exports Contact ID, Countact Count which may hint that
> several totems can be used at the same time, but for now, only allow
> one totem at a time.
> 
> We also ignore scan time in hid-input.c because there is not much point
> to forward it now given that the indication of the tool being present
> is already provided through BTN_TOOL_DIAL.
> 
> We need to add a new BTN_TOOL_DIAL event because the HID mapping
> suggests that this tool is aimed at being used by the system and not
> the applications. Also this prevents current systemd heuristics to
> apply ID_INPUT_TOUCHSCREEN to this new type of devices.
> 
> I mapped Azimuth to ABS_WHEEL to somehow ressemble the Wacom Pads.

HID docs indicate this is a full tool rotation, so ABS_RZ would be more
appropriate?

"Azimuth 
    The counter-clockwise rotation of the cursor about the Z-axis."

But you also say it has rotation, so this is a bit confusing now :)
We should also use INPUT_PROP_DIRECT here.

> Last, both Width and Heigth are groupped together, the FW reports

typo: grouped

> similar values for both and we are out of ABS_* events.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1511846
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi,
> 
> This is probably v4.16 material as we are close to the merge window
> (I wouldn't mind it applied in v4.15 though ;-P)

I'm going to be annoying here and say I'd like to figure out how to add this
to libinput first to figure out what details can go wrong before we merge it
and commit to this forever. Hopefully that shouldn't take that long...

Cheers,
   Peter

> The patch does the job but we probably need to decide if the mappings
> I chose are correct.
> 
> For the record, I uploaded some evemu-record traces and hid-recorder
> traces in the RH Bz linked above to keep traces of them.
> The interesting one is the evemu one for the totem with this patch
> applied:
> https://bugzilla.redhat.com/attachment.cgi?id=1350389
> 
> Cheers,
> Benjamin
> 
>  drivers/hid/hid-input.c                | 28 +++++++++++++++++++++++++++-
>  drivers/hid/hid-multitouch.c           | 11 +++++++++++
>  include/linux/hid.h                    |  6 ++++++
>  include/uapi/linux/input-event-codes.h |  1 +
>  4 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 04d01b57d94c..7da72b571b7d 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -229,6 +229,7 @@ __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
>  	case ABS_X:
>  	case ABS_Y:
>  	case ABS_Z:
> +	case ABS_TOOL_WIDTH:
>  	case ABS_MT_POSITION_X:
>  	case ABS_MT_POSITION_Y:
>  	case ABS_MT_TOOL_X:
> @@ -786,13 +787,24 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  			map_abs_clear(ABS_TILT_Y);
>  			break;
>  
> +		case 0x3f: /* Azimuth */
> +			map_abs_clear(ABS_WHEEL);
> +			break;
> +
>  		case 0x33: /* Touch */
> -		case 0x42: /* TipSwitch */
>  		case 0x43: /* TipSwitch2 */
>  			device->quirks &= ~HID_QUIRK_NOTOUCH;
>  			map_key_clear(BTN_TOUCH);
>  			break;
>  
> +		case 0x42: /* TipSwitch */
> +			if (field->application == HID_GD_SYSTEM_MULTIAXIS) {
> +				map_key_clear(BTN_TOOL_DIAL);
> +			} else {
> +				device->quirks &= ~HID_QUIRK_NOTOUCH;
> +				map_key_clear(BTN_TOUCH);
> +			}
> +			break;
>  		case 0x44: /* BarrelSwitch */
>  			map_key_clear(BTN_STYLUS);
>  			break;
> @@ -806,6 +818,20 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  			map_key_clear(BTN_TOUCH);
>  			break;
>  
> +		case 0x48: /* WIDTH */
> +		case 0x49: /* HEIGHT */
> +			map_abs_clear(ABS_TOOL_WIDTH);
> +			break;
> +
> +		case 0x51: /* CONTACT ID */
> +			goto ignore;
> +
> +		case 0x54: /* CONTACT COUNT */
> +			goto ignore;
> +
> +		case 0x56: /* SCANTIME */
> +			goto ignore;
> +
>  		case 0x46: /* TabletPick */
>  		case 0x5a: /* SecondaryBarrelSwitch */
>  			map_key_clear(BTN_STYLUS2);
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 65ea23be9677..a0b332518eaa 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -974,6 +974,7 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  	    field->application != HID_DG_TOUCHPAD &&
>  	    field->application != HID_GD_KEYBOARD &&
>  	    field->application != HID_GD_SYSTEM_CONTROL &&
> +	    field->application != HID_GD_SYSTEM_MULTIAXIS &&
>  	    field->application != HID_CP_CONSUMER_CONTROL &&
>  	    field->application != HID_GD_WIRELESS_RADIO_CTLS &&
>  	    !(field->application == HID_VD_ASUS_CUSTOM_MEDIA_KEYS &&
> @@ -1003,6 +1004,14 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		return 1;
>  	}
>  
> +	/*
> +	 * We do not want to export scantime on System MultiAxis
> +	 * for now
> +	 */
> +	if (field->usage->hid == HID_DG_SCANTIME &&
> +	    field->application == HID_GD_SYSTEM_MULTIAXIS)
> +		return -1;
> +
>  	/*
>  	 * some egalax touchscreens have "application == HID_DG_TOUCHSCREEN"
>  	 * for the stylus.
> @@ -1193,6 +1202,8 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  			break;
>  		case HID_GD_MOUSE:
>  			suffix = "Mouse";
> +		case HID_GD_SYSTEM_MULTIAXIS:
> +			suffix = "MultiAxis";
>  			break;
>  		case HID_DG_STYLUS:
>  			suffix = "Pen";
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index d491027a7c22..f93ebbe2f23d 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -189,6 +189,12 @@ struct hid_item {
>   * http://www.usb.org/developers/hidpage/HUTRR40RadioHIDUsagesFinal.pdf
>   */
>  #define HID_GD_WIRELESS_RADIO_CTLS	0x0001000c
> +/*
> + * System Multi-Axis, see:
> + * http://www.usb.org/developers/hidpage/HUTRR62_-_Generic_Desktop_CA_for_System_Multi-Axis_Controllers.txt
> + */
> +#define HID_GD_SYSTEM_MULTIAXIS	0x0001000e
> +
>  #define HID_GD_X		0x00010030
>  #define HID_GD_Y		0x00010031
>  #define HID_GD_Z		0x00010032
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 179891074b3c..f886499fdd4c 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -406,6 +406,7 @@
>  #define BTN_TOOL_MOUSE		0x146
>  #define BTN_TOOL_LENS		0x147
>  #define BTN_TOOL_QUINTTAP	0x148	/* Five fingers on trackpad */
> +#define BTN_TOOL_DIAL		0x149	/* System MultiAxis */
>  #define BTN_TOUCH		0x14a
>  #define BTN_STYLUS		0x14b
>  #define BTN_STYLUS2		0x14c
> -- 
> 2.14.3
> 
