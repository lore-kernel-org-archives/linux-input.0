Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795646237;
	b=hrtmeoIxLMvH+AC3piSHuyxWLe2iqkQZ4G0pzMx+TVS0AEWDyeeDI4oaX1R1ntjItNvS
	 6ucpZTF/ZFnKw1zbuYFNkqLNwzHKt9Dd4msbOVW6BWDtxKrzGsCzDl5fzj/oJ2+JYhHNk
	 g8JZQUdBYMS51XGVzj+mEDfFC15n1Jtood0FD8eM1enAK4xK7fAysoVcgYLjOFhtUZbgT
	 92cQ8w3IPNLyFWf47lZc96kHbqC7cmNDX88MPdOYcAetAjEq/9Tt+k8NlDH5eYbHf1u3F
	 2vsTU9NdnsSJqQRw9NAQzkijgkf6FTVxBoq30Tym4RPhXJfOFtN57ZYDeA3s/BOh6ZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795646237;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NETc7SGDIwIqrmInvNti52VmQ4lFCDnjsHSIoXfrCQI=;
	b=X/b8m6RQCGSfOhMiIJqENVTzSk61PfK4nHjueVUrQ5pG6eXJD/jzFpoPJLpQFNx2hxHE
	 +dm7GzjB2WgTe+jHEAwfOyv5KJ8k5XvCokG7hbGc2zP8f9/Jmc9wMsFPXdqju0Gt7My0v
	 PmwpZcvIwxPcrJO7eqvAH1yemdwIWJIR5ZYtWBCr7mf9pvPQlGE7Cvp20Bvj6qhPodkl4
	 0LlMz/FGl2Sd5UwRf+xDq4AsQnwvJ2NRdXgP1cRNGbJJQDobaIfmVHMfQByex+0ApXTh/
	 VwvOQui7j33utzSqjlmVfdlG8f+sRY+sjfdy0PSNsQu5wqg2+xwUSgumxjzi50oh+pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MlGyQ88F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BFF606A323
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 22:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75BFF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MlGyQ88F
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9212a5a66f8so51841636d6.2
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:37:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795646236; cv=none;
        d=google.com; s=arc-20260327;
        b=P+KQHxUAW021+y1cWohjv46P3WUDGJff3mW/ZYy/dAhEL8MdTlFyO3TE5w2ttckBKW
         j+d/Qyye8nAz6taGP5Xlk9q5XaDJrTCL58TT1zf6aZoAf47AHBq1ZgfDeiZ/NenCCpoX
         wwlro7qgYw9hBIhfjRLHEqsqhjgKmSbg1wvjMWsC35ty4sVl5OMFdaa9sOuXIWNF449G
         o4t2CVjKqq1Q4SyCXPPfLvVVFO01wrPoQa3HAGAh0AgyL541QtmYolf/QLT5aQtW1DbZ
         PxCAJlYICUagZIHrRAPT+SbBiwRddK+sPhItqTCGxKtxKjSrw120SxHFUwF5KYxfUuSv
         lNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NETc7SGDIwIqrmInvNti52VmQ4lFCDnjsHSIoXfrCQI=;
        fh=8Cpf0t73udAaYnUYl8jL+9cayOF3PrRmVgAdKiCPvE8=;
        b=Yi+BR0deTko2Pnrw2cuQS18G/32ykCL43IAIy0rAdQ785wsur0Mr6aTGufzH8vGkTJ
         inRkIPIQ7Uwfz1BQj+hBgj4s2TftMUyVuiwL7otHENvAQk43ZXI5fLFM6oHvAanV/j0t
         5Ph/a6+Zhj+Hwkhzp6dkxLMizG+CBCNaHIFAxhfRmUyuffZhtIKUTv2pjGn5wiLlalqW
         lnZDaGab95TEi9o49NK5lRJuMf+cFJOd1MY0GeuWLD8Xqk8HyLvLPaqX+OfvFjFWq1J3
         UjooyOoGHafoS7FpgJ0Jb/xPh/E0Ah0UNJXdQzxm5bG9+dgbq71EZPdgMOvl6wHYunJC
         uGFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795646236; x=1796251036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NETc7SGDIwIqrmInvNti52VmQ4lFCDnjsHSIoXfrCQI=;
        b=MlGyQ88F+0CS+gbdDqfKGgX8VMkKlSxUi5Vdr49LUTInUC9hc10k0IfUWvoPpZgMva
         qtvUoe4c3QM/pM0L0Ca2qUWcF8z6/BmYvYNmdUdzfePFCXHiX13jzRvstyjwI/FB8KBh
         75RsqjhixioWhl92M8RVDUSsaz9HW4OviHhcm7830TsMJzedNFRouuQqiBSqjIu8+zbD
         QcVBbEfP3r5uRPQFyAd5wmi0HvDfdFTC5s+95pUmR9G1rUQwNEf6124jNEO4dA6bxT/A
         79FtGf8mSffEAvDBdW6bXO3adHGjN7hDmz7gnQTV1vxusEYrWAmhk4N2eX5yQsHAHWZI
         yDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795646236; x=1796251036;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NETc7SGDIwIqrmInvNti52VmQ4lFCDnjsHSIoXfrCQI=;
        b=1bDVAX4bLyYUZPQSFmqNsw9i/WYq3xGyZF5M/5Vke/zl7gLexmg/ID1a8+Eo9asEQj
         xjIpNoIUFifcYuXt+SXIPgDoRIbVBwpL8P+m5mPk1au1Yg6iYfXvGrlM9PQkw/Sk/8Hv
         2Wz5pzxXXt1yr5l/NdBgW2VsoR5qdrJAyDhrCH2qS1gsJQVBTEgsztdeXDfWPwFos94c
         Tgipq0dLfNIdh7xEPruJNABhQ2ok+du2wR7eeesegO30h7dIbZRe0DcgpMh3p9x0/HXA
         V2nM6EiOYcNxyfu3yw4tUS3MNKEPzZK7rnQFjeBH2zTwkMULoMV9pHSH7Xk2gLj90ltV
         vmAw==
