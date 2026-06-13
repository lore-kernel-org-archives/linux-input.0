Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DD1A4F2F
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310627; cv=none; b=cwzZJFkiN4nu0kRsNcwH7YpGPYu/lic7SrptoF+hBrTEuaAa44s9J89OLN85vGyiGcOp0y99iTEn0VyzorW7AXqc2w0TccFWbkEohxE2LZfeLIjtASwZxVHqKgM3YQU5zX2kpzvu8M6khTrtal1pE9I9rJjCmJ/Da2/LLZJ5Q7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310627; c=relaxed/simple;
	bh=qDbq1Bwp0N4rc9wOQMw2+OadyamjTmkvbA4Wf5S/V+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJnpGwFLQU3i28wrPTRT1GEEapsGy6nYrlCV1LbvCXbETSywGCH8BkVDMK0Ln+J42UOj6NI/82Tkd1nnf+2CKjtfj2R5baqp6wdIKPxc/OBHBt7jiM+eIIlPdzdRLaSfxi5iF+xK05X/cotpnWvRSCyJiPmG8862cI3nlt//dHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=P6zxcHUp; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="P6zxcHUp"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id 9328C403CE
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 00:30:22 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 90686406F4
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 00:30:21 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id D443E200C5E
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 03:30:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1781310621;
	bh=bJ3yfMzkJgkMThrYSPm0kuPOXn6tmDyJsMHQKz8pLWc=;
	h=Received:From:Subject:To;
	b=P6zxcHUpiNLOZcAKynvVdR1wybS+pp7bz/dFI+MGk8m8U3cXVv5sS0alsV4a41TMI
	 pxap8cUWoDqAfipDsv1/n2Qm1nubFx8lL0pUJ6ceBWDwM5kbRpXkfjA9AMDZKME/uT
	 UslrYgl8ZiQrGSncsj86DPpp45ZPloBipSKgRYj4snQrfCGf+3ukuaB0R04T1fl3nx
	 U7eQN/rUHuWUyfQeLD1KYXBWQ5H01rHGacP8qXlhUutj8JDKsG5k37REIIOy3Xdjgm
	 Lg+TBO6Qr8OGXOgMxLAsDouv22Nx3OETAfjh/Y8hA/o2lACjUNnFDgGamDQrT6xv+V
	 TgnTZBHX69Pcg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c8857a27041so102081a12.1
        for <linux-input@vger.kernel.org>;
 Fri, 12 Jun 2026 17:30:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+i1l6iVEiq9K9shorB00dKYI9yaPS+SoG7rS3w6i74n34elXwv3LUJg2+9D4Wvnn5HNVtoF8oy9YVpug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1UwOMHXJVsUm8/6FQeJtPelxGh1/kz0VRqW2T7qJjvXTOCro4
	DX90FpB6dR97EpeWqRyghu12vlkYEc2m9s6sDIOPALb59h+O0p/08YhfdiHsdzVgEM72iT3OA84
	gfOLzth3Pvd1+fjoIjBxGlDKg2VpUvCQ=
X-Received: by 2002:a05:6a21:9089:b0:3b4:af58:813a with SMTP id
 adf61e73a8af0-3b7961f7c86mr1763514637.1.1781310619338; Fri, 12 Jun 2026
 17:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612142326.1704858-1-denis.benato@linux.dev>
 <20260612142326.1704858-4-denis.benato@linux.dev>
 <CAGwozwHCAC1AkAjo4BqyjdS+GQqDWaMgmmtgAi14VzBc9NM3gQ@mail.gmail.com>
 <f4d34bd2-c7aa-43da-a3f3-a9dafe82af66@gmail.com>
In-Reply-To: <f4d34bd2-c7aa-43da-a3f3-a9dafe82af66@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 13 Jun 2026 02:30:08 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwE-EOdbJgKwUXth3S5Tzw4AcxJaMCjP=r0YUP5+TNnOkQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfon1s1K2_uiuzN23nAjKMGXgPN2MHlCPC8dG87tzPW2z-jEulYe6RKYec
Message-ID: 
 <CAGwozwE-EOdbJgKwUXth3S5Tzw4AcxJaMCjP=r0YUP5+TNnOkQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] HID: asus: add support for xgm led
To: Denis Benato <benato.denis96@gmail.com>
Cc: Denis Benato <denis.benato@linux.dev>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
 Mateusz Schyboll <dragonn@op.pl>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178131062108.973478.10979264112777295118@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 12 Jun 2026 at 17:56, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 6/12/26 16:39, Antheas Kapenekakis wrote:
