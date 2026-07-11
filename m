Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A3372EEF
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783767569; cv=pass; b=kI6+Fhge9fv5bdobtt1JD6TJolvw0sFR3+6JBny+ceJjHutQp7OctIdsItUtZeO4kGwEpLIMZ8bG3FV/pYo6UevgirJVpC26K8Z4TtyYNpVNw6CtxSZ9mQHMZznx57Fh3Av4iYIJXbBj4sLqiqUds+VOoq3pjjhdeOHfxdRyKho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783767569; c=relaxed/simple;
	bh=8U7Zbw5wkNzV8H2qbxwZdoYclSWhOBQ0taPpBSOtX/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKPGCp6NTvjLZ/zv3t49pjy/yuWuUdNBplfQmGBqji8BC6f8YJp2sLEOIxRAqYXrHVVs8/+sLW7UtHY6oexoQ4OHrJSIrxGe0zBl/zfIrQg92xat9pvVOJMIOiEdeGTGa2APtG+EeLer9rWXD1KfukKoiFtHubWK+6JyqIQC3ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEgb71t3; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEgb71t3"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15c7d22070so235073966b.2
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 03:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783767566; cv=none;
        d=google.com; s=arc-20260327;
        b=Om2f9f0wZqBVOqvFrdjRK+GEruxPd/E7vFlnpOfCD++FhMIYZ4UYxLugTxzjYvvKMM
         pUFlgZnLFjmaBEvE6wkCrG1DeVqbtIj6t96yFu35OJTUqJnJWRUIWo9cdkxJ1l36owUR
         lIxRv2hddSx58qovJJW0JEz/rFBj3vng5AY1S78oaEP9aEEVvM32Fi/W297cqMFx74b4
         qjcebIQkoHFgewso3aN05b+lLS9FFrIU1nASFU4uvIkxy5yBVZ+50VxJiziORG6fZZPI
         PWSWDege1ShMPbUFAz8khu6l7TVdZ/wgsdnCatDoO1jHQXTsfRbw3oBpfAummrGksqqE
         notQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8U7Zbw5wkNzV8H2qbxwZdoYclSWhOBQ0taPpBSOtX/o=;
        fh=XzrJXVMqEgYNsZ+ocD7TO91Ur9B6R7souog47LsArtY=;
        b=SovXjL8qD+f5CKKvXkhvGAdETUi4N/9zPqJHl+VsDkdfDEOv+5D61mkOpL3MKBJWXx
         ay8FIngiYwBPM+b0o5BoOmQVprzc7Ym28swYPqzcxdZfbyS5aiyuLC29WBmycZCcpf/U
         8d/PzOt3RSsPaK8Uua9oxt/UK1YHxtNEfwFcQDB8iZ50zW5n2We47G36vn9JUXrd2Cyf
         Ptuj+dRoy6lLgD+HboIoqh1SlVHxQiG5SkY3tVdw3/qITVWf66uOaXCwTMw7E1t3thE9
         dUeJo4TexNdOAHrYmur9i27lAORVjFOkbnIchvbO2987DfvWSEu6nJ/xhynGRsUEAckz
         4y0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783767566; x=1784372366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8U7Zbw5wkNzV8H2qbxwZdoYclSWhOBQ0taPpBSOtX/o=;
        b=DEgb71t3If89iV8pB2evNgky0n63ijV3CIsgscrdCFFjmxeMOiH4QCLFlpl517OWfD
         SXilzM1Q5reIcrrjh4sQagW8AA81VsPu/NUfyURMUxgbdXYE4hvpGh0lLjHhOe4zSED5
         Alp5Q1LJvvbYkvPtflm7+Pc7IPosksbN/Z8n9IzrTmSqWMBOoGzWwS620MgAsVZbtVMe
         sGWdspULwonADZUubce8ucog4B7AGs9MhsXlRHw7q9/kRMs7c2qiScc37g5Cz2nA2eHu
         O0oABaQjWtUa5C1vGuAKw+sSONPPAqzCWh2q4UaJEs3XiJdZCQpWGrAyKpg4cD+Ckswh
         PUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783767566; x=1784372366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8U7Zbw5wkNzV8H2qbxwZdoYclSWhOBQ0taPpBSOtX/o=;
        b=S9tsPIX29/Lso2GBnjHR3M2GrNXusFeD9h0Vc+0yBDvTsQoL3qiHubwF1GuRwTg0mR
         EYzrwJT7b4FNBuyCFnalwdQcI/DHJq+wbPdgE/5pa24vC1pkWtmvlN37fjZotIQvhV5l
         cAJXrCqM1Ln9Mp6IgLlGHNTvGykOW1695JPuJJTLX+bIITygB29lj/iUz0jd7PJXYjSL
         md3HuTBNnsuJ/RwxwWXSHi8nqd1UprWoDwz6rcaGqpTpw8NexeDy6dttT3r+efDngb7M
         ii9V/dEDpdUeykHq2E28wY9u2Vc+b3THxnJ7BuX3EWvkZei+7nlxZ/k9ph2CvvOwLVX1
         45UQ==
