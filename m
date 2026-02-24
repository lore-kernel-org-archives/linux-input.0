Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB1D1DB95E
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958893; cv=pass; b=sRWoCQFD1UYIY+a8bnEDaU6eBIBfI8T7WkGCPf0sBB3oaASzJOw9FQL47Q0LZawjZ1fEiM7Seol7/gmkfWV7QQrZScfCohS1/KqpVrOgqqX0mSc6XIIXrCXScDA1/wmkZ3W0Gvma6LXt8P8lVcwn5Gb44iqdbkzrlM5H0BhvnZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958893; c=relaxed/simple;
	bh=X5Y12kUV38pG7nAZY9K4Cb2NClR1fCEEj+Ro59li9z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkW6WNmQL7dG+VoRPcff9HMQfsn6E4xZQVHnw88r1L1wSJWKPilxocOR610sLxF9JI/K5MfgT2FxfCpcet120n2jTg/dFASJszY8hpv00r2ENeOQara7WD3yfT3bD9HrrekcOcMlJxIyHQd3/FMOPpWiXZ67siTkbbvW3fZNeFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Prg/M4cx; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Prg/M4cx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43988056dc3so820153f8f.3
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 10:48:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771958889; cv=none;
        d=google.com; s=arc-20240605;
        b=UluL04sy3AnJOTE2BRNQDKn0YqwAamOgIi4GnmP64sJj1EaeU0/JQPHJswJ5uus++g
         kjfzIpb03hhlk4vhl7KrUVhwxpCJkhj5G3QAKru90C13MeybcYqTMTCzmUVlYZk5fuVG
         DBJoJuioH+TTBNGMVUeiKyTlheFSCDTqzl7igJZiaw/sMHiJZSGXK7MQmpaIW+pKTg6i
         2GsH7Goi9SHAzpIZaUWsw8l7YT8IPuuqroqGm4QSGLZQP/TwcdrlJCqQJcn6e9Yl53we
         jwz7UVJ9B9Ltn0XWRjDMKTKHiyagGBvt6xj+KG2Yz7u2tBj9todnpsjZdei8OVGpjuQ3
         FxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WURExyt/CylXCLUNGoLyAOIYKhPAOah+b84XuuWyhB8=;
        fh=iplrzezZ8X2lmt9sb+y2l3c6P6uT5TMa9tskJcJWEQs=;
        b=k5taMpgdWhjIrLZf5EPxZEStC5YukyOwqM4asLkPE4unu2Gi9FOZV2x+W9gpAR6P1q
         qLiCqNE0uR0sIcXbecb9bUwAzouHAXhta7Opj9Gr5bj8uMSnUh10qMwaiSh99mm2h0IL
         5Y3MvIRiALPtqXo0UKPbQOE95VaDxhASZIaLBuDelrZTL7kEWjNdkng0CCsqwa2p1zud
         YFA+YjSddNuOY3fVLSaYWVohEI/cn81Z6wNkBZEkA4fu0ynR7MIciSILtEJYFboG/w4G
         3frjIezYIJ0S2I3v3rhlTFOjTvDtPioizsX/r4fQj4J/l17RTgiNAH2R0CPQ6WULka5e
         O1Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771958889; x=1772563689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WURExyt/CylXCLUNGoLyAOIYKhPAOah+b84XuuWyhB8=;
        b=Prg/M4cxf56stlqqYANbyIP949Wimtd/mQcC6EmFB2XVHOBTGhfryL5f6mNtNAZcOL
         XFJ3sHk6mZ22JzhJjTCiNoUt43EecVJfave28mxJoST220oHLqlQM5NpRcZyglzWfcxy
         cHMgZ+MI1TChH5d1Ik+epKFr8UaJklVfm5tyOh5Fdsbuu+NpZvH74v+QivOKzBAjvtCi
         vVPYb+RF9Uh17jtZ6B9nnqlyWeKz4vX+DtZVkNcfyg7YztQoD/1WAwIVH1giPyYrHI1H
         sYtDWIM/O57L95tNS+WWcsW3do4LNlDXRp0GB7+DoeKgg2rX/KGptoSIqwhJnCYl86yI
         SWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771958889; x=1772563689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WURExyt/CylXCLUNGoLyAOIYKhPAOah+b84XuuWyhB8=;
        b=ewT/j9JsWiXWKtszShWnjLEiOM3jXkv3kipKZ7rQCg5zquMETl8n+dHwgA07eTxSBK
         8EsOzMU1K0FIURe6aDWhGElYlGjd4RgMD3PnYpnbag8yexVHY+wZLTp10OoJ0ZjuDo7L
         Mb+MFzdPvP0XbFDaWRAczW7EY3E8Zy+wdERvnxLcZeECLz0iurJxkWppcTENoeFRN4Bf
         cxkBz3aweV3Bl+cnvVkU4QvohkSdXStXIEhii7ri8SUKA2lFC9xsyc4KnchpNtghEDXY
         /J5+wqcRQzMKQ2Y5YrqKW66ONS6WtwlWoHxWsG35rGYF4XkVchSRhKELxKxGm0SP02PU
         t+ig==
