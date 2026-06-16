Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B443DA7F4
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591138; cv=pass; b=n4Vpouo1+r5n4t9JDCJcdNMw19nzK6f9jcVX4Au3/dnlFRtRPEOPIvY5JvqROhdYw2tLso5epb//wneWsYcf2NLF/UpSRr03EonlslqiBHXCIG3wYDUrNFbDkYuLFJRuc+r0YLwSxSREQ6fLs2U936TTZUF6AY7XbQHUeC+q0i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591138; c=relaxed/simple;
	bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sydOxfPEQh6o2n5dL5kG1oSlnMSPoxhILCL9mlNai+OSuFi5ZEhydq2vxjXIbAGZ6Og2+udJKSr7IObafF2nmCN38XM3LXm0uLKJdcvZ+wBF2W+9pRe/16+DsOg6gSbFzwhi8CbD5+Q5Rk0FJ2NKG2NEbquHVEG2xv7Y1RkDbS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9ppV8ZT; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9ppV8ZT"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304f590dd91so4773911eec.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 23:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781591137; cv=none;
        d=google.com; s=arc-20240605;
        b=eoOjQjYXrVRwb1hCjDSA0LMrz9fsVPQf7yQABp1Ngyz5Dh6ViuhJBaYXM3W3i8JKi4
         u8e8E7OuKspz4W4bl+hFL2oiBXlequiS65Y3snQzuaNyKhqdCE5qmnJCjcqlAQ7q/QsC
         WxJCk1Tazex97YkP4DkZAOx+TZO5y5HjmjdgyJD86/FfYRFr7LbTADmjNDE5Qe9LQtjJ
         mAieFSP8Ir0IayVj0temg40koJU0jyFJrsjNus7v9ljyNpXFzbcFNMjJUCEs5N27fivt
         iTn1kWD6Pazwsjafu2lm6+usvlve8VkS4jLb7ceeOYHokUl4ltTz/zSDrMjxWmkM07k7
         Ofwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
        fh=Qb2EMUV3QjZddhE57UjTytI4Rw6L0PHYdXsd10O7Gq4=;
        b=VkJ3VhSutBYj+WOk33UOmdrRetpekCnR0cY1l6Av5FZuDtZpOmrlistp74x6zEUD/i
         xoADr4F/uj94vp3RB2MlorhhmO4liZaMTNnDRY9UsoWd6jKn43Ma0L59YxN8Vi5vDHjp
         oS6jSeS0P32sKYzETCt8veQkUR6+i2Ktd2DHtppw8QewmCxx70pxmzZhy7+mAqiX6PXf
         UmeeWMsgPqdWK5gWMeArg281QaSnIclIQBJUg11FlU379WZH+hSP2w8Whsn3SltQgZsd
         ZXYMpwgyYeQ8uLw+2giPCRGuNlPxT61bW1z3TqJqGMa1EHQnRAklGNZg3ZNmBJVUotCi
         16IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781591137; x=1782195937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
        b=Y9ppV8ZTAJsGkPvzOdot+jVkZSpot2S/5K09jxMR9cndK3snzxUex6zEB7RijV/MhE
         d676Jd5D5crvU0ByXtjIRIyE5cfGMsNrD1/DzdNguEPz7m81ogiQVNHOVS95V500qCQS
         KA/ZVzykUnB/4utvkfwbgYi43Paecnjt10/nYwU++LXJp+fExcaFT2+WRgsFYgipR0Lf
         VlHbTudjLw+ZFrzcKyh9QdAe7KNSHTL2kHa0GAp5bXbJbfGUDeQ2fUCHwnQ1M3g7qq10
         7tMes9ttSCCEwlUapmWdmWZKGAACmONaU9fNpepigCdqX5PDHzEjCNLcNt9brCLhSmdZ
         GQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781591137; x=1782195937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YZplQ6Ddkpj2GJX3+/D7fSo3HWc2/s74s4mdCUpbfxs=;
        b=SamAI0gKzuj10dilFVLHjmeL1vWS+44Oe1VqKHMKD05yHqbTJh3HfjllQ4oBXwG+3T
         oMfBPi5JDrGZsurWymnqi7C8bzIRaMz8fesmH45Fjh6vubUgqSMmdG2tAqcSMqXVtw6r
         YtO5s32Sm+XNRggbelsxHdzGCQWGnhoyXXtIg1NtVgyJWN78en4p/xoPFF0llP94I9PY
         KfnFbj3uioY/HJ6zj0YtacfKGGCHuc45QaDZiFJe8LlGSUvXlb7FHh4BQlkdWBgdGhTN
         zh8ZsKj7c9EB7C595XhA8YLTsgdbWQGnAq7FU+d/oEDjdUlpjp1ZGAC8Dw9mfr8d40uZ
         f/sQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NUQ0tMIysPIsKzzZ5Notohcwuf37sToaECElX2fwYet0E4hI+zlTl/TFb9YhOezK/T3qd60Da1UIHaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpToXrVOs0hMOj9Mxn2oNfvTErDOZwC5hp1Da5o7eWLStpgzki
	T0eKQ/8wTv+hRbNqfLZqfsA4Zi2MJJWGFqHtQLU8tPfofwSFdcNAzT1LDG8fs//EVWnGsdvZc0F
	Yj2S0/kFq3/zSDE7WNJjpUs/PWceUmbw=
