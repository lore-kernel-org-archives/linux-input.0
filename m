Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07650381B04
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612316; cv=pass; b=M65kFh/7wCV3ig+KtRMaBwQ1s/fLI4U38T/xlVRS6rMlGhx9DhsYf35QK8xiel8zE8TURZYDR0lqRvOIpm2FZfFlBvNTjqPVAo8jb5+1opgRp8WJwsOE4ghwpJ5iBTCa3uEGnMjND4xlR6Jmo6UprH7rYJMA9cEtGLFWjPWE9UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612316; c=relaxed/simple;
	bh=b0/0kxre5xjBrVj4aOiM2GU678inpy/D6b6HsWVXpM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V43StXtEW39OdUeyHdxAnZD+OgB9oVuCaF3xc4r7itCIwgWMxTfVls3Bx+iSvgtjL2Gvj9ZgwQDMRi84ST1C7x0Eqv48gse6dOsFzBwZESSb1adrwORMrpyEL1n2x1M+MLc+bi9LflbnI//hj4hBV0xeXoiQ6L26OZsaLJK6hmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB8oDVZa; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB8oDVZa"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c029505b389so177505966b.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 08:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783612313; cv=none;
        d=google.com; s=arc-20260327;
        b=ayIYzKyNTMdmwUnqwUz8cf6Y9045bCD/4fxZTCJ5aHuhThDeePJN5zIWFUBx+KzaOC
         enPD10+R9exNmcKbCKga90X/V5TejRFImBXRZhPZeqF6I7nWMvxmwZRxxLRZh0olMFWg
         mBg6gFiKxAECko4LPKgpDWSkVgwustum8LOYt3I1y9JLYwQr2ZHAvGWpffepcAiKzGWS
         ATsplnBNHo3WMGJTDAQlwKmRoI2aSQh/v0d4fmO7+HPN1vfkDjPW93OK9z+8bghUCeEX
         jE1em08Gp01TG8uSs30beNGB4Wpj1WKrhPwWiVureZUPVjpJOiki+PO6Nk1EznlvgVCh
         lvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b0/0kxre5xjBrVj4aOiM2GU678inpy/D6b6HsWVXpM0=;
        fh=aWKUvRx/0DpoYVBDXq6wJDl0O6mWTMEewh+P2EPnInc=;
        b=BC6bl+1YNCTI/q8nK9NRhxiYYaFAAg35uFPd3zrhoZoho4oTJ2Ugmk71dMNSunLkBR
         xZ48Viw2ewblwQPV/CrAGRPowo/Q3asURh1VLvS7tSHBt8dM8LYQ8H8gHfd5nkDal3oq
         6jO6aY4+mRltybKMq5/ZCReDqhKh+D8YhTP5nBxyM6ZBmeT3NI8B+7TGjDb5Edm84m8b
         eEvXYgd/8Y3TwjDtEeczkFhq7D8sG8FIzKNBKvNnVPFaOL5i0UcYMwbaAup6CMOGN2CO
         WU/E2Wg22yI16AzrHP7FdFb1ozklhOqfdOitQvDEdkl7yoqKSlK/S5dOhKyirhbDqN1H
         z50Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783612313; x=1784217113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b0/0kxre5xjBrVj4aOiM2GU678inpy/D6b6HsWVXpM0=;
        b=KB8oDVZat97CssqGU4XQrlBgIefdwcLf1u5Q4WP7iUBLytUknCnmk8hXOImty3D2YZ
         cvaH8pjEcRoaKv+gv2k01dP8DIXSF4G2EzHiWJYpV/FpXcrjgVKA1+D56r4NwrPZiVuf
         avYGSAxnkOZs6nTFmG/s+bkeZahmWVNP+Sye3T5j+M2Q75dLDKNSDAeL/rDLixOFM0Rm
         +X5fhlimxOnByNT8bg8rxMvEeqKg4D74JyM41sMZjeUexXOTGa0q4/reLY5FkFrSDEU8
         vPRal0Pb7anElnZGoD9usyPPfGq1/Huv43rv0MthXljpyE8Q+ZBaMc6zSBB+XzD7OuZJ
         5uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612313; x=1784217113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b0/0kxre5xjBrVj4aOiM2GU678inpy/D6b6HsWVXpM0=;
        b=isUiar8FdPaCLK+d7ApRIIZiYcYah48ZvcRfJyTkmYEwreenQaxORDWLYEyKh9F2G7
         btkbrVX6Naoz7i8H9jrNk70i9OwkpYjoKXW1iFOThyDehHYIBSuh656h7bUshqZbl8V6
         RDJCoIGt1Ph4wPm1N2H54iaKMtmiogMnlvmvHvboYz6eOmkYKz5ByEukwKlcqOnaVO6N
         zxPRHpYLfwLWpcn9snOaCcjuTc1FmkLgcXMy5RrN8Y6iUvdUgUzF9mMR4EyJrz69Paq3
         1IH7ILgLZchHaTbeilQjn6qerc5BMcmQFxfcq4kBgDkV5u80q17a/DgXSTAHD5IOcz2s
         4yZA==
