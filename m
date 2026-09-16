Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20092346784
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789520067; cv=none; b=UgUPOspFpq1AslKXqJZ2vtZfjw0t4pdy6JRGBwGNMw7GQZ2KB4d9hm65WfsvN8atKcn2/pPKEMN1uVfR5vvRy25/3mMqoPCoYpBVcMzPygleES/lX+2dvsHk0PCNFTkHCH6KoDjJCPROcv3gtWEM0PCot2MRhgy+a8FX+fBc0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789520067; c=relaxed/simple;
	bh=QNyrKLfygxdwkjOQuKG0DYvoOYzaQwnyMoJrWEtRyuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9e14P67Kzml/JbSYyhQi607+kkLD4JzhNRWamEUtH0SAFfHDsjl1JS72ZEloIqU440Hsv8P9Dvt0j2UzDfU6KGaAWSjLssfbT90JiZAYTsuIgSca4rvG7sCzAaA0RNaucnJPIvefNkTOieZibypZvWXQlj7KDU+pvAMwmLhou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtQC0LNB; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtQC0LNB"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso2666985e9.2
        for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 17:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789520063; x=1790124863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyuLZJXkPRi4fNif6ZQOyJ47bmiKCrSFmmrUPvKFMn4=;
        b=KtQC0LNB9oRddCSW5uOewATDnIyY/nrlAI78UNejcFWhzgDXaGTyXlxrplzkJTW4aI
         fMChxFJhJChdUprhQnlPpnSqBefWc1z870Pg1SGJkulpLNpiOk8qnvMEiCHhIC3fsuh7
         iA/2ODunIoetSpcooo2whdzNoBrm5ZCPZLClPUn8YCOzzqUSeHqch+6NmWIwF6N1zUOq
         uIRk6g3+D13g/Y/inccyZsQZe5S7hgx+ToQHGVedqaWEvqW4xdpxDntZ/BcMsn32cU+J
         BhY7AFzIzK4UhepKZ7PcdskyU27t1kuOm51GjiBQ6/2Z6SRQpWzLqNuvFWRJeK+mRV9+
         L+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789520063; x=1790124863;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dyuLZJXkPRi4fNif6ZQOyJ47bmiKCrSFmmrUPvKFMn4=;
        b=ju3ykRaTyYVgz57QR5j2vIMAGmR7O4vte7h6djAWytCT9TRZhvqkgtSMhMOzX0vzRl
         0yESnBaIdi0zffPd1G2n56nu+FWyPo8x/YP5XHH/smSiNcoymWwB0FpqUzV3Ye8qBCmq
         T2qP/sR6eEYsYGQ9Xaevw11oWvVeW3tYUR3vO4hUMVIx/z9Vz/W27DT4kdd/+e4c3/iX
         HeoKDbV7Nzzp41jpK6duUMUGCYStLwbeafC41JR3is9xD6y1Ph5dU6ugCMOkCqHUgfNp
         kc1ILMSihAZs2MRc3sO3NyQRcOKpzO6mwVq8680C/Rx7cL07ifmgrMkMk0gm3Gu2rJjH
         1ACg==
X-Forwarded-Encrypted: i=1; AKwUvByoiHdOLBj/AyD0ULrsX43ZHV17p7TR+hc7n7R2fRW4q9frGanfFfsoKxAcna4oEZ6RrYBACXuRqgVsbg==@vger.kernel.org
X-Gm-Message-State: AFuF++lpXZH9qM75P0I8ph0iFuHQQKPl01Z2GU8IM0lfRA70RHJ998Wk
	Mtn6adTjvZzb/68XSXU0YbruLPw/epZGvVO4J6TNQ+9y3GhywT0YFbox
