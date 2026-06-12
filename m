Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60193644DB
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275166; cv=none; b=d3WMiKoS3FQK7eypawzl7pek+Xm1s1CCWgUgqSlBtgz6lNpfGpvHLrqW+1Gop0gTQI1YwiTKnjK9SjGSvirvvXRkWG8nf3q3ldvdcnzqeub9fSAWVraskLmHQff29aJTzAdVlfX868mdbkTNUzIMX7LNVur0nWR4WkA7GgHbGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275166; c=relaxed/simple;
	bh=eO02ISprtZyiMDybn6wHT7KmDEHXDRqQNsO8Z8R/cgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnyuyQZbFEEBGRpzXue6zwj6OOKphpEAhNIquWGRggbLRw9sev+LVfkAxjDpiAxA5z3EQD7FOxBr5oO7tczVVeX1QPPj7cH9xKvNl2Ucqi7Vjfwk+Fc6NN7DStbaJRlHkjJ7LXVjWZZ1120ANogcrdm5TwyTlgN6mNavLpcvcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=jZLKyjdM; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="jZLKyjdM"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 246E3C04CF
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 17:39:16 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 82477C052F
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 17:39:15 +0300 (EEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 951DC1FF2B3
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 17:39:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781275155;
	bh=dEga/Y3g9yjVl6J12AQ5+AFC+R8CaSDtoWL2Jo64yGI=;
	h=Received:From:Subject:To;
	b=jZLKyjdMUg9YKgSU7kQK3/B2APBwVbTi9MkFZeG+zuan4soVTa1nPJ7G+nYFuIgYI
	 x4qJ0olsoN9kkkcq6F/ScH2nTkFprVIS6Cfa1z3vpY3j2CI6cX1hNLKm1UPuWRMZ/9
	 OFcYAr5KZrcuOaegdZ0V0idTIVdW370/Ji/qEsT7Hx4jw4DxlN7eMSYZoTDz2GqbST
	 6bre5LKwcu+jJ4LUcR4mDwxSNTjFHWL7w0h6MaWiC5n+4GkELpZmRXsT7hjIrmoBAq
	 sKQLCivA36pi3IGxlvjXXpehmXVlKqpY9iFTWJrvZGM2zSElgUz/HsAYsbzep+BoT5
	 S1HKLisO6sPOw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.53) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f53.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-36b9d265355so514752a91.2
        for <linux-input@vger.kernel.org>;
 Fri, 12 Jun 2026 07:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+JVpFRZPn009TucQ4BprEluLGvYwS+Uks22aMVh+UdSBQR7i2XEBrz4KBvT7Y0yhAMIUmDrocpshsG3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YweojQR760IwJBiwF7FqN7u/8A38B1kg/5vdaFS7ZMMYxL3YFEx
	xafTT56E1qF9pNhbJjPwYpezdr9JwHyw9V6hEUCnMVhadhTnP8VJ83gJ1Zc3aKgDWD21itdyHV9
	teNMHK71ATONuw5fFwOR4/a2Yutsyy6Y=
X-Received: by 2002:a17:90b:380e:b0:36d:79c6:1563 with SMTP id
 98e67ed59e1d1-37a035f00e6mr3451009a91.17.1781275152813; Fri, 12 Jun 2026
 07:39:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612142326.1704858-1-denis.benato@linux.dev>
 <20260612142326.1704858-4-denis.benato@linux.dev>
In-Reply-To: <20260612142326.1704858-4-denis.benato@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 12 Jun 2026 16:39:01 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHCAC1AkAjo4BqyjdS+GQqDWaMgmmtgAi14VzBc9NM3gQ@mail.gmail.com>
X-Gm-Features: AVVi8Cdf-SCzBFp4pyJubT3c8WKiZcOMOkM3yeQmW1JnTM0E1m0uf-6z4_m8mFY
Message-ID: 
 <CAGwozwHCAC1AkAjo4BqyjdS+GQqDWaMgmmtgAi14VzBc9NM3gQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] HID: asus: add support for xgm led
