From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [Patch-V2 3/6] HID: hid-logitech-hidpp: Add basic support for
 Logitech G920
Date: Thu, 19 Nov 2015 12:18:13 +0100
Message-ID: <20151119111813.GG19344@mail.corp.redhat.com>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
 <1447345535-2912-4-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60334 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754315AbbKSLSV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2015 06:18:21 -0500
Content-Disposition: inline
In-Reply-To: <1447345535-2912-4-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, Michal =?utf-8?B?TWFsw70=?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>

On Nov 12 2015 or thereabouts, Simon Wood wrote:
> This patch adds basic support for the Logitech G920 wheel when in HID
> mode. This wheel 'speaks' the HID++ protocol, and therefor is driven
> with hid-logitech-hidpp.
> 
> At this stage the driver only shows that it can communicate with the
> wheel by outputting the name discovered over HID++.
> 
> The normal HID functions work to give input functionality using
> joystick/event interface.
> 
> Note: in 'hidpp_probe()' we have to start the hardware to get packets
> flowing, the same might apply in future for other devices which don't
> use the unifying protocol.
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>
> ---
>  drivers/hid/hid-core.c           |  1 +
>  drivers/hid/hid-ids.h            |  1 +
>  drivers/hid/hid-logitech-hidpp.c | 71 +++++++++++++++++++++++++++++++---------
>  3 files changed, 57 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c6f7a69..190260c 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1902,6 +1902,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G29_WHEEL) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_F3D) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index ac1feea..269e758 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -619,6 +619,7 @@
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2	0xc218
>  #define USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2	0xc219
>  #define USB_DEVICE_ID_LOGITECH_G29_WHEEL	0xc24f
> +#define USB_DEVICE_ID_LOGITECH_G920_WHEEL	0xc262
>  #define USB_DEVICE_ID_LOGITECH_WINGMAN_F3D	0xc283
>  #define USB_DEVICE_ID_LOGITECH_FORCE3D_PRO	0xc286
>  #define USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940	0xc287
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 0f53dc8..699a486 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -49,11 +49,13 @@ MODULE_PARM_DESC(disable_tap_to_click,
>  #define HIDPP_QUIRK_CLASS_WTP			BIT(0)
>  #define HIDPP_QUIRK_CLASS_M560			BIT(1)
>  #define HIDPP_QUIRK_CLASS_K400			BIT(2)
> +#define HIDPP_QUIRK_CLASS_G920			BIT(3)
>  
>  /* bits 2..20 are reserved for classes */
>  #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21)
>  #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
>  #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
> +#define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
>  
>  #define HIDPP_QUIRK_DELAYED_INIT		(HIDPP_QUIRK_NO_HIDINPUT | \
>  						 HIDPP_QUIRK_CONNECT_EVENTS)
> @@ -146,8 +148,11 @@ static void hidpp_connect_event(struct hidpp_device *hidpp_dev);
>  static int __hidpp_send_report(struct hid_device *hdev,
>  				struct hidpp_report *hidpp_report)
>  {
> +	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
>  	int fields_count, ret;
>  
> +	hidpp = hid_get_drvdata(hdev);
> +
>  	switch (hidpp_report->report_id) {
>  	case REPORT_ID_HIDPP_SHORT:
>  		fields_count = HIDPP_REPORT_SHORT_LENGTH;
> @@ -168,9 +173,13 @@ static int __hidpp_send_report(struct hid_device *hdev,
>  	 */
>  	hidpp_report->device_index = 0xff;
>  
> -	ret = hid_hw_raw_request(hdev, hidpp_report->report_id,
> -		(u8 *)hidpp_report, fields_count, HID_OUTPUT_REPORT,
> -		HID_REQ_SET_REPORT);
> +	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
> +		ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
> +	} else {
> +		ret = hid_hw_raw_request(hdev, hidpp_report->report_id,
> +			(u8 *)hidpp_report, fields_count, HID_OUTPUT_REPORT,
> +			HID_REQ_SET_REPORT);
> +	}
>  
>  	return ret == fields_count ? 0 : -1;
>  }
> @@ -1430,10 +1439,12 @@ static void hidpp_overwrite_name(struct hid_device *hdev, bool use_unifying)
>  	else
>  		name = hidpp_get_device_name(hidpp);
>  
> -	if (!name)
> +	if (!name) {
>  		hid_err(hdev, "unable to retrieve the name of the device");
> -	else
> +	} else {
> +		dbg_hid("HID++: Got name: %s\n", name);
>  		snprintf(hdev->name, sizeof(hdev->name), "%s", name);
> +	}
>  
>  	kfree(name);
>  }
> @@ -1596,6 +1607,25 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		goto hid_parse_fail;
>  	}
>  
> +	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> +		connect_mask &= ~HID_CONNECT_HIDINPUT;
> +

