Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD021CFE0
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269842; cv=none; b=HRUegTy0aILTpFuCbgO0sr5ctlXmrPpvSs5NFLPK22t2N3UYjQvv8DHPSJTgp8lCf1HrqYLiOVSv5nK0RGL1UukxLKSI0iJlelfjQ2G7E1uwn/rqMV2oxWKDPZZCi2+rU4BQoQab9e0qwvANMltA3vsM6TK1HdV7n88dOVFA7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269842; c=relaxed/simple;
	bh=siUhEoDUOj/xn0oVaBAN4sf5Cm1d7xOIcat7Sd9wWeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6MtcjtbmYZ1hZgi/1bKTMnbLB5xJ48VixSTJMypjcwcPXoKUG23dkv33bnWcJfwYlCTGd9yIGk+ISepbUBI7yxVppNQ1o51oQTQ7GvgtMuH2JEvOWBNWvL8XG0wqoE0VaYayqEVeU6gGuRp47j76/Qj17KQSWWbf2nlgyq5AUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLFZCUPl; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLFZCUPl"
Message-ID: <30258f28-4036-4e99-9494-031212544dc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781269828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1qYBhXEp32uKYgncsRorBaQWb1nEivFIzIlm2EVkIU=;
	b=CLFZCUPlqFTOJy5hcgu/D88t8r9jh5494BbGSqynqGsJesAqp9IaS/03MlAFdhDBiU0Ro7
	RfXIKf0UjapcbHolQ8DoJENXwqCPgaF7ptWg83rtxSSCivF/aumVbEcCxSymz1WZiB2AEO
	n/iok3UN36/xchwNZo6D5rHg3G5WEP4=
Date: Fri, 12 Jun 2026 15:09:56 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] HID: asus: add support for xgm led
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
References: <20260611221141.45456-1-denis.benato@linux.dev>
 <20260611222102.2528F1F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260611222102.2528F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/12/26 00:21, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The `asus_xgm_led_set` function is incorrectly assigned to the non-blocking `brightness_set` LED callback, but it performs sleeping operations.
> - [Medium] The XGM LED class device name is hardcoded, which causes device probe failures due to sysfs naming collisions.
> --
>
> commit 55bc647f99f9d2c64c1e99f0ee43e81efa5a6298
> Author: Denis Benato <denis.benato@linux.dev>
>
> HID: asus: add support for xgm led
>
> XG mobile stations have very bright leds behind the fan that can be
> turned either ON or OFF: add a cled interface to allow controlling the
> brightness of those red leds.
>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 3f5e96900b67a..8a5f364b7535f 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
> [ ... ]
>
>> @@ -1303,6 +1327,32 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>  		}
>>  	}
>>  
>> +	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
>> +	    ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
>> +	     (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
>> +		drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
>> +		if (drvdata->xgm_led == NULL) {
>> +			ret = -ENOMEM;
>> +			goto err_stop_hw;
>> +		}
>> +		drvdata->xgm_led->hdev = hdev;
>> +		drvdata->xgm_led->cdev.name = "asus:xgm:led";
> [Severity: Medium]
> If multiple XG Mobile docks are connected, or if an ungraceful disconnect
> leaves a stale sysfs entry behind, will this hardcoded name cause a sysfs
> naming collision? A duplicate name error here would cause
> led_classdev_register() to fail and abort the entire HID device probe.
ASUS has no models that can support two XGM devices: the connector
is a mixed usb-c+proprietary pci-e and no model has more than one:
there is no way one device can have more than one of these and I think
hardcoding the name is absolutely acceptable here.
> Should this use a dynamic identifier, perhaps incorporating dev_name(),
> to ensure uniqueness?
>
>> +		drvdata->xgm_led->cdev.brightness = 1;
>> +		drvdata->xgm_led->cdev.max_brightness = 1;
>> +		drvdata->xgm_led->cdev.brightness_set = asus_xgm_led_set;
> [Severity: High]
> Can this cause a sleep-in-atomic bug if the LED is triggered by a software
> blink (such as a timer or heartbeat sysfs trigger)?
>
> When software blinking is used, the LED core invokes the brightness_set
> callback directly from softirq context. However, asus_xgm_led_set() calls
> asus_kbd_set_report(), which performs a GFP_KERNEL allocation and a blocking
> USB transaction via hid_hw_raw_request().
>
> Should this callback be assigned to brightness_set_blocking instead,
> so the LED core knows to defer the sleeping work to a workqueue?
Will test this and produce a v2 regardless of the outcome.
>> +		ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
>> +		if (ret) {
>> +			hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
>> +			goto err_stop_hw;
>> +		}
>> +
>> +		/*
>> +		 * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
>> +		 * what the default brightness resets when doing a cold boot.
>> +		 */
>> +		asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>> +	}
>> +