X-Forwarded-Encrypted: i=1; AHgh+RqE4LskRMK6X/fV3Kr8z+Sb4WNdSIXTBndGJlXTWIklyR3cEWjzWZcMb6zkmwM2v07R5w7ifAovXnl9sw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6L321Egr039MzIY3whOnOBSwv4XoZpvsMdjZqe2XZpEk9hGYB
	VnXTXbMnE8VTBR2+JYR6VO3cLWudDCD4LRGiQZhvA47d2v6POdTlMKl486Omi2LyxPnrFbEeeyh
	0qq12FpDDj/hqHJWgTYinZWKoby+AXPs=
X-Gm-Gg: AfdE7clhyHP8YLerWoogjv5p9els3txuwevL4PUPE/gp0kVjBwDooQTSbMSr01/1ywm
	P/op7QUOivcAa0FIIDaZ4pwTVby3qDY/ztF5X5t6UFc7dplIh4oX+LKQS6GBY+zEOtKs1uSWEV+
	QNyVovZx4Vc0RMh8NmSXYkzS6Xl7FhXh+PYXXQVnTNzR9PXhtmXud7tbuKsAf/X/YPF9JQuQLG4
	u/gOgzUJjF7b/PkSSD0j53NogmtZnrmXR3fY1D6P75ZJIUamnj3fxHdL7QhWcQFmuWx8uU=
X-Received: by 2002:a17:907:3e02:b0:c10:256:3d6a with SMTP id
 a640c23a62f3a-c161ea79a5amr108215866b.31.1783767566245; Sat, 11 Jul 2026
 03:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4130C026-2A83-408B-836A-ECA044491C47@gmail.com>
 <CAKNVLfZSjWgiT7cwy4kf3QLq49yzU6PPZQBiRpmU-fARA3iqFg@mail.gmail.com>
 <f8a6f9e3f5a7582c708669f22733add1a6b9ea8e.camel@crapouillou.net> <CAKNVLfbK5TEFSRuJSv-3Bvx+JjLuPTn1LjKj7nBEEdGxsqiQjg@mail.gmail.com>
In-Reply-To: <CAKNVLfbK5TEFSRuJSv-3Bvx+JjLuPTn1LjKj7nBEEdGxsqiQjg@mail.gmail.com>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Sat, 11 Jul 2026 13:59:15 +0300
X-Gm-Features: AVVi8CfX52Hrjp_6sHEUFAGBN08XqybmaTfD_GRjXW0qdIfUd7wLJc1zla3GOqI
Message-ID: <CAKNVLfas9vmOFRhaozsBgBf8tb_HR6mCMOyw=gHSTm2HxBHSXQ@mail.gmail.com>
Subject: Re: [RFC] Input: matrix_keypad: fix interrupt regression introduced
 by commit 01c84b03d80a
To: Paul Cercueil <paul@crapouillou.net>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, linux-input@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> For testing, you could temporarily modify the driver

I've done the test on all JZ47xx I have and it turns out that
my assumption was wrong. All of them report live state of
the pin.

So, guys, the patch can be reverted with no doubts.

BR,
Siarhei

=D1=87=D1=82, 9 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 18:51, Siar=
hei Volkau <lis8215@gmail.com>:
>
> > Siarhei, do you remember the context of that patch?
>
> Yes. My understanding is that at least some Ingenic GPIO controllers
> don't report the current input level while the pin is configured for IRQs=
,
> but instead expose the level latched at the moment the interrupt occurred=
.
> That's what I was trying to work around.
>
> > That was definitely working on the SoC I tested ...
>
> You wouldn't notice this with the gpio-keys driver because its usage
> pattern matches this behavior. For example, if the IRQ is configured
> for the falling edge, then when the interrupt fires the level register wi=
ll
> read 0, which is exactly what gpio-keys expects.
>
> I'm not sure whether this affects all Ingenic GPIO controllers,
> but it should be easy to verify. For testing, you could temporarily
> modify the driver as follows:
>
> In the IRQ handler, before reconfiguring the IRQ for the opposite edge:
> - read and print the GPIO level register/bit;
> - wait for an arbitrary amount of time (long enough to release the
> button between the two reads);
> - read and print the GPIO level register/bit again.
>
> If both reads return 0, even though the button has been released,
> then the controller behaves like the JZ4755 and latches the GPIO
> level at the time of the interrupt.
> If the first read returns 0 and the second returns 1, then the controller
> reports the live GPIO input level, as typical GPIO controllers do.
>
> > I wonder if you were just experiencing bouncing?
>
> I'm sure no, I remember that without that patch, I got the same readings
> for all buttons in a row, no matter which column was active and as far as=
 I
