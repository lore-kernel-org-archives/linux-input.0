Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AEC3ACA65
	for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542404; cv=pass; b=ID49xqJdIoApNvO8Ze2hoWL3bWAVULvDUBGa4blg/JW51h068px58hnfk7YIJe1z4T6LYmlCjtdxzbpmlUeYvDIWEG6P08x04shSVjNq5ltgrLckL4+IBIW/mmAKX/1aDSoMS1GyaOCRaSAOK8Zr11tq7Xv86QXEIz3xjBkyYWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542404; c=relaxed/simple;
	bh=YYy7UXm7Ndj5VALDSS0mL6vKUl66pWwvTy/E19HXqz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXMqFJ5OgRCKpfk6wdENQFGi+9Q7YTWGdtfrH3LeFuKiEAVjPL4w3qcKZYPvoJasFBg+S3XZayzJU+JuvZ1dBefRqcMGO+eKHkNaHztFm56G+y9Ng5yJujJ5lvCVV0GN6qGFBV0O2Ek0OYWieRa4aZmwM8G3AIOswU6MU1gAB98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNuIt7yC; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNuIt7yC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ad135063so6069205e9.0
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 02:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777542401; cv=none;
        d=google.com; s=arc-20240605;
        b=FqUW87k5wUfo99XwqYqjB1A2GGnDhF1gIC1StmxaoSe+QNlz+ff1EX+njos3gkiVJ5
         PQuErOUQQPR1A/LBYJJfIIEu6hobOZ5gTURW4t1u0ohD5u5MfcsEPcYURhAO2RJ56otj
         F3HeFPljqL4fAX2U+rPzbCuNIMMD70IknGD+Mfua18VxoYAFgFuqb83QZc8sxCotGY6D
         STgau17Tzs/EDAVnzYYNyOoA7sbc1HBuhd3PpinUrM6AOuy7NI/YWG7m/xSBfWtPl0Zi
         Sxd6fVkCTlKGOL7XCu9gIbOLGUkhcM1tfO1ICf2SJXbZB2KdABaMCP+yHUrB6G+T+AHQ
         Ul2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pnm+TYAzXFndKYIkyfpXu4u9DLZ8kkC1SAqK0htK4W0=;
        fh=VkvRPspFm/m+xODt4ZHDB/CnkbqTZZZruK0ILA6eH/0=;
        b=cQt3XgCC6NlUlexJXXJEn6GZQDomn9t5lyJ1F8PEpZaD/5kY+wvCG2ZZ2K4kdJCt5E
         SPgtiLXcl0R3aG23fBn149xWwrmKoydP5uHIZW5PMTmvAubQGnGXQu4tlU0DHBTMqBP3
         4bA/JR1YYefIMq4tX+HfPMC/y1JWqg1qTh3Qqsx9m9KzXd3OdOahK21GZTTaGupLbs+N
         axxCAsyb0mpnIkA/vqMcOmEmbArwCTP7GeQaR88wQctLObC8g/ECFLwv/mWtRqyzoOAC
         YaQmckm6+ic3LMk29vN9bH/6p3tDZCZIkTs2sgO9lLLMOnaANGzzkaQKNoZdWggIFwd+
         2Bew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777542401; x=1778147201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnm+TYAzXFndKYIkyfpXu4u9DLZ8kkC1SAqK0htK4W0=;
        b=bNuIt7yCfdY2SqWIZb/Ya8CPNQxH+INeYc+7TBIvKOar47uk2xZsz0ndA8fCb8biNo
         fHGicKjywMRjEIxX8QadTzrYWE8b1EHR4FNa3IHoJSwN7ywfF55heczT9yLrhGVBU0gi
         /WCSwDTijj/VuMSLgT4w+1kfR6IJ8TtNRFW4JVmlUTCugyDtnQpAGGx2lIK5mdI4WWae
         ZuKOb9cWMLJ6JhPzbTIQ2JMgolp0X4eIt8sFP8EgWyz0ZaWYcSmI8OwJpC+FJgT0DUbm
         cCMrT6Niszq8//axQN+pM1Bt9h4xpgLr8wobbGOoO01kxd0PNa5WSQPLmwbfYYT3Xlyj
         26lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777542401; x=1778147201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnm+TYAzXFndKYIkyfpXu4u9DLZ8kkC1SAqK0htK4W0=;
        b=huYHN2as6B7y6sW4cr3qRyIXzAFohfCO9SzJA5sYthHzc+6F/z5KiJ7D5bBpmd5IaH
         uNaRqnGRd1fpUVuMAflErpof6c7ZtHf/X+Gfe9DKc6aDLWqCOpePZHi2jXnhZdcK4Z0v
         jAamNriJgCnNonN41QwrQURBmbqBqSIQMWMkIGyzAOvCuCAQaDUSlfiUzhRkS8HZA4hX
         boZY+aS5dAOu8hLr76cx9Vb45FDA3ksxE7X/IfY/KXcGnPmLXBal2HSYtXSrJA5146Ii
         sekMUjC6SQHAbEWlfS5NUAtVtB2y4Jai9AcMoqq6iUJ24FnO54h7f2P8fopKfZZBv3HP
         bkTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aPJ43x+ue9kgoDSUyFhjoFx/DqZ/dB7HjB0Qj4OcGbMa/WtXlYNj9yo02E4ofMc/QxpjE99BRxfcqrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PNudMUwJZiFA9PxSPGu71I0sgXCkAI0rayuzrRHZr2vZc+Wo
	/Sgo0/iO6X1PZJAxdxhLToKem9Y4hWNj/5mJ3SauzgnRpkrNLAK4Yrm8eCFvdnHVvHYW+g2n+ex
	OGaUqy2sMGyDAfoY0Y05auCz2Qo2UZB4=
