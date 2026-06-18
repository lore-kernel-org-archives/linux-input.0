Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF853C9897
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774345; cv=pass; b=GD2mfblXJ/gXk2GRvcInxTjKE4riKI0PxYw8rjMoh2eg1hMNqIDaKFgsM9C9wS5ozBlZ0zPIYYt4LkAl+J0B2aI5Yff1hTL9R4fcW2H6j0wTKAxIqt2DxQNA/VyBpiInpet+2fTdWgGjh0QuASslDoYYDrS+J0K5HE22GCz/GGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774345; c=relaxed/simple;
	bh=iXXS+DdvdpHDISQJAmld4xgdLVhKLH0Jazoj5E1xJKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxhvfeRnmlUR2ifpC0MhwjsWPapJVDWA9BnimEF8EJiZ2HXBZBIDXRl2mpR5Cdm9CZ17hcTVja9lWkGaENxaLMyoX/YbR7N5odsjGTQ5ge7UDVOE4T1GQUr8RQ7DOzoC/fXTnbD6hpC2vULowNieG5tUMFo0siSXi2fkg9l7WQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svCHfmjW; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svCHfmjW"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30759632453so172940eec.1
        for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 02:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781774335; cv=none;
        d=google.com; s=arc-20240605;
        b=BRe1/K7rdjsHZP7KVYsDJ+KfVE5PW0XEWMaAasqwaYCTAoCVy0ATu7s0Z9Hpi1VmjJ
         ZS4Hz231l7E4qLESbSOIaVHXVp00hRJBhPV7Li8PAWQ8MhWPgHTgz7iGjWo7XabwhW0+
         +IRFSqmLpOHaRopQzvzkAvNyE1YfZCLERxygys5KA/HIBXSXoDUXtacyszLIx9LCjwk1
         /XM+LPe+YvpqfILCwAwc54y5pP9orD9jDeD8A3on3LzbSUYtwfr0pwVA+FLoJ2DumoA6
         e4Sk/hisJHXwaZjyfSttWtRHov+v4kYhzcEbWFx6G/A2tG3gM5o63tLBlzTLOFewDIrO
         ZwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iXXS+DdvdpHDISQJAmld4xgdLVhKLH0Jazoj5E1xJKc=;
        fh=6doLg8sXB85M4qfwNsLN0b7suSiGmNinUP7twLpyxyU=;
        b=WkmgRw50Q8kneLIS/ajHGdEMwpyuCOKwaV77RBiAzXGsVl2zwav2jDGBoJLC+Pr+qN
         RGJ0mtNRfqpRwCIipyGTcL2LEsqHuVcRvwReXNrrJc7WlpF/iWTN7eWOB1+oEJrTebpK
         9c16W6yxSaH3LE/AYjI/AIB7CGlN35ii3alktzhYZly0gBSqm+IpUH5BqJcFkdkv0HFZ
         3paklbehPTZQq8ApNYSbbNXtJ/xItRH/+axmZp5Kd5iveLC62AiZBKx5wWu/mD6MAhsD
         P4+X+CSpvG6fj7yzPhPStOCxQM+FWUwxkki259TTfMPgCO4PJrktthQyz8O/hcxHX8Hi
         6c9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781774335; x=1782379135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXXS+DdvdpHDISQJAmld4xgdLVhKLH0Jazoj5E1xJKc=;
        b=svCHfmjWdy9fVHTCYHHVhzuC4EYvs/qch4QmzwA/63gVMZiU4s3jVAoFEM0UM0UmSW
         bwORU+3vBordIGCRTdOLg8jZxH2uuu/qW2lHQLlZkfZzHdoIFvZ0oZQ5sPe3m49HN88e
         9MdPgT9CiKFwv9a3MwADBqK6FuKPdw1A602ShMH/PDErDAtZnXYC3Kh/oPHyu3LIUD+R
         QkV9exODwC7oLGb8Yfj4f1eHMlGLnDyFAX2hvrBrqUtC9A+0ILgsmd9ODY8r6BmUkgUN
         qUW4h/1nc3FNJvMdLzGQN4zQo/tgyYiOf1Hogt0Qnt1uLnORZ3c5h/nAOemQckpgi/jp
         bpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781774335; x=1782379135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXXS+DdvdpHDISQJAmld4xgdLVhKLH0Jazoj5E1xJKc=;
        b=gqdttsGuSqgIdbMJfo8QBh+EB8ruir5L6Uw4HbFmp4sS5hG98XtAwM3FZsRrmutVrH
         +j3SxEueJap59xeIpkeDSKkfq01as4SkDeAqTeB/LZb0Po1bw9YgMjkMheFTLgWx8ige
         CvLtNmhttHMhNBF8qpVaM7NewUVke3a2WJS6+AtDZWw9UFTphuCEr2HdOQFfNdjek5CH
         YEvORFQ+y/L1o2CVeGQEQzTIebwE00PIFvhGXzKwmi+7/mjGkpv5JqA+SkO2gZfxTNrL
         9T2aqHpUJ+zteXORpx/ET4aT9bRfqiNOSJI0Eo0w1XqhBxUc4wyUPxjxXNtCxiS5RVF4
         +gag==