X-Forwarded-Encrypted: i=1; AJvYcCWa3ofk+eXXWWf6yH1HplwTo/8ktk/EDs7RZQlnp/eTkbmi8g17JFnCJ4fL47o+gqm+IZkJnzTxI+xSjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp/Lm1h6aXQsb22kPYd7v43a2lEFlDxVi6kTNZ5MU9kbyO9gDz
	18/+vqMuzY3BBpLg2Kukq2Vvft5D+u6z1R6A1g5FZyqiHpXxSt5ksHMm+PQyLTLBYDw10AbBCtE
	eoDeVr3QQIJp0Q6j2I94Kn4CcM5FmYF9sQ46UaOXi
X-Gm-Gg: ATEYQzx2NwXJGBP7HESXNv2KJT8/Vdq9YsqEaGLtP2hZDBguXdtVAHkVzXwZh+wFfTe
	MK7WfyNZ5senK7TBU7q5WFDR4tq4vevUL3GLloO/NJjca9YB56y75685I+hTYeQBhtTXJv37Tov
	Yuo49F2eiK1Equb3CZtC9ATpBd4h7udJ8AEwOl7NFkUoDCMaBXD8meTRibDRK/gbmp9j1/j42Ro
	rmyrAD+ISl02Fw3voj4HsYo/fgWJzOWK0V0/WApobMe2MhmXV+cwy0MALf3kD/nHv3Hm/fvpu1r
	RdVDIjyar+CqLW6lcv3yi+TM7kBzxhHT6s4bL1Dq+R0XzKQ=
X-Received: by 2002:a5d:5f53:0:b0:430:f40f:61ba with SMTP id
 ffacd0b85a97d-4396f181ed7mr25285160f8f.41.1771958888625; Tue, 24 Feb 2026
 10:48:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220165047.2844568-1-appsforartists@google.com> <CAGwozwHDGc=2hyUSQA7Awoa-3Gj=2BQ8JPqz0vEUPOpNiqY+RQ@mail.gmail.com>
In-Reply-To: <CAGwozwHDGc=2hyUSQA7Awoa-3Gj=2BQ8JPqz0vEUPOpNiqY+RQ@mail.gmail.com>
From: Brenton Simpson <appsforartists@google.com>
Date: Tue, 24 Feb 2026 13:47:55 -0500
X-Gm-Features: AaiRm50GQ9FB8BHb-7-XQOqW1TiunW2cNrSFU5rM3chKk94CYX-PlA8SUDwU2M4
Message-ID: <CAAL3-=-0e6PqNyR64oCrBcA+kGwAfBVMoFc9zOpUVMoeXo_Z-A@mail.gmail.com>
Subject: Re: [PATCH] HID: sony: add support for Rock Band 2 instruments
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sanjay Govind <sanjay.govind9@gmail.com>, 
	Rosalie Wanders <rosalie@mailbox.org>, Vicki Pfau <vi@endrift.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Antheas!

Sanjay, Rosalie, and I got in touch off-thread.  We'll be submitting a
patch that handles Rock Band instruments more holistically (not just
the Wii ones) shortly.

Preview here:
https://github.com/Rosalie241/hid-sony/tree/rb2-instruments

