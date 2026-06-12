Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347826A1CF
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781279804; cv=none; b=to+a0nOQfxb9QYlgK1/3/Pt2OhTC9a7aEnypuF61Qm8kzrKFuYYpHvREb5TeUX22cGyPUvo+q4iENTtZKR2jbv0jdZz5N2Bp8Z2nlDGQS8K0TWF1JcZaNYssgybu/3usPuxMKQGa0H84cZZBmZQE79/OMBiYSTngZMthRVEAHSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781279804; c=relaxed/simple;
	bh=DcznXY8XEzzXn8MSx3ZCv3gpOjISrXqdjertUhp9mRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiSKDJmpYp0TEHj5xizWpY+99L+Z2yp44nitfkPxDpI8YjcuJpExefg3VSfCAvAmUmZMnLurg201bsXDyRxSrF/DUFn9p0iMgQwQnuO/EfRH2GiVdnJwafnGnoF7GqA8BpxVf4tfnHQ3/USDvadGsQFJxBePeyk6EfZuoD7nGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnAMJadM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnAMJadM"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so876571f8f.2
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781279800; x=1781884600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6K6TmGA4TRES1bWMqUJppwMTN+lKZvz4bUY75q6Ffg=;
        b=XnAMJadMOY512w0T0RGrMk76LKOr7taEmhy8fgeWUoutpy1IDd+LUUn6oaP9UoqT72
         N0itjRejg8tZnCaC9amCkY1tYl24CQqGwIE2/TTlwNlV203HObOBgbHS9hb9NC70uz9t
         ArbSOu0tChYrMItaRVkKeugiYm+RB9YhrfY303BDq7WDehA+dCvbK6zMI73pSNYZF73T
         //uuaMGLaf0nL3tJQFHqj94Ub9GAMJesz5OQ1qIFum0sLqosK0njTUUcQ6UtGMmMxEj6
         70W/ddw6lkJoVUm8v8dA5wP0w1h3Bpbq0zTqyfpoiF3K9uCIl8FgPNGI08uRbfRlVCq1
         XBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781279800; x=1781884600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6K6TmGA4TRES1bWMqUJppwMTN+lKZvz4bUY75q6Ffg=;
        b=nHRB2f51llWJMgMDEFEN/d3i/CzKYCWA+z8Np+VR496kGrSHtqmhJCLDKAPh4OsRDc
         Kv1THlVfBxDdx/1+5llEtvDqBMDcoCOwjPk8IXBIZYi9FsnyI9JQV+1CatAjvhaFEiNT
         WO+ZMQsfvRVBzCQytnrRbPhKNJDcqejY9LaUKeHwAid104+qKo2SEwk4qHwP3aq3fgDB
         TJ1nDQdrL2W2SpCacZ2Mem0/e0LgotJ/PRPF3qjANF/GePoV48HNzMy4jbLUqCIKq0BU
         Swhg2w9XcyeQxdpeuY0ECb1tgly4Ui6KgArlR+S8LQ5Fpaw+8BEjKhTGz+mGL4tF9kU1
         0OVA==
X-Forwarded-Encrypted: i=1; AFNElJ/69H9MyRLSN1DmMrtKl81NtQdQhzYS5Do3xK+/snozrE8Jzcm43vRwApMhmWecEGaE5gIOPY/CG0SKlA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37SC74uoEEgu9NOs94Qldk9qwwQoXN6LzPxDhyvZ8HbOXQH74
	LYrA7OCQu5X6g/Sd1hf+DwGggNowL7v4Xi19wydc3qqDvdWDo6CzDxvCraU3Fg==
X-Gm-Gg: Acq92OG8zo8BM/kp4bHVZQGtzUXNngXn6Sc+SRkjzkFqL77Z4vLt2XsxxIOfPDZyCAd
	xCpsGhfNIP4YJfPVZTpU1CCo2SFWANVpLpzRhTXtwABSy9wOWUmkE0cFd+LyjH4tz0L3wQqRWfu
	vaMkvzH2LYAmAGJf3SaMcdf8t1PJKAFlnRRyQ5tGGlUwW2LyFzYPsnEeZfzJfTM8NS6/Vr1eHsZ
	Qy4AIfo5Xm1+kXeExy9GZ0SAcqn+YfF8JB7wK9lDS/mO9tUFDyewWVnOBRcaaZcpWXNViZEeEKW
	5yMYS/ZAodGX0wmuZQ1VlFTsLKRCWulgPS+3BqN/MCYniDbv2uBawVh6G6E5RLv2uGNpzvh52g/
	3QBsJMe1vZkA5NV2vUz5immqqBRlaSp7/12o1iUf+lqSVo5GWIKq6QANTNs2dWpkF6R1Rllmwuo
	ExxE2T/MO6ZAx/9xzycWkNFCWhpF+o2Wt++irFY6aWFA==
X-Received: by 2002:a05:6000:4010:b0:45e:ea65:d329 with SMTP id ffacd0b85a97d-4606da6a198mr5467928f8f.7.1781279800262;
        Fri, 12 Jun 2026 08:56:40 -0700 (PDT)