X-Gm-Gg: AeBDietTNuvFtU+3/Q4P4jGAkYh/wF2GLs1mqjC/iHboLSQmG/IH9FpF2NVFjG5wbZT
	a/rt/msIohppHdB00zasX2YtwXIPKloq5eJF9JrrnJyzlaUEQch+s1dSG+vKkkefcq33ZSaPESo
	AHUc3KfSMHfycqJI9lTusW032irqVBAPtJme7nAA9uPW5PV6aP/moXAppNqjARORiDqDmVOP4lK
	5D2UQ3/peyXxcXPu3u0Q07OirgywvD2c2kI8bFFY0pXouMkRYRcxg8lNMxziTbN75SseEzE7ez0
	1Yxu1K71sGz3UBVBePcx4wXM0UBcLg==
X-Received: by 2002:a05:600c:a14:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48a844525c5mr34271805e9.17.1777542400905; Thu, 30 Apr 2026
 02:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428114308.113253-1-clamor95@gmail.com> <20260428114308.113253-3-clamor95@gmail.com>
 <CAD++jLkU-G38xtzzfAV_otiYuM2G5NHdCdtjFjsy2AjpG22_rg@mail.gmail.com>
In-Reply-To: <CAD++jLkU-G38xtzzfAV_otiYuM2G5NHdCdtjFjsy2AjpG22_rg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 30 Apr 2026 12:46:29 +0300
X-Gm-Features: AVHnY4J2d33Ni_4euu9OwYqttI2CkGecy4BoPNr0s6ZGUefNtnkuSxque7MA9HU
Message-ID: <CAPVz0n3h+zWi-b-ZTLqwXR-9JNGcUgVodUgo+ywhBfK-UDQJAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Input: isa1200 - new driver for Imagis ISA1200
To: Linus Walleij <linusw@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 12:2=
2 Linus Walleij <linusw@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> I just saw this thing:
>
> On Tue, Apr 28, 2026 at 1:43=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
>
> > +/* HCTRL5 controls the PWM high duty cycle of internal channel */
> > +#define ISA1200_HCTRL5                 0x35
> (...)
> > +struct isa1200_config {
> (...)
> > +       u32 duty;
> > +};
> > +       /* Duty cycle */
> > +       regmap_write(isa->map, ISA1200_HCTRL5, config->period >> 1);
> (...)
> > +       if (isa->clk)
> > +               regmap_write(isa->map, ISA1200_HCTRL5, config->duty);
> (..)
> > +       if (isa->clk) {
> > +               ret =3D device_property_read_u32(dev, "imagis,period-ns=
",
> > +                                              &config->period);
> > +               if (ret)
> > +                       return dev_err_probe(dev, ret,
> > +                                            "failed to get period\n");
> > +
> > +               config->period /=3D ISA1200_HCTRL6_PERIOD_SCALE;
> > +               config->duty =3D config->period >> 1;
> > +       }
> > +
> > +       if (isa->pwm) {
> > +               struct pwm_state state;
> > +
> > +               pwm_init_state(isa->pwm, &state);
> > +
> > +               if (!state.period)
> > +                       return dev_err_probe(dev, -EINVAL,
> > +                                            "PWM period cannot be zero=
\n");
> > +
> > +               config->freq =3D div64_u64(NANO, state.period * config-=
>clkdiv);
> > +               config->duty =3D state.period >> 1;
>
> So you don't need the same code writing
> regmap_write(isa->map, ISA1200_HCTRL5, config->period >> 1);
> above, just use confg->duty which contains config->period >> 1
> (...)

No this is intended. It seems that isa1200 uses period >> 1 (aka 1/2
of period for some type of pre-enable). Setting duty as 1/2 period be
default is a safe fallback but it will not trigger haptics.

> > +       device_property_read_u32(dev, "imagis,duty-cycle-ns", &config->=
duty);
>
> I'm not sure about this, it works for me when I set this to 100
> resulting in a register write of 100 to ISA1200_HCTRL5. But are
> we sure that this register is expressed in nanoseconds? I think
> some calculation is needed here (and probably another value
> in my device tree).
>

I do are that this most likely is somehow mapped, but I have no clue
how to transfer this into actual nanoseconds. That is very
unfortunate.

In you original code
/*
* This is done in the vendor tree with the commment
* "Duty 0x64 =3D=3D nForce 90", and no force feedback happens
* unless we do this.
*/
if (isa->clk)
regmap_write(isa->map, ISA1200_HCTRL5, 0x64);

0x64 is actually some conversion of duty cycle, you got this accurately.

> Yours,
> Linus Walleij