X-Forwarded-Encrypted: i=1; AHgh+RprxnXZu5Pf5uV+iusRaqqOBKBgZNq9Avw9wc6B8MXllTN9Tzyt//hb/0XikZ1OSo1+CcrnDt7DtO1hjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyGH4Rs1ztPbC7jqMnzTZQZDCb8RC9znhtYgjYAhYaAXTKFxA
	vmExBWJ2Mt2XqNa8wJ9HHMwTvfvuRZOLOq/i3ReNpYD892YbyOlpWZBbt8+ALld0huyHxeEMF4D
	ewdiwfCrp2Qa6sDMInOVmZxCx1UTLJl0=
X-Gm-Gg: AfdE7ckTs6pi6HfmLxPpnSNi2/tyG5jyYLN3vYRwdOKQ1XK1T4Z2dNMld6FtMPy8NNc
	FZtrNCJZZZwnrGszyetlcUdKJHGih5i0IKhsktAL9mq5GsGPmBUD0SI26v8sL4flHFWYaWHIvok
	A8DVgTMF35e16N/6NCpcygv/hA0nASR8gYuxMx6yNPvo/cxfxc7BE1iAosdT7kcwGJfWwALgt4r
	NjtU/+RbMCTwtDfobnXmwKZsf8JmvFnDCjeGjejddCnINbCs51BefXPqlG82HDIbAvRc20kIujc
	VeXE/g==
X-Received: by 2002:a17:906:2081:b0:c12:5970:e62d with SMTP id
 a640c23a62f3a-c15e782ccf7mr115010066b.29.1783612313161; Thu, 09 Jul 2026
 08:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4130C026-2A83-408B-836A-ECA044491C47@gmail.com>
 <CAKNVLfZSjWgiT7cwy4kf3QLq49yzU6PPZQBiRpmU-fARA3iqFg@mail.gmail.com> <f8a6f9e3f5a7582c708669f22733add1a6b9ea8e.camel@crapouillou.net>
In-Reply-To: <f8a6f9e3f5a7582c708669f22733add1a6b9ea8e.camel@crapouillou.net>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Thu, 9 Jul 2026 18:51:42 +0300
X-Gm-Features: AVVi8CeVytOXpxtam9GV8CeJJZ7SzATXpXLuUbvlleOWIhLE89f0hRMPOKQP0Nw
Message-ID: <CAKNVLfbK5TEFSRuJSv-3Bvx+JjLuPTn1LjKj7nBEEdGxsqiQjg@mail.gmail.com>
Subject: Re: [RFC] Input: matrix_keypad: fix interrupt regression introduced
 by commit 01c84b03d80a
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Siarhei, do you remember the context of that patch?

Yes. My understanding is that at least some Ingenic GPIO controllers
don't report the current input level while the pin is configured for IRQs,
but instead expose the level latched at the moment the interrupt occurred.
That's what I was trying to work around.

> That was definitely working on the SoC I tested ...

You wouldn't notice this with the gpio-keys driver because its usage
pattern matches this behavior. For example, if the IRQ is configured
for the falling edge, then when the interrupt fires the level register will
read 0, which is exactly what gpio-keys expects.

I'm not sure whether this affects all Ingenic GPIO controllers,
but it should be easy to verify. For testing, you could temporarily
modify the driver as follows:

In the IRQ handler, before reconfiguring the IRQ for the opposite edge:
- read and print the GPIO level register/bit;
- wait for an arbitrary amount of time (long enough to release the
button between the two reads);
- read and print the GPIO level register/bit again.

If both reads return 0, even though the button has been released,
then the controller behaves like the JZ4755 and latches the GPIO
level at the time of the interrupt.
If the first read returns 0 and the second returns 1, then the controller
reports the live GPIO input level, as typical GPIO controllers do.

