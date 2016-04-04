From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 2/2] HID: wacom: Support switching from vendor-defined
 device mode on G9 and G11
Date: Mon, 4 Apr 2016 22:54:52 +0200
Message-ID: <20160404205452.GC3443@mail.corp.redhat.com>
References: <56FD84F4.6060707@gmail.com>
 <1459794412-10306-1-git-send-email-killertofu@gmail.com>
 <1459794412-10306-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43556 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755616AbcDDUy5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Apr 2016 16:54:57 -0400
Content-Disposition: inline
In-Reply-To: <1459794412-10306-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <jason.gerecke@wacom.com>

On Apr 04 2016 or thereabouts, Jason Gerecke wrote:
> A tablet PC booted into Windows may have its pen/touch hardware switched
> into "Wacom mode" similar to what we do with explicitly-supported hardware.
> Some devices appear to maintain this state across reboots, preventing their
> use with the generic HID driver. This patch adds support for detecting the
> presence of the mode switch feature report used by devices based on the G9
> and G11 chips and has the HID codepath always attempt to reset the device
> back to sending standard HID reports.
> 
> Fixes: https://sourceforge.net/p/linuxwacom/bugs/307/
> Fixes: https://sourceforge.net/p/linuxwacom/bugs/310/
> Fixes: https://github.com/linuxwacom/input-wacom/issues/15
> 
> Co-authored-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---

