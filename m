Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226713A2E12
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509646; cv=none; b=JLLAK7r/TvdQPjZZwzx84izatuxPKEO7EZ+DYIjcryPMkXK9YBvA2N5pukiDu5pckS+FDuf11gRjjGLE4Xyvmlt5zA2cCbWIMZNcoiTZyYQRg+PWaQDpASYkEY+hRFmft/Yj15mbha41dD1zwEkAl9MA7yE0oBMTsSUocxL1xY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509646; c=relaxed/simple;
	bh=Ix8NITcu+4ybhu56RWNyaDTxgxHUpYM7smt11ghVdtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdGetUCPOafsB1G4dWocI6IIcM1JlkQyCgjKQjdHDHrcOiirXeFOKMrYyynF54vCdy7PC6XvekjKrDf9J+1iKIWLZyzKhWMtzINBBpVpRB4E3h2Azcj7HJ3Mj9MMGuQUzigSLI0IT3afHmMA/RiUKAtRnsBO+3EefVMAVX0MOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=aHc4pYCw; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="aHc4pYCw"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id D336B3EB4F
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 21:53:00 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 34BC33FA78
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 21:52:59 +0000 (UTC)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 551A42020FF
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 00:52:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1789509178;
	bh=51gBxGogJFAaezkdy9z+JZ/z/T2z0OizgJhVelphwVE=;
	h=Received:From:Subject:To;
	b=aHc4pYCw2Ua3VPuAvOkTxD0WVynz0w93mldBP4haLb95mHJBBD6ahifWDuOY8vrL/
	 Q3q1eAX6hKVzB+uEfVSdP0qMfBCQ9hoAxZD1Al5Sf7HJ7o3QbYTLgyGtuaRJy04o8p
	 KdZQ/gdSDLEJTFnPITVZaU9+M7SSPo9ND7IjxnsqBlNl/9eVgZVliIsqvh0zJ3f/ZA
	 Qdi1sqEX1u24fdeykQL8mWdDugsil91dbPqRPS+X6nY7T1ljEW98B8dWR5zENJhIxL
	 +qA2ycHLX2T3niLbBzHlx2p5hMVo/Qk1n8BfN4btFv2ifMVr5VxAeMO686YTwHa2F2
	 2LMWUs9puSDvQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 74.125.227.141) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj2-f13.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ed6d6eso2343385ad.2
        for <linux-input@vger.kernel.org>;
 Tue, 15 Sep 2026 14:52:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxELNGIJWGm0wUg0Kb/2rOyCE1l8bnPHD4TNc1g4iFVlhzK1VWs1PR68cyGZxd8HBwozknAPVOCQQe71Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kd9rGVfwGYYc6ELvg9EeyfUx5jubbdw8fBQEFV5QwFhKLy1XR9
	mcWsRfEXsAimNq3NLgYl7MEwPMW9M+EtzKjJRaZkeYlgkTyJmkpWs7YMo6QuZ3fAXQ5YAOXwhEf
	yi8Pge+5oVcr6Scz2BgL542/pPHjcpkw=
X-Received: by 2002:a17:903:4b4f:b0:2d6:f6ba:263d with SMTP id
 d9443c01a7336-2dd8e00565amr3284085ad.7.1789509176805; Tue, 15 Sep 2026
 14:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915181200.18086-1-denis.benato@linux.dev>
 <20260915181200.18086-4-denis.benato@linux.dev>
In-Reply-To: <20260915181200.18086-4-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 15 Sep 2026 23:52:44 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHe7dnSi1=NuqeQuXD0FtdPKLJvwyC53ff6LUmRU9Z7SQ@mail.gmail.com>
X-Gm-Features: AcwNN1WubovSigBopQ6HqhsaZYeO7rOessUJCsqQ43pEWdUjzQtYDNp6sUoH1Ds
Message-ID: 
 <CAGwozwHe7dnSi1=NuqeQuXD0FtdPKLJvwyC53ff6LUmRU9Z7SQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: asus: add support for xgm led
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178950917857.3474086.9984482882708832392@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 15 Sept 2026 at 20:12, Denis Benato <denis.benato@linux.dev> wrote:
>
> XG mobile stations have very bright leds behind the fan that can be
> turned either ON or OFF: add a cled interface to allow controlling the
> brightness of those red leds.

