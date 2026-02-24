Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5C3B52E2
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771956091; cv=none; b=h+gh14Oojp5KCXcLdAKOY8mTVKtqQbYOn5JKdPpz5hCrcm3nW823vqSmVik9OaxpF3TxyPh0OFbEZ9Ii28dWfwZrH7dgbbfjKuD10OHk0oAny/80ar+9iojdFPr5Xabc6+XnUJw/tYW+az+3gUJUv6IHQCgl+Wf6Kz/hxEXAw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771956091; c=relaxed/simple;
	bh=qhBEuRV6fs3rnNGrwM/wQryTh4ZQlq2azvONG6EdSXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXmLFTHd1uHUZ4a6XBcylgEz0p0Yx6Z48jhlxW+33bhpbCioIf8XtDUSL4K72w18ZCnZyDZA3T7k8HpKoeow5M/W+nt6mZVJVduXWhej/9H92RWxyCo28tuBXcD0R9v4YxK6AFYeIGNPuPtx9rbxtVAAiHDoTvw/GPyhVBpB9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=k77UkIdy; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="k77UkIdy"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 4527ABC3ED
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 20:01:26 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 3D31ABDC23
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 20:01:25 +0200 (EET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A486A200CA6
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 20:01:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1771956084;
	bh=nx8q+04J+6U8lQkyJp1U8/w7u+mvZriqm/9MMwTSkGQ=;
	h=Received:From:Subject:To;
	b=k77UkIdykSv8stNWlogTfvI4M9oEcqE4jKurmJXCo2NWzH+H+rDOyB5YcnQ29ywOc
	 y59KwKj8Dt4Wibrro78E1Y1Qw18oqXmVCtqbDE2gEh+ExMgmh2RoNSntfAJ1S31OZW
	 JlHpYU5DFRFi1LERYjuTZUOhNdZ27MxbV8+E1ii/AtbESGkCKMOiIIVMablv+nsapN
	 CTZPbvxqe7u7lz0yJyUOVNnhE1OQwmTZW36abJENY74m4tE2pksSKcdZpSdFGoaq/o
	 Vk7V+/MKrmdejgQ9xOedrA4gLWBS3o90xVPiT9fJCVyWQ96EADmhBKbIzsukwKZxCP
	 ghcsnziIbJ/zg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.46) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f46.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so3545651a91.3
        for <linux-input@vger.kernel.org>;
 Tue, 24 Feb 2026 10:01:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVr3KobIKLHkSCSCR0GjGZUPoQZH+lzzrWR8Swg9miUNYUVCCmJMEPHqmMVoshMu4ZRiNrfR/WdDtmXJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYtZ26XYoLgDPsFXAdS3d6ewksCMcn1bOw+CkHD0kYilIxjAa
	pFiLCVN5uumalUd/4xaycqbdDGJbLHWCgL5rioKACqiq+Q6jYDgvYko9t+sDVe34c7aGGut7aBO
	uaPC6PIIAFvsqvgWyUwESgKaRPdZTNe4=
X-Received: by 2002:a17:90a:e706:b0:356:83b2:539b with SMTP id
 98e67ed59e1d1-358ae8e5e45mr11678419a91.32.1771956083033; Tue, 24 Feb 2026
 10:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220165047.2844568-1-appsforartists@google.com>
In-Reply-To: <20260220165047.2844568-1-appsforartists@google.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 24 Feb 2026 19:01:10 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHDGc=2hyUSQA7Awoa-3Gj=2BQ8JPqz0vEUPOpNiqY+RQ@mail.gmail.com>
X-Gm-Features: AaiRm51uBRKgFQElwl4zKFC9XbkVxOqfDeKNss1t_ZNx8VbUQ85fL1EicyL4k_k
Message-ID: 
 <CAGwozwHDGc=2hyUSQA7Awoa-3Gj=2BQ8JPqz0vEUPOpNiqY+RQ@mail.gmail.com>
Subject: Re: [PATCH] HID: sony: add support for Rock Band 2 instruments
To: appsforartists@google.com
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sanjay Govind <sanjay.govind9@gmail.com>,
	Rosalie Wanders <rosalie@mailbox.org>, Vicki Pfau <vi@endrift.com>,
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177195608487.2291383.1067401391159292542@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Hi Brenton,

