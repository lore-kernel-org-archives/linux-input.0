Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.235.229.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271828;
	b=t9HjsA73HxnMlh1mfvP5v7hP5zWtcEuiEaT2s8p2As0YtiVs4DyjU0xPp4n1+8aO7QUb
	 M8P+iTQGFA9VrsPik/AroyvQHWE8ujIWPrvPdXq03gwQCU4AI0xdI69qY9FqUNQGHfe8H
	 oRdewTITApTB9cbFR7FuiNDHQivT42rhzjqcK+e9BVrg07T0ql9Psxborf/B0fL1LbwNG
	 BPq5640yQVaR3/foGzv35rt+XfHYmmDrpV6x9Jj1jv1U7QDprg6VT++86jBitxMd/mDmC
	 5wmBREU9cmyNgmyTrLkTki6pDYdTAmdp8nGTzMM2DMJ38zFV+1ZmmDyKkTPbkeHIOaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271828;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Chocolate:X-Operating-System:X-Uptime:User-Agent;
	bh=ldQ3qeBmydFhieFaL8KfkuaD+7PjtokDguyKmldrn+Y=;
	b=Gi6RPVnu/2ifOlfCTQu3QDViuk5o72RxX/5UBdOz3tm4ZTTa94SZmQpq6N2pnHxexFN2
	 kW0q8eHrn1XbuMVCg5OBPCFGny3dmR1a8+M9btOfqf3/LnT34/mpJ1MfmbXjOa07uZPLW
	 0WrNNgKkCVgfsIBxg7cgo/QU6i0VwNnER5ePn5mqGMXwfrtEnCvXp/CYl8n/sV+lMfAlt
	 JmKIZGkVnWpt9bvOLm0BndqhSDtiHvXxRQoavCSb5WykrDCILWppGeeEw5MT1dL4fSR8v
	 PSNfiPzfuJpCf662eaSe4Eu5Gf1Iw7cJUHjFo0bm/4bPHbRoc9rKc9L1Aqv7uBsgu+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=treblig.org;
	spf=pass smtp.mailfrom=treblig.org;
	dkim=pass header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b="Ozhe/Xs+";
	arc=none smtp.remote-ip=46.235.229.95
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D5606A321;
	Tue, 10 Nov 2026 00:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 243D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=treblig.org header.i=@treblig.org header.a=rsa-sha256 header.s=bytemarkmx header.b=Ozhe/Xs+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=ldQ3qeBmydFhieFaL8KfkuaD+7PjtokDguyKmldrn+Y=; b=Ozhe/Xs+A9vQzn5n
	QAZvsAbHW0aCCLnu7jPmOVxYwqwzMsfkTDCq11sdynkVB4YjlNRoCe1f2UjMdlgekJFq+57t8qIkf
	OMr9q8kldJ89QAfNPcuk7phEOFd+doeEP3jWDdHUwXkzEnWyehFNX/oQvlpoB8WFxyaJmeU+EEWJE
	6ygugV7P1/4FOv5awrGEbHrys/9dWctZreqMSoSUwy30/duF4FyvuoV9BSi8Jhy/Z2DGZwjAII0Wd
	Pz7vicfKx7H2zfTjLJD+6/RhGldkyLE3b9GO7iiJT2iPFHTquP7rSGU0XQcIToTOHaqeje3jHD1cY
	RGJJSGftD0ZHBpYa/Q==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
	(envelope-from <dg@treblig.org>)
	id 1xQa43-00000002uth-0bHs;
	Tue, 10 Nov 2026 00:50:19 +0000
Date: Tue, 10 Nov 2026 00:50:19 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: "Jesper B. Christensen" <jaytersen@gmail.com>,
	jens.glathe@oldschoolsolutions.biz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	jikos@kernel.org, bentiss@kernel.org
Subject: Re: [PATCH] HID: asus: support the Zenbook A14 (UX3407RA) keyboard
 backlight
Message-ID: <avJqS5WjagHUo84q@gallifrey>
References: <20261031215710.11126-1-jaytersen@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20261031215710.11126-1-jaytersen@gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.115+deb13.1-amd64 (x86_64)
X-Uptime: 00:48:01 up 7 days,  3:26,  3 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)

* Jesper B. Christensen (jaytersen@gmail.com) wrote:
> The ASUS Zenbook A14 (UX3407RA), a Qualcomm Snapdragon X2 Elite
> (Hamoa)-based laptop, carries its main keyboard on an I2C-HID device
> with the ID 0B05:0220. Its Fn/media hotkeys are emitted as vendor-page
> (HID_UP_ASUSVENDOR) usages on report 0x5A.

Hi Jesper,
  Just to let you know this also works on my X1 Zenbook A14 UX3407QA.
Very nice!

Dave

