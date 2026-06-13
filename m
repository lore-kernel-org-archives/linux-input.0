Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDFB1547C0
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781356980; cv=none; b=a2UuJjAKqPm3gGUDMyZA16LXi3K/L9J3j/l/juCWxMNN2QnxBPkgloZmYA5CkJ7YksDLl/+xjwAVKOMQ9n+CGh18KFheWXajJTNigNUtfq5I2OAwMwNu09uhKYVH+p1WBwFJjz0XmW7bmCxtHdaALVp31t9Oy18dNvw/Uq0vbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781356980; c=relaxed/simple;
	bh=ODEPmkKVKtxpPAUFrRuu3NE+FBbPlq1pQkblCOYwlJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZdZI/aghgqEKwPdRnvC42uD2hHuNuaXR5+cufE1QVi3zeATDHb3PyEnCtIezqyIvsAsnkyINaqjiYtEKq0kfkEILIQAWTV/7hVVknIzeIPpniykQlv+W0pFz2U/bdUKEcWJGOhwzNz4axngkxsZ1y0EmZM8qiPeSnvOp9772W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnLkjW7M; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnLkjW7M"
Message-ID: <4f46e056-cf67-499b-9143-03f56037eb81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781356967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMfSVphkl0vo9/M/QN+2NsVgJugdL0ODybYMjubWebo=;
	b=pnLkjW7MmarzEuYWiOpvFEeSw2GmsMThnalzIeJAILYD8H5uK4E7L92IIEqZJNG4CLvKUn
	QXi/FIgowbT3x/221nl2aXVu6O8rJHorvrNxcdqz5ZA3rgS/W4kyLb4ttQ7Wwrn4p7RKxf
	JEbqTRMU11sVq+40WD4zBfVjjDCJCeo=
Date: Sat, 13 Jun 2026 15:22:44 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] HID: asus: add i2c entry for FA808UM and other
 TUFs
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 connorbelli2003@gmail.com, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
References: <20260612142326.1704858-5-denis.benato@linux.dev>
 <20260612143750.26B531F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <20260612143750.26B531F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/12/26 16:37, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Improper Workqueue Initialization / Memory Corruption via Re-initialization
> - [High] Use-After-Free due to Race Condition in `asus_remove()`
> - [High] Missing NULL check for `devm_kasprintf` allocation leading to Kernel Oops
> --
>
> commit ee67627a03893a0ccf0a7653ac62191a687b7821
> Author: Denis Benato <denis.benato@linux.dev>
>
> HID: asus: add i2c entry for FA808UM and other TUFs
>
> On newer TUF laptops the keyboard HID device uses the same PID/VID of a
> USB device that was found in ROG laptops: add it to hid-asus as i2c too.
>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 0f78242b6a1db..7964fc96196e5 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -1565,6 +1565,9 @@ static const struct hid_device_id asus_devices[] = {
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>>  	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
>>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
>> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
>> +	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
>> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK },
> [Severity: Critical]
> This is a pre-existing issue, but since this patch enables QUIRK_HID_FN_LOCK
> for a new device, could the fn_lock_sync_work initialization cause workqueue
> corruption?
>
> In asus_input_configured(), INIT_WORK(&drvdata->fn_lock_sync_work, ...) is
> called per-input. For devices with multiple inputs, if hid_hw_start() enables
> interrupts before all inputs are configured, an early KEY_FN_ESC event could
> schedule the work before the next input is configured. 
>
> The next call to asus_input_configured() would then re-execute INIT_WORK() on
> the already queued work item, clearing its list pointers and causing a panic. 
>
> Additionally, for devices with 0 inputs, it is never initialized, causing a
> warning in cancel_work_sync().
This is implemented in f631011e36b87b173b71c7592b558ad05d791228

("HID: hid-asus: Implement fn lock for Asus ProArt P16")  and I see a

asus_kbd_set_fn_lock(hdev, true);

things

asus_kbd_set_fn_lock(hdev, true);

Shouldn't one of the two (probably the latest) be:

asus_kbd_set_fn_lock(hdev, false);


Moreover I see from the commit message that this implementation has
been copied from hid-lenovo, so does hid-lenovo suffers from the same issue?

Since I don't have the affected hardware and I'm much confused by this double true
I won't try to fix it in this patchset unless absolutely necessary or I have more info,
but ideally I would like the patch to come from who can actually test the fix.

> [Severity: High]
> This is a pre-existing issue, but is there a potential use-after-free during
> device removal when QUIRK_HID_FN_LOCK is enabled?
>
> In asus_remove(), cancel_work_sync(&drvdata->fn_lock_sync_work) is called
> before hid_hw_stop(hdev). Since the hardware is still active, a late
> KEY_FN_ESC event can trigger asus_event() and unconditionally call
> schedule_work() after the work was supposedly canceled. 
>
> Once the driver is removed and drvdata is freed by devres, could the
> workqueue execute asus_sync_fn_lock() and dereference the freed drvdata?
>
> [Severity: High]
> This is a pre-existing issue, but does the XGM LED name allocation need a
> NULL check?
>
> In asus_probe(), devm_kasprintf() is used to allocate the name for
> drvdata->xgm_led->cdev.name:
>
> 	drvdata->xgm_led->cdev.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
> 			"asus:xgm-%s:led",
> 			strlen(hdev->uniq) ?
> 			hdev->uniq : dev_name(&hdev->dev));
> 	drvdata->xgm_led->cdev.brightness = 1;
>
> If devm_kasprintf() fails under memory pressure, it returns NULL. This NULL
> pointer is then passed to led_classdev_register(), which passes it to
> led_classdev_next_name() and eventually to strscpy() as the source string. 
> Since strscpy() does not check for a NULL source, this would cause an
> immediate NULL pointer dereference.
>
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>>  	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
>>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
