Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19729430
	for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776626655; cv=pass; b=E3HZETvtVX9L2xm2IwxNHkrSoaPlM6TtTuUM0RyVtzDjXycRSyapQkyM8UTGe4NpOBVNC3l4eJRty6XOpB0Mir0Fzma2CJS84jbXWb9ao0eEGRfxGmL8OJkJ5KGi2aP4lZpLO5gjYhzqLYzk+0e6EFmpg30Vf/CeQZzl2qLijvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776626655; c=relaxed/simple;
	bh=B8YL+ZjfYjYZYo8mKpz8W0Aifen5TRZl2aZmQBwcqH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDdVaROBoKStgSXgaMqhXjoaDYqU1ODneLCjT9+k5wnRZyUmFZDyE1jknOHP4KA7r7poH6MROllXmPmKRrRFPa34Py4fzj5icDfgTrfIV3uQLpsGQusTx/Q6HXKddIfBP5fb216pWhbAP3s2qs+WbRvv2z9lZdnl7pGi+SRY1c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNjkiLU3; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNjkiLU3"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-671ab90fc1fso4815851a12.0
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 12:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776626652; cv=none;
        d=google.com; s=arc-20240605;
        b=APachPeb14Q63aLXrdtXa43clZaaLLpRHbxg451lCyxFiPV1vnikX6NoasU+YYaxsu
         x/mcpllvbbADODKXwoUL2VAasHEGAdMFvhO4tEMBgNXwxsbQFI/UZcgpy/XpLUE9KQoC
         3RfhfUP5CEeGLKxvc9gOgSENmAxeLJ6Rjc+4w57+ACk+gu8EBdHev4W8eJ0iQmfaJMQR
         yII7CTNK0YN0nNX4aUkkRmE7uaJm6DPs1KEi9bcrCUPgpaNTwUL8P0Jn9ltOhmOe6ueB
         AzBZRoQFihQBm7zLlyn4khJeSomQ1I7q1Zwp4M0beeSHmhBW7u90CsQ769/h/vZ4eYoe
         bSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQH04z7x8H1rcGTmeiJrbfOkfXAtrvyNulld8gjFD1k=;
        fh=Js2xIdKuYYno1ICI5seoyMoEV1epWx4tPyswvfytPqY=;
        b=Lh2w+th6WhtPPqOSNiYpMbrxgZ3JZNdFuToF9wd1fBi/dDzug30UFflDYUmGdvTzPJ
         dpjq7gILlIDKN4gpkYVWxjYhwuauLhE/Hh/kNAgzg3SjAVhSBoendhOb7b/ToEym/lLe
         Scr97OTIsMh+crlznpxqGvaueTtbVBgI1rnhm0j/6EPdQnUbvdg5ABnHYkDXrazyYTZ4
         Ufjm4m8IPpoZs203jtDQn+0NMfxlpHTnQPjbq6g93YoET1U2oNW0JyrtlfoHvvsB6A1M
         N4lLeRoKuq13daVI/nhgzj+evXq6Xy6PYkYHvnO4O9Zk+z89ScbPjTp0S+x/7o9K3p0I
         Vn/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776626652; x=1777231452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQH04z7x8H1rcGTmeiJrbfOkfXAtrvyNulld8gjFD1k=;
        b=aNjkiLU3ZpfSP33HP2T3xb3OKNM0Ap3EVVkb2b5cj3b4tdJ0p5QlMRRdaTiS46vMU0
         Bi9wIRHUbdXzH1O1oCwO4d904IItq0Sig2kang+4gT9Yu6wn2XtbJIzYptt9PblIvMZF
         a3d8qB7aeYuiJn+aZEvqv3vQmQOzLgrMUfDYSjXLoGp9Cl2VH4ox83XXSg/HT6ud3fxj
         tW2kAWFwgjIzjz+C0VLQBIbF8GmVQ5n3bxF6WNjc+pSbPeXlhXy6sTNwuXiGLFMXVL2E
         s8rylNBJEByH9c7ZOQM1N2+DQANla1AotLmAIXYRIyfPbNXkuQ2udYcFghPEgXLOe3zZ
         zEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776626652; x=1777231452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQH04z7x8H1rcGTmeiJrbfOkfXAtrvyNulld8gjFD1k=;
        b=K79Weeqd63+3G3ho6UBbQ2m7TglX/2FajcE133YNIK3iyhuju+3Ee9ve8iTQR5DLUQ
         a5nI4GR+49nUVVdxIseuwWoPj+59u8Be+mOREH+09szhhYsvdAy6m1c2WqmpOyogvMNz
         WyVH+r+GYtWe6fo3ZjMVjec6GweHZ2bDFnrCvhg7epbndohBklPD2g9nApqH/0WxtgbN
         4t58keLWgRZLtGRUqw0Y7EtjD025KS8gf18HfL/7Q0zYhICy6MEv+qiyLsSRt7FiqR1l
         LeBlpbEzoOpZ3A37hzMKcKsYHay4dA8lLAwvhiQkkxrA+DAMQvM2LjnKl73sXlNc1t65
         tsEA==
