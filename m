Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D973D412C
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703931; cv=none; b=pqA5gYjd4b2WfaTpGFBKQmPaTeULvPRiuA6gMXOrRCfTqB1vFY/rZHuPcvNpyMAnp4MEYXIO9HT7zDCyM+MZmdeBFWMvQdN2vkSQCY8qBLyaZBGDOThyifYUg2HFST+o3dgbApN6TZff1298XFNFfAKEv9Ktj7qJnnUDoLqmTZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703931; c=relaxed/simple;
	bh=qIFpL1IE/bkdh/i9cMSulsvoyvijBWtDE39B68/RVXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NujbgegAKqZuqYD/DnCANzRvaLysMJw7yUrj1YblD2onxZeCZflg3rqvMOneGtLCP3lM5gSAs311ARS3kbesCKKc8TsCGeABUrseYfN+t5YUVylqGwGgGkmp1yes18aBDjf/7KcCsn2Hn5II+oV+Ssr93g14MKezh0WmMKGt/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jW2q9GMH; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jW2q9GMH"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 7C39A40748
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 13:45:18 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id CCF924065A
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 13:45:16 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CC360202309
	for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 16:45:15 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781703916;
	bh=XMR5k/VIBPW9C14X3XohCdTswQWpMeogeh3LXkICA9E=;
	h=Received:From:Subject:To;
	b=jW2q9GMHWpsp5u8QeaertJW/IfqP0h1Z3uqYHpEDxOgCETRBJ66GMjk9bgtFoUpIX
	 +FMEZ+Fh0lIxhnHFEwNALpktKLb35FdpiC8Y/pA7w5XV1VZRgEyayQ5Sr8vlSYeNyk
	 hHQWkcFDWbdCFtVHurCwUGjU4d1sMM1hzjPtQOR/1hA4kGPu1OaB9HuY3v7zL/J0Zu
	 vR3D/HScYDsugGBGqZWbEDLYWJhmpcgymQQTUtPz6ZxqfQrBBV5WxAn5sUngmWUFh7
	 4pI04kkiq2kzNi7RNjVhE0fzhcrU5GiXASb3bAI4R/gGULJqtkSuwK8OKDInBqujry
	 CJSZgQyJzu7IQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.43) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f43.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-36d98b9aa9aso4800979a91.3
        for <linux-input@vger.kernel.org>;
 Wed, 17 Jun 2026 06:45:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ85ckZdOcZEOxmlLuj9HLpXRL1GO7UX7L7zlxLVyjRfdpc88+zXVxXaoJCKW5o070Iil+lKmMZpNaBuJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5beB5D52YXIsvGAU3MnnyRujiq+FdK/IlbCYiavAOljWFUqii
	l7Okwfo9ps0uPslZ0Xp3R1f3aMLJyh7nlmX6sb0XvEvD1VHRsRcB7kSDaP9tCLH8oBPo7VnXuBl
	ylAzKwYLA8fknzqkpjas0Vuj8r9D9b54=
X-Received: by 2002:a17:90b:3d44:b0:36d:b12f:613c with SMTP id
 98e67ed59e1d1-37c9ddbd514mr3609029a91.10.1781703914332; Wed, 17 Jun 2026
 06:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615165058.3845-1-denis.benato@linux.dev>
 <20260615165058.3845-5-denis.benato@linux.dev>
 <CAGwozwGfwXeC-SLbbHhHN7_a+Uz8G9ToQcb54XRrcGru3GG2Lg@mail.gmail.com>
 <5006ff55-846e-4812-bc89-b270fbef6ccc@linux.dev>