Sorry, I missed this one. But with the latest changes, the test should
be:
if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)

see below:

> +	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
> +		ret = hid_hw_start(hdev, connect_mask);
> +		if (ret) {
> +			hid_err(hdev, "hw start failed\n");
> +			goto hid_hw_start_fail;
> +		}
> +		ret = hid_hw_open(hdev);
> +		if (ret < 0) {
> +			dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
> +				__func__, ret);
> +			hid_hw_stop(hdev);
> +			goto hid_hw_start_fail;
> +		}
> +	}
> +
> +
>  	/* Allow incoming packets */
>  	hid_device_io_start(hdev);
>  
> @@ -1604,8 +1634,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		if (!connected) {
>  			ret = -ENODEV;
>  			hid_err(hdev, "Device not connected");
> -			hid_device_io_stop(hdev);
> -			goto hid_parse_fail;
> +			goto hid_hw_open_failed;
>  		}
>  
>  		hid_info(hdev, "HID++ %u.%u device connected.\n",
> @@ -1618,19 +1647,18 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
>  		ret = wtp_get_config(hidpp);
>  		if (ret)
> -			goto hid_parse_fail;
> +			goto hid_hw_open_failed;
>  	}
>  
>  	/* Block incoming packets */
>  	hid_device_io_stop(hdev);
>  
> -	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
> -		connect_mask &= ~HID_CONNECT_HIDINPUT;
> -

This is the hunk that has been moved up and that has been recently
changed.

> -	ret = hid_hw_start(hdev, connect_mask);
> -	if (ret) {
> -		hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
> -		goto hid_hw_start_fail;
> +	if (!(hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
> +		ret = hid_hw_start(hdev, connect_mask);
> +		if (ret) {
> +			hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
> +			goto hid_hw_start_fail;
> +		}
>  	}
>  
>  	if (hidpp->quirks & HIDPP_QUIRK_CONNECT_EVENTS) {
> @@ -1642,6 +1670,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	return ret;
>  
> +hid_hw_open_failed:
> +	hid_device_io_stop(hdev);
> +	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
> +		hid_hw_close(hdev);
> +		hid_hw_stop(hdev);
> +	}
>  hid_hw_start_fail:
>  hid_parse_fail:
>  	cancel_work_sync(&hidpp->work);
> @@ -1655,9 +1689,11 @@ static void hidpp_remove(struct hid_device *hdev)
>  {
>  	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
>  
> +	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
> +		hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
>  	cancel_work_sync(&hidpp->work);
>  	mutex_destroy(&hidpp->send_mutex);
> -	hid_hw_stop(hdev);
>  }
>  
>  static const struct hid_device_id hidpp_devices[] = {
> @@ -1685,6 +1721,9 @@ static const struct hid_device_id hidpp_devices[] = {
>  
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
>  		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
> +
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
> +		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
>  	{}
>  };
>  
> -- 
> 2.1.4
> 

Sorry for not spotting this earlier. Maybe Jiri can change it locally if
there are no other changes to make to the series?

Cheers,
Benjamin

