Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EDE335BDB
	for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 05:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771653155; cv=pass; b=KcLPQhX8kSVFDnlpy9xQ9VvvD4fiDUGWqgCmnL4BFrVtw1IOlOsyc+V9JIU1L8aZIvMeP3eO8TKzi1NmjgI+/pcqP5z/64fD6Mzw6SBXzO3zI7Mlc5OmZxK0O0EOuYYO0FTJNMA+RGQ5IWk1/z8jVMloduwJlNshPMiFRhYrKWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771653155; c=relaxed/simple;
	bh=MAXmS7arVgqTB3bItbvD4Rmgt4jEYOa3ILO7cB1gSK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vfa3JeGvW2emu6zjd/i3s3yKQaZ7xW2VxDpvxmSTa6noaC5p43CxGRwgnFgM/kfl5DmV+XAjihh2iIhPuHuqPkS6NvvcM9vQWgPDbYa0pGpxLRuUvECahS6FrKYlJcRbh9ylHMRreulZW6HS5LedLi/By7ea1sBIqOpPCLfDH5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BgbbAAPO; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BgbbAAPO"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43638a3330dso2280966f8f.0
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2026 21:52:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771653152; cv=none;
        d=google.com; s=arc-20240605;
        b=M8Zbzxlz5dCi77hDeFL3qMM8/e/ylJ+sWnb3IIOj6w/HZtTHTeo3+XQKMoSVJhVh8T
         q/fvoVV0O/DplxH+H8tqytRuVBSzw/ViW4mHqXmUfk7UBW9Ap6APyLHt/bpTapEuthxA
         m/Kf2UoHJR/8cMNMx6dkP4OrZf7NqeeuLBx+6SloYtpUFK5uwoegh0I2V7o+xUo2Iy3J
         6eHAJvQJKXnYGdOCpbCIUN2JgnKXQi9S+GB16qjbteJtwG0VsJ24cs78ioxGmeMDVgC2
         jluBS+mvsRjHM6zhB1e1WWaPY9atqWmVRfR5fFtJGk6X0DP1gfg6y6bPvYM7ZlxUnkRN
         OtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JW8Vo1kJCpbmo2/XiYprVqfaCK2V37t7hDm9RLvggZE=;
        fh=nR0WCJH4wmaMZsJgiDTj2aGI1hHc5yejwJPC/qz6Ux0=;
        b=HYIv8MG3OZJvoCGKMPUp/AHxob32QGflLc3yqFEI8l5kpTp1GnR3YFRVgyTQHfjNIv
         0OH0D74Bk8Hdv6ka+v87FPXOACWaM+bzKw5q12l5eF/259uci0jtFaMVx2twOa9+teD+
         CDuX7qxKGxH1bTCTH6qaKgFywOU5D0e8rixyYGHtOthIBwVcoN0vbWVcEjIVqc6U7cG0
         n9Ep9c09vWqtWkeDjnfPsgotMBK4qx1j07uDVyC74j1G4Mq2ZlTFFa4DQGBXRL86zFId
         ikfrDpIM4FLDph1RW5EWFp2Srs4cUD6zhTEbl8EFjAmU8HVOo+k3GWKwnGsrXYW0ToEc
         xEEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771653152; x=1772257952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW8Vo1kJCpbmo2/XiYprVqfaCK2V37t7hDm9RLvggZE=;
        b=BgbbAAPOL2GFSqnB/I1CJAGyHH1QvmM/Qqc3rW7OD4lQ9DL4BNy/EeKb4gky7BJ9UJ
         WDi3GBJfa5tGd4GeJ6F5HKjbhk5UcqnhiqvZIb2EKJ3Eejcn87144vRh3f6y9FmYjtCw
         fst8iw8pTYQwkTGcp/ntPn/txdtDRcs784A52EoAr9HMqdi+j1LruaYYlxJa/Dd0lGDS
         XNOuG6r6lwZ3aWoNYQzjOmN1MIFFYtxolI1zd5CutXqx503R/55sewLlCSyFPM3LwXht
         e5TErnnVZ4sqCQ76/UHMVll+F83I3JvMiOX0Wn5FSr2luRWgFWKy4pel9c+6Mx3H8ndq
         okug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771653152; x=1772257952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JW8Vo1kJCpbmo2/XiYprVqfaCK2V37t7hDm9RLvggZE=;
        b=G8aoyreUhU14PvE4x+bIi2TYfs0of9dR1b/OUysKPSZrJcLDIna3V/EBZv8UJfilK/
         qPNQtIVTXi58/inkxJ4d4UoLmCGV1vnf4j2l0xKcmy5DUEsGxtyPvgdoN4q9sgKNdEuy
         8JGVDXdaA/sz86OpsJmnj/CC8iZoxXyUqRf4lckbEOPjj/AhH/Y8whS5RZMaDKvGYgGj
         JSGCyEFFowRp1qjemUZn4LLQJmSrMcJBvnnvXXsRWbf1IKvC9FZGcfKlYQj0wdL2ZTTc
         FkToqX471iPM+wrULVf93BDSIrEAuedQsYZiS9bnS621LTurKs8h3hZE+4lXZcjnYHO2
         umTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgdqzG9+zvstb2JxgvIQjcx5PP4SUnL9dkTXPcIr+MHeshTrio81F/OkbhjMET4hCGEGSzppW6px/+7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yywtn9pp7YNBb+Lx0MI5vBOCO+KiP+sbetRqFY3H7zs4fE3N3PD
	D+PQ7w2UzR+l/46w3zPJDTmOXWMscdcA+veeovu6LOYJ3v/FpRE2IxluVpAlCF4dAgR/hhkLBoV
	dn7sAkWJLyiTa9/ZdMNjjO6s+/owu8xLdcu8s06Am
