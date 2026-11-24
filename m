Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795549164;
	b=uVcBDRVF0X9g3A2iv/jPZ0PtvLj48Z0Bs6T2BniysVskyBMgF//4ONdCedPotfSmyqEo
	 UR6aDhMmaXu0JL2wagDMi4loZmy6umvMOYjc1vTzYKSpVDyqA2dICnUnEGJeiYWzO43AS
	 4pLop3+mhsXHcJYvv29nOX5YJhNn/Y55S5J9l9jYzaPSeixLSlSLiJXyo8tiRyQ0SPE0f
	 xShae5qqyOUFPig/34NxpRth86TryHwBshbQueDzf5XpYfiJpPomAlIX46xD75ZgHX9pN
	 bY6gtdBObstq+8wYK4K4g5MUjzou9Qmjn4B2ulWuarUMqB1DcHPp2TO78mRcGkJPTKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wu6tXx6YfE7l4Mva2JR2OLNsbHXUq95QfytVnLKi2kk=;
	b=DiuC/tZ4/rfFwx0K96kNtCpiqiRIJSDg8lv+BYe+I5kTYe327E6cDSd28TU/i34rgzjS
	 pHW/kSqTm8SMw9i+kJymIFxDZ0DApYZmXeTpId6w5mQS/qGbf+0hFyvEun6K0yriXna8+
	 TV/bzKr6IJEHJ5s7eiAXRvM/KUoFKGkEkTZ6P3Y+OSEii0AVEMF9EqizBaMZ/SfqM7mti
	 BEc5ovUHVPhUbwBjF9OOk6mpXKdSi2gqbQ7+KiaYjP/tOvlVIVOIJ7W3kQ0nzpkbzQI+A
	 nUUXXVo0oehX167kMemmGEStjDqVIhJ/kg/DijU1G3X7H6v4j0DI5MHEQZTh8/nHhyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cW2rwNVJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E8606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A62E8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cW2rwNVJ
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-92123f02faeso50809026d6.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 11:39:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795549163; cv=none;
        d=google.com; s=arc-20260327;
        b=eNfjExcm0CW5aesIZow6oHaNpxMxO+QrRENkYw6Cz0gitOcZpmzdf9LH1WDqMoRIcj
         0ptSD1PBl8dSVZ1tABNGMPbTne+CRy8GwuRTuKiD3+3XNgnt18FB/bgWupnpFtvJgXDd
         h83hWtwMDMADKsRKAXIHDzv4cbYcI6cvzRtrql8PmxRIMBO2B8aL50nd7kO1Bq0WvO8B
         vPcuAL5nK2qQQ6cU3Po2S0+APjrj8WKi68bKcbJiCDErqHe7gtBH48Oq9BB1zbPFnVYx
         k65Dyj2RiV3Q2ro7LmVF8hLMJXPUnS3rd+8sHC47OwDorRoK5Je62IZKTBLzblJMvqgv
         Mmaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wu6tXx6YfE7l4Mva2JR2OLNsbHXUq95QfytVnLKi2kk=;
        fh=dzF23EZrHm9llL0P5QUiNHKChESOgz66TXNjKqxrRH4=;
        b=ZYnIoqhwpaOgqKce8xOPmbyxXaZK1KGJ89z4KDgJnC+ZXQu5rSjpyPW8UcJGEN8/C2
         tq0jyS91GzbvAMmWASkViFV3IZGlgP5nc7d9B5vWHw8OmgDDeaoQU6S7L3dD+BG2H3Be
         gFxTE8jiVyQRElC3IqZ6TP+3hsDmM8o7SUbdLXcXx3K+auIrZLT6M6pZP18Y6hFvYKML
         S2oeYJJHyCaEANibV8aoXQopdx/d1xwaJ3+VXozQ4D/qf0iysWlKpOBwXaDiQjinCa1Z
         hxBb0JxF7XbpUpWu9AVchNOG5o9siOuJCmvkdivvI7k9a9i4qHlAQCDapRUh9eR0BcHn
         lgbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795549162; x=1796153962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wu6tXx6YfE7l4Mva2JR2OLNsbHXUq95QfytVnLKi2kk=;
        b=cW2rwNVJI6HxHt+wItMR2czZyFM8ow0B06BcI45fbba+VQFvn1Z0TXpWSTRRWCwRZe
         8T60OJmWcm5C+mon3iZZDG6m2QDYKL0T1i8+sFCuPN0jVqjgomqe3HEQSH9fXycJ+GG9
         alRSQ4xAVZwqaC/6LzbYEREJ0M7v+pMFEguNQs4Qwq7HONhVTapJ/XnaQEZgsMn/P4SL
         aA6rG2RZG5qRTRrQ+4C/uRkiS1FSOIwgFHPuU8wi3u69EWkim6F7ZHAZzD6gnPLaZdrl
         BxKkIaD+i9B1PaXiYnydaY96GoTsMjJkvMnhAXVtuccblVLlQVvz5p9cLpKDEJ98Q5pk
         pszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549163; x=1796153963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wu6tXx6YfE7l4Mva2JR2OLNsbHXUq95QfytVnLKi2kk=;
        b=fBK7a5CWuVa+IZo0ecNBcpaqjpWXfF2tO0+MpvyWfaCrSHDsElOxJGobw9NDGx3M0y
         Kz66BEADbFQYplJyhmGdVs/4bkInMK3fUgiaXS2ycyNEjHrkE+TMTwpvTn51UmtuaaA9
         MNoxavgn5RN//hI0l8ngA4+lG+fmHqfXk1E7VGKh6CXwCYSJ5S2+pxVd+Pc5TTAPXFos
         9DD5cWX1K50+23ZFVIXiFlcQ0HcLS+cKnGAys7lZYzNgLkFKNABLctjrTaWUkuEnyTa+
         6EiX4p4oi0PwchH6HWL9AZJYHhSErm14znwvaqGtoR/pzpXn+uW77KLRAi6r6UDHECK0
         hgxg==