On Tue, Feb 24, 2026 at 1:01=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
>
> Hi Brenton,
>
> Let me give you a quirk review. Nice to hear from you again.
>
> On Fri, 20 Feb 2026 at 17:50, <appsforartists@google.com> wrote:
> >
> > From: Brenton Simpson <appsforartists@google.com>
> >
> > Rock Band 2 for the Nintendo Wii and for the Sony PlayStation 3 use the
> > same mapping as later games:
> >
> >     Green:              SOUTH   (A)
> >     Red:                EAST    (B)
> >     Yellow:             NORTH   (Y)
> >     Blue:               WEST    (X)
> >     Orange/pedal:       TL      (L1)
> >     Solo flag:          TL2     (L2)
> >     Tilt:               TR      (R1)
> >     Pad flag:           THUMBL  (L3)
> >     Instrument button:  MODE    (Steam/Xbox)
> >     Whammy bar:         ABS_Z   (Axis 4)
> >     Effects switch:     Z       (Axis 5)
> >
> > As documented at https://github.com/TheNathannator/PlasticBand/blob/mai=
n/Docs/.
>
> The checkpatch hits this line. Remove this line and replace with see belo=
w.
>
> >
> > The guitar and drums both use the same mapping.  Tested using the Wii
> > versions of the instruments.
> >
>
> A link tag.
>
> Link: https://github.com/TheNathannator/PlasticBand/blob/main/Docs/
> > Signed-off-by: Brenton Simpson <appsforartists@google.com>
> > ---
> >  drivers/hid/hid-ids.h  |  8 +++++++-
> >  drivers/hid/hid-sony.c | 45 +++++++++++++++++++++++++++++-------------
> >  2 files changed, 38 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 3e299a30dcde..644d3c4df144 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -664,6 +664,10 @@
> >  #define USB_DEVICE_ID_UGCI_FLYING      0x0020
> >  #define USB_DEVICE_ID_UGCI_FIGHTING    0x0030
> >
> > +#define USB_VENDOR_ID_HARMONIX         0x1bad
> > +#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE   0x3010
> > +#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE    0x3110
> > +
> >  #define USB_VENDOR_ID_HP               0x03f0
> >  #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A           0x464a
> >  #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A  0x0a4a
> > @@ -1299,7 +1303,9 @@
> >
> >  #define USB_VENDOR_ID_SONY_RHYTHM      0x12ba
> >  #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE       0x074b
> > -#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE   0x0100
> > +#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE                0x0100
> > +#define USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE       0x0200
> > +#define USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE                0x0210
>
> Indentation on first glance seems incorrect. But this file seems to
> follow the rule of vendor gets one tab, and others are aligned. And
> your additions match that.
>
> But other than that, it is true that it is a mess and everyone does
> what they do.
>
> >  #define USB_VENDOR_ID_SINO_LITE                        0x1345
> >  #define USB_DEVICE_ID_SINO_LITE_CONTROLLER     0x3008
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index a89af14e4acc..f6975f6ae882 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -62,9 +62,10 @@
> >  #define GH_GUITAR_CONTROLLER      BIT(14)
> >  #define GHL_GUITAR_PS3WIIU        BIT(15)
> >  #define GHL_GUITAR_PS4            BIT(16)
> > -#define RB4_GUITAR_PS4_USB        BIT(17)
> > -#define RB4_GUITAR_PS4_BT         BIT(18)
> > -#define RB4_GUITAR_PS5            BIT(19)
> > +#define RB2_INSTRUMENT            BIT(17)
> > +#define RB4_GUITAR_PS4_USB        BIT(18)
> > +#define RB4_GUITAR_PS4_BT         BIT(19)
> > +#define RB4_GUITAR_PS5            BIT(20)
>
> I thought these were not formatted correctly. But they are. You added
> RB2_INSTRUMENT above. I would suggest pulling it down and making it
> BIT(20) instead. It minimizes the diff.
>
> >
> >  #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLE=
R_BT)
> >  #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_B=
T)
> > @@ -422,12 +423,12 @@ static const unsigned int sixaxis_keymap[] =3D {
> >         [0x11] =3D BTN_MODE, /* PS */
> >  };
> >
> > -static const unsigned int rb4_absmap[] =3D {
> > +static const unsigned int rb_absmap[] =3D {
> >         [0x30] =3D ABS_X,
> >         [0x31] =3D ABS_Y,
> >  };
> >
> > -static const unsigned int rb4_keymap[] =3D {
> > +static const unsigned int rb_keymap[] =3D {
> >         [0x1] =3D BTN_WEST, /* Square */
> >         [0x2] =3D BTN_SOUTH, /* Cross */
> >         [0x3] =3D BTN_EAST, /* Circle */
> > @@ -625,17 +626,17 @@ static int gh_guitar_mapping(struct hid_device *h=
dev, struct hid_input *hi,
> >         return 0;
> >  }
> >
> > -static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_inpu=
t *hi,
> > +static int rb_instrument_mapping(struct hid_device *hdev, struct hid_i=
nput *hi,
> >                           struct hid_field *field, struct hid_usage *us=
age,
> >                           unsigned long **bit, int *max)
> >  {
> >         if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_BUTTON) {
> >                 unsigned int key =3D usage->hid & HID_USAGE;
> >
> > -               if (key >=3D ARRAY_SIZE(rb4_keymap))
> > +               if (key >=3D ARRAY_SIZE(rb_keymap))
> >                         return 0;
> >
> > -               key =3D rb4_keymap[key];
> > +               key =3D rb_keymap[key];
> >                 hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
> >                 return 1;
> >         } else if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_GENDESK)=
 {
> > @@ -645,10 +646,10 @@ static int rb4_guitar_mapping(struct hid_device *=
hdev, struct hid_input *hi,
> >                 if (usage->hid =3D=3D HID_GD_HATSWITCH)
> >                         return 0;
> >
> > -               if (abs >=3D ARRAY_SIZE(rb4_absmap))
> > +               if (abs >=3D ARRAY_SIZE(rb_absmap))
> >                         return 0;
> >
> > -               abs =3D rb4_absmap[abs];
> > +               abs =3D rb_absmap[abs];
> >                 hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
> >                 return 1;
> >         }
> > @@ -1101,11 +1102,14 @@ static int sony_mapping(struct hid_device *hdev=
, struct hid_input *hi,
> >         if (sc->quirks & GH_GUITAR_CONTROLLER)
> >                 return gh_guitar_mapping(hdev, hi, field, usage, bit, m=
ax);
> >
> > +       if (sc->quirks & RB2_INSTRUMENT)
> > +               return rb_instrument_mapping(hdev, hi, field, usage, bi=
t, max);
> > +
> >         if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
> > -               return rb4_guitar_mapping(hdev, hi, field, usage, bit, =
max);
> > +               return rb_instrument_mapping(hdev, hi, field, usage, bi=
t, max);
> >
> >         if (sc->quirks & RB4_GUITAR_PS5)
> > -               return rb4_guitar_mapping(hdev, hi, field, usage, bit, =
max);
> > +               return rb_instrument_mapping(hdev, hi, field, usage, bi=
t, max);
> >
> >         /* Let hid-core decide for the others */
> >         return 0;
> > @@ -2369,12 +2373,25 @@ static const struct hid_device_id sony_devices[=
] =3D {
> >         /* Guitar Hero PC Guitar Dongle */
> >         { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTA=
NE_GUITAR_DONGLE),
> >                 .driver_data =3D GH_GUITAR_CONTROLLER },
> > -       /* Guitar Hero PS3 World Tour Guitar Dongle */
> > -       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_GUITAR_DONGLE),
> > +       /* Guitar Hero World Tour PS3 Guitar Dongle */
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_GH_GUITAR_DONGLE),
> >                 .driver_data =3D GH_GUITAR_CONTROLLER },
> >         /* Guitar Hero Live PS4 guitar dongles */
> >         { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTA=
NE_PS4_GHLIVE_DONGLE),
> >                 .driver_data =3D GHL_GUITAR_PS4 | GH_GUITAR_CONTROLLER =
},
> > +       /* Rock Band 2 instruments
> > +        * Nintendo Wii instruments are included in `hid-sony` because =
`hid-nintendo`
> > +        * is for the newer Nintendo Switch, and the Wii instruments us=
e the same
> > +        * protocol as their Sony PlayStation 3 cousins.
> > +        */
>
> I would simplify it to "Rock Band 2 Instruments for Wii U. They use
> the hid-sony protocol.". Readers do not need more context.
>
> Other than that, I would drop all the renames from your patch. They
> triple the diff and just make it harder to merge. Without those, the
> patch is essentially the hunk below, the new PIDs, and the quirk. The
> justification of the quirk is that you do not want your code to hit
> rb4_ps4_guitar_parse_report(sc, rd, size); (?)
>
> This patch is very reasonable to merge as it makes no code changes
> after you clean it up a bit.
>
> As for why the buttons are jumbled, this is standard HID gamepad
> handling. You are not supposed to read them directly, but instead use
> something like [1] or PR to [2]. If the gamepad does not have
> vibration, there is no functionality loss either. But... this patch is
> also very welcome.
>
> Best,
> Antheas
>
> [1] https://github.com/mdqinc/SDL_GameControllerDB
> [2] https://github.com/libsdl-org/SDL
>
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX=
_WII_RB2_GUITAR_DONGLE),
> > +               .driver_data =3D RB2_INSTRUMENT },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX=
_WII_RB2_DRUMS_DONGLE),
> > +               .driver_data =3D RB2_INSTRUMENT },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_RB2_GUITAR_DONGLE),
> > +               .driver_data =3D RB2_INSTRUMENT },
> > +       { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_RB2_DRUMS_DONGLE),
> > +               .driver_data =3D RB2_INSTRUMENT },
> >         /* Rock Band 4 PS4 guitars */
> >         { HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFM=
ASTER),
> >                 .driver_data =3D RB4_GUITAR_PS4_USB },
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >
> >
>