Not sure how much this matters now, but for the series:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> Changes from v1:
>  * Incorporate Benjamin's feedback & suggested wacom_set_device_mode code
> 
>  drivers/hid/wacom_sys.c | 100 ++++++++++++++++++++++++++++++++++--------------
>  drivers/hid/wacom_wac.h |   8 ++++
>  2 files changed, 80 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index b338bbf..ccf1883 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -152,6 +152,25 @@ static void wacom_feature_mapping(struct hid_device *hdev,
>  		hid_data->inputmode = field->report->id;
>  		hid_data->inputmode_index = usage->usage_index;
>  		break;
> +
> +	case HID_UP_DIGITIZER:
> +		if (field->report->id == 0x0B &&
> +		    (field->application == WACOM_G9_DIGITIZER ||
> +		     field->application == WACOM_G11_DIGITIZER)) {
> +			wacom->wacom_wac.mode_report = field->report->id;
> +			wacom->wacom_wac.mode_value = 0;
> +		}
> +		break;
> +
> +	case WACOM_G9_PAGE:
> +	case WACOM_G11_PAGE:
> +		if (field->report->id == 0x03 &&
> +		    (field->application == WACOM_G9_TOUCHSCREEN ||
> +		     field->application == WACOM_G11_TOUCHSCREEN)) {
> +			wacom->wacom_wac.mode_report = field->report->id;
> +			wacom->wacom_wac.mode_value = 0;
> +		}
> +		break;
>  	}
>  }
>  
> @@ -322,26 +341,41 @@ static int wacom_hid_set_device_mode(struct hid_device *hdev)
>  	return 0;
>  }
>  
> -static int wacom_set_device_mode(struct hid_device *hdev, int report_id,
> -		int length, int mode)
> +static int wacom_set_device_mode(struct hid_device *hdev,
> +				 struct wacom_wac *wacom_wac)
>  {
> -	unsigned char *rep_data;
> +	u8 *rep_data;
> +	struct hid_report *r;
> +	struct hid_report_enum *re;
> +	int length;
>  	int error = -ENOMEM, limit = 0;
>  
> -	rep_data = kzalloc(length, GFP_KERNEL);
> +	if (wacom_wac->mode_report < 0)
> +		return 0;
> +
> +	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
> +	r = re->report_id_hash[wacom_wac->mode_report];
> +	if (!r)
> +		return -EINVAL;
> +
> +	rep_data = hid_alloc_report_buf(r, GFP_KERNEL);
>  	if (!rep_data)
> -		return error;
> +		return -ENOMEM;
> +
> +	length = hid_report_len(r);
>  
>  	do {
> -		rep_data[0] = report_id;
> -		rep_data[1] = mode;
> +		rep_data[0] = wacom_wac->mode_report;
> +		rep_data[1] = wacom_wac->mode_value;
>  
>  		error = wacom_set_report(hdev, HID_FEATURE_REPORT, rep_data,
>  					 length, 1);
>  		if (error >= 0)
>  			error = wacom_get_report(hdev, HID_FEATURE_REPORT,
>  			                         rep_data, length, 1);
> -	} while (error >= 0 && rep_data[1] != mode && limit++ < WAC_MSG_RETRIES);
> +	} while (error >= 0 &&
> +		 rep_data[1] != wacom_wac->mode_report &&
> +		 limit++ < WAC_MSG_RETRIES);
>  
>  	kfree(rep_data);
>  
> @@ -411,32 +445,41 @@ static int wacom_bt_query_tablet_data(struct hid_device *hdev, u8 speed,
>  static int wacom_query_tablet_data(struct hid_device *hdev,
>  		struct wacom_features *features)
>  {
> +	struct wacom *wacom = hid_get_drvdata(hdev);
> +	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
> +
>  	if (hdev->bus == BUS_BLUETOOTH)
>  		return wacom_bt_query_tablet_data(hdev, 1, features);
>  
> -	if (features->type == HID_GENERIC)
> -		return wacom_hid_set_device_mode(hdev);
> -
> -	if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
> -		if (features->type > TABLETPC) {
> -			/* MT Tablet PC touch */
> -			return wacom_set_device_mode(hdev, 3, 4, 4);
> -		}
> -		else if (features->type == WACOM_24HDT) {
> -			return wacom_set_device_mode(hdev, 18, 3, 2);
> -		}
> -		else if (features->type == WACOM_27QHDT) {
> -			return wacom_set_device_mode(hdev, 131, 3, 2);
> -		}
> -		else if (features->type == BAMBOO_PAD) {
> -			return wacom_set_device_mode(hdev, 2, 2, 2);
> -		}
> -	} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
> -		if (features->type <= BAMBOO_PT) {
> -			return wacom_set_device_mode(hdev, 2, 2, 2);
> +	if (features->type != HID_GENERIC) {
> +		if (features->device_type & WACOM_DEVICETYPE_TOUCH) {
> +			if (features->type > TABLETPC) {
> +				/* MT Tablet PC touch */
> +				wacom_wac->mode_report = 3;
> +				wacom_wac->mode_value = 4;
> +			} else if (features->type == WACOM_24HDT) {
> +				wacom_wac->mode_report = 18;
> +				wacom_wac->mode_value = 2;
> +			} else if (features->type == WACOM_27QHDT) {
> +				wacom_wac->mode_report = 131;
> +				wacom_wac->mode_value = 2;
> +			} else if (features->type == BAMBOO_PAD) {
> +				wacom_wac->mode_report = 2;
> +				wacom_wac->mode_value = 2;
> +			}
> +		} else if (features->device_type & WACOM_DEVICETYPE_PEN) {
> +			if (features->type <= BAMBOO_PT) {
> +				wacom_wac->mode_report = 2;
> +				wacom_wac->mode_value = 2;
> +			}
>  		}
>  	}
>  
> +	wacom_set_device_mode(hdev, wacom_wac);
> +
> +	if (features->type == HID_GENERIC)
> +		return wacom_hid_set_device_mode(hdev);
> +
>  	return 0;
>  }
>  
> @@ -1818,6 +1861,7 @@ static int wacom_probe(struct hid_device *hdev,
>  	}
>  
>  	wacom_wac->hid_data.inputmode = -1;
> +	wacom_wac->mode_report = -1;
>  
>  	wacom->usbdev = dev;
>  	wacom->intf = intf;
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 25baa7f..e2084d9 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -84,6 +84,12 @@
>  #define WACOM_DEVICETYPE_WL_MONITOR     0x0008
>  
>  #define WACOM_VENDORDEFINED_PEN		0xff0d0001
> +#define WACOM_G9_PAGE			0xff090000
> +#define WACOM_G9_DIGITIZER		(WACOM_G9_PAGE | 0x02)
> +#define WACOM_G9_TOUCHSCREEN		(WACOM_G9_PAGE | 0x11)
> +#define WACOM_G11_PAGE			0xff110000
> +#define WACOM_G11_DIGITIZER		(WACOM_G11_PAGE | 0x02)
> +#define WACOM_G11_TOUCHSCREEN		(WACOM_G11_PAGE | 0x11)
>  
>  #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
>  				 ((f)->physical == HID_DG_STYLUS) || \
> @@ -238,6 +244,8 @@ struct wacom_wac {
>  	int ps_connected;
>  	u8 bt_features;
>  	u8 bt_high_speed;
> +	int mode_report;
> +	int mode_value;
>  	struct hid_data hid_data;
>  };
>  
> -- 
> 2.7.3
> 
