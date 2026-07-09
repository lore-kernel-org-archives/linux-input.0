Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F1301471;
	Thu,  9 Jul 2026 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592720; cv=none; b=dZyUU5H6qbwtblukNyaZyJ+Jvv6zQ2dRUTOjeXvSJ5WQJXZpfmQQJrlFjzt4qHkeA523pXSTk3754g4Fpa/smHDi/NOxXb3M1Nha58j1/InadskIZakhmOPj2Di34H0QhGIwHh32VX1ddJoIwmCmoyiHUBDr6ZvzO1C75Te5G/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592720; c=relaxed/simple;
	bh=ftsWCvmh+g2E8CcvNFbXzwQuMwMaePiI6nBCWtB8quo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MBWg7dxss5AXgIJpT676amGCZtsagrTPvs72ZRiU1lP9/YqrOWkFpBP4HFuLGWJA/fKRIX6/dp0s/KvNGY8EvrrPus3PFz+I1juBN13I1NlQgON+gBtLoVvA8+8WcK93vF6F0Bo2zz/YcC0fqp1H+7P3Ds8MXdEXSgRqmBcVVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=wx/zCKdK; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wx/zCKdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1783592710;
	bh=ftsWCvmh+g2E8CcvNFbXzwQuMwMaePiI6nBCWtB8quo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=wx/zCKdKkOvs9Htbe9Q/WiVsDeg5xhqwyI1t2JCrFaS0z1ml6C22KWFl9lyDBRRVQ
	 T9iRxjiNvrU1djm3DXA6zXmGm/mi6hU3DyxxpTJ0VIUzLL9xjLdNYAUwnkuiWjEh0C
	 yKFaP/wdY7coFYw79hlOwY1YtkuipRVOimzejHBQ=
Message-ID: <f8a6f9e3f5a7582c708669f22733add1a6b9ea8e.camel@crapouillou.net>
Subject: Re: [RFC] Input: matrix_keypad: fix interrupt regression introduced
 by commit 01c84b03d80a
From: Paul Cercueil <paul@crapouillou.net>
To: Siarhei Volkau <lis8215@gmail.com>, Alexander Kochetkov
	 <al.kochet@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, 	linux-kernel@vger.kernel.org
Date: Thu, 09 Jul 2026 12:25:06 +0200
In-Reply-To: <CAKNVLfZSjWgiT7cwy4kf3QLq49yzU6PPZQBiRpmU-fARA3iqFg@mail.gmail.com>
References: <4130C026-2A83-408B-836A-ECA044491C47@gmail.com>
	 <CAKNVLfZSjWgiT7cwy4kf3QLq49yzU6PPZQBiRpmU-fARA3iqFg@mail.gmail.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZM
 LQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5Uz
 FZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtN
 z8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe
 +rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY
 3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr
 1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f
 33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIP
 dlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET
 4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7U
 rf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KF
 lBwgAhlGy6nqP7O3u7q23hRU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Siarhei, do you remember the context of that patch?

The driver will read the pin level to emulate pins configured in "both
edges" IRQ mode, and switch to "rising edge" if low, and "falling edge"
if high. That was definitely working on the SoC I tested it with
(probably JZ4770). I would be surprised if it did not work on the
JZ4755.

You mention in that commit message that you would get the pin level
before the interrupt happened, I wonder if you were just experiencing
bouncing?

Anyway, I agree that this commit can be reverted.

Le mercredi 08 juillet 2026 =C3=A0 18:59 +0300, Siarhei Volkau a =C3=A9crit=
=C2=A0:
> Regarding JZ4755, I agree that the [1] patch can be reverted.
> No device requiring this workaround has landed in the mainline.
> qi,lb60 (Ben Nanonote) seems unaffected as it was there before
> the patch was proposed.
>=20
> However, if there are genuinely two hardware operating modes:
> - "GPIO input mode" while scanning
> - "GPIO interrupt input mode" while idle
> then the keypad driver should be aware of this distinction.
>=20
> I'd like to propose pinctrl state transitions as the mechanism for
> switching
> these modes, wherever it makes sense (Allwinner et al).

I agree.

>=20
> CC Paul as the maintainer of Ingenic pinctrl driver.
>=20
> BR,
> Siarhei

Cheers,
-Paul

>=20
>=20
> =D1=81=D1=80, 8 =D0=B8=D1=8E=D0=BB. 2026=E2=80=AF=D0=B3. =D0=B2 16:30, Al=
exander Kochetkov
> <al.kochet@gmail.com>:
> >=20
> > Hi everyone,
> >=20
> > I found a commit [1] that breaks the matrix_keypad behavior on the
> > Allwinner A64.
> >=20
> > I have a PINE A64-LTS board with a connected keypad polled by
> > matrix_keypad.
> > This commit caused interrupts to stop arriving at the matrix_keypad
> > driver entirely.
> >=20
> > An explicit call to gpiod_direction_input() disables interrupt
> > reception on all chips
> > where the GPIO input mode and GPIO interrupt input mode are
> > configured via
> > the pinmux register. Interrupt reception is guaranteed to break on
> > Allwinner
> > (A64, H3, H6, etc.), Broadcom (BCM2835/2711), and some Rockchip
> > SoCs. It
> > does not break on NXP i.MX (i.MX6, i.MX8), STMicroelectronics
> > (STM32MP1),
> > TI Sitara (AM335x), or Intel/AMD.
> >=20
> > Furthermore, the assumption that enable_row_irqs() restores the
> > interrupt mode is
> > also specific to the Ingenic pinctrl. In the vast majority of
> > drivers, enable_row_irqs() is
> > supposed to simply set the interrupt enable mask without changing
> > the pinmux.
> >=20
> > Commit [1] was introduced to work around a hardware limitation in
> > Ingenic's JZ4755.
> > This specific behavior is unique to Ingenic and a small number of
> > specialized chips.
> > The majority of SoCs (around 90%) allow reading a GPIO input that
> > is currently configured
> > as an interrupt source.
> >=20
> > In my opinion, the correct approach would be to revert this commit
> > and fix the behavior of
> > ingenic_gpio_get_value() inside pinctrl-ingenic.c instead. However,
> > I do not own an Ingenic
> > board, so I won't be able to test such a patch.
> >=20
> > Alternatively, I could introduce a DTS property like read-gpio-
> > quirk in matrix_keypad to restore
> > the original driver behavior by default, and add this property to
> > qi_lb60.dts so as not to break
> > the Ingenic platform.
> >=20
> > What do you think? What is the best way to proceed here?
> >=20
> > Best regards,
> > Alexander Kochetkov
> >=20
> > [1] commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29 ("Input:
> > matrix_keypad - force switch rows to input mode")