> In addition to the the standard I2C keyboard quirks and the keyboard
> backlight quirk, a few new have been added:
> 
>   QUIRK_KBD_REPORT_SIZE: The UX3407RA seems to only accept 64 byte
>    reports
>   QUIRK_KBD_OOBE: Refactor existing Out-Of-Box mitigation into a
>    quirk.
> 
> The keyboard backlight is software controlled. Since WMI is not
> available on Snapdragon based platforms this change registers a
> separate led device that sends hid reports to the Embedded Controller
> (EC).
> 
> Signed-off-by: Jesper B. Christensen <jaytersen@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 88 ++++++++++++++++++++++++++++++++++++++++--
>  drivers/hid/hid-ids.h  |  1 +
>  2 files changed, 85 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index c38a2b3b33d9..072df9816e50 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -66,6 +66,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define ASUS_FAN_CTRL_KEY_CODE 0xae
>  
>  #define SUPPORT_KBD_BACKLIGHT BIT(0)
> +#define EC_KBD_MAX_BACKLIGHT 3
>  
>  #define MAX_TOUCH_MAJOR 8
>  #define MAX_PRESSURE 128
> @@ -100,6 +101,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_ROG_ALLY_XPAD		BIT(13)
>  #define QUIRK_HID_FN_LOCK		BIT(14)
>  #define QUIRK_FILTER_CAMERA_COMPANION	BIT(15)
> +#define QUIRK_KBD_REPORT_SIZE           BIT(16)
> +#define QUIRK_KBD_OOBE			BIT(17)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -169,10 +172,12 @@ struct asus_drvdata {
>  	bool battery_in_query;
>  	unsigned long battery_next_query;
>  	struct asus_hid_listener listener;
> +	struct led_classdev kbd_led_cdev;
>  	bool fn_lock;
>  };
>  
>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
> +static void asus_kbd_illum_toggle(struct asus_drvdata *);
>  
>  static const struct asus_touchpad_info asus_i2c_tp = {
>  	.max_x = 2794,
> @@ -469,6 +474,7 @@ static int asus_event(struct hid_device *hdev, struct hid_field *field,
>  		case KEY_KBDILLUMDOWN:
>  			return !asus_hid_event(ASUS_EV_BRTDOWN);
>  		case KEY_KBDILLUMTOGGLE:
> +			asus_kbd_illum_toggle(drvdata);
>  			return !asus_hid_event(ASUS_EV_BRTTOGGLE);
>  		case KEY_FN_ESC:
>  			if (drvdata->quirks & QUIRK_HID_FN_LOCK) {
> @@ -576,15 +582,23 @@ static int asus_raw_event(struct hid_device *hdev,
>  
>  static int asus_kbd_set_report(struct hid_device *hdev, const u8 *buf, size_t buf_size)
>  {
> -	u8 *dmabuf __free(kfree) = kmemdup(buf, buf_size, GFP_KERNEL);
> +	size_t alloc_size = buf_size;
> +
> +	if (QUIRK_KBD_REPORT_SIZE)
> +		alloc_size = (buf_size > FEATURE_KBD_REPORT_SIZE) ?
> +			buf_size : FEATURE_KBD_REPORT_SIZE;
> +
> +	u8 *dmabuf __free(kfree) = kzalloc(alloc_size, GFP_KERNEL);
>  	if (!dmabuf)
>  		return -ENOMEM;
>  
> +	memcpy(dmabuf, buf, buf_size);
> +
>  	/*
>  	 * The report ID should be set from the incoming buffer due to LED and key
>  	 * interfaces having different pages
>  	 */
> -	return hid_hw_raw_request(hdev, buf[0], dmabuf, buf_size, HID_FEATURE_REPORT,
> +	return hid_hw_raw_request(hdev, buf[0], dmabuf, alloc_size, HID_FEATURE_REPORT,
>  				  HID_REQ_SET_REPORT);
>  }
>  
> @@ -702,6 +716,38 @@ static void asus_kbd_set_brightness(struct hid_device *hdev, u8 brightness)
>  		hid_err(hdev, "Asus failed to set keyboard backlight: %d\n", ret);
>  }
>  
> +static void asus_kbd_set_brightness_cdev(struct led_classdev *led_cdev,
> +				    enum led_brightness brightness)
> +{
> +	struct asus_drvdata *drvdata = container_of(led_cdev, struct asus_drvdata, kbd_led_cdev);
> +	u8 level = (u8)brightness;
> +
> +	if (level > EC_KBD_MAX_BACKLIGHT)
> +		level = EC_KBD_MAX_BACKLIGHT;
> +
> +	asus_kbd_set_brightness(drvdata->hdev, level);
> +	drvdata->kbd_backlight_brightness = level;
> +}
> +
> +static enum led_brightness asus_kbd_get_brightness_cdev(struct led_classdev *led_cdev)
> +{
> +	struct asus_drvdata *drvdata = container_of(led_cdev, struct asus_drvdata, kbd_led_cdev);
> +
> +	return (enum led_brightness)drvdata->kbd_backlight_brightness;
> +}
> +
> +static void asus_kbd_illum_toggle(struct asus_drvdata *drvdata)
> +{
> +	if (!drvdata->kbd_led_cdev.brightness_set)
> +		return;
> +
> +	u8 current_level = drvdata->kbd_backlight_brightness;
> +	u8 max_level = EC_KBD_MAX_BACKLIGHT;
> +	u8 next_level = (current_level + 1) % (max_level + 1);
> +
> +	asus_kbd_set_brightness_cdev(&drvdata->kbd_led_cdev, next_level);
> +}
> +
>  static void asus_kbd_wmi_fan(struct hid_device *hdev, struct hid_raw_event_data *data)
>  {
>  	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> @@ -956,7 +1002,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
>  	if (!(kbd_func & SUPPORT_KBD_BACKLIGHT))
>  		return -ENODEV;
>  
> -	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16")) {
> +	if (drvdata->quirks & QUIRK_KBD_OOBE) {
>  		ret = asus_kbd_disable_oobe(hdev);
>  		if (ret < 0)
>  			return ret;
> @@ -972,10 +1018,28 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
>  	drvdata->listener.brightness_set = asus_kbd_backlight_set;
>  	ret = asus_hid_register_listener(&drvdata->listener);
>  	if (ret < 0) {
> -		hid_err(hdev, "Unable to register kbd brightness listener: %d\n", ret);
> +		if (ret != -ENODEV) {
> +			hid_err(hdev, "Unable to register kbd brightness listener: %d\n", ret);
> +		}
>  		drvdata->listener.brightness_set = NULL;
>  	}
>  
> +	// Non-x86 architectures do not have WMI, just register a led
> +	// device directly
> +	if (ret == -ENODEV) {
> +		drvdata->kbd_led_cdev.name = "asus::kbd_backlight";
> +		drvdata->kbd_led_cdev.brightness_set = asus_kbd_set_brightness_cdev;
> +		drvdata->kbd_led_cdev.brightness_get = asus_kbd_get_brightness_cdev;
> +		drvdata->kbd_led_cdev.max_brightness = EC_KBD_MAX_BACKLIGHT;
> +		ret = led_classdev_register(&hdev->dev, &drvdata->kbd_led_cdev);
> +		if (ret < 0) {
> +			hid_err(hdev, "Unable to register kbd brightness led: %d\n", ret);
> +			drvdata->kbd_led_cdev.brightness_set = NULL;
> +		}
> +
> +		asus_kbd_set_brightness_cdev(&drvdata->kbd_led_cdev, 1);
> +	}
> +
>  	return ret;
>  }
>  
> @@ -1372,6 +1436,9 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
>  
> +	if (drvdata->kbd_led_cdev.brightness_set)
> +		asus_kbd_set_brightness_cdev(&drvdata->kbd_led_cdev, drvdata->kbd_backlight_brightness);
> +
>  	return 0;
>  }
>  
> @@ -1502,6 +1569,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		}
>  	}
>  
> +	if (dmi_match(DMI_PRODUCT_FAMILY, "ProArt P16"))
> +		drvdata->quirks |= QUIRK_KBD_OOBE;
> +
>  	/* Laptops keyboard backlight is always at 0x5a */
>  	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>  	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
> @@ -1539,6 +1609,9 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> +	if (drvdata->kbd_led_cdev.brightness_set)
> +		led_classdev_unregister(&drvdata->kbd_led_cdev);
> +
>  	asus_worker_stop(drvdata->worker);
>  	hid_hw_stop(hdev);
>  	return ret;
> @@ -1551,6 +1624,9 @@ static void asus_remove(struct hid_device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_hid_unregister_listener(&drvdata->listener);
>  
> +	if (drvdata->kbd_led_cdev.brightness_set)
> +		led_classdev_unregister(&drvdata->kbd_led_cdev);
> +
>  	asus_worker_stop(drvdata->worker);
>  	hid_hw_stop(hdev);
>  }
> @@ -1673,6 +1749,10 @@ static const struct hid_device_id asus_devices[] = {
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD),
>  	  I2C_KEYBOARD_QUIRKS | QUIRK_FILTER_CAMERA_COMPANION },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD),
> +	  I2C_KEYBOARD_QUIRKS | QUIRK_USE_KBD_BACKLIGHT | QUIRK_KBD_REPORT_SIZE |
> +	  QUIRK_KBD_OOBE},
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index cb7f16d75fce..a992c0aabd45 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -221,6 +221,7 @@
>  #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
>  #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
>  #define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD	0x4b42
> +#define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD	0x0220
>  #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
>  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
>  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
> -- 
> 2.53.0
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