X-Forwarded-Encrypted: i=1; AL+hErFLzeKmiCf8sHYQzhPQmyJS4HYZ3EvBtPTcbMuzvcu7qRZC2UalFyyljVh9XmJcfuelb52rkPhH6JAw2w==@vger.kernel.org
X-Gm-Message-State: APuU4Z8QOxjxCUrdWmCFoxfnc71amCkE7qaDVhFW81s/trd59C/GS7Nt
	XdsKf69HB34GdpBjAmsT6SpiQDeHwlJLXgbZi59cCW2vc70+QV1hqh5mAYr7H37mRalx9BTllns
	VtBJNuPvyRq/L3ZOa8c24Wazfs3YPF04=
X-Gm-Gg: AZFdTZc08eFzx0XiTIk68F3hFhHvKrTZCkluGJnOJGcZFWH/oiFtfydwp7fINNkcyR7
	ztSCXV9qAE9yjjpY7cqltVt/SMBzph7mWQp7ENo3JMo8E9BIKtEMuiO4hz/alj7omdkilRUwxVy
	Fmh4UvtLh+VrqZjim3r1o2PI51Xuf94DQ6mCA1X4phqchxFTNbaSUVEnUHILrFCMomXIq9l0+Nl
	qLJMrxASo5i24YH82rEargiHbslHrDAesRIfUH5BrN8Gdul1XK5+1LHd8jAhY2SX8r3v4tgMl6i
	7h34j4tpEPqs5cVj95GQTkdBUDfsUk366p2DmwzzTBYH9LtP6cK7E60l51JRdTI+36Vf8Rs60IO
	CV7CdkB9Z+x7sx5MF0eUfza7GdTHwWmtSkxvvwKx/MJpRipq3zlEI7AVsBA==
X-Received: by 2002:a05:6214:5295:b0:921:1365:5c0b with SMTP id
 6a1803df08f44-92134a76bd0mr341425156d6.30.1795646236224; Wed, 25 Nov 2026
 14:37:16 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <AS8P251MB00012F559DCFF177B19F767BC8B42@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
 <7oq0p682-ps92-9986-2rq9-q8n7n7154752@xreary.bet>