X-Forwarded-Encrypted: i=1; AL+hErH9RcQaVnMxPu8oTpuRVDL7t3uL/PHES55gJtGnYgoH/1KkliqMKEU0jPv/cylB2M6/0x2iDMWNZKmTzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z92YLEWvpYnS1GdJVMvcqVsW3sCwQxl2jigvrCAcFWFKliuGGjN
	F+vez289//lwTuxquyDROcToErhWq8CZEbS3UwSUzoE8ZRR5wT8rg7SZ5ABlPP/VXbw75y4m60r
	PWz8gDdCBl02Jlk7Ir4buSTpGYWiDUME=
X-Gm-Gg: AZFdTZc1QZL7YAgPiL2xmT6bzCXR7fwnWMhqwpvq93hzOCUoHiLw5LqPGwvu+lv1pNP
	zhmKN6pxpvFjXqXx+m23hPAHN5qmm6Xfw61lQPg4xywe/OtGlpJOC3kWFKfaYp1zZwh+RXjh/7+
	cteLr46Z1dRtK/vgF6uPW6GI9L6cuCQy5iiWaGquIrYhnktwGxhh1i8CsdK2HjgBMGbIBaDCvaO
	fAnCr2V/o61id+zsiVSTDasO3ZasXVtqila22puMK7GioAwtHJiwj46lL/Xrapy0N2GCc37V9Ws
	kKguCdDKe2GP2I4yzT59NrkX0xYXCZ/Q7p/DVQnhheDzM7//LXJg+CrcT301nWLnoENm/9gw0CU
	WMuyi/zq70Zg3mQf1xnBztNUQ4KwKjhK5oqdz
X-Received: by 2002:ad4:4ea5:0:b0:921:2a52:7961 with SMTP id
 6a1803df08f44-92134a69adfmr276073706d6.11.1795549162306; Tue, 24 Nov 2026
 11:39:22 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110020632.4003499-1-svv@google.com> <20261110020632.4003499-4-svv@google.com>
 <CANRwn3S63O+WRTGhpcNR__ybSuYUb2uEJavUY3b9Uaa_vEhWXQ@mail.gmail.com>