> > On Fri, 12 Jun 2026 at 16:23, Denis Benato <denis.benato@linux.dev> wrote:
> >> XG mobile stations have very bright leds behind the fan that can be
> >> turned either ON or OFF: add a cled interface to allow controlling the
> >> brightness of those red leds.
> >>
> >> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> >> ---
> >>  drivers/hid/hid-asus.c | 70 ++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 70 insertions(+)
> >>
> >> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> >> index 323dc0b7f3ff..21c4a60d224e 100644
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
> >> @@ -118,6 +120,11 @@ struct asus_kbd_leds {
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
> >> @@ -143,6 +150,7 @@ struct asus_drvdata {
> >>         unsigned long battery_next_query;
> >>         struct work_struct fn_lock_sync_work;
> >>         bool fn_lock;
> >> +       struct asus_xgm_led *xgm_led;
> >>  };
> >>
> >>  static int asus_report_battery(struct asus_drvdata *, u8 *, int);
> >> @@ -941,6 +949,23 @@ static int asus_battery_probe(struct hid_device *hdev)
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
> >> +       if (ret != ROG_XGM_REPORT_SIZE) {
> >> +               hid_err(xgm->hdev, "Unable to set XG mobile led state: %d\n", ret);
> >> +               return ret;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
> >>  {
> >>         struct input_dev *input = hi->input;
> >> @@ -1184,6 +1209,14 @@ static int __maybe_unused asus_resume(struct hid_device *hdev)

I might have confused the hunk here and you are right, input
configured is above.

> >>                 }
> >>         }
> >>
> >> +       if (drvdata->xgm_led) {
> >> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
> >> +               if (ret) {
> >> +                       hid_err(hdev, "Asus failed to restore xgm brightness: %d\n", ret);
> >> +                       goto asus_resume_err;
> >> +               }
> >> +       }
> >> +
> >>  asus_resume_err:
> >>         return ret;
> >>  }
> >> @@ -1310,6 +1343,40 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >>                 }
> >>         }
> >>
> >> +       if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> >> +           ((hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> >> +            (hdev->product == USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> >> +               drvdata->xgm_led = devm_kzalloc(&hdev->dev, sizeof(*drvdata->xgm_led), GFP_KERNEL);
> >> +               if (drvdata->xgm_led == NULL) {
> >> +                       ret = -ENOMEM;
> >> +                       goto err_stop_hw;
> >> +               }
> >> +               drvdata->xgm_led->hdev = hdev;
> >> +               drvdata->xgm_led->cdev.name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
> >> +                                       "asus:xgm-%s:led",
> >> +                                       strlen(hdev->uniq) ?
> >> +                                       hdev->uniq : dev_name(&hdev->dev));
> >> +               drvdata->xgm_led->cdev.brightness = 1;
> >> +               drvdata->xgm_led->cdev.max_brightness = 1;
> >> +               drvdata->xgm_led->cdev.brightness_set_blocking = asus_xgm_led_set;
> >> +
> >> +               /*
> >> +                * Sometimes after a reboot LEDs are ON, sometimes are OFF: set them to
> >> +                * what the default brightness resets when doing a cold boot.
> >> +                */
> > I think this is set by the driver, so you should reformat the comment
> > above, so you should trim the comment.
> >
> > Perhaps, "The LED state is arbitrary on boot, therefore default to the
> > initial brightness set above". This way it does not become outdated if
> > cdev.brightness changes.
> yeah better spelling. I agree.
> >> +               ret = asus_xgm_led_set(&drvdata->xgm_led->cdev, drvdata->xgm_led->cdev.brightness);
> >> +               if (ret) {
> >> +                       hid_err(hdev, "Asus failed to set xgm led: %d\n", ret);
> >> +                       goto err_stop_hw;
> >> +               }
> > You already do this in asus_input_configured so you do it twice?
> > Perhaps skip one if you end up keeping them? I think that it's better
> > to keep this block.
> In asus_input_configured? Will take a look in the next days. I tought
> the other was in asus_resume since at resume they resets back...
> > Or even better return an error in _get so that on boot it is
> > ambiguous? I assume the leds remain to the state they had prior to the
> > reboot? With this change, imagine a user that turned off the leds in
> > windows, permabooted into Linux, and now has the lights always turn on
> > during boot.
> Cold boot sets them to ON, while rebooting keep them at what they were.
>
> After exiting from sleep they are always ON, but this is on an ally,
> I don't know if on an old rog flow it's the same.
> > Moreover, can systemd restore this or is it out of scope for its led
> > handler? Perhaps it is an ambitious idea though, and better skipped.
> I don't see realistic for this to fail if it was successful at probe so it
> shouldn't matter. As for systemd restoring them it would have to
> be informed that they changed (but there is no read-back) so either
> way something has to happen at resume, but doing this means no
> additional software is necessary and user preference is being
> respected regardless of anything else.

Ok, so xg mobile is the first generation gpu dock with the wide
connector, which is why it is i2c. It's probably from the side port.

So, when it initializes in general it enables the leds. And it
initializes on boot and on wake. And it has no memory.

For not setting the led, you could return an error on reads if the
brightness has not been written yet and if it has return a cached
value / restore on awake. You can store the brightness in the struct
below xgm_led, e.g., xgm_led_val, and initialize it to -1. If it is
-1, get would return the same error you did for battery capacity in
asus-wmi

In that case, you would remove the init from probe. Otherwise, the
current patch with a small tweak to the comment if you do a revision
is fine by me

Reviewed by: Antheas Kapenekakis <lkml@antheas.dev>

> >> +
> >> +               ret = led_classdev_register(&hdev->dev, &drvdata->xgm_led->cdev);
> >> +               if (ret) {
> >> +                       hid_err(hdev, "Asus failed to register xgm led: %d\n", ret);
> >> +                       goto err_stop_hw;
> >> +               }
> >> +       }
> >> +
> >>         /* Laptops keyboard backlight is always at 0x5a */
> >>         if (is_vendor && (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT) &&
> >>             (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID)) &&
> >> @@ -1366,6 +1433,9 @@ static void asus_remove(struct hid_device *hdev)
> >>         if (drvdata->quirks & QUIRK_HID_FN_LOCK)
> >>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
> >>
> >> +       if (drvdata->xgm_led)
> >> +               led_classdev_unregister(&drvdata->xgm_led->cdev);
> >> +
> >>         hid_hw_stop(hdev);
> >>  }
> >>
> >> --
> >> 2.47.3
> >>
> >>
> Thanks,
> Denis
>