In-Reply-To: <7oq0p682-ps92-9986-2rq9-q8n7n7154752@xreary.bet>
From: Jason Gerecke <killertofu@gmail.com>
Date: Wed, 25 Nov 2026 14:37:05 -0800
X-Gm-Features: Aa3M54rJ9MwmaCXdPotwBN2qugkZVUKhLi83dpEuPzNGuEqAfSo2SmcJHzmY0cs
Message-ID: <CANRwn3Rptpbh_74GaDQ9D54uAFpqUv1VVD17GQBEE+8CAtxQFg@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: validate GRAPHIRE_BT report length
To: Jiri Kosina <jikos@kernel.org>
Cc: Aamir Ahmed <elb12345@hotmail.co.uk>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 12:47=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wro=
te:
>
> On Sat, 5 Sep 2026, Aamir Ahmed wrote:
>
> > wacom_graphire_irq() parses GRAPHIRE_BT reports by dereferencing
> > wacom->data at fixed offsets up to data[7], guarded only by the
> > data[0] =3D=3D WACOM_REPORT_PENABLED_BT report-id check. It never consu=
lts
> > the report length, and wacom_wac_irq() does not pass len down for this
> > device type.
> >
> > A malformed, malfunctioning or spoofed Bluetooth Graphire (VID 0x056a,
> > PID 0x81) can send a report shorter than 8 bytes that still passes the
> > report-id check. The handler then reads past the received report and
> > forwards the bytes to userspace as ABS_X/ABS_Y/ABS_PRESSURE/ABS_MISC/
> > ABS_DISTANCE and battery state.
> >
> > On the Bluetooth transports the backing buffer is large and fixed (hidp
> > copies into input_buf[HID_MAX_BUFFER_SIZE]; uhid uses UHID_DATA_MAX), s=
o
> > this reads stale in-buffer bytes rather than overrunning the allocation=
.
> > It is the same missing-length-check class already fixed in the sibling
> > handlers wacom_intuos_bt_irq() (commit 2f1763f62909 ("HID: wacom: fix
> > out-of-bounds read in wacom_intuos_bt_irq")) and
> > wacom_intuos_pro2_bt_irq() (commit a8e04f3f894c ("HID: wacom: validate
> > report length in wacom_intuos_pro2_bt_irq")); the GRAPHIRE_BT handler w=
as
> > not covered by those changes. The issue was found by LLM-assisted varia=
nt
> > analysis of those two fixes.
> >
> > Pass the wire length to wacom_graphire_irq() and reject GRAPHIRE_BT
> > reports shorter than the furthest offset the parser dereferences.
> >
> > Fixes: 387142bb8fcb ("Input: wacom - handle Graphire BT tablets in waco=
m.ko")
> > Assisted-by: LLM:opus-4.8
> > Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
>
> Ping, Jason, could you please Ack this one? Thanks.
>

Thanks for catching this, Jiri. I'll ack this to get it out of your
hair since it seems to do the job :)

Aamir -- I would really appreciate a second patch that addresses the
*other* cases handled by this function. It looks like everything but
WACOM_MO should have len =3D=3D WACOM_PKGLEN_PENABLED, while WACOM_MO
itself is supposed to have len =3D=3D WACOM_PKGLEN_BBFUN.

Acked-by: Jason Gerecke <jason.gerecke@wacom.com>

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

> > ---
> >
> > Notes (not part of the changelog):
> > - Compile-tested on x86_64 with CONFIG_HID_WACOM=3Dm; builds with no ne=
w
> >   warnings. No runtime reproducer: per the changelog, on the hidp/uhid
> >   transports this is a stale-buffer read, so KASAN is not expected to f=
ire.
> > - Found by LLM-assisted variant analysis of the two sibling fixes cited
> >   above (see the Assisted-by tag).
> >  drivers/hid/wacom_wac.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index 8feb8027be95..31da8b956607 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -338,7 +338,7 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
> >       }
> >  }
> >
> > -static int wacom_graphire_irq(struct wacom_wac *wacom)
> > +static int wacom_graphire_irq(struct wacom_wac *wacom, size_t len)
> >  {
> >       struct wacom_features *features =3D &wacom->features;
> >       unsigned char *data =3D wacom->data;
> > @@ -350,6 +350,12 @@ static int wacom_graphire_irq(struct wacom_wac *wa=
com)
> >       int retval =3D 0;
> >
> >       if (features->type =3D=3D GRAPHIRE_BT) {
> > +             if (len < WACOM_PKGLEN_PENABLED) {
> > +                     dev_warn(input->dev.parent,
> > +                              "Graphire BT report too short: %zu bytes=
\n",
> > +                              len);
> > +                     goto exit;
> > +             }
> >               if (data[0] !=3D WACOM_REPORT_PENABLED_BT) {
> >                       dev_dbg(input->dev.parent,
> >                               "%s: received unknown report #%d\n", __fu=
nc__,
> > @@ -3475,7 +3481,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, s=
ize_t len)
> >       case GRAPHIRE:
> >       case GRAPHIRE_BT:
> >       case WACOM_MO:
> > -             sync =3D wacom_graphire_irq(wacom_wac);
> > +             sync =3D wacom_graphire_irq(wacom_wac, len);
> >               break;
> >
> >       case PTU:
> > --
> > 2.53.0.windows.1
> >
>
> --
> Jiri Kosina
> SUSE Labs
>
>
