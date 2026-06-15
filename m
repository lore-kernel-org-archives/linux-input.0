Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E6E36655C
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557161; cv=none; b=XQ6CCCXXqOvuyXaZe8HNXqi5CHVGyufA48WxYPjEWADKHpZAvfqU3+SoITPZ2BkKpNesYRADfCxa65wgYouDWqmmRRBFiYaxbd3+YSdZWkKhJhSs4kIq4AJKeZT5+E7OM0Ru6bpe7LUrxtGVpDwAUUbg+eC089wnrK595KxuLvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557161; c=relaxed/simple;
	bh=mkiPMrXB7/Gh7E4lIUmvjyTu0uUmkvjCr2zM1fhHLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lUG5v5IoNO4ZkQ9qdbH/eqElJnp/N8mkEscJoEmsKz7G4s6uCd02k0RHrhht095f3MoPcZZ/ANZRLR0LhVJn3McOKBvGCGwKDbMxTIxL3DRrwW16lRTwGHQ8D7to2EfYXyKgxo4KurtQjvBXtu++tn2btaASMalZUb9y7lqMhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6LLlC/d; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y6LLlC/d"
Message-ID: <a70f9213-234c-45cc-9232-8222241b3c99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781557148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vodv0UI7KNaAIE2z/Qhv2BVPuyor2Z9avmyczVTiA4M=;
	b=Y6LLlC/dT1M5CStT7dyBFuGRfj3IfWAS3YzBetMyYqSTxUW7MvumLsFiLfVDT2hu56A1KS
	6xMrD2Yvh7pnFmNS0ChPxgyz7HDXeqp5t1PceGdU3Mi71lGWtEw599QZpfU3lGl7ZdL9cs
	YwlwXkHgKSqr1PAH/V/SPaC7kQYEq2M=
Date: Mon, 15 Jun 2026 22:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/5] HID: asus: add support for xgm led
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
References: <20260615165058.3845-5-denis.benato@linux.dev>
 <20260615170045.AF91E1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260615170045.AF91E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/15/26 19:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Propagating cosmetic LED restore errors during system resume causes the entire device resume to fail.
> - [High] Failing to initialize the auxiliary XG Mobile LED aborts the entire HID device probe.
> - [High] Manual call to `hid_hw_stop()` while using `devm_led_classdev_register()` leads to a use-after-teardown bug during device removal and probe error paths.
> --
>
> commit 26f82fa14c4bebc817bb5d79a1cdcdc34bb503d3
> Author: Denis Benato <denis.benato@linux.dev>
>
> HID: asus: add support for xgm led
>
> XG mobile stations have very bright leds behind the fan that can be
> turned either ON or OFF: add a cled interface to allow controlling the
> brightness of those red leds.
>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 6896730efafca..e68a6d93369d8 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
> [ ... ]
>> @@ -1343,9 +1371,52 @@ static int asus_start_multitouch(struct hid_device *hdev)
>>  	return 0;
>>  }
>>  
>> +static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>> +{
> [ ... ]
>> +	drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
>> +
>> +	/* LED state is arbitrary on boot, set a default */
>> +	ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>> +	if (ret) {
>> +		hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
>> +		goto asus_xgm_init_err;
>> +	}
>> +
>> +	ret = devm_led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
> [Severity: High]
> Because this LED is registered using devm_led_classdev_register(), its
> unregistration happens during the devres cleanup phase. This phase runs after
> the driver's remove callback (or probe error path) finishes.
>
> If the probe error path or asus_remove() manually calls hid_hw_stop(hdev),
> the HID transport is shut down. During the subsequent devres cleanup,
> led_classdev_unregister() is called and sets the LED to LED_OFF. This invokes
> asus_xgm_led_set(), which calls hid_hw_raw_request() on a stopped interface.
>
> Could this lead to a use-after-teardown bug?
>
>> +	if (ret) {
>> +		hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
>> +		goto asus_xgm_init_err;
>> +	}
>> +
>> +	return 0;
>> +asus_xgm_init_err:
>> +	drvdata->xgm_led = NULL;
>> +	return ret;
>> +}
>> +
>>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>>  {
>>  	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> +	int ret;
>>  
>>  	/*
>>  	 * If we have a backlight listener registered, restore the previous state,
>> @@ -1355,7 +1426,17 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
>>  	if (drvdata->listener.brightness_set)
>>  		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
>>  
>> +	if (drvdata->xgm_led) {
>> +		ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>> +		if (ret) {
>> +			hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
>> +			goto asus_resume_err;
> [Severity: High]
> If asus_xgm_led_set() fails to restore the LED state (e.g., due to an I/O
> error or timeout), this returns the error code directly to the PM core.
> A failed resume callback causes the PM subsystem to treat the device resume as
> failed, potentially leaving primary features like the keyboard and touchpad
> unresponsive.
>
> Would it be better for the failure of a cosmetic LED restore to log a warning
> instead of aborting the entire device resume?
No: xg mobile device controllers are just that: not an input device: if it fails
there it's right to tear down the whole thing.
>> +		}
>> +	}
>> +
>>  	return 0;
>> +asus_resume_err:
>> +	return ret;
>>  }
>>  
>>  static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
> [ ... ]
>> @@ -1484,6 +1565,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  		}
>>  	}
>>  
>> +	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
>> +	    ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
>> +	     (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
>> +		ret = asus_xgm_init(hdev, drvdata);
>> +		if (ret) {
>> +			hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
>> +			goto err_stop_hw;
> [Severity: High]
> If asus_xgm_init() fails, the code jumps to err_stop_hw, failing the entire
> device probe.
>
> Does this make a non-critical aesthetic feature a hard dependency for the
> entire device? Might it be safer to log the failure rather than preventing
> the keyboard and touchpad from working?
Ditto. Won't resolve these as it would only make the code more confusing.
>> +		}
>> +	}
>> +
>>  	/* Laptops keyboard backlight is always at 0x5a */
>>  	if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>>  	    (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