Hi Denis,
as of last month, I am also the proud owner of a XG Mobile (2025 in my
case). Therefore, I can now comment on this series and give you
feedback.

First, I have some interim patches that are not ready yet to post. The
device still has some led behavior that I need to investigate, but I
attach them here for your reference. You may send them on my behalf if
you want to see them sooner though.

https://github.com/anatase-org/patchwork/commit/af3e5e1755f720a2fffd1b67cb1253e11efbc5bb
https://github.com/anatase-org/patchwork/commit/7718c4b64b03ca9be043e8c56f1833e5c4880fff

Note that these two patches are essentially a replacement for this
patch essentially, except for the binding, where your device is I2C
where mine is thunderbolt, so that still needs to be added. There are
still leftover issues with the LED I have to investigate before I
submit these patches.

As you know, USB keyboards in Asus laptops are connected over WMI
through s2idle as well, which is what makes them turn off their
backlight during suspend. However, our devices are external and cannot
use the same path. I suspect that there is a different notifier for
these devices over armoury crate we need to investigate first.

> Let the led core manage the power transitions: the classdev is flagged
> with LED_CORE_SUSPENDRESUME, so it is switched off at suspend and its
> last brightness is restored at resume. The EC drives its own blinking
> pattern during s2idle anyway, so the led state while the machine is
> asleep is not meaningful.
>
> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 84 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 03150d29eec5..a427e272563d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
>  #define FEATURE_KBD_LED_REPORT_ID2 0x5e
>
> +#define ROG_XGM_REPORT_SIZE 300

Here, you define an additional report size var. This is not necessary,
as ROG_ALLY_REPORT_SIZE is only used for reads currently in the driver
and we defer to hid core to set the write length. Therefore, you might
increase ROG_ALLY_REPORT_SIZE to 300 universally instead, as a
correctness fix. This way, when Aura devices attempt to write 300
bytes, they still work regardless of the quirk. This is what
af3e5e1755f720a2fffd1b67cb1253e11efbc5bb.

