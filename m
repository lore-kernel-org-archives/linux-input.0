Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FCB3955DB
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787611640; cv=none; b=VB+GE2CowK81UGEgMMA7CLynhaUGB0Thk9Y0kPJebjPIHWh4K0i+O6dfPwYwPYW95+ZILPMMy1HXJHDazjenQzntIFs6lmPXWY3RkCXu7zujxwkTmuheGo20PGO/9/tkiSlA3G7LVxePgBg0thA5qZFxGUxCsXz60BZGHAe79nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787611640; c=relaxed/simple;
	bh=BzBPsIG5ky7+DddDQ1/V+RE0+tAO0csoZ2OjCnpbEhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nw4o3v05UfGdx73Ujf8DrADNlM32cjzSLFaKxdk1Mx0JMs7e1HqNa7uS8peJfKl11auRAMMynV2FJ7wSiZoE8qlQO1HyrioJTtiux7DVVDG7m6OnxtVQ0bfbaer/ymcFcDumbU6uS6latzfONflsqMlG5PtZh52QGUJQMLEnIBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5UygqwD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5UygqwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7851F000E9;
	Mon, 24 Aug 2026 22:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787611638;
	bh=8gUL8d8So/BmdMDQG4az4EvdssPY21Uc1gjvopUpdTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5UygqwDjyu0guVjdASApqpQ/Ga6FypGO9OpUDzvL0ksyNFBPVeQmePylM+Y+VOAy
	 85/H04nuQnV46jnCQY6jNKXjC4sZR79uZu/YO9wpFSIikwk04cDHt8bbCfpUrRnm4F
	 6ozc5KP+48H2iFKXNlcw0Cri+GLOLXjUEkcqHstYOlAeuVb+anhYTOQggsPkijiAo7
	 57PCTUjGAyzyxdb3MTdkDHueCZeFpR3gqXY+6CRTOSDEg4MKelNJg3cat1tUDPtuJf
	 aN/U++40HAkiW+teV348ZQmvp/XAyPIxMOmGOAE5msKATyIlnaUDBhaAqT+zX1PLLC
	 zCKrEHZb/42DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] ALSA: usb-audio: expose the Topping M62's
 analogue gains as mixer controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260824223107.406504-2-mikhail.v.gavrilov@gmail.com>
References: <20260824201331.304705-1-mikhail.v.gavrilov@gmail.com>
 <20260824223107.406504-1-mikhail.v.gavrilov@gmail.com>
 <20260824223107.406504-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 22:47:18 +0000
Message-Id: <20260824224718.AA7851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch uses crc16() but does not select CONFIG_CRC16 in Kconfig,=
 causing a potential build failure.
--

--- Patch [1]: [PATCH v6 1/2] ALSA: usb-audio: expose the Topping M62's ana=
logue gains as mixer controls ---
commit 2f97c4794fd4611a2d19d7809d566fbe5f5f49ee
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

ALSA: usb-audio: expose the Topping M62's analogue gains as mixer controls

This commit adds mixer controls for the Topping M62 by exposing the analogue
input gains and output volumes over a vendor HID channel. It implements a
custom communication protocol in a new mixer_topping.c file to talk to the
device.

> diff --git a/sound/usb/mixer_topping.c b/sound/usb/mixer_topping.c
> new file mode 100644
> index 0000000000000..f8ddeafb02226
> --- /dev/null
> +++ b/sound/usb/mixer_topping.c
[ ... ]
> +static void topping_build(u8 *f, u8 target, u8 prop, s32 value)
> +{
> +	u16 crc;
> +
> +	f[0] =3D 0x22;
> +	f[1] =3D 0x33;
> +	f[2] =3D 0x20;
> +	f[3] =3D 0x01;
> +	f[4] =3D 0x01;
> +	f[5] =3D target;
> +	f[6] =3D prop;
> +	put_unaligned_be32(value, f + 7);
> +	crc =3D crc16(0xffff, f + 2, 9);

[Severity: Low]
Does SND_USB_AUDIO need to select CRC16 in sound/usb/Kconfig?

Since this new code uses crc16(), building the kernel with CONFIG_SND_USB_A=
UDIO
enabled but CONFIG_CRC16 disabled might fail during linking with an undefin=
ed
reference to crc16().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824223107.4065=
04-1-mikhail.v.gavrilov@gmail.com?part=3D1