> remember I tested it with arbitrary long col-scan-delay-us in range of
> 10-100 ms.
>
> BR,
> Siarhei
>
> =D1=87=D1=82, 9 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 13:25, Pa=
ul Cercueil <paul@crapouillou.net>:
> >
> > Hi,
> >
> > Siarhei, do you remember the context of that patch?
> >
> > The driver will read the pin level to emulate pins configured in "both
> > edges" IRQ mode, and switch to "rising edge" if low, and "falling edge"
> > if high. That was definitely working on the SoC I tested it with
> > (probably JZ4770). I would be surprised if it did not work on the
> > JZ4755.
> >
> > You mention in that commit message that you would get the pin level
> > before the interrupt happened, I wonder if you were just experiencing
> > bouncing?
> >
> > Anyway, I agree that this commit can be reverted.
> >
> > Le mercredi 08 juillet 2026 =C3=A0 18:59 +0300, Siarhei Volkau a =C3=A9=
crit :
> > > Regarding JZ4755, I agree that the [1] patch can be reverted.
> > > No device requiring this workaround has landed in the mainline.
> > > qi,lb60 (Ben Nanonote) seems unaffected as it was there before
> > > the patch was proposed.
> > >
> > > However, if there are genuinely two hardware operating modes:
> > > - "GPIO input mode" while scanning
> > > - "GPIO interrupt input mode" while idle
> > > then the keypad driver should be aware of this distinction.
> > >
> > > I'd like to propose pinctrl state transitions as the mechanism for
> > > switching
> > > these modes, wherever it makes sense (Allwinner et al).
> >
> > I agree.
> >
> > >
> > > CC Paul as the maintainer of Ingenic pinctrl driver.
> > >
> > > BR,
> > > Siarhei
> >
> > Cheers,
> > -Paul
> >
> > >
> > >
> > > =D1=81=D1=80, 8 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 16:30=
, Alexander Kochetkov
> > > <al.kochet@gmail.com>:
> > > >
> > > > Hi everyone,
> > > >
> > > > I found a commit [1] that breaks the matrix_keypad behavior on the
> > > > Allwinner A64.
> > > >
> > > > I have a PINE A64-LTS board with a connected keypad polled by
> > > > matrix_keypad.
> > > > This commit caused interrupts to stop arriving at the matrix_keypad
> > > > driver entirely.
> > > >
> > > > An explicit call to gpiod_direction_input() disables interrupt
> > > > reception on all chips
> > > > where the GPIO input mode and GPIO interrupt input mode are
> > > > configured via
> > > > the pinmux register. Interrupt reception is guaranteed to break on
> > > > Allwinner
> > > > (A64, H3, H6, etc.), Broadcom (BCM2835/2711), and some Rockchip
> > > > SoCs. It
> > > > does not break on NXP i.MX (i.MX6, i.MX8), STMicroelectronics
> > > > (STM32MP1),
> > > > TI Sitara (AM335x), or Intel/AMD.
> > > >
> > > > Furthermore, the assumption that enable_row_irqs() restores the
> > > > interrupt mode is
> > > > also specific to the Ingenic pinctrl. In the vast majority of
> > > > drivers, enable_row_irqs() is
> > > > supposed to simply set the interrupt enable mask without changing
> > > > the pinmux.
> > > >
> > > > Commit [1] was introduced to work around a hardware limitation in
> > > > Ingenic's JZ4755.
> > > > This specific behavior is unique to Ingenic and a small number of
> > > > specialized chips.
> > > > The majority of SoCs (around 90%) allow reading a GPIO input that
> > > > is currently configured
> > > > as an interrupt source.
> > > >
> > > > In my opinion, the correct approach would be to revert this commit
> > > > and fix the behavior of
> > > > ingenic_gpio_get_value() inside pinctrl-ingenic.c instead. However,
> > > > I do not own an Ingenic
> > > > board, so I won't be able to test such a patch.
> > > >
> > > > Alternatively, I could introduce a DTS property like read-gpio-
> > > > quirk in matrix_keypad to restore
> > > > the original driver behavior by default, and add this property to
> > > > qi_lb60.dts so as not to break
> > > > the Ingenic platform.
> > > >
> > > > What do you think? What is the best way to proceed here?
> > > >
> > > > Best regards,
> > > > Alexander Kochetkov
> > > >
> > > > [1] commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29 ("Input:
> > > > matrix_keypad - force switch rows to input mode")