To: Denis Benato <denis.benato@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178127515502.2721949.9870639037096996626@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 12 Jun 2026 at 16:23, Denis Benato <denis.benato@linux.dev> wrote:
>
> XG mobile stations have very bright leds behind the fan that can be
> turned either ON or OFF: add a cled interface to allow controlling the
> brightness of those red leds.
>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/hid-asus.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 323dc0b7f3ff..21c4a60d224e 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -51,6 +51,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define FEATURE_KBD_LED_REPORT_ID1 0x5d
>  #define FEATURE_KBD_LED_REPORT_ID2 0x5e
>
> +#define ROG_XGM_REPORT_SIZE 300
> +
>  #define ROG_ALLY_REPORT_SIZE 64
>  #define ROG_ALLY_X_MIN_MCU 313
>  #define ROG_ALLY_MIN_MCU 319
> @@ -118,6 +120,11 @@ struct asus_kbd_leds {
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
> @@ -143,6 +150,7 @@ struct asus_drvdata {
>         unsigned long battery_next_query;
>         struct work_struct fn_lock_sync_work;
>         bool fn_lock;
> +       struct asus_xgm_led *xgm_led;
>  };
>
>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
> @@ -941,6 +949,23 @@ static int asus_battery_probe(struct hid_device *hdev)
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
> +       if (ret != ROG_XGM_REPORT_SIZE) {
> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  {
>         struct input_dev *input = hi->input;
> @@ -1184,6 +1209,14 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)
>                 }
>         }
>
> +       if (drvdata->xgm_led) {
> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
> +               if (ret) {
> +                       hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
> +                       goto asus_resume_err;
> +               }
> +       }
> +
>  asus_resume_err:
>         return ret;
>  }
> @@ -1310,6 +1343,40 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>                 }
>         }
>
> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> +               drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
> +               if (drvdata->xgm_led == NULL) {
> +                       ret = -ENOMEM;
> +                       goto err_stop_hw;
> +               }
> +               drvdata->xgm_led->hdev = hdev;
> +               drvdata->xgm_led->cdev.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
> +                                       "asus:xgm-%s:led",
> +                                       strlen(hdev->uniq) ?
> +                                       hdev->uniq : dev_name(&hdev->dev));
> +               drvdata->xgm_led->cdev.brightness = 1;
> +               drvdata->xgm_led->cdev.max_brightness = 1;
> +               drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
> +
> +               /*
> +                * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
> +                * what the default brightness resets when doing a cold boot.
> +                */

I think this is set by the driver, so you should reformat the comment
above, so you should trim the comment.

Perhaps, "The LED state is arbitrary on boot, therefore default to the
initial brightness set above". This way it does not become outdated if
cdev.brightness changes.

> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
> +               if (ret) {
> +                       hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
> +                       goto err_stop_hw;
> +               }

You already do this in asus_input_configured so you do it twice?
Perhaps skip one if you end up keeping them? I think that it's better
to keep this block.

Or even better return an error in _get so that on boot it is
ambiguous? I assume the leds remain to the state they had prior to the
reboot? With this change, imagine a user that turned off the leds in
windows, permabooted into Linux, and now has the lights always turn on
during boot.

Moreover, can systemd restore this or is it out of scope for its led
handler? Perhaps it is an ambitious idea though, and better skipped.

> +
> +               ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
> +               if (ret) {
> +                       hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
> +                       goto err_stop_hw;
> +               }
> +       }
> +
>         /* Laptops keyboard backlight is always at 0x5a */
>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
> @@ -1366,6 +1433,9 @@ static void asus_remove(struct hid_device *hdev)
>         if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
>
> +       if (drvdata->xgm_led)
> +               led_classdev_unregister(&drvdata->xgm_led->cdev);
> +
>         hid_hw_stop(hdev);
>  }
>
> --
> 2.47.3
>
>

