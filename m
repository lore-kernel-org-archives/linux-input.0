Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534546AA6E
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647996; cv=pass; b=s9wNHAFOLasipv9WSPNq829IyTATJ0ficOTAbA4JP6ar28VsJpK3iFPQFgW3YNlPAsFpczFjRU4vXr/Bls1QYvamPsH2U84CAfpGQrC7OXlZU3yQuqSc3fRhmw3qWeAAby4S5AC7UD9ByEpqt1+OmBB+IQGUdvF7tnAL49a8ff8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647996; c=relaxed/simple;
	bh=pvEwDPe+PFnR1RotL2lHNdiBOIWynKG/nmDLDAz5kLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X1yIX58pCGPqx6bYJB4eUpiOA9Kh6P6aA/kA741uoYcbatKsgimDlUyf8acFHtbSexyWrMpnmtPQNVkjtVad+9/opd18dMwOzqkDU4VgnNKmjBQurZM24SzC+4b/fOIqVn3OQLZANP7ummW9KbP1rbo1dU2ilI4/ShJtaf+qwQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWhSSZOS; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWhSSZOS"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8efef6533aaso81686066d6.0
        for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 08:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784647994; cv=none;
        d=google.com; s=arc-20260327;
        b=JqlYYItNNpVVUlVMW8b9XrmOrJ7ZIiwYRLoL8O8NUBlBiuHcoMR9IWorfhpVcmZhlp
         kfMDUm+Fy72a0URCEbBHgH7eUTF2eaD8Y81T7D+s9cFs3Wd9znepOu8icsETJlEZdfG1
         zAM83g/9Na9g+vFS3h8xZ/I1OnvGaqOOq41HBWg0Vxv9FjAKn1LkpccyngPddFT1UlRU
         Un+DSbIVYXgflal0LhM4Mo26GUz4DG1Qd2VvKEnXbWEptAcFkyQCezMDIQLzlxOarFt+
         iNFRCYz+mLJVqsU2Mb6lM13bRFXNOFb9r1oz8KNR/eR/H0+nXazexBQW7cUfFJRVxnOp
         4NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dbk557nnV2K4tDo/ZRP6BHPQjX/n7fQg63TgiPQAQr8=;
        fh=2o6hoRDiz7tpXst61e6O9skZPMNWZ8tKx5XRsIbEpaI=;
        b=FcwhOn2nl3FT1ye9ZGGgQdC14upAwXxfDOxt69uvRPfzrTXvF/kp89E4vjcsx9VIxd
         dZXfQHinufd8EWr9/+iwlTq8XIuByS2y+lKnCF3IbH54gei19UryhI2XRQD7+Z8C5jfR
         6gKYA8Jb7dF26H+ZEELNjuUAr+Q+xHxokUxALFYnfHrjTsfwzJL0RpxJt3M8JbGTX9IK
         Ufpmn3qY2LDvh+dgYTwUoZ89IVHEc7TX8yHTbDabujQkvTLoVld2hofQ6fWZXiaZluB4
         IzazJeclt1WdkUAuc5mSYsTIE0XkQLdMLmbwi1rBt2diSTb+YMecZNErwIKVcTRySTZU
         kmTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784647994; x=1785252794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dbk557nnV2K4tDo/ZRP6BHPQjX/n7fQg63TgiPQAQr8=;
        b=KWhSSZOSH8I3nSiTzYUJLOmY0yQzgiTLTwRjYkF9PM/bzWMGrpnh1FJiDYosu7P3lU
         brKFl26MOD72FZr0c94Wh1zsmWqsje0fUtah39+i2ZvcXQR0vP2vPbm7Ar9oGz0JlRO7
         dUvYIHnqjIPJM9DMFYEzHcMm4HZjy91JuPMJKlOaAoOn2LWnc0fxXJ+Gjc69gb8Dukm3
         n5i2j90vPDmW502lzzbPmRs9nTSeKavnEZiQAA2PAhJCRTQfL+XvIeJhPwb/Qe9z49Iq
         jVyQxAc4p9zGTCOSzwoFVY8jfnCukqX8JW4jWC/L203io/k0N8TqjMXzfE0NzfVG8sPN
         9iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647994; x=1785252794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbk557nnV2K4tDo/ZRP6BHPQjX/n7fQg63TgiPQAQr8=;
        b=Tj7OW/0SRRWe9nT8RqgwnC5IoNJwKdzFIWmvrmhyEJq4OU64rTog8OHIlYar5wdjhy
         5uWa1MHnUb9nbYCIIkrOeh8nKi/YRXuirruI7GnNv0gggiAP07023WonG45cZIAdm0tU
         iBaTJSATc++N2j4tw61Ia6EPJXY0qZ6R4LhmidnUfHdgQDPmX82pqY/QcQEElirn6Lf3
         DEHxCqBNxWzSfsOK5Q5xr+0PuKm2CL4UZHptkgee+fj2XRHWkb4xJ21rUTQHJWsxCmdQ
         a/3WD54suPaF5u5nGcOLUA/SenVA2m9ra5cFQtXpDvwnJJkVTXtdoB3cAC08AJRg6cXu
         Pl4A==