In-Reply-To: <CANRwn3S63O+WRTGhpcNR__ybSuYUb2uEJavUY3b9Uaa_vEhWXQ@mail.gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 24 Nov 2026 11:39:11 -0800
X-Gm-Features: Aa3M54o2OOpleRkrCFNEdlqQD3MYtqXEWF3YvkJU9bfSOLKz15MuchopzE_T5qU
Message-ID: <CANRwn3QjnmnhJP2y7tihZWrvgkdT9PG+qGaNbEW=x=mgUP4OHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: wacom: report ABS_TWIST alongside ABS_Z for pen twist
To: Siarhei Vishniakou <svv@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 3:29=E2=80=AFPM Jason Gerecke <killertofu@gmail.com=
> wrote:
>
> On Mon, Nov 9, 2026 at 6:21=E2=80=AFPM Siarhei Vishniakou <svv@google.com=
> wrote:
> >
> > Historically, Wacom tablets reported stylus barrel rotation (twist)
> > via ABS_Z because a dedicated evdev axis did not exist. Now that we
> > have this axis, report pen twist on ABS_TWIST in addition to ABS_Z.
> >
> > Keep reporting ABS_Z to maintain backward compatibility for existing
> > applications that support Wacom devices.
> >
> > Signed-off-by: Siarhei Vishniakou <svv@google.com>
> > ---

Still waiting for the requested inline comments, but in the meantime
I've been able to test and verify that the code works as expected:

Tested-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> >  drivers/hid/wacom_wac.c | 35 +++++++++++++++++++++++++++++------
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index 614f2adab563..7676bc26a027 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -802,8 +802,10 @@ static void wacom_exit_report(struct wacom_wac *wa=
com)
> >                 input_report_key(input, BTN_STYLUS2, 0);
> >                 input_report_key(input, BTN_TOUCH, 0);
> >                 input_report_abs(input, ABS_WHEEL, 0);
> > -               if (features->type >=3D INTUOS3S)
> > +               if (features->type >=3D INTUOS3S) {
> >                         input_report_abs(input, ABS_Z, 0);
> > +                       input_report_abs(input, ABS_TWIST, 0);
> > +               }
> >         }
> >         input_report_key(input, wacom->tool[idx], 0);
> >         input_report_abs(input, ABS_MISC, 0); /* reset tool id */
> > @@ -981,6 +983,7 @@ static int wacom_intuos_general(struct wacom_wac *w=
acom)
> >                         t =3D (data[7] & 0x20) ? ((t > 900) ? ((t-1) / =
2 - 1350) :
> >                                 ((t-1) / 2 + 450)) : (450 - t / 2) ;
> >                         input_report_abs(input, ABS_Z, t);
> > +                       input_report_abs(input, ABS_TWIST, t);
> >                 } else {
> >                         /* 4D mouse 2nd packet */
> >                         t =3D (data[6] << 3) | ((data[7] >> 5) & 7);
> > @@ -1411,6 +1414,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom=
_wac *wacom)
> >                                 input_report_abs(pen_input, ABS_TILT_Y,
> >                                                  (signed char)frame[8])=
;
> >                                 input_report_abs(pen_input, ABS_Z, rota=
tion);
> > +                               input_report_abs(pen_input, ABS_TWIST, =
rotation);
> >                                 input_report_abs(pen_input, ABS_WHEEL,
> >                                                  get_unaligned_le16(&fr=
ame[11]));
> >                         }
> > @@ -1935,7 +1939,7 @@ static void wacom_map_usage(struct input_dev *inp=
ut, struct hid_usage *usage,
> >         int resolution;
> >
> >         if (equivalent_usage =3D=3D HID_DG_TWIST) {
> > -               resolution_code =3D ABS_RZ;
> > +               resolution_code =3D ABS_TWIST;
> >         }
>
> Requesting a comment here just to make sure that anyone that is only
> casually reading doesn't think this code is dead. Setting *some* kind
> of radial axis here (be it ABS_RZ or ABS_TWIST) is critical to
> ensuring HID properly calculates the resolution for ABS_Z, and that
> might not be obvious when you see HID_DG_TWIST forcing the
> resolution_code to ABS_TWIST.
>
> >
> >         resolution =3D hidinput_calc_abs_res(field, resolution_code);
> > @@ -2332,6 +2336,7 @@ static void wacom_wac_pen_usage_mapping(struct hi=
d_device *hdev,
> >                 break;
> >         case HID_DG_TWIST:
>
> Also requesting a comment for this case that explains that the usage
> here is mapped twice for backwards-compatibility, and that the order
> matters since the latter call will override `usage->type` and
> `usage->code`, preventing wacom_wac_pen_event from automatically
> emitting an ABS_Z event.
>
> >                 wacom_map_usage(input, usage, field, EV_ABS, ABS_Z, 0);
> > +               wacom_map_usage(input, usage, field, EV_ABS, ABS_TWIST,=
 0);
> >                 break;
> >         case HID_DG_ERASER:
> >                 input_set_capability(input, EV_KEY, BTN_TOOL_RUBBER);
> > @@ -2522,10 +2527,21 @@ static void wacom_wac_pen_event(struct hid_devi=
ce *hdev, struct hid_field *field
> >                 return;
> >
> >         /* send pen events only when the pen is in range */
> > -       if (wacom_wac->hid_data.inrange_state)
> > -               input_event(input, usage->type, usage->code, value);
> > -       else if (wacom_wac->shared->stylus_in_proximity && !wacom_wac->=
hid_data.sense_state)
> > -               input_event(input, usage->type, usage->code, 0);
> > +       if (!wacom_wac->hid_data.inrange_state) {
> > +               if (!wacom_wac->shared->stylus_in_proximity ||
> > +                   wacom_wac->hid_data.sense_state)
> > +                       return;
> > +               value =3D 0;
> > +       }
> > +
> > +       input_event(input, usage->type, usage->code, value);
> > +       /*
> > +        * ABS_Z was used to report twist data, because ABS_TWIST was n=
ot yet
> > +        * defined at the time. For compatibility purposes, also report=
 twist
> > +        * via ABS_Z.
> > +        */
>
> I think this comment could be a little more clear, perhaps referencing
> the double-mapping in wacom_wac_pen_usage_mapping (and how we need to
> send data out of both ABS_TWIST and ABS_Z but that `usage->type` and
> `usage->code` can only be set to one of those two)
>
> Jason (she/they)
> ---
> Now instead of four in the eights place /
> you=E2=80=99ve got three, =E2=80=98Cause you added one  /
> (That is to say, eight) to the two,     /
> But you can=E2=80=99t take seven from three,    /
> So you look at the sixty-fours....
>
> > +       if (equivalent_usage =3D=3D HID_DG_TWIST)
> > +               input_report_abs(input, ABS_Z, value);
> >  }
> >
> >  static void wacom_wac_pen_pre_report(struct hid_device *hdev,
> > @@ -3741,6 +3757,7 @@ void wacom_setup_device_quirks(struct wacom *waco=
m)
> >                 __clear_bit(BTN_TOOL_PENCIL, wacom_wac->pen_input->keyb=
it);
> >                 __clear_bit(BTN_TOOL_AIRBRUSH, wacom_wac->pen_input->ke=
ybit);
> >                 __clear_bit(ABS_Z, wacom_wac->pen_input->absbit);
> > +               __clear_bit(ABS_TWIST, wacom_wac->pen_input->absbit);
> >                 __clear_bit(ABS_DISTANCE, wacom_wac->pen_input->absbit)=
;
> >                 __clear_bit(ABS_TILT_X, wacom_wac->pen_input->absbit);
> >                 __clear_bit(ABS_TILT_Y, wacom_wac->pen_input->absbit);
> > @@ -3823,6 +3840,8 @@ int wacom_setup_pen_input_capabilities(struct inp=
ut_dev *input_dev,
> >         case CINTIQ_COMPANION_2:
> >                 input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0)=
;
> >                 input_abs_set_res(input_dev, ABS_Z, 287);
> > +               input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0=
, 0);
> > +               input_abs_set_res(input_dev, ABS_TWIST, 287);
> >                 wacom_setup_cintiq(wacom_wac);
> >                 break;
> >
> > @@ -3835,6 +3854,8 @@ int wacom_setup_pen_input_capabilities(struct inp=
ut_dev *input_dev,
> >         case INTUOS4S:
> >                 input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0)=
;
> >                 input_abs_set_res(input_dev, ABS_Z, 287);
> > +               input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0=
, 0);
> > +               input_abs_set_res(input_dev, ABS_TWIST, 287);
> >                 fallthrough;
> >
> >         case INTUOS:
> > @@ -3855,6 +3876,8 @@ int wacom_setup_pen_input_capabilities(struct inp=
ut_dev *input_dev,
> >
> >                 input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0)=
;
> >                 input_abs_set_res(input_dev, ABS_Z, 287);
> > +               input_set_abs_params(input_dev, ABS_TWIST, -900, 899, 0=
, 0);
> > +               input_abs_set_res(input_dev, ABS_TWIST, 287);
> >
> >                 wacom_setup_intuos(wacom_wac);
> >                 break;
> > --
> > 2.56.0.455.g6c5a503b38-goog
> >
> >
