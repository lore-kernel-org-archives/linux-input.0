Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C1B375ACB
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526413; cv=pass; b=amwLOj9fE9LO6sJyu1xt19POiqvutq9HhTlvntaDAbp9jqLeJxoUdWfmqViEvDzlE2dQ6DGCe/MkGCZl3wODgwElWKEVqkmJjXOOPQjGmLFvj6jIInj9/xI3gQryWb6hF0i4JNs1hg5RWyUIGj51AOsRGKkcL1E6kyehKsTJfdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526413; c=relaxed/simple;
	bh=8wJqUMybu+9Rze5o8DcYSQ5RnrX9XW9g4G6x4CzTMJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goPGXONaFxskKXNXy21557nXDOS5KbSEYQPmKE7e/oKJMdNoj13ynzptLSLeTmNakK+MeyOK0h74thLLkGo0Is8lEg+COy71IBh2b76+C6nXhrwLy3BR4YA6rHTT/FIKgK4P9TrA7pkyW6tvL9mC0UuYxCdgg9iPxcdhw2hON7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV2YTeMN; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV2YTeMN"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so1401963a12.3
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 09:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526410; cv=none;
        d=google.com; s=arc-20260327;
        b=Car1bW3SaM+HVCUyYib/5OmWo0duey9IZw7srKCXfnoh2ShQas12pIhvdBgDjgYgSv
         txuw7BZkthGs+cBDq0taD/L471WZsa62/pZ5S177uQTp1VBCUCmomwcY9FbOGLJVwItG
         vG0xvlFzk/LaRmXxaOU0CfX0dVogX0RX/PGCjAJBaPQJNji4TY7tsbSuqrUREmE1wy1D
         fNxZJpx27HFP/6aNzA2VloQ1eizOAqKxek7URfpJxlf4irNZ6kx7gHzfzlLcBevB8txC
         472MwexMtvA+qxheGL6MTYZqnD3tIfiqJDApYxGI+hYz99LRgqTjD8LaIP2Cd5oLi9fr
         f+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8wJqUMybu+9Rze5o8DcYSQ5RnrX9XW9g4G6x4CzTMJs=;
        fh=dERT6KAvRsIGWDpDCkQb0+SNNu3F1zTMpXFlNnn4NVg=;
        b=NLWgpq+BQXcDJMvtVkWnQMIUQQySaw3fmwJ8xQiyOf8NUsiTC5L8emSILXVHV7wwXy
         DsGigFXNA/qbdJXfetK+g0I61HtaD00Q8NxU01N9mPm0vMq6KVQyRjVl6zx42a0ji5FU
         YEhIYZR6DZxjFrmK3FVlI94D2eXgd2GUv0nCwEwOUJPun8dl3AYRBMItBlYeSYrD4NjP
         03IQe9DnH+zrAQbQSG9w/Tzzye4KJCb/ecnuCfVwVtsIk5DGwKUJm0+Y1E6kP1MPFWaz
         6CuaQpNffhdXdK5NvrQ7hmPOkodFVa5Kvqdh9biJj0HnnSLCnDjpIPsCsAhbxCaOdAke
         1WOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783526410; x=1784131210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8wJqUMybu+9Rze5o8DcYSQ5RnrX9XW9g4G6x4CzTMJs=;
        b=KV2YTeMN0Ykx+N4S/p1PtoH8nYMy5i/v1uT/udy8YmMGJ90WafSQaaqtVnsBEZXTsE
         F/kodxn0QQXEKFwCHdjs3Zm8A9YH3kcVtMoMoxN7xDDt5z6SpKVx3pI/GIUnD+spZ48d
         msQnQFMmwKw6LhPirCCzJE6P7RzOFQwUvO5nWQR10XL/dP34o33I/yXMOZH5rJaGHnwL
         BdBS00DU4ndqK5ouJ1sN2u9HdVouWGLllhXNLfPO1XFmlbWwciyAOcrhynCt39S/cMme
         lwcIXWpmiwxqJLFjTZ2Pp1GP22XzZuTPU7udSNR+mQ9PqAT9sAlHHxiX/N3EVmLiDLeS
         Bszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526410; x=1784131210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wJqUMybu+9Rze5o8DcYSQ5RnrX9XW9g4G6x4CzTMJs=;
        b=PM4rkpyORFBQFKsQqp/sx+3Vmpy7PLrdAEQ0iju5PS4XFcvujErkDspyel7Kz87h1g
         j9FG205U2M6MwuFCHmET6mt3kTe7ElhFLcC4Q1oFUFT6KJGQiVqKQLY2cr5pw1XwMRGc
         yeokWjOivKII1MgZPmmOC9A1Qauo2nfitcK3gfkDBtoBbdA3axp8dQoJbkBEypM2X7Lc
         HlyAOFY4KXPJQT2cwJ5A65DBGaDCSlqYcGET15k5hFCgWza106ejyX2iUPy0ix20SMpP
         XXf2Ui+Fqo6FkJknEKB/ooNuzU6ruu3kMGFUC/CyGo/wQMFduLsYOfb/XHi8MsB14k7/
         ZZBQ==