> +
>  #define ROG_ALLY_REPORT_SIZE 64
>  #define ROG_ALLY_X_MIN_MCU 313
>  #define ROG_ALLY_MIN_MCU 319
> @@ -144,6 +146,11 @@ struct asus_worker {
>         bool removed;
>  };
>
> +struct asus_xgm_led {
> +       struct led_classdev cdev;
> +       struct hid_device *hdev;
> +};
> +
>  struct asus_touchpad_info {
>         int max_x;
>         int max_y;
> @@ -170,6 +177,7 @@ struct asus_drvdata {
>         unsigned long battery_next_query;
>         struct asus_hid_listener listener;
>         bool fn_lock;
> +       struct asus_xgm_led *xgm_led;
>  };
>
>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
> @@ -1161,6 +1169,26 @@ static int asus_battery_probe(struct hid_device *hdev)
>         return ret;
>  }
>
> +static int asus_xgm_led_set(struct led_classdev *led_cdev, enum led_brightness value)
> +{
> +       const u8 buf[ROG_XGM_REPORT_SIZE] = {
> +               FEATURE_KBD_LED_REPORT_ID2, 0xC5, (value) ? 0x50 : 0x00
> +       };
> +       struct asus_xgm_led *xgm = container_of(led_cdev, struct asus_xgm_led, cdev);
> +       int ret;
> +
> +       ret = asus_kbd_set_report(xgm->hdev, buf, ROG_XGM_REPORT_SIZE);
> +       if (ret < 0) {
> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
> +               return ret;
> +       } else if (ret != ROG_XGM_REPORT_SIZE) {
> +               hid_err(xgm->hdev, "Unexpected partial transfer to XG mobile: %d\n", ret);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +

Moreover, as this is an Aura device, and by setting
ROG_XGM_REPORT_SIZE to 300, you can now reuse the initial inits and
brightness handler instead of adding new ones as you did here. This
way, for asus laptops with a wmi handler, the brightness keyboard
shortcut of the device will also control the eGPU, which is preferable
behavior. This is what 7718c4b64b03ca9be043e8c56f1833e5c4880fff does
in part.

I have not tested the common path yet. I have been travelling so I
have not flashed the new kernel on my z13. I have been using the eGPU
with a different device.

7718c4b64b03ca9be043e8c56f1833e5c4880fff also fixes the "blinking
pattern" of the EC, as you note in your subject. With the init,
suspend and resume handlers sending the init of that patch, during
boot the light blinks, it becomes solid once hid-asus binds, then
during the transition to sleep, it starts to blink until it turns red,
and does the reverse during resume. It would be good for you to give
feedback for that. I have not verified the Windows behavior there, and
we should do that for correctness. The init is referenced from
g-helper in Windows, but maybe there is another command that signals
sleep better.

I do not have an answer to the sleep leds unfortunately. My XG's RGB
stays on while there is a device plugged in, regardless of whether its
sleeping or shutdown. This makes me think that we are missing a
notifier command, and the brightness patch you propose here just
papers over the issue. So we should investigate that first.

Let me know how you'd like to proceed.

Best,
Antheas


>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  {
>         struct input_dev *input = hi->input;
> @@ -1406,6 +1434,49 @@ static void asus_initialize_reports(struct hid_device *hdev)
>         }
>  }
>
> +static int asus_xgm_init(struct hid_device *hdev, struct asus_drvdata *drvdata)
> +{
> +       const char *name;
> +       int ret;
> +
> +       drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
> +       if (drvdata->xgm_led == NULL)
> +               return -ENOMEM;
> +
> +       name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "asus:xgm-%s:led",
> +                             strlen(hdev->uniq) ? hdev->uniq : dev_name(&hdev->dev));
> +
> +       if (name == NULL) {
> +               ret = -ENOMEM;
> +               goto asus_xgm_init_err;
> +       }
> +
> +       drvdata->xgm_led->hdev = hdev;
> +       drvdata->xgm_led->cdev.name = name;
> +       drvdata->xgm_led->cdev.brightness = 1;
> +       drvdata->xgm_led->cdev.max_brightness = 1;
> +       drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
> +       drvdata->xgm_led->cdev.flags = LED_CORE_SUSPENDRESUME;
> +
> +       /* LED state is arbitrary on boot, set a default */
> +       ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
> +       if (ret) {
> +               hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
> +               goto asus_xgm_init_err;
> +       }
> +
> +       ret = devm_led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
> +       if (ret) {
> +               hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
> +               goto asus_xgm_init_err;
> +       }
> +
> +       return 0;
> +asus_xgm_init_err:
> +       drvdata->xgm_led = NULL;
> +       return ret;
> +}
> +
>  static int __maybe_unused asus_resume(struct hid_device *hdev)
>  {
>         struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> @@ -1545,6 +1616,16 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>         if (!drvdata->tp)
>                 asus_initialize_reports(hdev);
>
> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> +               ret = asus_xgm_init(hdev, drvdata);
> +               if (ret) {
> +                       hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
> +                       goto err_stop_hw;
> +               }
> +       }
> +
>         /* Laptops keyboard backlight is always at 0x5a */
>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
> @@ -1594,6 +1675,9 @@ static void asus_remove(struct hid_device *hdev)
>         if (drvdata->listener.brightness_set)
>                 asus_hid_unregister_listener(&drvdata->listener);
>
> +       if (drvdata->xgm_led)
> +               devm_led_classdev_unregister(&hdev->dev, &drvdata->xgm_led->cdev);
> +
>         asus_worker_stop(drvdata->worker);
>         hid_hw_stop(hdev);
>  }
> --
> 2.47.3
>
>