X-Forwarded-Encrypted: i=1; AFNElJ/6YRiXf0mjjZq39lIEoREHVDZpichM4qrMlrIBQ8XGcijzWzTkzG/n4d3DB2ixF9CTM9ec0vqEnbgLuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNouQc1BGz+0WAt2AowEW4xyy2rrnmPhKH6kttaWh3ZJ7RWpMF
	SXmylNl494PLAsheHdyHTBNz5cGyBZ9SdMVag3O1NK9DGSqfboaKaaUuFR1zHarKswEnOdruflv
	9vU/nbHBC1ke6gQbZxq7ur42NtvJrxwU=
X-Gm-Gg: AfdE7clDT7M2fHX+X9dRET4U5zaje6ywd7vDczupyhf5jS9sQ9isFIuQOApbfUQZQe+
	CZZxlKzMhS0ZQGOuYtOe4CsHJaVakNnfXkt6u8EyJ13+7zTMd80snKX3M6DgSxHowpx5gOr9ohl
	OAJHULcEWxHaOFZH7/CJvw6TddAkQkxfg1HRQBkYGFSTgTa3Ct7UHsFFLZLG1CaHn9Azh4TMyx7
	wnfs6uw0vVxHIfdN9ryPSodfnx8iaHdGjVx04hOPFPI24PmQJJkB94O8/+Mn3p235B+48jGiA==
X-Received: by 2002:a05:7300:730b:b0:304:dddb:f8 with SMTP id
 5a478bee46e88-30bca20f8damr5812502eec.35.1781774335449; Thu, 18 Jun 2026
 02:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528053203.9339-1-clamor95@gmail.com> <20260528053203.9339-5-clamor95@gmail.com>
 <ajDPtOyr8GJYaVYQ@google.com> <CAPVz0n2fnM6zYtP9bCtsY9mcLdce_R+1UPmMo0o4JRgjnhuhKA@mail.gmail.com>
 <ajGyejCSRMhY4G2R@google.com>
In-Reply-To: <ajGyejCSRMhY4G2R@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 18 Jun 2026 12:18:42 +0300
X-Gm-Features: AVVi8Cf9TbqQeyGuWNgkeGWahIsHp2X0krUtvBhwls2q1omyQtqvEQF6YkA0rCg
Message-ID: <CAPVz0n0r-1SXH_dfS9HkQJrF7e-6+O5Me2bPjcscnizmfTfjZg@mail.gmail.com>
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

=D1=81=D1=80, 17 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 00:2=
3 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Jun 16, 2026 at 09:25:25AM +0300, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 16 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
07:26 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Hi Svyatoslav,
> > >
> > > On Thu, May 28, 2026 at 08:32:00AM +0300, Svyatoslav Ryhel wrote:
> > > > From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > >
> > > > Add support for multimedia top button row of ASUS Transformer's Mob=
ile
> > > > Dock keyboard. Driver is made that function keys (F1-F12) are used =
by
> > > > default which suits average Linux use better and with pressing
> > > > ScreenLock + AltGr function keys layout is switched to multimedia k=
eys.
> > > > Since this only modifies codes sent by asus-ec-keys it doesn't affe=
ct
> > > > normal keyboards at all.
> > >
> > > I think using input handler to intercept ScreenLock + AltGr is quite
> > > awkward. I think this also passes the original key events (unless you
> > > make it a filter not a regular handler).
> > >
> > > I do not see benefit for reacting to AltGr+ScreenLock on other keyboa=
rds
> > > to activate the special mode on this one. So given the fact that you
> > > already mange the data stream when you split it into "serio" ports,
> > > maybe just intercept this key combo right there and create the input
> > > device and signal input events right there?
> > >
> >
> > Though it seems awkward at a first glance, media keys are integrated
> > with a standard keyboard in a detachable dock. It is highly unlikely
> > that media keys will be used with a different keyboard then the one
> > that is integrated with dock. Additionally, the ScreenLock key has a
> > code specific to this driver and is not in general use, so even if any
> > standard keyboard has AltGr but none has ScreenLock specific to this
> > driver except the dock itself. Handler is also set as observer so it
> > should not interfere with work of other input devices.
>
> I am not concerned about it interfering with other drivers, I am
> concerned about it unnecessarily connecting to unrelated devices
> (anything that declares EV_KEY).
>
> Again, I think having input handler is not appropriate here. I would
> fold this patch into the patch that introduces the 2 serio ports,
> enhanced the data stream analysis to detect your key combo, and then
> report through this new input device. You do not need to have the round
> trip through atkbd and the new input handler for this.
>

I will try with filtering first if you don't mind. If that will not
work I'll consider folding. Do you have any good examples of handler
with filter to use as an inspiration? Thank you.

> Thanks.
>
> --
> Dmitry