X-Forwarded-Encrypted: i=1; AHgh+RoxMlvMaOneVXsnmRroEjCIJuYGU0sRTpAw31PzbDqwee57KRB5jkHzCGxI3Aiksv0MRFfL9Cy8GAGe9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YziUQJ1I0NstNzK3zoSlJuLA3yn8hOpp7dIrnAka+S3HiDtToSZ
	Ni6h2Zw9L6ZPgnXzsaex01Z5sWaBhHLJCxGhgRorSFqTpf2zyBAA00nzRyd5g9kGM4rYamiQk9A
	PPe8huyyvhMMngSXbJpMjcE/pcHwgx0s=
X-Gm-Gg: AR+sD13tYdsh7oUxWqzl3p8ll8gLXmRZDOyUdfLPKfWHaG6nGHLkUt9ZHfwoS0lJ26p
	4IUTiF5qBltF8FuYGKr0etZtm3t0yJW/+9gU0Wqb8807GDD6i9YsTSa6J4EAqkOhoLEodlqy5o6
	EGPf/UFotyI3gOVN5MCMa1uZcprJrQdCME6HoRw6pj+JryILVo2ajO6m5idt5/moHOIGKMOffxc
	dLjUQOf+oLNVf+2cZK6Vrbd3aBf3BU0yFZd2QDGXdL8EjvxUdddsI6AEF7IxaM8xZAZij5OC2mW
	1IjjX5I=
X-Received: by 2002:a05:6214:490:b0:8fd:6df3:b377 with SMTP id
 6a1803df08f44-9077853be30mr224540786d6.59.1784647993513; Tue, 21 Jul 2026
 08:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716090726.2711293-1-lee@kernel.org> <20260720122156.GA11805@google.com>
In-Reply-To: <20260720122156.GA11805@google.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 21 Jul 2026 08:33:01 -0700
X-Gm-Features: AUfX_mxT1mlPKldhyPt1-O1_OLpw_yh4r4osxerQSTt4ho7ySmNTeJRIGzVkyJQ
Message-ID: <CANRwn3RT7BeR3sAHdQrZCLZL5i6cbSdaaCNERUA2pvbLxk5BNg@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 5:54=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Is Jason back in this week?
>
> Note that all of the Sashiko review comments are pre-existing issues.
>

I'm back now :)

> > Input subsystem guidelines require that device capabilities are adverti=
sed
> > before the input device is registered.  The Wacom driver was violating
> > this by advertising the SW_MUTE_DEVICE capability post-registration in
> > wacom_set_shared_values() (and duplicating it in device-specific setup
> > cases).
> >
> > Resolve this by moving the SW_MUTE_DEVICE capability setup to
> > wacom_setup_touch_input_capabilities() for all touch devices that suppo=
rt
> > it, excluding TabletPC devices.

This paragraph is no longer accurate. The TabletPC-specific checks
were removed. It would be more correct to say something more like "for
all HID_GENERIC touch devices that support it" given the new logic.