X-Gm-Gg: AZuq6aJuaMnhqwYMUWiYAjea7P1gxjAnUzeSQRd7jOQWVv4T3aA071OiyoCsinFtoqh
	54QQ0gUCdN/AA+YVshV2mcCjzBt02likZetiMGf8KH6+peYIg0VnRoES7DIZUa+wsw5hbdQMzsb
	2YGkovsxFU5B2hcLd+oX8gl7fmRWlDScbd7dcVpplmuPuAk81fsRmZMwTsfpEDoRySMquKxa860
	RU6mmo7pvU0iCDLyVdeLqwHmUrML2O03aglgnP2UQCIz6aMpSOWRwTHAVIh7LT4bkCOdU0FS1ud
	AJQHlpc=
X-Received: by 2002:a05:6000:22c6:b0:437:9ced:d04c with SMTP id
 ffacd0b85a97d-4396f178237mr3491713f8f.35.1771653151704; Fri, 20 Feb 2026
 21:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220165047.2844568-1-appsforartists@google.com>
 <f0d2a36a-5320-43c9-909b-3c41257c5e48@mailbox.org> <CAAL3-=-Cbi+xL2wXKG7vsjMgh8iX8chA+rzkXk_R80cpQF5vNw@mail.gmail.com>
 <6bf7ba2f-bfe1-4988-b15f-9a42f4546b91@mailbox.org>
In-Reply-To: <6bf7ba2f-bfe1-4988-b15f-9a42f4546b91@mailbox.org>
From: Brenton Simpson <appsforartists@google.com>
Date: Sat, 21 Feb 2026 00:52:20 -0500
X-Gm-Features: AaiRm52xIH_qdMJFZivXqZ9-aD0-QokgC0J7n0Ox7p4Het5MzVZT-X06hUKU3Lw
Message-ID: <CAAL3-=9AH1sriouFV-bVGbo8aVxP8LG07HOLyOG=dbRKFZPn7g@mail.gmail.com>
Subject: Re: [PATCH] HID: sony: add support for Rock Band 2 instruments
To: Rosalie <rosalie@mailbox.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sanjay Govind <sanjay.govind9@gmail.com>, 
	Antheas Kapenekakis <lkml@antheas.dev>, Vicki Pfau <vi@endrift.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 12:26=E2=80=AFAM Rosalie <rosalie@mailbox.org> wrot=
