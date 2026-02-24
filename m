Received: from relay14.grserver.gr (relay14.grserver.gr [157.180.73.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59E23ACA59
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.180.73.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960796; cv=none; b=uJ53AEuh4BXVev1xbD9PMgkDm6dxEnoaL+SSqv+07qJmBf8fBWy/joLp58J7EICun22ksVshCi9BjpPkmo8aC7FcA+Zg+hMBuzsdyhPPSBl+f1tebVEEG8OyAArYDlNiE84UGSOrao7j9G4Fm2ZfxHZZ/7Kf9wsQ8SWpJb9pmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960796; c=relaxed/simple;
	bh=Zcn0OCKmC3cpds65VwOTF7k4o+G9sCFHWQqtMaL3IAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjoonSzLvJJvOMmc26wmggF9F8viRE4mHJsTG+mmPNiLXczvKjfCtihnMEPgJdglutYRXLl6p4Q0VuGTWX/6Dvbe+xz71542nSAoi/bJIiHVDZ1+qht4XBKdcKQybU+B3fJaEWrrFQpDYw2+r+U2+ZcMtKstU0u4hIpue1pUUuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ecpQxFpo; arc=none smtp.client-ip=157.180.73.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ecpQxFpo"
Received: from relay14 (localhost [127.0.0.1])
	by relay14.grserver.gr (Proxmox) with ESMTP id 6B125409A2
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 19:19:53 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay14.grserver.gr (Proxmox) with ESMTPS id 288AB40A56
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 19:19:52 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 16873200C67
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 21:19:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1771960791;
	bh=mpghqyf8EspO5WSfSwr3BYcKdN7AmaiPnq+O5y4erLo=;
	h=Received:From:Subject:To;
	b=ecpQxFpoisC8KvO1VQB+2xrlWhgzo2/vKIcZn6xcZKbTXXa8XlLv4SWyc+ayKV3jj
	 TTRNPaX76xvJJrwjHyOrjBLsgqE3ixBxhMwoEOIfb4yjwQ8oTZeKLp9RZuPA9w/jpy
	 Ya6Rpaj0uwf9su5n/Wc8ycV3Qv5WtQjTQE+UtbNhNA/2HX+wLrJ6oWwBX9EGUxEJF9
	 4PffPZ1NVFe6RviikPkS7nomkn7MnYbaGP40LkEBPbNP8DABidw9Ga/i3L7kCSEm1Z
	 5lPUkNtOa5GnWJRpMYWR3rpig+QKkmVZt6SNJkZ3A0II/MZaHC9XSnLInVTW1sCgyK
	 mKRJuyTQAKFjw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-c70b4a0cda5so55847a12.1
        for <linux-input@vger.kernel.org>;
 Tue, 24 Feb 2026 11:19:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW+PsG+zoQP5VucdwXB+QYpoSIt90Y6Pw7BXobLkwQ3YGPKB139nLpdp/N3wjeOZ57a8YTFOLkAkJ/A/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb+W48WwjIO6sMW27tm4e/SFgEGxREiKl+0HkSvsaLaRVx1QFI
	/F4H9cA49r+Xcol0M4rhDtGjhlLaSLt9+WCy2UP7HxB7hMncsjVCuwj4/SFJoKMI1+4+DVkkUsx
	aJpdGFm3xdNBtkMMY/uIovVxVLn2tOao=
X-Received: by 2002:a17:90b:1dce:b0:354:c3a4:3a6 with SMTP id
 98e67ed59e1d1-359037f361amr759632a91.3.1771960789944; Tue, 24 Feb 2026
 11:19:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220165047.2844568-1-appsforartists@google.com>
 <CAGwozwHDGc=2hyUSQA7Awoa-3Gj=2BQ8JPqz0vEUPOpNiqY+RQ@mail.gmail.com>
 <CAAL3-=-0e6PqNyR64oCrBcA+kGwAfBVMoFc9zOpUVMoeXo_Z-A@mail.gmail.com>
 <CAGwozwE+zUc9W00o89+CTpF3-XDmp6U+sNYBspBEcT6-A0Hr5g@mail.gmail.com>
In-Reply-To: 
 <CAGwozwE+zUc9W00o89+CTpF3-XDmp6U+sNYBspBEcT6-A0Hr5g@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 24 Feb 2026 20:19:38 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEofcErbh+0fD108Hb-Amhj1B7ek14aVgWBV08N+b0zfQ@mail.gmail.com>
X-Gm-Features: AaiRm51eDhh6v3g96t-OTuA8A-OQpBDGyZMVRcR2_2Xdb0HL7kTLB2_o4a8t6Gs
Message-ID: 
 <CAGwozwEofcErbh+0fD108Hb-Amhj1B7ek14aVgWBV08N+b0zfQ@mail.gmail.com>
Subject: Re: [PATCH] HID: sony: add support for Rock Band 2 instruments
To: Brenton Simpson <appsforartists@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sanjay Govind <sanjay.govind9@gmail.com>,
	Rosalie Wanders <rosalie@mailbox.org>, Vicki Pfau <vi@endrift.com>,
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177196079155.2596194.3034218196901876661@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 24 Feb 2026 at 20:19, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Tue, 24 Feb 2026 at 19:48, Brenton Simpson <appsforartists@google.com>=
 wrote:
> >
> > Thanks Antheas!
> >
> > Sanjay, Rosalie, and I got in touch off-thread.  We'll be submitting a
> > patch that handles Rock Band instruments more holistically (not just
> > the Wii ones) shortly.
> >
> > Preview here:
> > https://github.com/Rosalie241/hid-sony/tree/rb2-instruments
>
> I reviewed that. If you want to merge quickly, I'd suggest less
> renames though. You are making changes there that are hard to review.
>
> Renames are typically a separate patch. If you truly believe in them
> and want to battle it out, that's where they'll go.
>
> I'd suggest you apply my suggestions to your patch anyhow and keep it
> separate. It is self contained and can merge quickly.
>
> I will leave it up to you if you want to have it as 1st patch of a
> series that Rosalie submits, or submit it on your own, get it merged
> to HID, then send the other patches on top of that remote.
>
> My recommendation would be the former.

*latter

>
> Best,
> Antheas
>
> > On Tue, Feb 24, 2026 at 1:01=E2=80=AFPM Antheas Kapenekakis <lkml@anthe=
as.dev> wrote:
> > >
> > > Hi Brenton,
> > >
> > > Let me give you a quirk review. Nice to hear from you again.
> > >
> > > On Fri, 20 Feb 2026 at 17:50, <appsforartists@google.com> wrote:
> > > >
> > > > From: Brenton Simpson <appsforartists@google.com>
> > > >
> > > > Rock Band 2 for the Nintendo Wii and for the Sony PlayStation 3 use=
 the
> > > > same mapping as later games:
> > > >
> > > >     Green:              SOUTH   (A)
> > > >     Red:                EAST    (B)
> > > >     Yellow:             NORTH   (Y)
> > > >     Blue:               WEST    (X)
> > > >     Orange/pedal:       TL      (L1)
> > > >     Solo flag:          TL2     (L2)
> > > >     Tilt:               TR      (R1)
> > > >     Pad flag:           THUMBL  (L3)
> > > >     Instrument button:  MODE    (Steam/Xbox)
> > > >     Whammy bar:         ABS_Z   (Axis 4)
> > > >     Effects switch:     Z       (Axis 5)
> > > >
> > > > As documented at https://github.com/TheNathannator/PlasticBand/blob=
/main/Docs/.
> > >
> > > The checkpatch hits this line. Remove this line and replace with see =
below.
> > >
> > > >
> > > > The guitar and drums both use the same mapping.  Tested using the W=
ii
> > > > versions of the instruments.
> > > >
> > >
> > > A link tag.
> > >
> > > Link: https://github.com/TheNathannator/PlasticBand/blob/main/Docs/
> > > > Signed-off-by: Brenton Simpson <appsforartists@google.com>
> > > > ---
> > > >  drivers/hid/hid-ids.h  |  8 +++++++-
> > > >  drivers/hid/hid-sony.c | 45 +++++++++++++++++++++++++++++---------=
----
> > > >  2 files changed, 38 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index 3e299a30dcde..644d3c4df144 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -664,6 +664,10 @@
> > > >  #define USB_DEVICE_ID_UGCI_FLYING      0x0020
> > > >  #define USB_DEVICE_ID_UGCI_FIGHTING    0x0030
> > > >
> > > > +#define USB_VENDOR_ID_HARMONIX         0x1bad
> > > > +#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE   0x3010
> > > > +#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE    0x3110
> > > > +
> > > >  #define USB_VENDOR_ID_HP               0x03f0
> > > >  #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A           0x4=
64a
> > > >  #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A  0x0=
a4a
> > > > @@ -1299,7 +1303,9 @@
> > > >
> > > >  #define USB_VENDOR_ID_SONY_RHYTHM      0x12ba
> > > >  #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE       0x074b
> > > > -#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE   0x0100
> > > > +#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE                0x0=
100
> > > > +#define USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE       0x0200
> > > > +#define USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE                0x0=
210
> > >
> > > Indentation on first glance seems incorrect. But this file seems to
> > > follow the rule of vendor gets one tab, and others are aligned. And
> > > your additions match that.
> > >
> > > But other than that, it is true that it is a mess and everyone does
> > > what they do.
> > >
> > > >  #define USB_VENDOR_ID_SINO_LITE                        0x1345
> > > >  #define USB_DEVICE_ID_SINO_LITE_CONTROLLER     0x3008
> > > > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > > > index a89af14e4acc..f6975f6ae882 100644
> > > > --- a/drivers/hid/hid-sony.c
> > > > +++ b/drivers/hid/hid-sony.c
> > > > @@ -62,9 +62,10 @@
> > > >  #define GH_GUITAR_CONTROLLER      BIT(14)
> > > >  #define GHL_GUITAR_PS3WIIU        BIT(15)
> > > >  #define GHL_GUITAR_PS4            BIT(16)
> > > > -#define RB4_GUITAR_PS4_USB        BIT(17)
> > > > -#define RB4_GUITAR_PS4_BT         BIT(18)
> > > > -#define RB4_GUITAR_PS5            BIT(19)
> > > > +#define RB2_INSTRUMENT            BIT(17)
> > > > +#define RB4_GUITAR_PS4_USB        BIT(18)
> > > > +#define RB4_GUITAR_PS4_BT         BIT(19)
> > > > +#define RB4_GUITAR_PS5            BIT(20)
> > >
> > > I thought these were not formatted correctly. But they are. You added
> > > RB2_INSTRUMENT above. I would suggest pulling it down and making it
> > > BIT(20) instead. It minimizes the diff.
> > >
> > > >
> > > >  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTR=
OLLER_BT)
> > > >  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLL=
ER_BT)
> > > > @@ -422,12 +423,12 @@ static const unsigned int sixaxis_keymap[] =
=3D {
> > > >         [0x11] =3D BTN_MODE, /* PS */
> > > >  };
> > > >
> > > > -static const unsigned int rb4_absmap[] =3D {
> > > > +static const unsigned int rb_absmap[] =3D {
> > > >         [0x30] =3D ABS_X,
> > > >         [0x31] =3D ABS_Y,
> > > >  };
> > > >
> > > > -static const unsigned int rb4_keymap[] =3D {
> > > > +static const unsigned int rb_keymap[] =3D {
> > > >         [0x1] =3D BTN_WEST, /* Square */
> > > >         [0x2] =3D BTN_SOUTH, /* Cross */
> > > >         [0x3] =3D BTN_EAST, /* Circle */
> > > > @@ -625,17 +626,17 @@ static int gh_guitar_mapping(struct hid_devic=
e *hdev, struct hid_input *hi,
> > > >         return 0;
> > > >  }
> > > >
> > > > -static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_=
input *hi,
> > > > +static int rb_instrument_mapping(struct hid_device *hdev, struct h=
id_input *hi,
> > > >                           struct hid_field *field, struct hid_usage=
 *usage,
> > > >                           unsigned long **bit, int *max)
> > > >  {
> > > >         if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_BUTTON) {
> > > >                 unsigned int key =3D usage->hid & HID_USAGE;
> > > >
> > > > -               if (key >=3D ARRAY_SIZE(rb4_keymap))
> > > > +               if (key >=3D ARRAY_SIZE(rb_keymap))
> > > >                         return 0;
> > > >
> > > > -               key =3D rb4_keymap[key];
> > > > +               key =3D rb_keymap[key];
> > > >                 hid_map_usage_clear(hi, usage, bit, max, EV_KEY, ke=
y);
> > > >                 return 1;
> > > >         } else if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_GEND=
ESK) {
> > > > @@ -645,10 +646,10 @@ static int rb4_guitar_mapping(struct hid_devi=
ce *hdev, struct hid_input *hi,
> > > >                 if (usage->hid =3D=3D HID_GD_HATSWITCH)
> > > >                         return 0;
> > > >
> > > > -               if (abs >=3D ARRAY_SIZE(rb4_absmap))
> > > > +               if (abs >=3D ARRAY_SIZE(rb_absmap))
> > > >                         return 0;
> > > >
> > > > -               abs =3D rb4_absmap[abs];
> > > > +               abs =3D rb_absmap[abs];
> > > >                 hid_map_usage_clear(hi, usage, bit, max, EV_ABS, ab=
s);
> > > >                 return 1;
> > > >         }
> > > > @@ -1101,11 +1102,14 @@ static int sony_mapping(struct hid_device *=
hdev, struct hid_input *hi,
> > > >         if (sc->quirks & GH_GUITAR_CONTROLLER)
> > > >                 return gh_guitar_mapping(hdev, hi, field, usage, bi=
t, max);
> > > >
> > > > +       if (sc->quirks & RB2_INSTRUMENT)
> > > > +               return rb_instrument_mapping(hdev, hi, field, usage=
, bit, max);
> > > > +
> > > >         if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
> > > > -               return rb4_guitar_mapping(hdev, hi, field, usage, b=
it, max);
> > > > +               return rb_instrument_mapping(hdev, hi, field, usage=
, bit, max);
> > > >
> > > >         if (sc->quirks & RB4_GUITAR_PS5)
> > > > -               return rb4_guitar_mapping(hdev, hi, field, usage, b=
it, max);
> > > > +               return rb_instrument_mapping(hdev, hi, field, usage=
, bit, max);
> > > >
> > > >         /* Let hid-core decide for the others */
> > > >         return 0;
> > > > @@ -2369,12 +2373,25 @@ static const struct hid_device_id sony_devi=
ces[] =3D {
> > > >         /* Guitar Hero PC Guitar Dongle */
> > > >         { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_RED=
OCTANE_GUITAR_DONGLE),
> > > >                 .driver_data =3D GH_GUITAR_CONTROLLER },
> > > > -       /* Guitar Hero PS3 World Tour Guitar Dongle */
> > > > -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_S=
ONY_PS3_GUITAR_DONGLE),
> > > > +       /* Guitar Hero World Tour PS3 Guitar Dongle */
> > > > +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_S=
ONY_PS3_GH_GUITAR_DONGLE),
> > > >                 .driver_data =3D GH_GUITAR_CONTROLLER },
> > > >         /* Guitar Hero Live PS4 guitar dongles */
> > > >         { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_RED=
OCTANE_PS4_GHLIVE_DONGLE),
> > > >                 .driver_data =3D GHL_GUITAR_PS4 | GH_GUITAR_CONTROL=
LER },
> > > > +       /* Rock Band 2 instruments
> > > > +        * Nintendo Wii instruments are included in `hid-sony` beca=
use `hid-nintendo`
> > > > +        * is for the newer Nintendo Switch, and the Wii instrument=
s use the same
> > > > +        * protocol as their Sony PlayStation 3 cousins.
> > > > +        */
> > >
> > > I would simplify it to "Rock Band 2 Instruments for Wii U. They use
> > > the hid-sony protocol.". Readers do not need more context.
> > >
> > > Other than that, I would drop all the renames from your patch. They
> > > triple the diff and just make it harder to merge. Without those, the
> > > patch is essentially the hunk below, the new PIDs, and the quirk. The
> > > justification of the quirk is that you do not want your code to hit
> > > rb4_ps4_guitar_parse_report(sc, rd, size); (?)
> > >
> > > This patch is very reasonable to merge as it makes no code changes
> > > after you clean it up a bit.
> > >
> > > As for why the buttons are jumbled, this is standard HID gamepad
> > > handling. You are not supposed to read them directly, but instead use
> > > something like [1] or PR to [2]. If the gamepad does not have
> > > vibration, there is no functionality loss either. But... this patch i=
s
> > > also very welcome.
> > >
> > > Best,
> > > Antheas
> > >
> > > [1] https://github.com/mdqinc/SDL_GameControllerDB
> > > [2] https://github.com/libsdl-org/SDL
> > >
> > > > +       { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARM=
ONIX_WII_RB2_GUITAR_DONGLE),
> > > > +               .driver_data =3D RB2_INSTRUMENT },
> > > > +       { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARM=
ONIX_WII_RB2_DRUMS_DONGLE),
> > > > +               .driver_data =3D RB2_INSTRUMENT },
> > > > +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_S=
ONY_PS3_RB2_GUITAR_DONGLE),
> > > > +               .driver_data =3D RB2_INSTRUMENT },
> > > > +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_S=
ONY_PS3_RB2_DRUMS_DONGLE),
> > > > +               .driver_data =3D RB2_INSTRUMENT },
> > > >         /* Rock Band 4 PS4 guitars */
> > > >         { HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_R=
IFFMASTER),
> > > >                 .driver_data =3D RB4_GUITAR_PS4_USB },
> > > > --
> > > > 2.53.0.414.gf7e9f6c205-goog
> > > >
> > > >
> > >
> >

