Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096660;
	b=GcKJJYdll1IUyRjIKmtb1+3suUVEccpO55L3ELat2olDGDA4j/y/kYgUVGqc2CUAZd16
	 HgWKb6H3EFLeTgzaQ3tVFouHIcJZyJk8GYPZmPsPJQefT401vA9qsUAX8h9M30J+tPbDv
	 zgHiHpWEbbaqg2colWFsPOnStPKF88AOF+uvsxPBP0qG3qOhnqIe0UlVHhc7LZTsgM0cs
	 kSPuMaf5JazRA/ydZ9A2MvgXATZBV0IEkpPkVrmLBXl+gOhKQdoeu95r0v45bHjt7xO/A
	 EMVPW23s4MQXcW8hoZWO1ibBGevMxWbeaQN0MlNW3p64UpkleipkcNpcmwIcaRIT/+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hEnclyY278SpcAybPZjNTkYHn8U/UquTJthQ6Pv8saY=;
	b=BsfdzOgN+wGixaNayneeGMdXCWnHqt6mY0INHh5SA+7xoeOlW763JvSH9imbinXSdMhI
	 aQumFZRVGCmLLcFsO3K09hVp3LdVhyTkcA8jATBb4vRG6dsyBYAW7fq030ZaHfs2+yquR
	 5wvknCalnml6O6vzKeX1y+5+JQI9G/K4oyMTLh/BfxKvi8pq5LTSkwsOhwaTILyX0j0oW
	 uVuiTbwQHAgi13qddhKRRYlW7OUHR1ky/e+F12+42b5l0b4cuquXHGlL4fXnTbuhsFUMz
	 1oh4XxEqHmtaddO1cNZ3+n1jPz6a8cSnOd7yieS0QbvGzmuISRZ5pubiEFLtiCx1pHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWOgcA2I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B002606A320;
	Thu, 19 Nov 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWOgcA2I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99741F000C4;
	Thu, 19 Nov 2026 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096660;
	bh=hEnclyY278SpcAybPZjNTkYHn8U/UquTJthQ6Pv8saY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UWOgcA2I1xIycUKqyRf9o+V1bGdwQzpGrOONi23nxhq1HtzYOnZTcUZs+H19Nb1qR
	 8IIrafFgfn1gGJ6wC31OsU2TYKlJzcWDonvuQqXyg5r8SKxorst9j5/mKG/R4YgaY1
	 ZJzaefZqrLYIXXHcy/tLWThb9v5zFJX5v0QhP6fTsjtFqOZoqFZrm6EXHDCbkbv7K0
	 +sF7lipXyiFf6xJKQMDDPRz7fXUoCewjzccSdtTf6b6woYS+M0QR4PxJSbgye957Pc
	 oD4gOBoPmIBzt75l1Z7v4RGRp8SuMOi27aDG3Xw9JawoK8pyln0yyI7TkUb/eo9MOk
	 1J8YweIln/2kQ==
Message-ID: <sashiko-outbox-223227@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] input: keyboard: Enable compile-testing for
 KEYBOARD_ASUS_TRANSFORMER_EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: mfd@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <27990d37c1b7854d9d5f0d0a0f45193af4b9ec51.1795095742.git.geert+renesas@glider.be>
References: <cover.1795095742.git.geert+renesas@glider.be>
 <27990d37c1b7854d9d5f0d0a0f45193af4b9ec51.1795095742.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:57:39 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] Input: missing I2C dependency causes build failure in
  asus_ec_keys_probe()
--

commit fd9324a9324e26f4ff25ae83d8027b69e04951cd
Author: Geert Uytterhoeven <geert+renesas@glider.be>

input: keyboard: Enable compile-testing for KEYBOARD_ASUS_TRANSFORMER_EC

This commit relaxes the Kconfig dependency for
KEYBOARD_ASUS_TRANSFORMER_EC to allow compile-testing when
MFD_ASUS_TRANSFORMER_EC is disabled.

> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kcon=
fig
> index 728bc068667e7..2709cff6d00bc 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -91,7 +91,7 @@ config KEYBOARD_APPLESPI
> =20
>  config KEYBOARD_ASUS_TRANSFORMER_EC
>  	tristate "Asus Transformer's Mobile Dock multimedia keys"
> -	depends on MFD_ASUS_TRANSFORMER_EC
> +	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST

[Severity: Medium]
Does KEYBOARD_ASUS_TRANSFORMER_EC also need to depend on I2C?

asus_ec_keys_probe() calls i2c_adapter_id(), which is only declared in
include/linux/i2c.h when CONFIG_I2C is enabled and has no fallback stub.
With COMPILE_TEST=3Dy and I2C=3Dn, building this driver fails with an
implicit function declaration error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795095742.gi=
t.geert+renesas@glider.be?part=3D2
