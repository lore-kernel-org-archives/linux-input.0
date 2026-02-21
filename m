Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FA17BCA
	for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771650261; cv=pass; b=O+nLlM40gENFeNbfJYry7mouZkBSj0vNUqp5I0UFtErYfzNWImVMVH22Ac8b/ixoa3k5l6UQrFXE/g1OSSvbcfgXrxVAl+tzVCZMHtgmm1OKckseNdV1fWHNjhLnIyqXsdYd6M61MtFCsTYT3KVR6+F/zIXaOJ5k22qyk+YLkkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771650261; c=relaxed/simple;
	bh=BijD8bBPcQ/i3Q2OHbdTZsnjLeMBlOgPtEoViK8Hcnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9g9IJrbSLnT/aDV3yv0tillFfRbATwzflp+Hox7M9SCNg3h2mskWDnLuHXA9cIl0IQHsSaBrQxVOaluFYqkYbTHlKtStaQ8VMa4tPFp/e9DD/3U+98pwJHwgaRQMHLBwNa3DnbpiH305a97DPA80SmprUrCR2MgRwsfcbYJt3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sasa5DTI; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sasa5DTI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43767807cf3so1998076f8f.1
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 21:04:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771650254; cv=none;
        d=google.com; s=arc-20240605;
        b=ZigcACgGTzTMm9HMs0nilBd6Ci8oevg5G4p6IN5xWsHxP5IkBEWSUpb50UyYXgwSpA
         pgd7nLk29K3qQSzMrpNh0wAOq84JYwsB/zW4KYZyDAfcMfgt5osHBG90uaBEzgRkz1ju
         OAUuBdCFAYhWrCjgKGoAkpNbr1A5p2b2kSrm/Q9wtNzEUTE1GvVvvGgeC8IkyKV7T/zq
         W2jkDPJPrFPhSNBY7MuSzG6syYQ19KrEz1ICJSwlnY9wNKnM+89duGJMOy3TW1noWSs6
         3bmU7umUVLBy5J6B1R+4h6xm4t+SSX14I5If7tqzDABkGmn/Y7xmTEZKWCDtaGjF/khV
         t/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=otyuI4GoeQesZNNIhOiFMvqk0jx4kUBT3AIeSFavEhA=;
        fh=FsmTAZCQ7C0TTaEbWhDX07NdVlhpHs559srbmphTQ0w=;
        b=KYfwqrZPH3XxVTpengPpFE8H2CbuJjkLhMr4xtarIAbbWNqX/6a1RqOCgjgFAeyoyl
         dx/I73GzSC3IqDzjoXRxLhSXdY8u4EWKOE2/Dvpmome3Wpc5FkoQAD8xiF4quv63AN/r
         eCEti40LpLT8sWatoDhHwnBEOYTnRkMer7hPptWugbHRSC+RyTwh4fEQCdu6Fpd9vGIW
         Mis4VO52Z1kZtTB4VCNzUV1ug0IxlaqAd2BzqPaSFZpXF+uXFfGB06xJ6qV7EgVcCUf1
         HlmkGfoOu9ihuZne+G0vG1oqzvhVWYmAwJxdy6JpDWTsPs4B/R0+S1Lb+QAzu+Fnucf6
         bl4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771650254; x=1772255054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otyuI4GoeQesZNNIhOiFMvqk0jx4kUBT3AIeSFavEhA=;
        b=sasa5DTIP3TVE8HFrteEih1V1XWldQ9wLo6yE567kWlk6Yus1FF2TqyTrvAS55mka3
         ZEqdz6M/+r8XNXW5bw/OEg3aTcPO5k1mxpLQrd0TguwLadBPFspEa8AvDV3Gk1p05w0y
         Bazksce0an8MF9WphuZ6Kk7tYz5KcDLoYqUvhb7c9avOvhw2qEorsSc70VgMJl4zcPNj
         giqroQBWiLduSA2dBmOy4iitMxPeOgKI8qeKXqIgQhpo+1/JhoNow6NN6WXhvdKMpQoY
         AB2WMS0fev+5KAUs6A4u6G5lqHeNAClzpa4l6k387kPpTnL6YlngiI73vppWumLhucUt
         EF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771650254; x=1772255054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otyuI4GoeQesZNNIhOiFMvqk0jx4kUBT3AIeSFavEhA=;
        b=ndeCqDUJH50v7NidYEBs0yTqK7SYfrVnDi/fIdukafYY4EDXNUPVdeIx92+Gg01czq
         MjeE6J4DvIvV+qhpNT0VUZpCGcRz32p6q2hRrNmC+pOPSIPvCcA+uoYdMTrhUfzeyqDY
         dQviLsiHvZplx1dPtc0eKLMmVAKq2Nfe5fuiIyEixrD5VycxzCkjGqnaNuIBlK+r0oZ7
         nV7M0SRtdrQAeEDJHEi87FZZeqPv1dAk2J12c6NCYi0dCgYBOWEHzFzJ5ankLuXwXtUE
         B6yguHzLa2NnMSQWItUhy+CiPFj71JCZzXut7iLJplD1gBz/In1H7BuUb4GQtFkgmv5y
         idtA==