In-Reply-To: <5006ff55-846e-4812-bc89-b270fbef6ccc@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 17 Jun 2026 15:45:02 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHUwyRTgHcsavkMVBhaUnDfUU_=PSRxtdye9Q4L6hYqKg@mail.gmail.com>
X-Gm-Features: AVVi8CfzOgb7kqe6MrQUrGkhhmjEo402PXtiR0iYNTYr53HJdYnQUMsIsQrYiKU
Message-ID: 
 <CAGwozwHUwyRTgHcsavkMVBhaUnDfUU_=PSRxtdye9Q4L6hYqKg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] HID: asus: add support for xgm led
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178170391610.2622222.5494085437737480532@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Wed, 17 Jun 2026 at 02:18, Denis Benato <denis.benato@linux.dev> wrote:
>
>
> On 6/15/26 23:55, Antheas Kapenekakis wrote:
> > On Mon, 15 Jun 2026 at 18:51, Denis Benato <denis.benato@linux.dev> wrote:
> >> XG mobile stations have very bright leds behind the fan that can be
> >> turned either ON or OFF: add a cled interface to allow controlling the
> >> brightness of those red leds.
> >>
> >> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> >> ---
> >>  drivers/hid/hid-asus.c | 91 ++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 91 insertions(+)
> >>
> >> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> >> index 6896730efafc..e68a6d93369d 100644
> >> --- a/drivers/hid/hid-asus.c
> >> +++ b/drivers/hid/hid-asus.c
> >> @@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> >>  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
> >>  #define FEATURE_KBD_LED_REPORT_ID2 0x5e
> >>
> >> +#define ROG_XGM_REPORT_SIZE 300
> >> +
> >>  #define ROG_ALLY_REPORT_SIZE 64
> >>  #define ROG_ALLY_X_MIN_MCU 313
> >>  #define ROG_ALLY_MIN_MCU 319
> >> @@ -143,6 +145,11 @@ struct asus_worker {
> >>         bool removed;
> >>  };
> >>
> >> +struct asus_xgm_led {
> >> +       struct led_classdev cdev;
> >> +       struct hid_device *hdev;
> >> +};
> >> +
> >>  struct asus_touchpad_info {
> >>         int max_x;
> >>         int max_y;
> >> @@ -169,6 +176,7 @@ struct asus_drvdata {
> >>         unsigned long battery_next_query;
> >>         struct asus_hid_listener listener;
> >>         bool fn_lock;
> >> +       struct asus_xgm_led *xgm_led;
> >>  };
> >>
> >>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
> >> @@ -1119,6 +1127,26 @@ static int asus_battery_probe(struct hid_device *hdev)
> >>         return ret;
> >>  }
> >>
> >> +static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
> >> +{
> >> +       const u8 buf[ROG_XGM_REPORT_SIZE] = {
> >> +               FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
> >> +       };
> >> +       struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
> >> +       int ret;
> >> +
> >> +       ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
> >> +       if (ret < 0) {
> >> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
> >> +               return ret;
> >> +       } else if (ret != ROG_XGM_REPORT_SIZE) {
> >> +               hid_err(xgm->hdev, "Unexpected partial transfer to XG mobile: %d\n", ret);
> >> +               return -EIO;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
> >>  {
> >>         struct input_dev *input = hi->input;
> >> @@ -1343,9 +1371,52 @@ static int asus_start_multitouch(struct hid_device *hdev)
> >>         return 0;
> >>  }
> >>
> >> +static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
> >> +{
> >> +       const char *name;
> >> +       int ret;
> >> +
> >> +       drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
> >> +       if (drvdata->xgm_led == NULL)
> >> +               return -ENOMEM;
> >> +
> >> +       name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
> >> +                             strlen(hdev->uniq) ? hdev->uniq : dev_name(&hdev->dev));
> >> +
> >> +       if (name == NULL) {
> >> +               ret = -ENOMEM;
> >> +               goto asus_xgm_init_err;
> >> +       }
> >> +
> >> +       drvdata->xgm_led->hdev = hdev;
> >> +       drvdata->xgm_led->cdev.name = name;
> >> +       drvdata->xgm_led->cdev.brightness = 1;
> >> +       drvdata->xgm_led->cdev.max_brightness = 1;
> >> +       drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
> >> +
> >> +       /* LED state is arbitrary on boot, set a default */
> >> +       ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
> >> +       if (ret) {
> >> +               hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
> >> +               goto asus_xgm_init_err;
> >> +       }
> >> +
> >> +       ret = devm_led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
> >> +       if (ret) {
> >> +               hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
> >> +               goto asus_xgm_init_err;
> >> +       }
> >> +
> >> +       return 0;
> >> +asus_xgm_init_err:
> >> +       drvdata->xgm_led = NULL;
> >> +       return ret;
> >> +}
> >> +
> >>  static int __maybe_unused asus_resume(struct hid_device *hdev)
> >>  {
> >>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> >> +       int ret;
> >>
> >>         /*
> >>          * If we have a backlight listener registered, restore the previous state,
> >> @@ -1355,7 +1426,17 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
> >>         if (drvdata->listener.brightness_set)
> >>                 asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brightness);
> >>
> >> +       if (drvdata->xgm_led) {
> >> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
> >> +               if (ret) {
> >> +                       hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
> >> +                       goto asus_resume_err;
> >> +               }
> >> +       }
> >> +
> >>         return 0;
> >> +asus_resume_err:
> >> +       return ret;
> >>  }
> >>
> >>  static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
> >> @@ -1484,6 +1565,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >>                 }
> >>         }
> >>
> >> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> >> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> >> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> >> +               ret = asus_xgm_init(hdev, drvdata);
> >> +               if (ret) {
> >> +                       hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
> >> +                       goto err_stop_hw;
> >> +               }
> >> +       }
> >> +
> > reset_resume has a special meaning and perhaps should not have been
> > used for this driver at all. Check if resume works and if it does use
> > that instead.
> I am not using reset_resume for xgm.
>
> reset_resume will become important to recover the ally,

For that, review the V2 s2idle series I have sent, it should drop that
codepath and work for all ally units

Sorry, misread the hunk again, I was looking at probe and confused it
with the resume check. The patch should be fine, you use resume.

Antheas

> but for xg mobile is unused (and useless).
> > Other than that and the refactor patch I'd rather see separately, the
> > other 4 patches look fine to me.
> Fair, I'll wait for maintainers to tell what they like the most
> and go from there.
>
> I agree there are things not really much related here
> but at least this way the order to apply them is clear.
> > Reviewed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Thanks,
> Denis
> > Best,
> > Antheas
> >
> >>         /* Laptops keyboard backlight is always at 0x5a */
> >>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
> >>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
> >> --
> >> 2.47.3
> >>
> >>
>

