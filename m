Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98EB34107F
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798504; cv=pass; b=gSPO/14/Q1OV9LH9/2SaxtbU0TtEe39CrZAauRIwwk7PLuCnSYWanr95FjgMoC1WJUtCekLMlsZ+or+an5Bs1BTaZvMRROKD4jbgynK8s5CcVCTpGps56+7BcfNMxW6IsrlpctLf2vdSJzVJZuvlSNjEyDHLiMlabROV4Oe+c0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798504; c=relaxed/simple;
	bh=Fp+R410qkEY1IMIQt5CDyM30oNbGYLRrPsG4ZVSu1Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuPefHYOHrFKWIO/lAIekI5ypjkaztgEZ0waau7N6vyV/l/7BudA1M7f3qc6XASl8+mWUgs0757Mhdi6ae71WKJbWF0FLBNZ3o8Aln6SEPdxm3RhKyEUYUlXHG3lMjIUnlHt+1z2Fs3YpMa7vz4jkjmDg8NB/sZe7c/LiPsG7Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=SIBQSHjA; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="SIBQSHjA"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81f52945098so1718107b3.0
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 02:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784798501; cv=none;
        d=google.com; s=arc-20260327;
        b=PONsEaQEg4ITxpuB2DOPpA3zRE2SHrGpRnb7PaqEdT1pXU9OsV9V1i5DKN2mwOOw5X
         d7YG6+Fdv4w7Ub6FfEVU1F3d8VIrsYxlNryJjvDhnGqYFNWWSeBIHnRlDRQRuK2mNoE2
         SbRiS9W96vEyX9PzWyGcd5vbu70CiWJj1dPNJU7vn2/8vOmpYPGNo9/auBd6Igg1HE3I
         fZxQ2N030bgpxz/8HYKIH0KPy4k5/NAmXTDuSs2ReLe4/8wldEUXH6IunQ+I3I46vDHb
         kNttjWcVR6NM5u/LRM/1zm5KHrEC5ZiuanSlifpj8oOYNkjgw9b/u5yA7bnZa+sjVovM
         A+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RSnKA2zo95wHPVbfGKIeKc74qvgW7zPdNGfr3Ifw5gc=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=RvfYcTyg9/VMb4zGe10vzpMaBF9b281vSj2HVTiodnvoBbYF/aUhBnmhvR+D/eofl3
         zIb1EiTXXE09FisdcQDtwbsQ6DBvNqgjldfXvb0zISqw81TjAnCw18lmdZ9friTXGNIC
         f1WcjaP2Chj9yhJkSmak5EfE+n+zKDm1P2brqZZcxLBroiIszKonKtIV9vnWffZZlKew
         JHGdyUhT9lK4AiuVIA92Uic/H6v9m0sNsOKfs+TaOJnylbOhm+CCvaixO8wx+bj3nxR2
         xZq1PaomByyc2AD0R94jkZUZGhdnZdKToYxujtnvs+GltyGimcyGXqP48mc0biXlSzob
         4zkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1784798501; x=1785403301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RSnKA2zo95wHPVbfGKIeKc74qvgW7zPdNGfr3Ifw5gc=;
        b=SIBQSHjAZXw4z6xm1dW/LmzhK/w+lagIPd+gIHgFSa5czBJmmMWshj+Vog3lbxgxJV
         CWePJROYPYwqKx/tmFJUAjzAXBw3yMouOZzxP32uV+REgN/DtzCWEWUdOY8XLGALb/P9
         rRBPqU48gBowShgW/b0dDsi7NKNKTVLn2iF+rRxta2gTAV84/nNkwrmJsIPDk2SK4eId
         LXmbz9B7v/R+9WQPrM6CHfycX/gW3NsO1xtIpLfmkFDOF0iZX7e8/MKmi8y7QJ31nlis
         TCrSFRUo7dLwT22NcrFWabjcY6J7gCDkYU5rDE8FWc6S+KkZ1WVkwTnnd/rkEbDkc/Bk
         jRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798501; x=1785403301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSnKA2zo95wHPVbfGKIeKc74qvgW7zPdNGfr3Ifw5gc=;
        b=fufP+TcDqDuOGLU0pDTuS1Ci1GyLo91D8Hq65BDMyVVXt8vjfJeFVeLlEXs/oKqhKc
         8Rq3ALswWR8PusGsUiUwvp7qIhWySvbQ15ue/j5q3ZUiLvpirKD5Je48ghU5Pt2ovLK0
         GR1usRx0hJSLW7h8rRRvGneckJ0wI6uPFa0yTqcq6OsgWgBoMHJpiqxhXi9HZ0t7o0/U
         wGIvOYCPwn0k1obeB9aWp/4p6YICtWzCuR5PHN66j97/KUsXQcJJkq+GlY3h7Zac8RZz
         BbSqFAm7apAp262XJmWWTdgzmgdEybDvQPnpNFNh4CirsQLHStbRsq9ZMkG6Q4vbEUkD
         SCRA==