e:
>
> On 2/21/26 06:04, Brenton Simpson wrote:
> > On Fri, Feb 20, 2026 at 9:42=E2=80=AFPM Rosalie <rosalie@mailbox.org> w=
rote:
> >
> >> On 20/02/2026 17:50, Brenton Simpson <appsforartists@google.com> wrote=
:
> >>
> >>> Rock Band 2 for the Nintendo Wii and for the Sony PlayStation 3 use t=
he
> >>> same mapping as later games:
> >>>
> >>>       Green:              SOUTH   (A)
> >>>       Red:                EAST    (B)
> >>>       Yellow:             NORTH   (Y)
> >>>       Blue:               WEST    (X)
> >>>       Orange/pedal:       TL      (L1)
> >>>       Solo flag:          TL2     (L2)
> >>>       Tilt:               TR      (R1)
> >>>       Pad flag:           THUMBL  (L3)
> >>>       Instrument button:  MODE    (Steam/Xbox)
> >>>       Whammy bar:         ABS_Z   (Axis 4)
> >>>       Effects switch:     Z       (Axis 5)
> >>>
> >>> As documented at https://github.com/TheNathannator/PlasticBand/blob/m=
ain/Docs/.
> >>>
> >>> The guitar and drums both use the same mapping.  Tested using the Wii
> >>> versions of the instruments.
> >>>
> >>> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> >>> ---
> >>>    drivers/hid/hid-ids.h  |  8 +++++++-
> >>>    drivers/hid/hid-sony.c | 45 +++++++++++++++++++++++++++++---------=
----
> >>>    2 files changed, 38 insertions(+), 15 deletions(-)
> >>>
> >
> > The indentation also seemed inconsistent in these two hid- files.  I
> > tried my best to follow the local style of the parts I edited.  Happy
> > to do a style pass in a separate commit if desired.
> >
>
> You can use the ./scripts/checkpatch.pl script to check for any issues
> with regards to style and indentation.

Thanks.  I ran that before I sent the patch, and it passes, but there
are still a lot of columns that aren't aligned in these files, and
look like they're meant to be.

> >>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> >>> index 3e299a30dcde..644d3c4df144 100644
> >>> --- a/drivers/hid/hid-ids.h
> >>> +++ b/drivers/hid/hid-ids.h
> >>> @@ -664,6 +664,10 @@
> >>>    #define USB_DEVICE_ID_UGCI_FLYING   0x0020
> >>>    #define USB_DEVICE_ID_UGCI_FIGHTING 0x0030
> >>>
> >>> +#define USB_VENDOR_ID_HARMONIX               0x1bad
> >>> +#define USB_DEVICE_ID_HARMONIX_WII_RB2_GUITAR_DONGLE 0x3010
> >>> +#define USB_DEVICE_ID_HARMONIX_WII_RB2_DRUMS_DONGLE  0x3110
> >>> +
> >>>    #define USB_VENDOR_ID_HP            0x03f0
> >>>    #define USB_PRODUCT_ID_HP_ELITE_PRESENTER_MOUSE_464A              =
  0x464a
> >>>    #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A     =
  0x0a4a