X-Forwarded-Encrypted: i=1; AJvYcCVP/+PB66duXXCkBTM+wBGalj/XAp0k+WNuj3vP/fzsrh7zvvuq+33lsA+kL//CinLEz+xjIe0xOYYPow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC84v1/HNXvC9nu40pdwWzvK2aYYz/IOYuEYKcrZ1hdIjpGsin
	RTs/h3w7ZpXX1yaJE7gdzowB9IN507Mj+BGCZ939QEzfEp5+KfJO0IKTCDEJAa45sOvGbn9mZy3
	/HfXbtjncmj3gWLZAV9EIy0f2TGpUDq+tW6lsxBYX
X-Gm-Gg: AZuq6aLBRv4LJgaHibFl2NjoQqHL5x1p2ibnEuF9dDjcMxzoGvazWkmIiFVa8bzRv4P
	166JX2fqjri7Jqn+E7srCvKiWhQC2ZAaAZZEjJE24tywJM03KehyZwREAPGHoUAyYl8t7H1M4lh
	rgRaGYYbKwFE363pKVf0+V+cxgiyM4+/B55QCfidld6H6m10JUgQ6RV9ttrfQH+Wh6QNJK5Xr14
	E1WUhpW8RffaW/U4j3BsDkAHkBoNEaSQ9/7ILrNXoKzP2gwyjS+bD60CENUw+DCBZSLQEjSz3IN
	p8lwLtc=
X-Received: by 2002:a5d:588b:0:b0:435:6c8d:d017 with SMTP id
 ffacd0b85a97d-4396f17b315mr3897117f8f.32.1771650253634; Fri, 20 Feb 2026
 21:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220165047.2844568-1-appsforartists@google.com> <f0d2a36a-5320-43c9-909b-3c41257c5e48@mailbox.org>
In-Reply-To: <f0d2a36a-5320-43c9-909b-3c41257c5e48@mailbox.org>
From: Brenton Simpson <appsforartists@google.com>
Date: Sat, 21 Feb 2026 00:04:01 -0500
X-Gm-Features: AaiRm53eLGGMXvHY7oQ98ayNTqmAEb7TNjVEJ-7-abmq3LBv9YHcGFSG82O5Q2c
Message-ID: <CAAL3-=-Cbi+xL2wXKG7vsjMgh8iX8chA+rzkXk_R80cpQF5vNw@mail.gmail.com>
Subject: Re: [PATCH] HID: sony: add support for Rock Band 2 instruments
To: Rosalie <rosalie@mailbox.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sanjay Govind <sanjay.govind9@gmail.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>, Vicki Pfau <vi@endrift.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 9:42=E2=80=AFPM Rosalie <rosalie@mailbox.org> wrote=
:

> On 20/02/2026 17:50, Brenton Simpson <appsforartists@google.com> wrote:
>
> > Rock Band 2 for the Nintendo Wii and for the Sony PlayStation 3 use the
> > same mapping as later games:
> >
> >      Green:              SOUTH   (A)
> >      Red:                EAST    (B)
> >      Yellow:             NORTH   (Y)
> >      Blue:               WEST    (X)
> >      Orange/pedal:       TL      (L1)
> >      Solo flag:          TL2     (L2)
> >      Tilt:               TR      (R1)
> >      Pad flag:           THUMBL  (L3)
> >      Instrument button:  MODE    (Steam/Xbox)
> >      Whammy bar:         ABS_Z   (Axis 4)
> >      Effects switch:     Z       (Axis 5)
> >
> > As documented at https://github.com/TheNathannator/PlasticBand/blob/mai=
n/Docs/.
> >
> > The guitar and drums both use the same mapping.  Tested using the Wii
> > versions of the instruments.
> >
> > Signed-off-by: Brenton Simpson <appsforartists@google.com>
> > ---
> >   drivers/hid/hid-ids.h  |  8 +++++++-
> >   drivers/hid/hid-sony.c | 45 +++++++++++++++++++++++++++++------------=
-
> >   2 files changed, 38 insertions(+), 15 deletions(-)
> >