X-Gm-Message-State: AOJu0YzC1JOatm1D+OtvU1h3dBtkKh/rQhclvN18mY5joZ9JT47B6BNt
	540NxdEXtCCdHlIRx6TM85Q1QmS3sLJm5Tm0r0kFdsg2L+Tcab9VCwzHUfKIubT3ibTN0xfctOz
	Wi3+UIiECkXJ0Un5uFgYxhALMPurTYHI=
X-Gm-Gg: AfdE7clWuB3UJniP4/qhd6l6DDGNzfXqpiJFHjiTrJ6QDTYQ9o9VXDw37IhCXAX2MmQ
	eyVbd7hZbMPH0hq6texdgq+SRTu0VM5rBdjSYyNmHl8bGO2gzdSaY41XFIEML54NfivtWAtLNEa
	3ZMoAqXYYAKaLN5uEDNCCLa3M3QifbuF25XnMLoIvVXZBhHHvx8voLuB/kpQ6QVJgKncHCn0KgL
	ka3FR2hJFBOHN6elyIZiiUlmn6lTBRWl4pBytK8XuH3w9Hp42Q1Wtggg1mUtZoplJ8qNuI=
X-Received: by 2002:a05:6402:4510:b0:698:3b7c:7e2c with SMTP id
 4fb4d7f45d1cf-69ab44aead7mr1482649a12.36.1783526409566; Wed, 08 Jul 2026
 09:00:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4130C026-2A83-408B-836A-ECA044491C47@gmail.com>
In-Reply-To: <4130C026-2A83-408B-836A-ECA044491C47@gmail.com>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Wed, 8 Jul 2026 18:59:57 +0300
X-Gm-Features: AVVi8Cd9ZOoKd0Qt_3UNK6_c-e907tH6GnmpgXYDV7_ypOSttuGKpzxKmkvrHmA
Message-ID: <CAKNVLfZSjWgiT7cwy4kf3QLq49yzU6PPZQBiRpmU-fARA3iqFg@mail.gmail.com>
Subject: Re: [RFC] Input: matrix_keypad: fix interrupt regression introduced
 by commit 01c84b03d80a
To: Alexander Kochetkov <al.kochet@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Regarding JZ4755, I agree that the [1] patch can be reverted.
No device requiring this workaround has landed in the mainline.
qi,lb60 (Ben Nanonote) seems unaffected as it was there before
the patch was proposed.

However, if there are genuinely two hardware operating modes:
- "GPIO input mode" while scanning
- "GPIO interrupt input mode" while idle
then the keypad driver should be aware of this distinction.

I'd like to propose pinctrl state transitions as the mechanism for switchin=
g
these modes, wherever it makes sense (Allwinner et al).

CC Paul as the maintainer of Ingenic pinctrl driver.

BR,
Siarhei


=D1=81=D1=80, 8 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 16:30, Alex=
ander Kochetkov <al.kochet@gmail.com>:
>
> Hi everyone,
>
> I found a commit [1] that breaks the matrix_keypad behavior on the Allwin=
ner A64.
>
> I have a PINE A64-LTS board with a connected keypad polled by matrix_keyp=
ad.
> This commit caused interrupts to stop arriving at the matrix_keypad drive=
r entirely.
>
> An explicit call to gpiod_direction_input() disables interrupt reception =
on all chips
> where the GPIO input mode and GPIO interrupt input mode are configured vi=
a
> the pinmux register. Interrupt reception is guaranteed to break on Allwin=
ner
> (A64, H3, H6, etc.), Broadcom (BCM2835/2711), and some Rockchip SoCs. It
> does not break on NXP i.MX (i.MX6, i.MX8), STMicroelectronics (STM32MP1),
> TI Sitara (AM335x), or Intel/AMD.
>
> Furthermore, the assumption that enable_row_irqs() restores the interrupt=
 mode is
> also specific to the Ingenic pinctrl. In the vast majority of drivers, en=
able_row_irqs() is
> supposed to simply set the interrupt enable mask without changing the pin=
mux.
>
> Commit [1] was introduced to work around a hardware limitation in Ingenic=
's JZ4755.
> This specific behavior is unique to Ingenic and a small number of special=
ized chips.
> The majority of SoCs (around 90%) allow reading a GPIO input that is curr=
ently configured
> as an interrupt source.
>
> In my opinion, the correct approach would be to revert this commit and fi=
x the behavior of
> ingenic_gpio_get_value() inside pinctrl-ingenic.c instead. However, I do =
not own an Ingenic
> board, so I won't be able to test such a patch.
>
> Alternatively, I could introduce a DTS property like read-gpio-quirk in m=
atrix_keypad to restore
> the original driver behavior by default, and add this property to qi_lb60=
.dts so as not to break
> the Ingenic platform.
>
> What do you think? What is the best way to proceed here?
>
> Best regards,
> Alexander Kochetkov
>
> [1] commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29 ("Input: matrix_keypa=
d - force switch rows to input mode")