X-Forwarded-Encrypted: i=1; AFNElJ8ygIzOih2nlWugG7sirXCiu0YV9WW+gikYea7GNL9K2B0JJ9Z7Gp4ZvDjrcmWMjWhLJyFTGM8YjjF02g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTAfsA7+UtqBn/fACiDdxz9U39bTI1A3Zmru7i34xfvTQHMac
	ilw8hJhqH7LhCVdDAzTiSBdZxOuml3MNoQIklXwRIkBnUf/aQKYU3Ly7TAD7MECwBhkdrQJepzH
	FeAu3ukBupHDeaPtLv4PyeMeTzPkEfYABIB1n
X-Gm-Gg: AeBDiesKrh69TL+gTkEE08MwNb/VJEmMno6VEhfUqVEp3JS3s44/ADhqoUBe/dPiInt
	T9FCXLIXf8dTOiPjOk60Blokovt2I4fDpIJ8dCai6QdfuQ/HKyZt0PnZm6jfpWV3FC7vtDHLdYN
	UsiZT8CFiQaAA2eTYKS6Z4LZlQbl9zAf6pQx3sAFHCsR8XNGemc4ogrHOBMgnqS8QpsRjAx5arY
	kJGHjMhMm1nleCv4IZlfSChL/DipoqUi1os/OkWCO41kFP5tV4gzIIqLYXxbbpusBNMyRhxRIIm
	2MzNdSXHw703WOOF
X-Received: by 2002:a05:6402:2b9b:b0:670:8b30:a8a7 with SMTP id
 4fb4d7f45d1cf-672bfc12ae6mr4782115a12.0.1776626651536; Sun, 19 Apr 2026
 12:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321202446.724277-1-charles.embedded@gmail.com>
 <20260321202446.724277-3-charles.embedded@gmail.com> <acDLSiujizhuYfOt@google.com>
 <CAHua+AMP-gwgFCX67rdDrfS8RUGpiw2msKYRn07AVWy+u_vTwQ@mail.gmail.com>
In-Reply-To: <CAHua+AMP-gwgFCX67rdDrfS8RUGpiw2msKYRn07AVWy+u_vTwQ@mail.gmail.com>
From: Charles Dias <charles.embedded@gmail.com>
Date: Sun, 19 Apr 2026 16:24:00 -0300
X-Gm-Features: AQROBzA84MJ5qSQWXZr5Vik9puTXqvhjs4hBN8ksO0MjAWI_DkYyU6B4LL8ojow
Message-ID: <CAHua+AOOy6NSQJUPHr7-VQp2zv6ggq0PXjkCbboN_Y2gY+zZ+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] Input: adafruit-seesaw - add interrupt support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anshul Dalal <anshulusr@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Charles Dias <charlesdias.cd@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 10:59=E2=80=AFAM Charles Dias
<charles.embedded@gmail.com> wrote:
>
> On Mon, Mar 23, 2026 at 2:12=E2=80=AFAM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Charles,
> >
> > On Sat, Mar 21, 2026 at 05:24:45PM -0300, charles.embedded@gmail.com wr=
ote:
> > > @@ -289,6 +341,19 @@ static int seesaw_probe(struct i2c_client *clien=
t)
> > >       input_set_max_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_P=
OLL_MAX);
> > >       input_set_min_poll_interval(seesaw->input_dev, SEESAW_GAMEPAD_P=
OLL_MIN);
> > >
> > > +     if (client->irq) {
> > > +             err =3D seesaw_register_write_u32(client, SEESAW_GPIO_I=
NTENSET, SEESAW_BUTTON_MASK);
> > > +             if (err)
> > > +                     return dev_err_probe(&client->dev, err,
> > > +                                             "failed to enable hardw=
are interrupts\n");
> >
> > Maybe this should be in seesaw_open()?
> >
> > Thanks.
> >
> > --
> > Dmitry
>
> Hi Dmitry. Thank you for your review!
>
> Since this is a one-time setup, I believe it should remain as is
> within the seesaw_probe() function, similar to other pin
> configurations.
>
> Please let me know if I'm missing any point here.
>
> Best regards,
> Charles Dias

Hi Dmitry,

I just wanted to follow up on my previous response regarding the initializa=
tion.

Please let me know if there is anything else you'd like me to address
or if there are any further changes needed on my end. Thank you!

Best regards,
Charles Dias