> >>> @@ -1299,7 +1303,9 @@
> >>>
> >>>    #define USB_VENDOR_ID_SONY_RHYTHM   0x12ba
> >>>    #define USB_DEVICE_ID_SONY_PS3WIIU_GHLIVE_DONGLE    0x074b
> >>> -#define USB_DEVICE_ID_SONY_PS3_GUITAR_DONGLE 0x0100
> >>> +#define USB_DEVICE_ID_SONY_PS3_GH_GUITAR_DONGLE              0x0100
> >>> +#define USB_DEVICE_ID_SONY_PS3_RB2_GUITAR_DONGLE     0x0200
> >>> +#define USB_DEVICE_ID_SONY_PS3_RB2_DRUMS_DONGLE              0x0210
> >>>
> >>>    #define USB_VENDOR_ID_SINO_LITE                     0x1345
> >>>    #define USB_DEVICE_ID_SINO_LITE_CONTROLLER  0x3008
> >>> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> >>> index a89af14e4acc..f6975f6ae882 100644
> >>> --- a/drivers/hid/hid-sony.c
> >>> +++ b/drivers/hid/hid-sony.c
> >>> @@ -62,9 +62,10 @@
> >>>    #define GH_GUITAR_CONTROLLER      BIT(14)
> >>>    #define GHL_GUITAR_PS3WIIU        BIT(15)
> >>>    #define GHL_GUITAR_PS4            BIT(16)
> >>> -#define RB4_GUITAR_PS4_USB        BIT(17)
> >>> -#define RB4_GUITAR_PS4_BT         BIT(18)
> >>> -#define RB4_GUITAR_PS5            BIT(19)
> >>> +#define RB2_INSTRUMENT            BIT(17)
> >>> +#define RB4_GUITAR_PS4_USB        BIT(18)
> >>> +#define RB4_GUITAR_PS4_BT         BIT(19)
> >>> +#define RB4_GUITAR_PS5            BIT(20)
> >>>
> >>>    #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTR=
OLLER_BT)
> >>>    #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLL=
ER_BT)
> >>> @@ -422,12 +423,12 @@ static const unsigned int sixaxis_keymap[] =3D =
{
> >>>        [0x11] =3D BTN_MODE, /* PS */
> >>>    };
> >>>
> >>> -static const unsigned int rb4_absmap[] =3D {
> >>> +static const unsigned int rb_absmap[] =3D {
> >>>        [0x30] =3D ABS_X,
> >>>        [0x31] =3D ABS_Y,
> >>>    };
> >>
> >>
> >> Is the Whammy bar mapped correctly to ABS_Z with this patch, or do the
> >> instruments not use the rb_absmap array, because the array does not
> >> contain ABS_Z?
> >>
> >> If it doesn't need the rb_absmap array, maybe it'd be better to make a
> >> separate rb2_instrument_mapping function instead of re-using the
> >> rb4_guitar_mapping function.
> >
> > I renamed the absmap to be consistent, but unlike the CRKD guitars,
> > the Harmonix guitars don't have a joystick, so they ignore the absmap.
> > It's the keymap they need.
> >
> >>> -static const unsigned int rb4_keymap[] =3D {
> >>> +static const unsigned int rb_keymap[] =3D {
> >>>        [0x1] =3D BTN_WEST, /* Square */
> >>>        [0x2] =3D BTN_SOUTH, /* Cross */
> >>>        [0x3] =3D BTN_EAST, /* Circle */
> >>> @@ -625,17 +626,17 @@ static int gh_guitar_mapping(struct hid_device =
*hdev, struct hid_input *hi,
> >>>        return 0;
> >>>    }
> >>>
> >>> -static int rb4_guitar_mapping(struct hid_device *hdev, struct hid_in=
put *hi,
> >>> +static int rb_instrument_mapping(struct hid_device *hdev, struct hid=
_input *hi,
> >>>                          struct hid_field *field, struct hid_usage *u=
sage,
> >>>                          unsigned long **bit, int *max)
> >>>    {
> >
> > Without the patch, the red button is not usable without a VDF:
> >
> > 0300037cad1b00001030000001010000,Licensed by Nintendo of America
> > Harmonix Guitar Controller for Nintendo
> > Wii,a:b1,b:b2,x:b0,y:b3,back:b8,start:b9,guide:b12,leftshoulder:b4,righ=
tshoulder:b5,lefttrigger:b6,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,=
rightx:a2,righty:a3,platform:Linux
> >
>
> Is everything mapped correctly except the red button without this patch?
> If so, maybe a simplified rb_keymap would be more clear code wise,
> alongside my suggestions below.

No, they're all jumbled.  Red is BTN_C, so it doesn't even appear in
games.  Other mismaps without this patch:

Green:         EAST
Blue:          SOUTH
Orange:        WEST
Solo flag:     L1
Start:         R2
Select:        L2
Tilt:          Z
Drum pad flag: SELECT

> > So all registered Rock Band instruments can use this
> > rb_instrument_mapping function.  The ones that send the axes at weird
> > locations are augmented by the existing rb4_parse functions; the older
> > ones send them at the standard locations.
> >
>
> I think you misunderstood my initial reply, if the rb_absmap array isn't
> required then it's rather confusing to use the same mapping function for
> the wii/ps3 instruments, because when reading the code it implies that
> it'll be used, I'd suggest creating a new mapping function named
> rb2_instrument_mapping which uses a (maybe simplified, see above)
> rb_keymap array but doesn't use the rb_absmap array, to clearly signal
> to code readers that it's unused for those instruments.
>
> My suggestion would also remove the need to rename the rb4_absmap
> variable name.

That handles joysticks, right?  The Wii/PS3 instruments don't have
joysticks to map.

> >>>        if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_BUTTON) {
> >>>                unsigned int key =3D usage->hid & HID_USAGE;
> >>>
> >>> -             if (key >=3D ARRAY_SIZE(rb4_keymap))
> >>> +             if (key >=3D ARRAY_SIZE(rb_keymap))
> >>>                        return 0;
> >>>
> >>> -             key =3D rb4_keymap[key];
> >>> +             key =3D rb_keymap[key];
> >>>                hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
> >>>                return 1;
> >>>        } else if ((usage->hid & HID_USAGE_PAGE) =3D=3D HID_UP_GENDESK=
) {
> >>> @@ -645,10 +646,10 @@ static int rb4_guitar_mapping(struct hid_device=
 *hdev, struct hid_input *hi,
> >>>                if (usage->hid =3D=3D HID_GD_HATSWITCH)
> >>>                        return 0;
> >>>
> >
> > Like the D-pad, the whammy and the effects switch are correctly mapped
> > by default.  I tested all the buttons on both the guitar and the
> > drums.  With the patch, they're correct.
> >
> >>> -             if (abs >=3D ARRAY_SIZE(rb4_absmap))
> >>> +             if (abs >=3D ARRAY_SIZE(rb_absmap))
> >>>                        return 0;
> >>>
> >>> -             abs =3D rb4_absmap[abs];
> >>> +             abs =3D rb_absmap[abs];
> >>>                hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
> >>>                return 1;
> >>>        }
> >>> @@ -1101,11 +1102,14 @@ static int sony_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> >>>        if (sc->quirks & GH_GUITAR_CONTROLLER)
> >>>                return gh_guitar_mapping(hdev, hi, field, usage, bit, =
max);
> >>>
> >>> +     if (sc->quirks & RB2_INSTRUMENT)
> >>> +             return rb_instrument_mapping(hdev, hi, field, usage, bi=
t, max);
> >>> +
> >>>        if (sc->quirks & (RB4_GUITAR_PS4_USB | RB4_GUITAR_PS4_BT))
> >>> -             return rb4_guitar_mapping(hdev, hi, field, usage, bit, =
max);
> >>> +             return rb_instrument_mapping(hdev, hi, field, usage, bi=
t, max);
> >>>
> >>>        if (sc->quirks & RB4_GUITAR_PS5)
> >>> -             return rb4_guitar_mapping(hdev, hi, field, usage, bit, =
max);
> >>> +             return rb_instrument_mapping(hdev, hi, field, usage, bi=
t, max);
> >>>
> >>>        /* Let hid-core decide for the others */
> >>>        return 0;
> >>> @@ -2369,12 +2373,25 @@ static const struct hid_device_id sony_device=
s[] =3D {
> >>>        /* Guitar Hero PC Guitar Dongle */
> >>>        { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCT=
ANE_GUITAR_DONGLE),
> >>>                .driver_data =3D GH_GUITAR_CONTROLLER },
> >>> -     /* Guitar Hero PS3 World Tour Guitar Dongle */
> >>> -     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_GUITAR_DONGLE),
> >>> +     /* Guitar Hero World Tour PS3 Guitar Dongle */
> >>> +     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_GH_GUITAR_DONGLE),
> >>>                .driver_data =3D GH_GUITAR_CONTROLLER },
> >>>        /* Guitar Hero Live PS4 guitar dongles */
> >>>        { HID_USB_DEVICE(USB_VENDOR_ID_REDOCTANE, USB_DEVICE_ID_REDOCT=
ANE_PS4_GHLIVE_DONGLE),
> >>>                .driver_data =3D GHL_GUITAR_PS4 | GH_GUITAR_CONTROLLER=
 },
> >>> +     /* Rock Band 2 instruments
> >>> +      * Nintendo Wii instruments are included in `hid-sony` because =
`hid-nintendo`
> >>> +      * is for the newer Nintendo Switch, and the Wii instruments us=
e the same
> >>> +      * protocol as their Sony PlayStation 3 cousins.
> >>> +      */
> >>> +     { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX=
_WII_RB2_GUITAR_DONGLE),
> >>> +             .driver_data =3D RB2_INSTRUMENT },
> >>> +     { HID_USB_DEVICE(USB_VENDOR_ID_HARMONIX, USB_DEVICE_ID_HARMONIX=
_WII_RB2_DRUMS_DONGLE),
> >>> +             .driver_data =3D RB2_INSTRUMENT },
> >>> +     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_RB2_GUITAR_DONGLE),
> >>> +             .driver_data =3D RB2_INSTRUMENT },
> >>> +     { HID_USB_DEVICE(USB_VENDOR_ID_SONY_RHYTHM, USB_DEVICE_ID_SONY_=
PS3_RB2_DRUMS_DONGLE),
> >>> +             .driver_data =3D RB2_INSTRUMENT },
> >>>        /* Rock Band 4 PS4 guitars */
> >>>        { HID_USB_DEVICE(USB_VENDOR_ID_PDP, USB_DEVICE_ID_PDP_PS4_RIFF=
MASTER),
> >>>                .driver_data =3D RB4_GUITAR_PS4_USB },
> >
> > Some of the Rock Band 3 instruments are outliers that try to merge
> > real stringed instruments with plastic ones, so I left those out of
> > scope for this commit.  The instruments from other games (and the
> > common ones from Rock Band 3) should be compatible with
> > rb_instrument_mapping.
>