Received: from [10.80.0.99] ([151.49.228.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c473bsm6883249f8f.28.2026.06.12.08.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 08:56:39 -0700 (PDT)
Message-ID: <f4d34bd2-c7aa-43da-a3f3-a9dafe82af66@gmail.com>
Date: Fri, 12 Jun 2026 17:56:39 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] HID: asus: add support for xgm led
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>
References: <20260612142326.1704858-1-denis.benato@linux.dev>
 <20260612142326.1704858-4-denis.benato@linux.dev>
 <CAGwozwHCAC1AkAjo4BqyjdS+GQqDWaMgmmtgAi14VzBc9NM3gQ@mail.gmail.com>
Content-Language: en-US
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwHCAC1AkAjo4BqyjdS+GQqDWaMgmmtgAi14VzBc9NM3gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/12/26 16:39, Antheas Kapenekakis wrote:
> On Fri, 12 Jun 2026 at 16:23, Denis Benato <denis.benato@linux.dev> wrote:
>> XG mobile stations have very bright leds behind the fan that can be
>> turned either ON or OFF: add a cled interface to allow controlling the
>> brightness of those red leds.
>>
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>> ---
>>  drivers/hid/hid-asus.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 323dc0b7f3ff..21c4a60d224e 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
>>  #define FEATURE_KBD_LED_REPORT_ID2 0x5e
>>
>> +#define ROG_XGM_REPORT_SIZE 300
>> +
>>  #define ROG_ALLY_REPORT_SIZE 64
>>  #define ROG_ALLY_X_MIN_MCU 313
>>  #define ROG_ALLY_MIN_MCU 319
>> @@ -118,6 +120,11 @@ struct asus_kbd_leds {
>>         bool removed;
>>  };
>>
>> +struct asus_xgm_led {
>> +       struct led_classdev cdev;
>> +       struct hid_device *hdev;
>> +};
>> +
>>  struct asus_touchpad_info {
>>         int max_x;
>>         int max_y;
>> @@ -143,6 +150,7 @@ struct asus_drvdata {
>>         unsigned long battery_next_query;
>>         struct work_struct fn_lock_sync_work;
>>         bool fn_lock;
>> +       struct asus_xgm_led *xgm_led;
>>  };
>>
>>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
>> @@ -941,6 +949,23 @@ static int asus_battery_probe(struct hid_device *hdev)
>>         return ret;
>>  }
>>
>> +static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
>> +{
>> +       const u8 buf[ROG_XGM_REPORT_SIZE] = {
>> +               FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
>> +       };
>> +       struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
>> +       int ret;
>> +
>> +       ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
>> +       if (ret != ROG_XGM_REPORT_SIZE) {
>> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>  {
>>         struct input_dev *input = hi->input;
>> @@ -1184,6 +1209,14 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
>>                 }
>>         }
>>
>> +       if (drvdata->xgm_led) {
>> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>> +               if (ret) {
>> +                       hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
>> +                       goto asus_resume_err;
>> +               }
>> +       }
>> +
>>  asus_resume_err:
>>         return ret;
>>  }
>> @@ -1310,6 +1343,40 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>                 }
>>         }
>>
>> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
>> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
>> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
>> +               drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
>> +               if (drvdata->xgm_led == NULL) {
>> +                       ret = -ENOMEM;
>> +                       goto err_stop_hw;
>> +               }
>> +               drvdata->xgm_led->hdev = hdev;
>> +               drvdata->xgm_led->cdev.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
>> +                                       "asus:xgm-%s:led",
>> +                                       strlen(hdev->uniq) ?
>> +                                       hdev->uniq : dev_name(&hdev->dev));
>> +               drvdata->xgm_led->cdev.brightness = 1;
>> +               drvdata->xgm_led->cdev.max_brightness = 1;
>> +               drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
>> +
>> +               /*
>> +                * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
>> +                * what the default brightness resets when doing a cold boot.
>> +                */
> I think this is set by the driver, so you should reformat the comment
> above, so you should trim the comment.
>
> Perhaps, "The LED state is arbitrary on boot, therefore default to the
> initial brightness set above". This way it does not become outdated if
> cdev.brightness changes.
yeah better spelling. I agree.
>> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>> +               if (ret) {
>> +                       hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
>> +                       goto err_stop_hw;
>> +               }
> You already do this in asus_input_configured so you do it twice?
> Perhaps skip one if you end up keeping them? I think that it's better
> to keep this block.
In asus_input_configured? Will take a look in the next days. I tought
the other was in asus_resume since at resume they resets back...
> Or even better return an error in _get so that on boot it is
> ambiguous? I assume the leds remain to the state they had prior to the
> reboot? With this change, imagine a user that turned off the leds in
> windows, permabooted into Linux, and now has the lights always turn on
> during boot.
Cold boot sets them to ON, while rebooting keep them at what they were.

After exiting from sleep they are always ON, but this is on an ally,
I don't know if on an old rog flow it's the same.
> Moreover, can systemd restore this or is it out of scope for its led
> handler? Perhaps it is an ambitious idea though, and better skipped.
I don't see realistic for this to fail if it was successful at probe so it
shouldn't matter. As for systemd restoring them it would have to
be informed that they changed (but there is no read-back) so either
way something has to happen at resume, but doing this means no
additional software is necessary and user preference is being
respected regardless of anything else.
>> +
>> +               ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
>> +               if (ret) {
>> +                       hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
>> +                       goto err_stop_hw;
>> +               }
>> +       }
>> +
>>         /* Laptops keyboard backlight is always at 0x5a */
>>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
>> @@ -1366,6 +1433,9 @@ static void asus_remove(struct hid_device *hdev)
>>         if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
>>
>> +       if (drvdata->xgm_led)
>> +               led_classdev_unregister(&drvdata->xgm_led->cdev);
>> +
>>         hid_hw_stop(hdev);
>>  }
>>
>> --
>> 2.47.3
>>
>>
Thanks,
Denis