X-Gm-Gg: Acq92OHNoMQnCCN7Kh+tAIQi2KUOeH48Rplze0tGkPGM3u5egmU/qjkqqJHftKCPHg4
	XkVgrQ0lfifjcC8/z9qzVtvS9WM1e62LunkoA/yV7EyF62GkAhMKJ2P8T8uz0D+4ju5kk8pqRx2
	13WkPaTxfVXW8S8XS59fvNCrd7z2bgbEyEFZjn8Moy0qc+7eZGXkSTD3XAf95Z+ATLCdrssy0Qa
	vN1yHUYteS4OunLa/H1mq36/IdsO9OcsBjqy/L9vFIxQXUobj5vSeg2jVCbV5HYThVeoLNXlLr4
	LbjL4lLu
X-Received: by 2002:a05:7300:2202:b0:304:5db8:da95 with SMTP id
 5a478bee46e88-30ba5f6dc2bmr1364047eec.23.1781591136757; Mon, 15 Jun 2026
 23:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-5-clamor95@gmail.com>
 <ajDPtOyr8GJYaVYQ@google.com>
In-Reply-To: <ajDPtOyr8GJYaVYQ@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 16 Jun 2026 09:25:25 +0300
X-Gm-Features: AVVi8CfyBzDLnTjfR4jMIsriu_x6XwPfClLdZn_4ROEykRr_gBRt_FIINro_bck
Message-ID: <CAPVz0n2fnM6zYtP9bCtsY9mcLdce_R+1UPmMo0o4JRgjnhuhKA@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 16 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 07:2=
6 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Thu, May 28, 2026 at 08:32:00AM +0300, Svyatoslav Ryhel wrote:
> > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> >
> > Add support for multimedia top button row of ASUS Transformer's Mobile
> > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > default which suits average Linux use better and with pressing
> > ScreenLock + AltGr function keys layout is switched to multimedia keys.
> > Since this only modifies codes sent by asus-ec-keys it doesn't affect
> > normal keyboards at all.
>
> I think using input handler to intercept ScreenLock + AltGr is quite
> awkward. I think this also passes the original key events (unless you
> make it a filter not a regular handler).
>
> I do not see benefit for reacting to AltGr+ScreenLock on other keyboards
> to activate the special mode on this one. So given the fact that you
> already mange the data stream when you split it into "serio" ports,
> maybe just intercept this key combo right there and create the input
> device and signal input events right there?
>

Though it seems awkward at a first glance, media keys are integrated
with a standard keyboard in a detachable dock. It is highly unlikely
that media keys will be used with a different keyboard then the one
that is integrated with dock. Additionally, the ScreenLock key has a
code specific to this driver and is not in general use, so even if any
standard keyboard has AltGr but none has ScreenLock specific to this
driver except the dock itself. Handler is also set as observer so it
should not interfere with work of other input devices.

> Thanks.
>
> --
> Dmitry
