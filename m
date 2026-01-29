Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4D325498;
	Thu, 29 Jan 2026 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694462; cv=none; b=BZOxfhKLFoa4dLgKGQNBc+plqr4i0/J08/VTMRo6SNXP4FC1sXO4xfhbBZV8J7nkzpSm447c9RxCTyOiPEPzr8iNZZalrlf2Hb+deOwOlOggWv0dflHJOa/MQWQgu1l3EZSu3cx1asXGgBIM4Vt8RkFB7rjI8tOWps4X4K53Lr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694462; c=relaxed/simple;
	bh=bp4YBs4xkojWf9D9BO+l2UoXaDQhj70Oi3BEWIor5Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V60RvCFP9nOSGaRYWSB0yIlA/XlYtjoJO8mxTuMPxlEEBo9ixpTe9/8x3kqd79h5Ho4qGY4T3x4nO9XhoYZVOvmKjx1IA3EzD8P9KwBoLiqZKQwDKmfS7ouFJiCLoc16T4CjfdtBwbp7fPbgU/NzhvqVmnltlk0wHx02cKEZk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=T/76Hg5W; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="T/76Hg5W"
Received: from [10.10.12.8] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 7DCF32FC00A5;
	Thu, 29 Jan 2026 14:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1769694450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIO71lF+DD+iCMcd28vuZ/FkOj4BjLCUostHT2X2HgA=;
	b=T/76Hg5WMi1bE3U9U3iRyZy14U5YknBmSgPY9uoQ442aucpPymbW3URSlbHGIa+obeS5PM
	We6vrz3oD/znKRNAfhxKR43zeDOKnFckgp189/Q4BbJIZYvufGxK8FbHXOTeV0GgxDEVtG
	pAb+16jQqaqmRuRiGI53Q7jvO+n0HPg=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <524ff955-6f71-4c3a-87e3-0991afb200c7@tuxedocomputers.com>
Date: Thu, 29 Jan 2026 14:47:30 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hid/hid-multitouch: Keep latency normal on deactivate
 for reactivation gesture
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260108161139.32681-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20260108161139.32681-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 08.01.26 um 17:09 schrieb Werner Sembach:
> Uniwill devices have a built in gesture in the touchpad to de- and
> reactivate it by double taping the upper left corner. This gesture stops
> working when latency is set to high, so this patch keeps the latency on
> normal.

Gentle bump

Best regards,

Werner

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
> V1->V2: Use a quirk to narrow down the devices this is applied to.
> V2->V3: Fix this patch breaking touchpads on some devices.
>          Add another device ID.
> V3->V4: Readd quirks formerly applied to the devices via the default class.
> V4->V5: Fix whitespace error.
>
>   drivers/hid/hid-multitouch.c | 32 +++++++++++++++++++++++++++++---
>   1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 179dc316b4b51..62e7036806549 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -76,6 +76,7 @@ MODULE_LICENSE("GPL");
>   #define MT_QUIRK_DISABLE_WAKEUP		BIT(21)
>   #define MT_QUIRK_ORIENTATION_INVERT	BIT(22)
>   #define MT_QUIRK_APPLE_TOUCHBAR		BIT(23)
> +#define MT_QUIRK_KEEP_LATENCY_ON_CLOSE	BIT(24)
>   
>   #define MT_INPUTMODE_TOUCHSCREEN	0x02
>   #define MT_INPUTMODE_TOUCHPAD		0x03
> @@ -211,6 +212,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
>   #define MT_CLS_WIN_8_DISABLE_WAKEUP		0x0016
>   #define MT_CLS_WIN_8_NO_STICKY_FINGERS		0x0017
>   #define MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU	0x0018
> +#define MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE	0x0019
>   
>   /* vendor specific classes */
>   #define MT_CLS_3M				0x0101
> @@ -330,6 +332,15 @@ static const struct mt_class mt_classes[] = {
>   			MT_QUIRK_CONTACT_CNT_ACCURATE |
>   			MT_QUIRK_WIN8_PTP_BUTTONS,
>   		.export_all_inputs = true },
> +	{ .name = MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE,
> +		.quirks = MT_QUIRK_ALWAYS_VALID |
> +			MT_QUIRK_IGNORE_DUPLICATES |
> +			MT_QUIRK_HOVERING |
> +			MT_QUIRK_CONTACT_CNT_ACCURATE |
> +			MT_QUIRK_STICKY_FINGERS |
> +			MT_QUIRK_WIN8_PTP_BUTTONS |
> +			MT_QUIRK_KEEP_LATENCY_ON_CLOSE,
> +		.export_all_inputs = true },
>   
>   	/*
>   	 * vendor specific classes
> @@ -830,7 +841,8 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>   			if ((cls->name == MT_CLS_WIN_8 ||
>   			     cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
>   			     cls->name == MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU ||
> -			     cls->name == MT_CLS_WIN_8_DISABLE_WAKEUP) &&
> +			     cls->name == MT_CLS_WIN_8_DISABLE_WAKEUP ||
> +			     cls->name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE) &&
>   				(field->application == HID_DG_TOUCHPAD ||
>   				 field->application == HID_DG_TOUCHSCREEN))
>   				app->quirks |= MT_QUIRK_CONFIDENCE;
> @@ -1709,7 +1721,8 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
>   	int ret;
>   
>   	if (td->is_haptic_touchpad && (td->mtclass.name == MT_CLS_WIN_8 ||
> -	    td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT)) {
> +	    td->mtclass.name == MT_CLS_WIN_8_FORCE_MULTI_INPUT ||
> +	    td->mtclass.name == MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE)) {
>   		if (hid_haptic_input_configured(hdev, td->haptic, hi) == 0)
>   			td->is_haptic_touchpad = false;
>   	} else {
> @@ -1998,7 +2011,12 @@ static void mt_on_hid_hw_open(struct hid_device *hdev)
>   
>   static void mt_on_hid_hw_close(struct hid_device *hdev)
>   {
> -	mt_set_modes(hdev, HID_LATENCY_HIGH, TOUCHPAD_REPORT_NONE);
> +	struct mt_device *td = hid_get_drvdata(hdev);
> +
> +	if (td->mtclass.quirks & MT_QUIRK_KEEP_LATENCY_ON_CLOSE)
> +		mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_NONE);
> +	else
> +		mt_set_modes(hdev, HID_LATENCY_HIGH, TOUCHPAD_REPORT_NONE);
>   }
>   
>   /*
> @@ -2375,6 +2393,14 @@ static const struct hid_device_id mt_devices[] = {
>   		MT_USB_DEVICE(USB_VENDOR_ID_UNITEC,
>   			USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19) },
>   
> +	/* Uniwill touchpads */
> +	{ .driver_data = MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			USB_VENDOR_ID_PIXART, 0x0255) },
> +	{ .driver_data = MT_CLS_WIN_8_KEEP_LATENCY_ON_CLOSE,
> +		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
> +			USB_VENDOR_ID_PIXART, 0x0274) },
> +
>   	/* VTL panels */
>   	{ .driver_data = MT_CLS_VTL,
>   		MT_USB_DEVICE(USB_VENDOR_ID_VTL,
