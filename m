From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: wacom - Support EMR and MFT sensors of Cintiq
 Companion Hybrid
Date: Sat, 24 Aug 2013 16:56:48 -0700
Message-ID: <20130824235648.GH4454@core.coreip.homeip.net>
References: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:61797 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab3HXX4v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Aug 2013 19:56:51 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so2021295pab.20
        for <linux-input@vger.kernel.org>; Sat, 24 Aug 2013 16:56:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, pinglinux@gmail.com

Hi Jason,

On Thu, Aug 22, 2013 at 06:15:35PM -0700, Jason Gerecke wrote:
> Adds support for the sensors integrated in to the Cintiq Companion
> Hybrid. These sensors use by-and-large the same protocol as the
> Cintiq 24HD touch.
> 
> NOTE: The ExpressKeys on the Cintiq Companion Hybrid are wired to
> both the EMR controller and CPU GPIO pins. It may be necessary to
> disable their functionality in this driver if building a custom
> Android kernel for this device (lest two events be sent to userspace
> for every button press).
> 
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/input/tablet/wacom_sys.c |  2 +-
>  drivers/input/tablet/wacom_wac.c | 49 +++++++++++++++++++++++++++++++++++++++-
>  drivers/input/tablet/wacom_wac.h |  1 +
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index 1ad3e07..8fa7af7 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -548,7 +548,7 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
>  			/* MT Tablet PC touch */
>  			return wacom_set_device_mode(intf, 3, 4, 4);
>  		}
> -		else if (features->type == WACOM_24HDT) {
> +		else if (features->type == WACOM_24HDT || features->type == ASTERIX) {
>  			return wacom_set_device_mode(intf, 18, 3, 2);
>  		}
>  	} else if (features->device_type == BTN_TOOL_PEN) {
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 541197b..8ccfe91 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -475,7 +475,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
>  	/* general pen packet */
>  	if ((data[1] & 0xb8) == 0xa0) {
>  		t = (data[6] << 2) | ((data[7] >> 6) & 3);
> -		if (features->type >= INTUOS4S && features->type <= WACOM_24HD) {
> +		if (features->type >= INTUOS4S && features->type <= ASTERIX) {
>  			t = (t << 1) | (data[1] & 1);
>  		}
>  		input_report_abs(input, ABS_PRESSURE, t);
> @@ -619,6 +619,25 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
>  			} else {
>  				input_report_abs(input, ABS_MISC, 0);
>  			}
> +		} else if (features->type == ASTERIX) {
> +			/*
> +			 * Do not send hardware buttons under Android. They
> +			 * are already sent to the system through GPIO (and
> +			 * have different meaning).
> +			 */
> +
> +#if 1

Should this be removed.

> +			input_report_key(input, BTN_1, (data[4] & 0x01));
> +			input_report_key(input, BTN_2, (data[4] & 0x02));
> +			input_report_key(input, BTN_3, (data[4] & 0x04));
> +			input_report_key(input, BTN_4, (data[4] & 0x08));
> +
> +			input_report_key(input, BTN_5, (data[4] & 0x10));  // Right
> +			input_report_key(input, BTN_6, (data[4] & 0x20));  // Up
> +			input_report_key(input, BTN_7, (data[4] & 0x40));  // Left
> +			input_report_key(input, BTN_8, (data[4] & 0x80));  // Down
> +			input_report_key(input, BTN_0, (data[3] & 0x01));  // Center

C-style comments are still preferred in the kernel.

> +#endif
>  		} else if (features->type >= INTUOS5S && features->type <= INTUOS5L) {
>  			int i;
>  
> @@ -1325,6 +1344,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
>  	case WACOM_22HD:
>  	case WACOM_24HD:
>  	case DTK:
> +	case ASTERIX:
>  		sync = wacom_intuos_irq(wacom_wac);
>  		break;
>  
> @@ -1763,6 +1783,24 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>  					      0, 0);
>  		}
>  		break;
> +
> +	case ASTERIX:
> +		__set_bit(BTN_1, input_dev->keybit);
> +		__set_bit(BTN_2, input_dev->keybit);
> +		__set_bit(BTN_3, input_dev->keybit);
> +		__set_bit(BTN_4, input_dev->keybit);
> +
> +		__set_bit(BTN_5, input_dev->keybit);
> +		__set_bit(BTN_6, input_dev->keybit);
> +		__set_bit(BTN_7, input_dev->keybit);
> +		__set_bit(BTN_8, input_dev->keybit);
> +		__set_bit(BTN_0, input_dev->keybit);
> +
> +		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
> +		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
> +
> +		wacom_setup_cintiq(wacom_wac);
> +		break;
>  	}
>  	return 0;
>  }
> @@ -2117,6 +2155,13 @@ static const struct wacom_features wacom_features_0xDF =
>  static const struct wacom_features wacom_features_0x6004 =
>  	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
>  	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> +static const struct wacom_features wacom_features_0x0307 =
> +	{ "Wacom ISDv5 307", WACOM_PKGLEN_INTUOS,  59552,  33848, 2047,
> +	  63, ASTERIX, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
> +	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
> +static const struct wacom_features wacom_features_0x0309 =
> +	{ "Wacom ISDv5 309", .type = WACOM_24HDT, /* Touch */
> +	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x0307, .touch_max = 10 };
>  
>  #define USB_DEVICE_WACOM(prod)					\
>  	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
> @@ -2247,6 +2292,8 @@ const struct usb_device_id wacom_ids[] = {
>  	{ USB_DEVICE_WACOM(0xF8) },
>  	{ USB_DEVICE_DETAILED(0xF6, USB_CLASS_HID, 0, 0) },
>  	{ USB_DEVICE_WACOM(0xFA) },
> +	{ USB_DEVICE_WACOM(0x0307) },
> +	{ USB_DEVICE_DETAILED(0x0309, USB_CLASS_HID, 0, 0) },
>  	{ USB_DEVICE_LENOVO(0x6004) },
>  	{ }
>  };
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
> index dfc9e08..f47a5c1 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -80,6 +80,7 @@ enum {
>  	WACOM_22HD,
>  	DTK,
>  	WACOM_24HD,
> +	ASTERIX,
>  	CINTIQ,
>  	WACOM_BEE,
>  	WACOM_13HD,

Thanks.

-- 
Dmitry