X-Gm-Message-State: AOJu0YwxIT1YdisVC3+mmfjcLutJxABYCezAYtoj6jdZB2TShWnEv0yZ
	RnvSeN6X9tWS+o6wOpn38OzzZsvR+qLCpUDJO+veWwc7F62ADzX7PqsgOWKp/0CcPuOM9nbwI1E
	0DGOXe/XJBuFiUwNTZLbvPMhZoPPJaE6jEN9CK3g+pA==
X-Gm-Gg: AR+sD11haD074QsyUBJLJJKTSBZzsdp7/41k/k0pjJyiwp/pdnOTo/oW9Y978B1pM/x
	u3dMuMHwOwxBb4iiPUk1moalTq1WWSAerBG97z4X/PeHKDaFBeFycF6+KjABnEWZ5hC/qDDLtgh
	uX4VvqVNAkPG6ULQ1/Z+IZr57XjOF3K6IKXCnM50YtVF23WWuo1KQ7FoihFQDcBzgujKZZw06e5
	+WERk6uXGkRcyjjLnjdYbW9m4rDGJM9O+pTBEGf89tlG+jAzX1Qx++qbynTiTn60zqWn0Xr6iZ6
	rmcaZHMIVG3R1SySty1PSRjPpqwH13C5wba8PYE/6x/rCCQ=
X-Received: by 2002:a05:690c:9988:b0:81e:a56f:844d with SMTP id
 00721157ae682-81f4d674777mr4408207b3.34.1784798501559; Thu, 23 Jul 2026
 02:21:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-chromaticity-v1-1-5ef5746ace2a@frame.work> <20260722173529.7BAA31F00ACA@smtp.kernel.org>
In-Reply-To: <20260722173529.7BAA31F00ACA@smtp.kernel.org>
From: Daniel Schaefer <dhs@frame.work>
Date: Thu, 23 Jul 2026 17:21:05 +0800
X-Gm-Features: AUfX_mxcKxylLeNZW3a59aaejdAdEzO2nyAJHcWYwC8eSH3yVQwwMFUuOy8lQmc
Message-ID: <CAAjcXz4K6vmATfobBQxqCtj2MgzX7omNbFQjkzY8_xXPkNOgXw@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor: als: scale each channel individually
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  Does the info_mask_shared_by_type for these channels need to be changed =
to
info_mask_separate so userspace can read the newly added scale for
CHROMATICITY_Y?

Yes, that's a good idea. Will send v2 after I tested it.