X-Gm-Gg: AYBFou02mayWhtlj9CoHqwTnoNV+fTHd0a/a7H+WAvQMtfSxZwOO5VL+oObH+ZO438K
	vPE7TqN1XTg2R6yPH1q/PtODS838w2wlojwhOtRxiE5eJ2orDGrq91tNflQhio+BSUBJgw286Om
	vOYBSkvRBMduxz+LYs1nToI2zNspYkP3hLd+iNch8hmxGbKHeSenrrBmsHrnkcZ5/zDDBHkcVBT
	2qrVTXNYPHccCZ8La4oE73y6v/ePGg5oz7JsqE/5Yw0iYU06VBWIeM7IkzBDF2OJvChS3xqcEKC
	Pj4Gc4uOsp4digUpqfQ7VHkI5hzf1gfVfPSpoRgxUOaPllnUwGjExGr1BT6EOYRNyIXpNnVbUX/
	3FgiygwoYsMvakDhy161koit40ncGm6fJCimfo23M/whYYvgLSXdrEGQDvZ3C9k0MJEYDuNq0hx
	S1vlafnbKbnDJZAxGmRdPilBj0izSzyE0dGaUFpVNZG1YowPCwK+tOhzuOZKO8hVuoIKFa8NASV
	Y9s
X-Received: by 2002:a05:600c:3b87:b0:49e:6c9b:4e94 with SMTP id 5b1f17b1804b1-49eb73308bemr5347775e9.28.1789520062558;
        Tue, 15 Sep 2026 17:54:22 -0700 (PDT)
