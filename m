Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=88.99.38.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140397;
	b=cVtT+8oh38jHDWaqtkxEZOKF/FgLIsrFMzUyODStTYiCDa27W/F7fZ3M650sAwBvjncK
	 SI2A2/cyPhW1WdQtH4nHmvl1iWIAyKd3O1AR8FY2Y7670WSiveh5xLXj57pk5Li0ABqX8
	 LgoQhADtagrEvfC2gtaEWD98af1j0DjUPgKvY53+oc9QrUWOQ47hM4V7fKb42jZemCHee
	 Lwi6FSvr2xVS5kGRt1RSca/87Ov5dQHLAYnL4jh2/aT3cxw7JZ4AZRpg4NjYftKRJcwy3
	 naKxWm/NZCCKQyOG2hkoHy3+aREHaLOAOu+sfkKgeNLD4a4H+AoP0snTmCYMl+PiV8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140397;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Received-SPF:
	 Received:X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-PPP-Message-ID:X-PPP-Vhost:X-Virus-Scanned:
	 X-Virus-Status;
	bh=aGNlbqNM+Cs0D6cWPf+dVF6ZXiIEwt2+4hu0aRBpEy4=;
	b=n2gqAyRVbGdJBmoa/ZPTZYL7W/xg1DqRAjfxQDmenq4rv9dOB3qM8h8G07Fal5dXoe26
	 dfImD17xda9NX2z7dai5iigVqCKBJM02osV/2zwbUG1eOTVWXSeELMnh2bkqp/Q8mG7WW
	 NzQwME18m1AgNePDmSuSnT4ucvN6dcwVFmfbak8Pxygb9ZX7z1YymfjyIChl2EWBkQt0b
	 iTSoebQof9lJsp4nsdDVhHrXxXNSbbEhwPr0D7Gh5s1gpwVhoyyjgnweJJwpkH2K49sjE
	 WIj+MsrMKgveOWjFth3OG/SmLZIAABPb2wOSzpkCBwGBNgf10Km6Xqa3KLEZJSc5HoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=antheas.dev;
	spf=pass smtp.mailfrom=antheas.dev;
	dkim=pass header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=MhEbA5LN;
	arc=none smtp.remote-ip=88.99.38.195
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91C9606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 12:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91C9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=MhEbA5LN
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 8D99ABC2F2
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:19:47 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 45432BBF0C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:19:46 +0200 (EET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 7ADB41FC17C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:19:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1794140385;
	bh=aGNlbqNM+Cs0D6cWPf+dVF6ZXiIEwt2+4hu0aRBpEy4=;
	h=Received:From:Subject:To;
	b=MhEbA5LNePwC4J8jiGlhR8bI05JPcSkoPHGyTnQIPsg1FdWn0C/FmVmdy3bAOZlU7
	 Ywa64/VnonD2QQp7tZuv+BFGLtBE7OngJF5U1fTJmhIhdUGRxuD1R+AhAvyl4HcK4Q
	 WLnLo8z3qHR85cXdDxB0tA2IJ/Sx8gDTtFXIt8i2Ia01WYqBpio5fOMmdT/2HjBGMG
	 pUaTgVe0fpDGWeUOkPHCv0Ct1ky5yUXck28Ev/HIOHox0GKxpsbNFn4/makz4fRdmW
	 cteWQbRq504PUyzVa+5o7Gsc9/IeVpIZNo3a0e+Gus+5oyTyV2KVGyFWK08pnSx5UQ
	 HVDx3Jl1hdtbw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e95bd1c14cso448675ad.2
        for <linux-input@vger.kernel.org>;
 Sun, 08 Nov 2026 04:19:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH52wsP9RmZIU8yM5EuPcx7F7aF1KkBzhtl6h6+GaDPUeELQXHj1rOfiRqmZFikPbzFVEulBDKrQg1DwQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZnUIMcvIYSMWzTVzlSVv5DxZoX6guHsWjuvREbDiSdnL84RFx
	BhAxExkaAksiFDs7Q0WsYOMqJZA4qFXryUwF65LV4HvmvmLtatoC3jVITGkJTohaL+4LgvnSEcN
	o75D79j6kyuTaPKqAK9vGwv0CuLF9g7A=
X-Received: by 2002:a17:903:228e:b0:2ed:472:b9d6 with SMTP id
 d9443c01a7336-2ed833ee6d6mr12879355ad.2.1794140384132; Sun, 08 Nov 2026
 04:19:44 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108110757.41368-1-hijae99@gmail.com>
In-Reply-To: <20261108110757.41368-1-hijae99@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 8 Nov 2026 13:19:33 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEKXJGBY5oZtdrrzfK-aOyYu5GaiOqkejSqbCPdeq0UJg@mail.gmail.com>
X-Gm-Features: AclHuK8FCPhpWMw0QpO6vfYGGLkv_VEx6bXqbmnEpZ9shDu4AyH7GudJk2u6IAc
Message-ID: 
 <CAGwozwEKXJGBY5oZtdrrzfK-aOyYu5GaiOqkejSqbCPdeq0UJg@mail.gmail.com>
Subject: Re: [PATCH] HID: ayaneo-flip-kb: Add driver for keyboard backlight
To: Hijae Song <hijae99@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <179414038593.756183.14857246429459088217@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 8 Nov 2026 at 12:08, Hijae Song <hijae99@gmail.com> wrote:
>
> The AYANEO Flip KB has a built-in SiGma Micro USB keyboard (1c4f:007c)
> with two HID interfaces: a boot keyboard and a vendor-defined one that
> carries an 8-byte Feature Report (ID 0x41) controlling the RGB
> backlight. hid-generic binds both, and the backlight is not exposed to
> the OS.
>
> Add a driver that exposes the backlight as a multicolor LED class
> device, ayaneo:rgb:kbd_backlight. The report layout was determined by
> experiments on real hardware:
>
>   byte 1-3: blue, red, green
>   byte 4:   firmware effect select (1 = static; 2 and 3 select
>             rainbow and breathing, which are not used here)
>   byte 5:   0 = off, 1 = on
>   byte 6-7: constants 0x41, 0x5a
>
> There is no separate brightness field, so brightness is applied by
> scaling the color bytes. GetFeature does not reflect the current state
> and is not used.
>
> Turning the backlight off keeps sending the configured color with
> mode=off rather than all zeroes, so that the keyboard's own Fn+Space
> toggle keeps working afterwards. The LED is marked
> LED_RETAIN_AT_SHUTDOWN so unbinding the driver does not blank it.
>
> Both interfaces are bound to this driver so hid-generic stays away; the
> boot keyboard interface is started unchanged.
>
> Tested on an AYANEO Flip KB: color and brightness changes through sysfs
> and UPower, Fn+Space toggling, behavior after reboot, and a third-party
> LED client (HueSync).

Hi,
I do not have the bandwidth to review this driver, but I will leave
some broad strokes feedback.

The name of the driver cannot be -flip-kb. You need to make sure it is
generic enough to match most Ayaneo devices. There are 4 flip devices
if I recall. Adding a driver for a single one is a tough sell. Also
this does not control the joysticks LEDs, so naming it ayaneo flip kb
is not appropriate. It is a niche device line, they do not sell a lot
of units and the form factor is not what most users prefer.

If this is an actual keyboard product on the market and Ayaneo is
sourcing the part for their device (it seems so, SiGma Micro appears
to make keyboard ICs), look-up similar devices and kernel drivers. One
might exist already. If not, and provided that Ayaneo did not modify
the backlight protocol, rename the driver appropriately to sigma
something, move it to the appropriate location if there is one, such
as the led subsystem, and match other backlight driver conventions.

Provided the latter is the case and we can make a Sigma micro driver,
I will also try to review the driver, as it is more valuable than just
Ayaneo Flip devices

Best,
Antheas

> Signed-off-by: Hijae Song <hijae99@gmail.com>
> ---
>  drivers/hid/Kconfig              |  12 +++
>  drivers/hid/Makefile             |   1 +
>  drivers/hid/hid-ayaneo-flip-kb.c | 171 +++++++++++++++++++++++++++++++
>  drivers/hid/hid-ids.h            |   1 +
>  4 files changed, 185 insertions(+)
>  create mode 100644 drivers/hid/hid-ayaneo-flip-kb.c
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index aa7fa11a..bba11e4b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -205,6 +205,18 @@ config HID_AUREAL
>         help
>         Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
>
> +config HID_AYANEO_FLIP_KB
> +       tristate "AYANEO Flip KB keyboard backlight"
> +       depends on USB_HID
> +       depends on LEDS_CLASS_MULTICOLOR
> +       help
> +         Support for the RGB backlight of the AYANEO Flip KB's built-in
> +         keyboard. The backlight is exposed as a multicolor LED class
> +         device.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called hid-ayaneo-flip-kb.
> +
>  config HID_BELKIN
>         tristate "Belkin Flip KVM and Wireless keyboard"
>         help
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 48a863b2..4bac905c 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD) += hid-appletb-kbd.o
>  obj-$(CONFIG_HID_CREATIVE_SB0540)      += hid-creative-sb0540.o
>  obj-$(CONFIG_HID_ASUS)         += hid-asus.o
>  obj-$(CONFIG_HID_AUREAL)       += hid-aureal.o
> +obj-$(CONFIG_HID_AYANEO_FLIP_KB)       += hid-ayaneo-flip-kb.o
>  obj-$(CONFIG_HID_BELKIN)       += hid-belkin.o
>  obj-$(CONFIG_HID_BETOP_FF)     += hid-betopff.o
>  obj-$(CONFIG_HID_BIGBEN_FF)    += hid-bigbenff.o
> diff --git a/drivers/hid/hid-ayaneo-flip-kb.c b/drivers/hid/hid-ayaneo-flip-kb.c
> new file mode 100644
> index 00000000..8068b7d4
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo-flip-kb.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * HID driver for the AYANEO Flip KB's built-in keyboard backlight
> + *
> + * The keyboard enumerates as a SiGma Micro USB HID device with two
> + * interfaces: a plain boot keyboard and a vendor-defined one carrying a
> + * Feature Report (ID 0x41) that controls the RGB backlight. The layout
> + * of that report was determined by testing on real hardware:
> + *
> + *   byte 0: report ID (0x41)
> + *   byte 1: blue
> + *   byte 2: red
> + *   byte 3: green
> + *   byte 4: firmware effect select (0 = keep previous report, 1 = static
> + *           color, 2 = rainbow cycle, 3 = breathing, other tested values
> + *           behave like 1); this driver only ever asks for static color
> + *   byte 5: mode, 0 = off, 1 = on (other tested values behave like 1)
> + *   byte 6: fixed 0x41
> + *   byte 7: fixed 0x5a
> + *
> + * Copyright (c) 2026 Hijae Song
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/hid.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "hid-ids.h"
> +
> +#define FLIP_KB_REPORT_ID      0x41
> +#define FLIP_KB_REPORT_SIZE    8
> +#define FLIP_KB_MODE_OFF       0
> +#define FLIP_KB_MODE_STATIC    1
> +#define FLIP_KB_EFFECT_STATIC  1
> +
> +struct flip_kb {
> +       struct hid_device *hdev;
> +       struct led_classdev_mc mc_led;
> +       struct mc_subled subled[3];
> +};
> +
> +static int flip_kb_send(struct hid_device *hdev, u8 r, u8 g, u8 b, u8 mode)
> +{
> +       u8 *buf __free(kfree) = kzalloc(FLIP_KB_REPORT_SIZE, GFP_KERNEL);
> +       int ret;
> +
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       buf[0] = FLIP_KB_REPORT_ID;
> +       buf[1] = b;
> +       buf[2] = r;
> +       buf[3] = g;
> +       buf[4] = FLIP_KB_EFFECT_STATIC;
> +       buf[5] = mode;
> +       buf[6] = 0x41;
> +       buf[7] = 0x5a;
> +
> +       ret = hid_hw_raw_request(hdev, FLIP_KB_REPORT_ID, buf,
> +                                FLIP_KB_REPORT_SIZE, HID_FEATURE_REPORT,
> +                                HID_REQ_SET_REPORT);
> +       return ret < 0 ? ret : 0;
> +}
> +
> +static int flip_kb_brightness_set(struct led_classdev *led_cdev,
> +                                 enum led_brightness brightness)
> +{
> +       struct led_classdev_mc *mc_led = lcdev_to_mccdev(led_cdev);
> +       struct flip_kb *kb = container_of(mc_led, struct flip_kb, mc_led);
> +
> +       if (brightness) {
> +               led_mc_calc_color_components(mc_led, brightness);
> +               return flip_kb_send(kb->hdev, kb->subled[0].brightness,
> +                                   kb->subled[1].brightness, kb->subled[2].brightness,
> +                                   FLIP_KB_MODE_STATIC);
> +       }
> +
> +       /*
> +        * An all-zero color combined with mode=off makes the keyboard's
> +        * own Fn+Space toggle stop responding until a non-zero report is
> +        * sent again. mode=off already blanks the backlight regardless of
> +        * the color bytes, so send the configured intensities unscaled
> +        * instead of collapsing them to zero.
> +        */
> +       return flip_kb_send(kb->hdev, kb->subled[0].intensity,
> +                           kb->subled[1].intensity, kb->subled[2].intensity,
> +                           FLIP_KB_MODE_OFF);
> +}
> +
> +static int flip_kb_probe(struct hid_device *hdev, const struct hid_device_id *id)
> +{
> +       struct flip_kb *kb;
> +       int ret, i;
> +
> +       ret = hid_parse(hdev);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Both interfaces match this driver, which keeps hid-generic from
> +        * binding to them, so the boot keyboard interface must be started
> +        * normally and left alone.
> +        */
> +       if (!hid_validate_values(hdev, HID_FEATURE_REPORT, FLIP_KB_REPORT_ID,
> +                                0, 1))
> +               return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +
> +       kb = devm_kzalloc(&hdev->dev, sizeof(*kb), GFP_KERNEL);
> +       if (!kb)
> +               return -ENOMEM;
> +
> +       kb->hdev = hdev;
> +       hid_set_drvdata(hdev, kb);
> +
> +       kb->subled[0].color_index = LED_COLOR_ID_RED;
> +       kb->subled[1].color_index = LED_COLOR_ID_GREEN;
> +       kb->subled[2].color_index = LED_COLOR_ID_BLUE;
> +       for (i = 0; i < 3; i++)
> +               kb->subled[i].intensity = 255;
> +
> +       kb->mc_led.subled_info = kb->subled;
> +       kb->mc_led.num_colors = 3;
> +       kb->mc_led.led_cdev.name = "ayaneo:rgb:" LED_FUNCTION_KBD_BACKLIGHT;
> +       kb->mc_led.led_cdev.max_brightness = 255;
> +       /* Keep the backlight lit across driver unbind instead of blanking it. */
> +       kb->mc_led.led_cdev.flags = LED_RETAIN_AT_SHUTDOWN;
> +       kb->mc_led.led_cdev.brightness_set_blocking = flip_kb_brightness_set;
> +
> +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       if (ret)
> +               return ret;
> +
> +       ret = led_classdev_multicolor_register(&hdev->dev, &kb->mc_led);
> +       if (ret)
> +               hid_hw_stop(hdev);
> +
> +       return ret;
> +}
> +
> +static void flip_kb_remove(struct hid_device *hdev)
> +{
> +       struct flip_kb *kb = hid_get_drvdata(hdev);
> +
> +       /* Unregister the LED before the transport goes away. */
> +       if (kb)
> +               led_classdev_multicolor_unregister(&kb->mc_led);
> +
> +       hid_hw_stop(hdev);
> +}
> +
> +static const struct hid_device_id flip_kb_devices[] = {
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO,
> +                        USB_DEVICE_ID_SIGMA_MICRO_AYANEO_FLIP_KB) },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(hid, flip_kb_devices);
> +
> +static struct hid_driver flip_kb_driver = {
> +       .name = "ayaneo-flip-kb",
> +       .id_table = flip_kb_devices,
> +       .probe = flip_kb_probe,
> +       .remove = flip_kb_remove,
> +};
> +module_hid_driver(flip_kb_driver);
> +
> +MODULE_AUTHOR("Hijae Song <hijae99@gmail.com>");
> +MODULE_DESCRIPTION("HID driver for the AYANEO Flip KB keyboard backlight");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 341bf587..88302307 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -1309,6 +1309,7 @@
>  #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD     0x0002
>  #define USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE    0x0034
>  #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2    0x0059
> +#define USB_DEVICE_ID_SIGMA_MICRO_AYANEO_FLIP_KB       0x007c
>
>  #define USB_VENDOR_ID_SIGMATEL         0x066F
>  #define USB_DEVICE_ID_SIGMATEL_STMP3780        0x3780
> --
> 2.54.0 (Apple Git-157)
>
>

