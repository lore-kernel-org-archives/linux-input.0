Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0F4358389
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216396; cv=pass; b=TgPzuO48ovCwO//pYCI9KDq5Z6zO7ASHa8dnJz+p1NZU+8md4ruMYo655RYLwDUJW5LpA82IKXLi1K7xCJkfZ4cTiPeZAnf3gzh7UWnY6e1thjuSzyTnxfpt/xg0BHgpD8ivTT8EAthNa/oQo5K4LFIC0zL95pjwefTkVEb24Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216396; c=relaxed/simple;
	bh=oq9iTLaWn0Mi2Ox9VNlSR3V+nuU7h8v5oKm2k62UzzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2dwuwrElTRzXTA+BKxdIkKeGObaJDSWiuH3nDhBMW7sXIldLsWUJcdf09ghb3tfD4O95Wy0WbBHYwQSk1qAhd2S/sYoVfrGCkwoLHoifbijfPUsl8ePSc6jsj7AB9ecPT2/g6KO5FTC6nAfRem79yHloHdxQhOp2En9CZW2RUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqGDyEQz; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqGDyEQz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c766a95a72dso1093296a12.1
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 04:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775216394; cv=none;
        d=google.com; s=arc-20240605;
        b=GJNKQnn/+DezzISEoGX72HTlosSyBXP1/bgkZSYkrsj1rPGNMQ8p3zfPTeGqP7sQSI
         yZmwZjGhE5LPSDv0QZu57dC4bFtckvSkgj9R6duWetarXwhKbCcCZij+HY7nYz7i3aMO
         nziu+eKW88qg1m+R4KeVZt7irytTYeFR+9MG3jnDT5H/68riDKVY5PY+0riQ3La1SDNv
         9Cs9VyiAH54KtUuzzEdVOrxg2qAd4TAXaMKE6PUvO8cq3DD1skyWfa36ITnHDj5AzY8H
         XsARt26E7k0XkNZep2DYf+hntMXUQq64hMsp/xDPLZ2Lh/OVKBSxEzaxDVjkdY/9Z58s
         6sWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5tmV4s8r4/9yWsoIHXbmcRcUkkyGttl7g/qLvdfyGD0=;
        fh=aVbUBW2U0zoj5LWLLXWZGrg1xHbozDbb8s9fY8JAdWo=;
        b=dSV3V59ILXEMegcrEWDZmznwgGsD32/qvZ0SbdcN2WN5f0Kk6gWdfRZq+gP+wBLaue
         /YxUPCaKHUgLk8dQBWsyioapuvMWALXdt8hMPEbnS4UU7Kko/JqxdeX++dyHmWlqRrVp
         xR7UpPbxu1S6bbhsrVgnsJ7QZhP5xZqLunbMrF+VoA23N456k4vayqdtWVhhfhVOexZW
         A6fvT/HTh4/9ZI31rJ9EedGZzr6c5cOTEQ1BWhLR1dsadPw/8DjSQrANcABlqwCn9Cc2
         2qV3mNSQd1qjnQxiR+jk5A7N5EChNMmDOBbkJSTRhxeWGGdWqgTu7bmrMkdsSsisZKql
         2aSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775216394; x=1775821194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tmV4s8r4/9yWsoIHXbmcRcUkkyGttl7g/qLvdfyGD0=;
        b=SqGDyEQz9PlBZc4JAULlRnbdccH0rXNHVXOWBkF3n7M6LQ5GEvwfU+QoBwhRAmtTSt
         CLbx2O04CvYY7kx8cD30FcQCXlzExKrEdkbqyXZwiUVaBCtg+bNjG7ECQw4pFr8e6lhP
         Ygd/sI6DrDxC0Ggi3Co567oy8qM91nlnpooNipd4LKnwhNC0ouZP40uuPSqzmpEoxMtx
         Zl2645Kt9//trpKLFDke2+Z4uc9whhNh6YnO2rpRSeVs++D7pZQlDlNjHRDD+EZIwLLh
         muYXmHfYX1WLF/eLGlmmbQDujye1EYyr2s1Ig7O1wllfMbISXhCGNCnLYFx5LvySUpN/
         VXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216394; x=1775821194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tmV4s8r4/9yWsoIHXbmcRcUkkyGttl7g/qLvdfyGD0=;
        b=I8AkZnrv1djrZP1DB2hfvJjHMiHCB53kJKkOQ4qJygoJq89jOZvCIppKmwdzSljsIB
         dOZCJFgxP2GwL+cqxlzFIA3H8o0GW7m0lBI/ndv7NzsseDvXw5WMAbDiyr36uZZLuDvk
         Z0qyjxCxHOvMf/fXsA3zijnvXOO0mTfEXnxMLzGRpMGmjq3eOs9mAtfKVovDmp15J/3T
         QoWAk92EUnnpEwkcN8EHhWOvfU8SQtF8P1rp4ukviUOU0RNNAPly07len3wbZYJ6kmEJ
         4CJws5CyCBRc8r817brzagFRFrCeaoKYfuXpsYJ6IldVLCxAO74veSi411C2ehc9/HcO
         YlLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9+4zVJCOE0qsznsV7u7uo2zPC919+PCqAzQQfes2oNiAKFDUYYunOgxrfdOyx5Km2KRl/hjNgI8PPFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/Cl9Z5cDnR62+fUb0nwRFJcF5GxTqxFdX7N07mFCLqDE8xFP
	UXBfqbBJc+rKlRRBNjU38h0ioVmzGDQJ+sSR/hMZmOjiFDqU3vmrMhHsp2FEe11lqPnC0WSPoqE
	7jtksC4ekCjm04l17/Z+P8WvB+yntbfU=
