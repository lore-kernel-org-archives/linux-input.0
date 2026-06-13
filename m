Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4A2C11CF
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781359326; cv=none; b=Xkg/uvGHTNhYnBqVbMlm0ICpEll4ZIrnYOgB4VyaI7zFcqp+mHO3t+Zcnlm2xuWKY49rT+sTCNG9EvLeQKa1qvvStA3+hahMbtd2Ow7l3d1RgkkKHiOHbTW41phJKkSXrlugPtx6pG8yfn7AreUnbhX8JmWmB6qUCgALa5Su7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781359326; c=relaxed/simple;
	bh=Ks/ll49piAY1N+saikNKVRdh+gJca4gDxneTLkoBvGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3Am6cI/qSPC4TF+i8agWex26rpPhusXHwcBCfaVEtQup23p/AFMD15Ufz/E+Jnuk6W54eP1Gf7mtZb5JS6xwNsmXPN2OBcsRB1SwnQlo0fJTEPXbV/e8sZ/y11dPFVIIBqKuQwfor8htuc0JrbsvAIvcNuflM2eqbW5XptcGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JNVdqqKe; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JNVdqqKe"
Message-ID: <7e851a3f-b595-468f-b3b1-a4ffbb03f85d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781359322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/DNcYnYpnA2SkT+mvkz/HH3xX5q0Tsq0RpjQVDExpU=;
	b=JNVdqqKexn5wTsQv2oyGqbxhutZHw28Fnivfp84dRGPtDrrwQY2UlbYD+QHxOpmTfyIMf2
	1bw3EbgKAZfDS1P0LuBcWtsz9FXKMter7U/EwtwD6OiavvqQSIz9pMJwkm9tQnGfi67iKd
	wQQFgs2GcVJVAr6fBrVRwjXwLN2o750=
Date: Sat, 13 Jun 2026 16:01:02 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] HID: asus: add support for xgm led
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Denis Benato <benato.denis96@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>
References: <20260612142326.1704858-1-denis.benato@linux.dev>
 <20260612142326.1704858-4-denis.benato@linux.dev>
 <CAGwozwHCAC1AkAjo4BqyjdS+GQqDWaMgmmtgAi14VzBc9NM3gQ@mail.gmail.com>
 <f4d34bd2-c7aa-43da-a3f3-a9dafe82af66@gmail.com>
 <CAGwozwE-EOdbJgKwUXth3S5Tzw4AcxJaMCjP=r0YUP5+TNnOkQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <CAGwozwE-EOdbJgKwUXth3S5Tzw4AcxJaMCjP=r0YUP5+TNnOkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/13/26 02:30, Antheas Kapenekakis wrote:
> On Fri, 12 Jun 2026 at 17:56, Denis Benato <benato.denis96@gmail.com> wrote:
>>
>> On 6/12/26 16:39, Antheas Kapenekakis wrote:
>>> On Fri, 12 Jun 2026 at 16:23, Denis Benato <denis.benato@linux.dev> wrote:
>>>> XG mobile stations have very bright leds behind the fan that can be
>>>> turned either ON or OFF: add a cled interface to allow controlling the
>>>> brightness of those red leds.
>>>>
>>>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>>>> ---
>>>>  drivers/hid/hid-asus.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>>>> index 323dc0b7f3ff..21c4a60d224e 100644
>>>> --- a/drivers/hid/hid-asus.c
>>>> +++ b/drivers/hid/hid-asus.c
>>>> @@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>>>  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
>>>>  #define FEATURE_KBD_LED_REPORT_ID2 0x5e
>>>>
>>>> +#define ROG_XGM_REPORT_SIZE 300
>>>> +
>>>>  #define ROG_ALLY_REPORT_SIZE 64
>>>>  #define ROG_ALLY_X_MIN_MCU 313
>>>>  #define ROG_ALLY_MIN_MCU 319
>>>> @@ -118,6 +120,11 @@ struct asus_kbd_leds {
>>>>         bool removed;
>>>>  };
>>>>
>>>> +struct asus_xgm_led {
>>>> +       struct led_classdev cdev;
>>>> +       struct hid_device *hdev;
>>>> +};
>>>> +
>>>>  struct asus_touchpad_info {
>>>>         int max_x;
>>>>         int max_y;
>>>> @@ -143,6 +150,7 @@ struct asus_drvdata {
>>>>         unsigned long battery_next_query;
>>>>         struct work_struct fn_lock_sync_work;
>>>>         bool fn_lock;
>>>> +       struct asus_xgm_led *xgm_led;
>>>>  };
>>>>
>>>>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
>>>> @@ -941,6 +949,23 @@ static int asus_battery_probe(struct hid_device *hdev)
>>>>         return ret;
>>>>  }
>>>>
>>>> +static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
>>>> +{
>>>> +       const u8 buf[ROG_XGM_REPORT_SIZE] = {
>>>> +               FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
>>>> +       };
>>>> +       struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
>>>> +       int ret;
>>>> +
>>>> +       ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
>>>> +       if (ret != ROG_XGM_REPORT_SIZE) {
>>>> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>>>  {
>>>>         struct input_dev *input = hi->input;
>>>> @@ -1184,6 +1209,14 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
> I might have confused the hunk here and you are right, input
> configured is above.
>
>>>>                 }
>>>>         }
>>>>
>>>> +       if (drvdata->xgm_led) {
>>>> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>>>> +               if (ret) {
>>>> +                       hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
>>>> +                       goto asus_resume_err;
>>>> +               }
>>>> +       }
>>>> +
>>>>  asus_resume_err:
>>>>         return ret;
>>>>  }
>>>> @@ -1310,6 +1343,40 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>>>                 }
>>>>         }
>>>>
>>>> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
>>>> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
>>>> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
>>>> +               drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
>>>> +               if (drvdata->xgm_led == NULL) {
>>>> +                       ret = -ENOMEM;
>>>> +                       goto err_stop_hw;
>>>> +               }
>>>> +               drvdata->xgm_led->hdev = hdev;
>>>> +               drvdata->xgm_led->cdev.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
>>>> +                                       "asus:xgm-%s:led",
>>>> +                                       strlen(hdev->uniq) ?
>>>> +                                       hdev->uniq : dev_name(&hdev->dev));
>>>> +               drvdata->xgm_led->cdev.brightness = 1;
>>>> +               drvdata->xgm_led->cdev.max_brightness = 1;
>>>> +               drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
>>>> +
>>>> +               /*
>>>> +                * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
>>>> +                * what the default brightness resets when doing a cold boot.
>>>> +                */
>>> I think this is set by the driver, so you should reformat the comment
>>> above, so you should trim the comment.
>>>
>>> Perhaps, "The LED state is arbitrary on boot, therefore default to the
>>> initial brightness set above". This way it does not become outdated if
>>> cdev.brightness changes.
>> yeah better spelling. I agree.
>>>> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>>>> +               if (ret) {
>>>> +                       hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
>>>> +                       goto err_stop_hw;
>>>> +               }
>>> You already do this in asus_input_configured so you do it twice?
>>> Perhaps skip one if you end up keeping them? I think that it's better
>>> to keep this block.
>> In asus_input_configured? Will take a look in the next days. I tought
>> the other was in asus_resume since at resume they resets back...
>>> Or even better return an error in _get so that on boot it is
>>> ambiguous? I assume the leds remain to the state they had prior to the
>>> reboot? With this change, imagine a user that turned off the leds in
>>> windows, permabooted into Linux, and now has the lights always turn on
>>> during boot.
>> Cold boot sets them to ON, while rebooting keep them at what they were.
>>
>> After exiting from sleep they are always ON, but this is on an ally,
>> I don't know if on an old rog flow it's the same.
>>> Moreover, can systemd restore this or is it out of scope for its led
>>> handler? Perhaps it is an ambitious idea though, and better skipped.
>> I don't see realistic for this to fail if it was successful at probe so it
>> shouldn't matter. As for systemd restoring them it would have to
>> be informed that they changed (but there is no read-back) so either
>> way something has to happen at resume, but doing this means no
>> additional software is necessary and user preference is being
>> respected regardless of anything else.
> Ok, so xg mobile is the first generation gpu dock with the wide
> connector, which is why it is i2c. It's probably from the side port.
You are correct in the connector: it is a pci-e custom connector with
an usb-c on the side.

That's not i2c: it's usb-c and it is basically a usb-c hub with others
usb connectors on the dock, a 2.5Gbps ethernet and the controller
device.
> So, when it initializes in general it enables the leds. And it
> initializes on boot and on wake. And it has no memory.
From what I can see I can say I have no idea, if this was 100% correct
I wouldn't see leds staying OFF after a reboot since the driver
does a reinit of the device.

These devices have leds entering a blinking pattern while the main device
is in s2idle and the ACPI has specific code for these devices.

It's what egpu_enable enables: the pci-e part of the device (usb-c
part is always enabled).

These devices heavily rely on ACPI, even if they are external so I'm
trying to reduce assumptions here.
> For not setting the led, you could return an error on reads if the
> brightness has not been written yet and if it has return a cached
> value / restore on awake. You can store the brightness in the struct
> below xgm_led, e.g., xgm_led_val, and initialize it to -1. If it is
> -1, get would return the same error you did for battery capacity in
> asus-wmi
Yes, I could do that, but considering this is just a simple ON/OFF switch,
where the device has no memory (even sleeping changes the status),
three times (even on windows):
sleep enter: whatever -> blinking
sleep exit: blinking -> ON
after some milliseconds: ON -> whatever was set before

I don't see anything to be gained by not setting it in _probe:
no memory write to spare, no delayed effect.

The cost of additional code that would be the same as the default _get
implementation just to throw an error is one I can't justify.
> In that case, you would remove the init from probe. Otherwise, the
> current patch with a small tweak to the comment if you do a revision
> is fine by me
>
> Reviewed by: Antheas Kapenekakis <lkml@antheas.dev>
Alright, thank you
>>>> +
>>>> +               ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
>>>> +               if (ret) {
>>>> +                       hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
>>>> +                       goto err_stop_hw;
>>>> +               }
>>>> +       }
>>>> +
>>>>         /* Laptops keyboard backlight is always at 0x5a */
>>>>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>>>>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
>>>> @@ -1366,6 +1433,9 @@ static void asus_remove(struct hid_device *hdev)
>>>>         if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>>>>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
>>>>
>>>> +       if (drvdata->xgm_led)
>>>> +               led_classdev_unregister(&drvdata->xgm_led->cdev);
>>>> +
>>>>         hid_hw_stop(hdev);
>>>>  }
>>>>
>>>> --
>>>> 2.47.3
>>>>
>>>>
>> Thanks,
>> Denis
>>