Let me give you a quirk review. Nice to hear from you again.

On Fri, 20 Feb 2026 at 17:50, <appsforartists@google.com> wrote:
>
> From: Brenton Simpson <appsforartists@google.com>
>
> Rock Band 2 for the Nintendo Wii and for the Sony PlayStation 3 use the
> same mapping as later games:
>
>     Green:              SOUTH   (A)
>     Red:                EAST    (B)
>     Yellow:             NORTH   (Y)
>     Blue:               WEST    (X)
>     Orange/pedal:       TL      (L1)
>     Solo flag:          TL2     (L2)
>     Tilt:               TR      (R1)
>     Pad flag:           THUMBL  (L3)
>     Instrument button:  MODE    (Steam/Xbox)
>     Whammy bar:         ABS_Z   (Axis 4)
>     Effects switch:     Z       (Axis 5)
>
> As documented at https://github.com/TheNathannator/PlasticBand/blob/main/Docs/.

The checkpatch hits this line. Remove this line and replace with see below.

>
> The guitar and drums both use the same mapping.  Tested using the Wii
> versions of the instruments.
>

A link tag.

Link: https://github.com/TheNathannator/PlasticBand/blob/main/Docs/
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> ---
>  drivers/hid/hid-ids.h  |  8 +++++++-
>  drivers/hid/hid-sony.c | 45 +++++++++++++++++++++++++++++-------------
>  2 files changed, 38 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3e299a30dcde..644d3c4df144 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -664,6 +664,10 @@
>  #define USB_DEVICE_ID_UGCI_FLYING      0x0020
>  #define USB_DEVICE_ID_UGCI_FIGHTING    0x0030
>
> +#define USB_VENDOR_ID_HARMONIX         0x1bad
> +#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE   0x3010
> +#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE    0x3110
> +
>  #define USB_VENDOR_ID_HP               0x03f0
>  #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A           0x464a
>  #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A  0x0a4a
> @@ -1299,7 +1303,9 @@
>
>  #define USB_VENDOR_ID_SONY_RHYTHM      0x12ba
>  #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE       0x074b
> -#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE   0x0100
> +#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE                0x0100
> +#define USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE       0x0200
> +#define USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE                0x0210

Indentation on first glance seems incorrect. But this file seems to
follow the rule of vendor gets one tab, and others are aligned. And
your additions match that.

But other than that, it is true that it is a mess and everyone does
what they do.

>  #define USB_VENDOR_ID_SINO_LITE                        0x1345
>  #define USB_DEVICE_ID_SINO_LITE_CONTROLLER     0x3008
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index a89af14e4acc..f6975f6ae882 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -62,9 +62,10 @@
>  #define GH_GUITAR_CONTROLLER      BIT(14)
>  #define GHL_GUITAR_PS3WIIU        BIT(15)
>  #define GHL_GUITAR_PS4            BIT(16)
> -#define RB4_GUITAR_PS4_USB        BIT(17)
> -#define RB4_GUITAR_PS4_BT         BIT(18)
> -#define RB4_GUITAR_PS5            BIT(19)
> +#define RB2_INSTRUMENT            BIT(17)
> +#define RB4_GUITAR_PS4_USB        BIT(18)
> +#define RB4_GUITAR_PS4_BT         BIT(19)
> +#define RB4_GUITAR_PS5            BIT(20)

I thought these were not formatted correctly. But they are. You added
RB2_INSTRUMENT above. I would suggest pulling it down and making it
BIT(20) instead. It minimizes the diff.