Received: from [10.80.0.99] ([151.95.60.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83da071asm40923465e9.8.2026.09.15.17.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 17:54:22 -0700 (PDT)
Message-ID: <9fd173d2-08c2-4455-b251-27af53db2028@gmail.com>
Date: Wed, 16 Sep 2026 02:54:21 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] HID: asus: add support for xgm led
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 "Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>
References: <20260915181200.18086-1-denis.benato@linux.dev>
 <20260915181200.18086-4-denis.benato@linux.dev>
 <CAGwozwHe7dnSi1=NuqeQuXD0FtdPKLJvwyC53ff6LUmRU9Z7SQ@mail.gmail.com>
Content-Language: en-US
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <CAGwozwHe7dnSi1=NuqeQuXD0FtdPKLJvwyC53ff6LUmRU9Z7SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/15/26 23:52, Antheas Kapenekakis wrote:
> On Tue, 15 Sept 2026 at 20:12, Denis Benato <denis.benato@linux.dev> wrote:
>> XG mobile stations have very bright leds behind the fan that can be
>> turned either ON or OFF: add a cled interface to allow controlling the
>> brightness of those red leds.
> Hi Denis,
> as of last month, I am also the proud owner of a XG Mobile (2025 in my
> case). Therefore, I can now comment on this series and give you
> feedback.


Perhaps. These two devices have nothing in common but the name.

> First, I have some interim patches that are not ready yet to post. The
> device still has some led behavior that I need to investigate, but I
> attach them here for your reference. You may send them on my behalf if
> you want to see them sooner though.
>
> https://github.com/anatase-org/patchwork/commit/af3e5e1755f720a2fffd1b67cb1253e11efbc5bb
> https://github.com/anatase-org/patchwork/commit/7718c4b64b03ca9be043e8c56f1833e5c4880fff
>
> Note that these two patches are essentially a replacement for this
> patch essentially, except for the binding, where your device is I2C
> where mine is thunderbolt, so that still needs to be added. There are
> still leftover issues with the LED I have to investigate before I
> submit these patches.
>
> As you know, USB keyboards in Asus laptops are connected over WMI
> through s2idle as well, which is what makes them turn off their
> backlight during suspend. However, our devices are external and cannot
> use the same path. I suspect that there is a different notifier for
> these devices over armoury crate we need to investigate first.

Your device is thunderbolt only, but 2022, 2023 and 2024
xg mobiles that his patch targets are devices for which the
ACPI of laptops supporting this weird connector is full of
references to and handling and custom code all over the place.

They are nothing alike. They share the name....

If I connect mine to my rog ally armoury crate gains a
slider that sends the exact same command my patch sends...

I couldn't find anything else over USB with wireshark:
everything else is ACPI-driven.

>> Let the led core manage the power transitions: the classdev is flagged
>> with LED_CORE_SUSPENDRESUME, so it is switched off at suspend and its
>> last brightness is restored at resume. The EC drives its own blinking
>> pattern during s2idle anyway, so the led state while the machine is
>> asleep is not meaningful.
>>
>> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>> Signed-off-by: Denis Benato <denis.benato@linux.dev>
>> ---
>>  drivers/hid/hid-asus.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 84 insertions(+)
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index 03150d29eec5..a427e272563d 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>>  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
>>  #define FEATURE_KBD_LED_REPORT_ID2 0x5e
>>
>> +#define ROG_XGM_REPORT_SIZE 300
> Here, you define an additional report size var. This is not necessary,
> as ROG_ALLY_REPORT_SIZE is only used for reads currently in the driver
> and we defer to hid core to set the write length. Therefore, you might
> increase ROG_ALLY_REPORT_SIZE to 300 universally instead, as a
> correctness fix. This way, when Aura devices attempt to write 300
> bytes, they still work regardless of the quirk. This is what
> af3e5e1755f720a2fffd1b67cb1253e11efbc5bb.

I answer to this below, but I want to point out something here:
you are right in wanting to join these, but wrong on what to join:
the right thing to do is not to join the ALLY_REPORT_SIZE and the
XGM report size, but instead to join the  KBD report size and the
ally one as one NKEY_REPORT_SIZE since this is exactly what they
are: N-KEY devices.

>> +
>>  #define ROG_ALLY_REPORT_SIZE 64
>>  #define ROG_ALLY_X_MIN_MCU 313
>>  #define ROG_ALLY_MIN_MCU 319
>> @@ -144,6 +146,11 @@ struct asus_worker {
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
>> @@ -170,6 +177,7 @@ struct asus_drvdata {
>>         unsigned long battery_next_query;
>>         struct asus_hid_listener listener;
>>         bool fn_lock;
>> +       struct asus_xgm_led *xgm_led;
>>  };
>>
>>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
>> @@ -1161,6 +1169,26 @@ static int asus_battery_probe(struct hid_device *hdev)
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
>> +       if (ret < 0) {
>> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
>> +               return ret;
>> +       } else if (ret != ROG_XGM_REPORT_SIZE) {
>> +               hid_err(xgm->hdev, "Unexpected partial transfer to XG mobile: %d\n", ret);
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
> Moreover, as this is an Aura device, and by setting
> ROG_XGM_REPORT_SIZE to 300, you can now reuse the initial inits and
> brightness handler instead of adding new ones as you did here. This
> way, for asus laptops with a wmi handler, the brightness keyboard
> shortcut of the device will also control the eGPU, which is preferable
> behavior. This is what 7718c4b64b03ca9be043e8c56f1833e5c4880fff does
> in part.


Absolutely bad idea, trust me: I have recently followed the fix
of a regression I introduced sending a 64-bytes command to
touchpads that accepts some other length as those stopped
working. Doing that is asking for troubles. Listen to who
caused the trouble already and make the most out of my
mistakes.

I also had to make asusctl send exactly 64-bytes commands
because of random bugs to zephyrus and strix models.
Sending 65 bytes to anime matrix is not a very good idea either.

Also Armoury Crate never sends anything different to 64 bytes
to N-key devices and I do not want to send anything different
than windows does.

Do you remember what happens to rainbow on ROG ally if you send
commands the MCU doesn't like? I don't want having weird things
difficult to debug and nearly impossible to recover from only because
the code would look better/be shorter.

These devices are fragile in handling, tied to the EC and low lever
hardware and I absolutely don't want to diverge from what
Armoury Crate does unless there is a very good reason to it.

I agree that ASUS devices are somewhat forgiving in accepting
different lengths, unlike MSI claws that will not answer to
commands until you have sent a number of bytes multiple of
the length they want, but this is no reason to toy around this. 

> I have not tested the common path yet. I have been travelling so I
> have not flashed the new kernel on my z13. I have been using the eGPU
> with a different device.

If with "the new kernel" you mean 7.3 I can tell you it appears
d3 is broken and some ASUS laptops stopped entering s2idle...

> 7718c4b64b03ca9be043e8c56f1833e5c4880fff also fixes the "blinking
> pattern" of the EC, as you note in your subject. With the init,
> suspend and resume handlers sending the init of that patch, during
> boot the light blinks, it becomes solid once hid-asus binds, then
> during the transition to sleep, it starts to blink until it turns red,
> and does the reverse during resume. It would be good for you to give
> feedback for that. I have not verified the Windows behavior there, and
> we should do that for correctness. The init is referenced from
> g-helper in Windows, but maybe there is another command that signals
> sleep better.

2022, 2023 and 2024 models don't blink outside of s2idle...
Because ACPI is all over the place and the device gets informed
constantly of what the host is doing.

If 2025 models blink until you bind the driver it that means they
rely on commands from the windows application... We will need
to replicate those as closely as possible.

I can ask ASUS if wireshark captures don't shed some lights to it.

> I do not have an answer to the sleep leds unfortunately. My XG's RGB
> stays on while there is a device plugged in, regardless of whether its
> sleeping or shutdown. This makes me think that we are missing a
> notifier command, and the brightness patch you propose here just
> papers over the issue. So we should investigate that first.

What I propose is correct for old models. Newer ones I know nothing
about except that there is no custom ACPI handling them.


> Let me know how you'd like to proceed.

Honestly I think you should name those something like xgb_tb_.....
and handle them separately since they have pretty much nothing
in common... Except the price maybe. Lol.

In general don't go crazy over refactors and trying to make the
code looks better at the expense of proven things: the priority
is for this driver to work reliably and to reuse as much things
proven to work as possible.

> Best,
> Antheas
>
>
>>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>>  {
>>         struct input_dev *input = hi->input;
>> @@ -1406,6 +1434,49 @@ static void asus_initialize_reports(struct hid_device *hdev)
>>         }
>>  }
>>
>> +static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
>> +{
>> +       const char *name;
>> +       int ret;
>> +
>> +       drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
>> +       if (drvdata->xgm_led == NULL)
>> +               return -ENOMEM;
>> +
>> +       name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
>> +                             strlen(hdev->uniq) ? hdev->uniq : dev_name(&hdev->dev));
>> +
>> +       if (name == NULL) {
>> +               ret = -ENOMEM;
>> +               goto asus_xgm_init_err;
>> +       }
>> +
>> +       drvdata->xgm_led->hdev = hdev;
>> +       drvdata->xgm_led->cdev.name = name;
>> +       drvdata->xgm_led->cdev.brightness = 1;
>> +       drvdata->xgm_led->cdev.max_brightness = 1;
>> +       drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
>> +       drvdata->xgm_led->cdev.flags = LED_CORE_SUSPENDRESUME;
>> +
>> +       /* LED state is arbitrary on boot, set a default */
>> +       ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
>> +       if (ret) {
>> +               hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
>> +               goto asus_xgm_init_err;
>> +       }
>> +
>> +       ret = devm_led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
>> +       if (ret) {
>> +               hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
>> +               goto asus_xgm_init_err;
>> +       }
>> +
>> +       return 0;
>> +asus_xgm_init_err:
>> +       drvdata->xgm_led = NULL;
>> +       return ret;
>> +}
>> +
>>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>>  {
>>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>> @@ -1545,6 +1616,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>>         if (!drvdata->tp)
>>                 asus_initialize_reports(hdev);
>>
>> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
>> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
>> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
>> +               ret = asus_xgm_init(hdev, drvdata);
>> +               if (ret) {
>> +                       hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
>> +                       goto err_stop_hw;
>> +               }
>> +       }
>> +
>>         /* Laptops keyboard backlight is always at 0x5a */
>>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
>> @@ -1594,6 +1675,9 @@ static void asus_remove(struct hid_device *hdev)
>>         if (drvdata->listener.brightness_set)
>>                 asus_hid_unregister_listener(&drvdata->listener);
>>
>> +       if (drvdata->xgm_led)
>> +               devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
>> +
>>         asus_worker_stop(drvdata->worker);
>>         hid_hw_stop(hdev);
>>  }
>> --
>> 2.47.3
>>
>>