On Thu, Jul 23, 2026 at 1:35=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] The patch fails to expose the individual scale for the CHROMAT=
ICITY_Y channel because it still uses `info_mask_shared_by_type`.
>
> Pre-existing issues:
> - [High] The driver's IIO buffer layout uses a fixed structure, but `avai=
lable_scan_masks` is dynamically populated, causing misaligned buffer reads=
 and data corruption.
> --
>
> --- Patch [1]: [PATCH] iio: hid-sensor: als: scale each channel individua=
lly ---
> commit 6d49cfd4cf380845a584116e06dcf23fc8c25ad6
> Author: Daniel Schaefer <dhs@frame.work>
>
> iio: hid-sensor: als: scale each channel individually
>
> This commit updates the hid-sensor-als driver to support individual scali=
ng
> factors for each channel, instead of using a single global scale. It stor=
es
> the scale attributes in arrays indexed by channel.
>
> Link: https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/merge_requ=
ests/413
>
> > diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid=
-sensor-als.c
> > index 384572844162c..232cb58e0a9ff 100644
> > --- a/drivers/iio/light/hid-sensor-als.c
> > +++ b/drivers/iio/light/hid-sensor-als.c
> > @@ -33,9 +33,9 @@ struct als_state {
> >               u32 illum[CHANNEL_SCAN_INDEX_MAX];
> >               aligned_s64 timestamp;
> >       } scan;
>
> [Severity: High]
> This is a pre-existing issue, but does this fixed struct buffer layout
> cause data corruption?
>
> The driver captures samples in als_capture_sample() into a static sparse
> array (als_state->scan.illum) based on fixed channel indices. However,
> indio_dev->available_scan_masks is dynamically constructed based on the
> attributes present on the sensor.
>
> The IIO core calculates scan_bytes and channel offsets assuming the buffe=
r is
> tightly packed.
>
> When iio_push_to_buffers_with_ts() is called in als_proc_event(), it writ=
es
> the timestamp at the end of the tightly packed length, which overwrites v=
alid
> channel data in the sparse array.
>
> The IIO demuxer then reads from incorrect offsets, scrambling the data se=
nt to
> userspace.
>
> Should the driver pack the samples sequentially instead of using fixed in=
dex
> offsets?
>
> > -     int scale_pre_decml;
> > -     int scale_post_decml;
> > -     int scale_precision;
> > +     int scale_pre_decml[CHANNEL_SCAN_INDEX_MAX];
> > +     int scale_post_decml[CHANNEL_SCAN_INDEX_MAX];
> > +     int scale_precision[CHANNEL_SCAN_INDEX_MAX];
> >       int value_offset;
> >       int num_channels;
> >       s64 timestamp;
>
> [ ... ]
>
> > @@ -186,9 +186,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
> >               ret_type =3D IIO_VAL_INT;
> >               break;
> >       case IIO_CHAN_INFO_SCALE:
> > -             *val =3D als_state->scale_pre_decml;
> > -             *val2 =3D als_state->scale_post_decml;
> > -             ret_type =3D als_state->scale_precision;
> > +             if (chan->scan_index >=3D CHANNEL_SCAN_INDEX_MAX)
> > +                     return -EINVAL;
> > +             *val =3D als_state->scale_pre_decml[chan->scan_index];
> > +             *val2 =3D als_state->scale_post_decml[chan->scan_index];
> > +             ret_type =3D als_state->scale_precision[chan->scan_index]=
;
> >               break;
>
> [Severity: Medium]
> Since the patch introduces per-channel scaling factors, can userspace act=
ually
> read the scale for the CHROMATICITY_Y channel?
>
> The als_channels array defines both CHANNEL_SCAN_INDEX_CHROMATICITY_X and=
 Y
> with .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE).
>
> Because of this, the IIO core will create a single in_chromaticity_scale =
sysfs
> attribute for both.
>
> When read, IIO queries the first registered channel of that type (X), lea=
ving
> the Y scale factor completely inaccessible.
>
> Does the info_mask_shared_by_type for these channels need to be changed t=
o
> info_mask_separate so userspace can read the newly added scale for
> CHROMATICITY_Y?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-chromati=
city-v1-1-5ef5746ace2a@frame.work?part=3D1