The indentation also seemed inconsistent in these two hid- files.  I
tried my best to follow the local style of the parts I edited.  Happy
to do a style pass in a separate commit if desired.

> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 3e299a30dcde..644d3c4df144 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -664,6 +664,10 @@
> >   #define USB_DEVICE_ID_UGCI_FLYING   0x0020
> >   #define USB_DEVICE_ID_UGCI_FIGHTING 0x0030
> >
> > +#define USB_VENDOR_ID_HARMONIX               0x1bad
> > +#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE 0x3010
> > +#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE  0x3110
> > +
> >   #define USB_VENDOR_ID_HP            0x03f0
> >   #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A                0=
x464a
> >   #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A       0=
x0a4a
> > @@ -1299,7 +1303,9 @@
> >
> >   #define USB_VENDOR_ID_SONY_RHYTHM   0x12ba
> >   #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE    0x074b
> > -#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE 0x0100
> > +#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE              0x0100
> > +#define USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE     0x0200
> > +#define USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE              0x0210
> >
> >   #define USB_VENDOR_ID_SINO_LITE                     0x1345
> >   #define USB_DEVICE_ID_SINO_LITE_CONTROLLER  0x3008
> > diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> > index a89af14e4acc..f6975f6ae882 100644
> > --- a/drivers/hid/hid-sony.c
> > +++ b/drivers/hid/hid-sony.c
> > @@ -62,9 +62,10 @@
> >   #define GH_GUITAR_CONTROLLER      BIT(14)
> >   #define GHL_GUITAR_PS3WIIU        BIT(15)
> >   #define GHL_GUITAR_PS4            BIT(16)
> > -#define RB4_GUITAR_PS4_USB        BIT(17)
> > -#define RB4_GUITAR_PS4_BT         BIT(18)
> > -#define RB4_GUITAR_PS5            BIT(19)
> > +#define RB2_INSTRUMENT            BIT(17)
> > +#define RB4_GUITAR_PS4_USB        BIT(18)
> > +#define RB4_GUITAR_PS4_BT         BIT(19)
> > +#define RB4_GUITAR_PS5            BIT(20)
> >
> >   #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLL=
ER_BT)
> >   #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_=
BT)
> > @@ -422,12 +423,12 @@ static const unsigned int sixaxis_keymap[] =3D {
> >       [0x11] =3D BTN_MODE, /* PS */
> >   };
> >
> > -static const unsigned int rb4_absmap[] =3D {
> > +static const unsigned int rb_absmap[] =3D {
> >       [0x30] =3D ABS_X,
> >       [0x31] =3D ABS_Y,
> >   };
>
>
> Is the Whammy bar mapped correctly to ABS_Z with this patch, or do the
> instruments not use the rb_absmap array, because the array does not
> contain ABS_Z?
>
> If it doesn't need the rb_absmap array, maybe it'd be better to make a
> separate rb2_instrument_mapping function instead of re-using the
> rb4_guitar_mapping function.

I renamed the absmap to be consistent, but unlike the CRKD guitars,
the Harmonix guitars don't have a joystick, so they ignore the absmap.
It's the keymap they need.

> > -static const unsigned int rb4_keymap[] =3D {
> > +static const unsigned int rb_keymap[] =3D {
> >       [0x1] =3D BTN_WEST, /* Square */
> >       [0x2] =3D BTN_SOUTH, /* Cross */
> >       [0x3] =3D BTN_EAST, /* Circle */
> > @@ -625,17 +626,17 @@ static int gh_guitar_mapping(struct hid_device *h=
dev, struct hid_input *hi,
> >       return 0;
> >   }
> >
> > -static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_inpu=
t *hi,
> > +static int rb_instrument_mapping(struct hid_device *hdev, struct hid_i=
nput *hi,
> >                         struct hid_field *field, struct hid_usage *usag=
e,
> >                         unsigned long **bit, int *max)
> >   {

Without the patch, the red button is not usable without a VDF:

0300037cad1b00001030000001010000,Licensed by Nintendo of America
Harmonix Guitar Controller for Nintendo
Wii,a:b1,b:b2,x:b0,y:b3,back:b8,start:b9,guide:b12,leftshoulder:b4,rightsho=
ulder:b5,lefttrigger:b6,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,righ=
tx:a2,righty:a3,platform:Linux

So all registered Rock Band instruments can use this
rb_instrument_mapping function.  The ones that send the axes at weird
locations are augmented by the existing rb4_parse functions; the older
ones send them at the standard locations.

> >       if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_BUTTON) {
> >               unsigned int key =3D usage->hid & HID_USAGE;
> >
> > -             if (key >=3D ARRAY_SIZE(rb4_keymap))
> > +             if (key >=3D ARRAY_SIZE(rb_keymap))
> >                       return 0;
> >
> > -             key =3D rb4_keymap[key];
> > +             key =3D rb_keymap[key];
> >               hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
> >               return 1;
> >       } else if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_GENDESK) {
> > @@ -645,10 +646,10 @@ static int rb4_guitar_mapping(struct hid_device *=
hdev, struct hid_input *hi,
> >               if (usage->hid =3D=3D HID_GD_HATSWITCH)
> >                       return 0;
> >

Like the D-pad, the whammy and the effects switch are correctly mapped
by default.  I tested all the buttons on both the guitar and the
drums.  With the patch, they're correct.

> > -             if (abs >=3D ARRAY_SIZE(rb4_absmap))
> > +             if (abs >=3D ARRAY_SIZE(rb_absmap))
> >                       return 0;
> >
> > -             abs =3D rb4_absmap[abs];
> > +             abs =3D rb_absmap[abs];
> >               hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
> >               return 1;
> >       }
> > @@ -1101,11 +1102,14 @@ static int sony_mapping(struct hid_device *hdev=
, struct hid_input *hi,
> >       if (sc->quirks & GH_GUITAR_CONTROLLER)
> >               return gh_guitar_mapping(hdev, hi, field, usage, bit, max=
);
> >
> > +     if (sc->quirks & RB2_INSTRUMENT)
> > +             return rb_instrument_mapping(hdev, hi, field, usage, bit,=
 max);
> > +
> >       if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
> > -             return rb4_guitar_mapping(hdev, hi, field, usage, bit, ma=
x);
> > +             return rb_instrument_mapping(hdev, hi, field, usage, bit,=
 max);
> >
> >       if (sc->quirks & RB4_GUITAR_PS5)
> > -             return rb4_guitar_mapping(hdev, hi, field, usage, bit, ma=
x);
> > +             return rb_instrument_mapping(hdev, hi, field, usage, bit,=
 max);
> >
> >       /* Let hid-core decide for the others */
> >       return 0;
> > @@ -2369,12 +2373,25 @@ static const struct hid_device_id sony_devices[=
] =3D {
> >       /* Guitar Hero PC Guitar Dongle */
> >       { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE=
_GUITAR_DONGLE),
> >               .driver_data =3D GH_GUITAR_CONTROLLER },
> > -     /* Guitar Hero PS3 World Tour Guitar Dongle */
> > -     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS=
3_GUITAR_DONGLE),
> > +     /* Guitar Hero World Tour PS3 Guitar Dongle */
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS=
3_GH_GUITAR_DONGLE),
> >               .driver_data =3D GH_GUITAR_CONTROLLER },
> >       /* Guitar Hero Live PS4 guitar dongles */
> >       { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCTANE=
_PS4_GHLIVE_DONGLE),
> >               .driver_data =3D GHL_GUITAR_PS4 | GH_GUITAR_CONTROLLER },
> > +     /* Rock Band 2 instruments
> > +      * Nintendo Wii instruments are included in `hid-sony` because `h=
id-nintendo`
> > +      * is for the newer Nintendo Switch, and the Wii instruments use =
the same
> > +      * protocol as their Sony PlayStation 3 cousins.
> > +      */
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_W=
II_RB2_GUITAR_DONGLE),
> > +             .driver_data =3D RB2_INSTRUMENT },
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX_W=
II_RB2_DRUMS_DONGLE),
> > +             .driver_data =3D RB2_INSTRUMENT },
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS=
3_RB2_GUITAR_DONGLE),
> > +             .driver_data =3D RB2_INSTRUMENT },
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_PS=
3_RB2_DRUMS_DONGLE),
> > +             .driver_data =3D RB2_INSTRUMENT },
> >       /* Rock Band 4 PS4 guitars */
> >       { HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFFMAS=
TER),
> >               .driver_data =3D RB4_GUITAR_PS4_USB },

Some of the Rock Band 3 instruments are outliers that try to merge
real stringed instruments with plastic ones, so I left those out of
scope for this commit.  The instruments from other games (and the
common ones from Rock Band 3) should be compatible with
rb_instrument_mapping.