> >
> > Additionally, replace the lookup-dependent
> > 'wacom_wac->shared->touch->product' references with 'hdev->product'
> > inside wacom_setup_touch_input_capabilities() as 'hdev' is already
> > available and represents the touch device itself.
> >
> > Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch=
")
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >
> > v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's req=
uest
> > v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch dev=
ices
> >
> >  drivers/hid/wacom_sys.c |  6 ------
> >  drivers/hid/wacom_wac.c | 19 +++++++++++--------
> >  2 files changed, 11 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > index 0eafa483b7f7..6c2a3ddfe366 100644
> > --- a/drivers/hid/wacom_sys.c
> > +++ b/drivers/hid/wacom_sys.c
> > @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom=
_wac *wacom_wac)
> >                       wacom_wac->shared->is_touch_on =3D true;
> >       }
> >
> > -     if (wacom_wac->shared->has_mute_touch_switch &&
> > -         wacom_wac->shared->touch_input) {
> > -             set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> > -             input_set_capability(wacom_wac->shared->touch_input, EV_S=
W,
> > -                                  SW_MUTE_DEVICE);
> > -     }
> >  }
> >
> >  static int wacom_parse_and_register(struct wacom *wacom, bool wireless=
)
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index a29bf051ada7..32c4fd03479e 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -3953,6 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct inp=
ut_dev *input_dev,
> >  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> >                                        struct wacom_wac *wacom_wac)
> >  {
> > +     struct wacom *wacom =3D container_of(wacom_wac, struct wacom, wac=
om_wac);
> > +     struct hid_device *hdev =3D wacom->hdev;
> >       struct wacom_features *features =3D &wacom_wac->features;
> >
> >       if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
> > @@ -3963,9 +3965,12 @@ int wacom_setup_touch_input_capabilities(struct =
input_dev *input_dev,
> >       else
> >               __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >
> > -     if (features->type =3D=3D HID_GENERIC)
> > +     if (features->type =3D=3D HID_GENERIC) {
> > +             input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> > +             __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> >               /* setup has already been done */
> >               return 0;
> > +     }

I'm still concerned about this not working properly. I don't see how
you are preserving the desired behavior where SW_MUTE_DEVICE is only
set on devices where `has_mute_touch_switch` is true (e.g. when a
WACOM_HID_WD_TOUCHONOFF usage is discovered in the HID descriptor). It
seems like this change will result in *all* HID_GENERIC touch devices
gaining SW_MUTE_DEVICE, which is not correct.

For devices that have SW_MUTE_DEVICE on the touch interface, I think
it would be sufficient to simply add a `has_mute_touch_switch` check
here, since the HID descriptor will have already been parsed by this
point. **But** I think the trickier part is handling the case where
SW_MUTE_DEVICE for the touch appears on a different interface,
endpoint, or (potentially) sibling USB device... (The SW_MUTE_DEVICE
usage is usually found in the "pad" collection, which is appears in
the HID descriptor for the pen interface/endpoint/device)

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> >
> >       input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> >       __set_bit(BTN_TOUCH, input_dev->keybit);
> > @@ -3997,19 +4002,17 @@ int wacom_setup_touch_input_capabilities(struct=
 input_dev *input_dev,
> >               input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> >               __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> >
> > -             if (wacom_wac->shared->touch->product =3D=3D 0x361) {
> > +             if (hdev->product =3D=3D 0x361) {
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
> >                                            0, 12440, 4, 0);
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> >                                            0, 8640, 4, 0);
> > -             }
> > -             else if (wacom_wac->shared->touch->product =3D=3D 0x360) =
{
> > +             } else if (hdev->product =3D=3D 0x360) {
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
> >                                            0, 8960, 4, 0);
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> >                                            0, 5920, 4, 0);
> > -             }
> > -             else if (wacom_wac->shared->touch->product =3D=3D 0x393) =
{
> > +             } else if (hdev->product =3D=3D 0x393) {
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
> >                                            0, 6400, 4, 0);
> >                       input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> > @@ -4039,8 +4042,8 @@ int wacom_setup_touch_input_capabilities(struct i=
nput_dev *input_dev,
> >               fallthrough;
> >
> >       case WACOM_27QHDT:
> > -             if (wacom_wac->shared->touch->product =3D=3D 0x32C ||
> > -                 wacom_wac->shared->touch->product =3D=3D 0xF6) {
> > +             if (hdev->product =3D=3D 0x32C ||
> > +                 hdev->product =3D=3D 0xF6) {
> >                       input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> >                       __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> >                       wacom_wac->has_mute_touch_switch =3D true;
> > --
> > 2.55.0.141.g00534a21ce-goog
> >
>
> --
> Lee Jones
>