> I wonder if you were just experiencing bouncing?

I'm sure no, I remember that without that patch, I got the same readings
for all buttons in a row, no matter which column was active and as far as I
remember I tested it with arbitrary long col-scan-delay-us in range of
10-100 ms.

BR,
Siarhei

=D1=87=D1=82, 9 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 13:25, Paul=
 Cercueil <paul@crapouillou.net>:
>
> Hi,
>
> Siarhei, do you remember the context of that patch?
>
> The driver will read the pin level to emulate pins configured in "both
> edges" IRQ mode, and switch to "rising edge" if low, and "falling edge"
> if high. That was definitely working on the SoC I tested it with
> (probably JZ4770). I would be surprised if it did not work on the
> JZ4755.
>
> You mention in that commit message that you would get the pin level
> before the interrupt happened, I wonder if you were just experiencing
> bouncing?
>
> Anyway, I agree that this commit can be reverted.
>
> Le mercredi 08 juillet 2026 =C3=A0 18:59 +0300, Siarhei Volkau a =C3=A9cr=
it :
> > Regarding JZ4755, I agree that the [1] patch can be reverted.
> > No device requiring this workaround has landed in the mainline.
> > qi,lb60 (Ben Nanonote) seems unaffected as it was there before
> > the patch was proposed.
> >
> > However, if there are genuinely two hardware operating modes:
> > - "GPIO input mode" while scanning
> > - "GPIO interrupt input mode" while idle
> > then the keypad driver should be aware of this distinction.
> >
> > I'd like to propose pinctrl state transitions as the mechanism for
> > switching
> > these modes, wherever it makes sense (Allwinner et al).
>
> I agree.
>
> >
> > CC Paul as the maintainer of Ingenic pinctrl driver.
> >
> > BR,
> > Siarhei
>
> Cheers,
> -Paul
>
> >
> >
> > =D1=81=D1=80, 8 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 16:30, =
Alexander Kochetkov
> > <al.kochet@gmail.com>:
> > >
> > > Hi everyone,
> > >
> > > I found a commit [1] that breaks the matrix_keypad behavior on the
> > > Allwinner A64.
> > >
> > > I have a PINE A64-LTS board with a connected keypad polled by
> > > matrix_keypad.
> > > This commit caused interrupts to stop arriving at the matrix_keypad
> > > driver entirely.
> > >
> > > An explicit call to gpiod_direction_input() disables interrupt
> > > reception on all chips
> > > where the GPIO input mode and GPIO interrupt input mode are
> > > configured via
> > > the pinmux register. Interrupt reception is guaranteed to break on
> > > Allwinner
> > > (A64, H3, H6, etc.), Broadcom (BCM2835/2711), and some Rockchip
> > > SoCs. It
> > > does not break on NXP i.MX (i.MX6, i.MX8), STMicroelectronics
> > > (STM32MP1),
> > > TI Sitara (AM335x), or Intel/AMD.
> > >
> > > Furthermore, the assumption that enable_row_irqs() restores the
> > > interrupt mode is
> > > also specific to the Ingenic pinctrl. In the vast majority of
> > > drivers, enable_row_irqs() is
> > > supposed to simply set the interrupt enable mask without changing
> > > the pinmux.
> > >
> > > Commit [1] was introduced to work around a hardware limitation in
> > > Ingenic's JZ4755.
> > > This specific behavior is unique to Ingenic and a small number of
> > > specialized chips.
> > > The majority of SoCs (around 90%) allow reading a GPIO input that
> > > is currently configured
> > > as an interrupt source.
> > >
> > > In my opinion, the correct approach would be to revert this commit
> > > and fix the behavior of
> > > ingenic_gpio_get_value() inside pinctrl-ingenic.c instead. However,
> > > I do not own an Ingenic
> > > board, so I won't be able to test such a patch.
> > >
> > > Alternatively, I could introduce a DTS property like read-gpio-
> > > quirk in matrix_keypad to restore
> > > the original driver behavior by default, and add this property to
> > > qi_lb60.dts so as not to break
> > > the Ingenic platform.
> > >
> > > What do you think? What is the best way to proceed here?
> > >
> > > Best regards,
> > > Alexander Kochetkov
> > >
> > > [1] commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29 ("Input:
> > > matrix_keypad - force switch rows to input mode")