X-Gm-Gg: ATEYQzzIU7XMqHz0UlFwsGpwTi7oC8sJd7Rek8uBWOMVYA5HMawieTn/R/+mu6ZCzfN
	ytr0nyX7wH/RDamMAi1rNKWPZ8JsjWjwADwClNtxr8KntCwOAN1y2WWznDlpYi9Kq97CoeI5jmM
	zSKrscvhOTYOiz+m5avC0FQTFijPlj8TeJCcqJtmBpt/ffq8yxGKOsz0MoYe3aRxZMrpDqGnh1p
	y3uo5pIUECFwfC56gwOACJ6m8uTwEet1EyZHb2DM6h1K0IsyKKU+DC40ke9x4NOYMeneGt7qWnS
	b7CkwalqmuzavG8armKwPIgDIkRUgmC6sY4n5Q==
X-Received: by 2002:a05:6a20:3952:b0:39f:29ab:b35a with SMTP id
 adf61e73a8af0-39f2edf4f56mr2585039637.16.1775216393693; Fri, 03 Apr 2026
 04:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306104025.43970-1-phucduc.bui@gmail.com> <20260306111912.58388-1-phucduc.bui@gmail.com>
 <20260306111912.58388-4-phucduc.bui@gmail.com> <ac37o-N5lqFMwDCC@google.com> <CAMuHMdW6y4MkCYR-rgn=FA38ZUE_X=3oQWNOvfdyMo=D5_xoxA@mail.gmail.com>
In-Reply-To: <CAMuHMdW6y4MkCYR-rgn=FA38ZUE_X=3oQWNOvfdyMo=D5_xoxA@mail.gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Fri, 3 Apr 2026 18:39:42 +0700
X-Gm-Features: AQROBzAplpcBbMUwl3WSWUof84440c_lG8zw5oOUTL7CqNiz6_JctFCHXOYYFdE
Message-ID: <CAABR9nEJBc7Wqp1r=d+fUES=_j=3UWRsi5bfxgJSmJNd25yPoQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] input: touchscreen: st1232: add system wakeup support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Jeff LaBundy <jeff@labundy.com>, Bastian Hecht <hechtb@gmail.com>, 
	Javier Carrasco <javier.carrasco@wolfvision.net>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry, Geert,

Thank you, Dmitry, for the review and the explanation. You are
absolutely right; I realized the I2C core handles this automatically,
which is t=E1=BA=A1i sao I dropped those changes in the v4 series [1] as Ge=
ert
mentioned.

Thank you, Geert, for pointing that out and for your support.

While working on this, I also noticed similar redundant wakeup
handling in the mpr121 driver and sent a cleanup patch to remove
it [2].

[1] https://lore.kernel.org/20260309000319.74880-1-phucduc.bui@gmail.com
[2] https://lore.kernel.org/all/20260309071413.92709-1-phucduc.bui@gmail.co=
m/

Thanks,
Phuc

On Thu, Apr 2, 2026 at 1:56=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Dmitry,
>
> On Thu, 2 Apr 2026 at 07:17, Dmitry Torokhov <dmitry.torokhov@gmail.com> =
wrote:
> > On Fri, Mar 06, 2026 at 06:19:12PM +0700, phucduc.bui@gmail.com wrote:
> > > From: bui duc phuc <phucduc.bui@gmail.com>
> > >
> > > The ST1232 touchscreen controller can generate an interrupt when the
> > > panel is touched, which may be used as a wakeup source for the system=
.
> > >
> > > Add support for system wakeup by initializing the device wakeup
> > > capability in probe() based on the "wakeup-source" device property.
> > > When wakeup is enabled, the driver enables IRQ wake during suspend
> > > so that touch events can wake the system.
> > >
> > > If wakeup is not enabled, the driver retains the existing behavior of
> > > disabling the IRQ and powering down the controller during suspend.
> >
> > I do not believe this patch is needed: i2c core already handles
> > "wakeup-source" property and manages wakeup IRQ.
>
> No, it is not needed, as mentioned in the cover letter of v4[1],
> and as tested by me[2].
>
> [1] https://lore.kernel.org/20260309000319.74880-1-phucduc.bui@gmail.com
> [2] https://lore.kernel.org/CAMuHMdUqiaP=3DCOTkKU_jK6Hdii+YJ5+zXnxFkOOnhL=
ri5NakTw@mail.gmail.com
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