>
>  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
>  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
> @@ -422,12 +423,12 @@ static const unsigned int sixaxis_keymap[] = {
>         [0x11] = BTN_MODE, /* PS */
>  };
>
> -static const unsigned int rb4_absmap[] = {
> +static const unsigned int rb_absmap[] = {
>         [0x30] = ABS_X,
>         [0x31] = ABS_Y,
>  };
>
> -static const unsigned int rb4_keymap[] = {
> +static const unsigned int rb_keymap[] = {
>         [0x1] = BTN_WEST, /* Square */
>         [0x2] = BTN_SOUTH, /* Cross */
>         [0x3] = BTN_EAST, /* Circle */
> @@ -625,17 +626,17 @@ static int gh_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
>         return 0;
>  }
>
> -static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
> +static int rb_instrument_mapping(struct hid_device *hdev, struct hid_input *hi,
>                           struct hid_field *field, struct hid_usage *usage,
>                           unsigned long **bit, int *max)
>  {
>         if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
>                 unsigned int key = usage->hid & HID_USAGE;
>
> -               if (key >= ARRAY_SIZE(rb4_keymap))
> +               if (key >= ARRAY_SIZE(rb_keymap))
>                         return 0;
>
> -               key = rb4_keymap[key];
> +               key = rb_keymap[key];
>                 hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
>                 return 1;
>         } else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
> @@ -645,10 +646,10 @@ static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_input *hi,
>                 if (usage->hid == HID_GD_HATSWITCH)
>                         return 0;
>
> -               if (abs >= ARRAY_SIZE(rb4_absmap))
> +               if (abs >= ARRAY_SIZE(rb_absmap))
>                         return 0;
>
> -               abs = rb4_absmap[abs];
> +               abs = rb_absmap[abs];
>                 hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
>                 return 1;
>         }
> @@ -1101,11 +1102,14 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
>         if (sc->quirks & GH_GUITAR_CONTROLLER)
>                 return gh_guitar_mapping(hdev, hi, field, usage, bit, max);
>
> +       if (sc->quirks & RB2_INSTRUMENT)
> +               return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
> +
>         if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
> -               return rb4_guitar_mapping(hdev, hi, field, usage, bit, max);
> +               return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
>
>         if (sc->quirks & RB4_GUITAR_PS5)
> -               return rb4_guitar_mapping(hdev, hi, field, usage, bit, max);
> +               return rb_instrument_mapping(hdev, hi, field, usage, bit, max);
>
>         /* Let hid-core decide for the others */
>         return 0;
> @@ -2369,12 +2373,25 @@ static const struct hid_device_id sony_devices[] = {
>         /* Guitar Hero PC Guitar Dongle */
>         { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_GUITAR_DONGLE),
>                 .driver_data = GH_GUITAR_CONTROLLER },
> -       /* Guitar Hero PS3 World Tour Guitar Dongle */
> -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE),
> +       /* Guitar Hero World Tour PS3 Guitar Dongle */
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE),
>                 .driver_data = GH_GUITAR_CONTROLLER },
>         /* Guitar Hero Live PS4 guitar dongles */
>         { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE_PS4_GHLIVE_DONGLE),
>                 .driver_data = GHL_GUITAR_PS4 | GH_GUITAR_CONTROLLER },
> +       /* Rock Band 2 instruments
> +        * Nintendo Wii instruments are included in `hid-sony` because `hid-nintendo`
> +        * is for the newer Nintendo Switch, and the Wii instruments use the same
> +        * protocol as their Sony PlayStation 3 cousins.
> +        */

I would simplify it to "Rock Band 2 Instruments for Wii U. They use
the hid-sony protocol.". Readers do not need more context.

Other than that, I would drop all the renames from your patch. They
triple the diff and just make it harder to merge. Without those, the
patch is essentially the hunk below, the new PIDs, and the quirk. The
justification of the quirk is that you do not want your code to hit
rb4_ps4_guitar_parse_report(sc, rd, size); (?)

This patch is very reasonable to merge as it makes no code changes
after you clean it up a bit.

As for why the buttons are jumbled, this is standard HID gamepad
handling. You are not supposed to read them directly, but instead use
something like [1] or PR to [2]. If the gamepad does not have
vibration, there is no functionality loss either. But... this patch is
also very welcome.

Best,
Antheas

[1] https://github.com/mdqinc/SDL_GameControllerDB
[2] https://github.com/libsdl-org/SDL

> +       { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE),
> +               .driver_data = RB2_INSTRUMENT },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE),
> +               .driver_data = RB2_INSTRUMENT },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE),
> +               .driver_data = RB2_INSTRUMENT },
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE),
> +               .driver_data = RB2_INSTRUMENT },
>         /* Rock Band 4 PS4 guitars */
>         { HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMASTER),
>                 .driver_data = RB4_GUITAR_PS4_USB },
> --
> 2.53.0.414.gf7e9f6c205-goog
>
>

