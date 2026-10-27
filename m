Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109347;
	b=Rn8a9NqAvtfWT+RDeAgHoZyU3xl84hWKoPPUpzwk8TsVhAdhEG3dzwkLGso5+RRGvnkV
	 7H/lxF+w2qM6tnzI56WXphXAsvsbJlp0vbJ5IwTlKZSZeZuc9Bgta47WdQ0HaJCjZ43+Z
	 GRnQ9Q153ZL0VVAMrHH6kTERMQYogG5//5DIKPnbBluN16eAOmCJjLaKQf2IA0CQE3Gsk
	 E/4PED42CB/X9fRCYDo0ga1uBCAFap/8U4lVN2Y62vUrG1YmVRSBhigJSKsF2Hmto4/mE
	 OxJHaSBcD3ibnzJTzJqn/M6iBfauNXC2IWMDT1K3EmVsBafynLQRgwSnyQ99ZHX6O3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DggvAPlwsoPiuWK26maVaGY+gu+kk9spfGM1nzTWWzA=;
	b=IjN8AveyqajO5v/TWdfZn9p17MBHlRGlpWW9GwfisALx5Zy3o8OO0LYqrNaLaJSDiizm
	 WoWVN0MMMC/w2k/B1g3q7vRxVLxUAEPpcMfD0htwibNcaI7XaYTgz37fBdnynaptgLj6S
	 ytaJSjjDnaxEkVvPineRnL5ZVXNd0bObnUzDJ1CH+bgYBLABmsC6ivkc+0Xn5YO4r4wV6
	 DbYl/VF4JviM1EwYP4GpBiJk+onB4ePoOWpFK686VOyt/twpjaS6WNdev7e1hwrFfSyVM
	 gPBlrqSXKBwPSwX9nTPjTuRD0Dv3OP9oShgjFeW68yuCFvjl+zxRiDHUoe6X0H5DUmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7KPaZyC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197D606A321;
	Tue, 27 Oct 2026 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7KPaZyC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ABD1F01825;
	Tue, 27 Oct 2026 13:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793109346;
	bh=DggvAPlwsoPiuWK26maVaGY+gu+kk9spfGM1nzTWWzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k7KPaZyChka5175S9uZAuEhJyBFOnhNtv3xF80leP5kyiUt8Loo6DnodzSyhaH3vr
	 VribtFhW4gFJ7YFd9FnhF21iFlcxGcFDuavJQi/AyZNNTgnxQvyGVbh16EGsAoKvwS
	 23ocS/kP+4lwFdUZG9yhX9xt3rj6fcU8xMQic6T60DXQLboam+QF1wLb3YKJCfJpzs
	 ZpXj8FGp0luY6pIxuBDvVl3Nd3QobSyM+nyLVur52GLnt7CdcQXQi1g0zeHfpoTxyb
	 A3w8kgp/6SgHxlQHpeHU1VAHW7qnYCm4bdtdmIPiC/RpncKz6YvkkiicEydwFRRm0F
	 V9SYzcDBIE71w==
Message-ID: <sashiko-outbox-186676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] Input: aw86927 - stop playback over suspend and on
 shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qianhui Xu" <xiaqinghuan@mail.ustc.edu.cn>, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261027132929.242158-6-xiaqinghuan@mail.ustc.edu.cn>
References: <20261027132929.242158-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261027132929.242158-6-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 13:55:45 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Input: aw86927: missing devm_add_action_or_reset() for aw86927_r=
eset()
--

commit becd63da0830df31ce436337adc571d6ea9ae15f
Author: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>

Input: aw86927 - stop playback over suspend and on shutdown

This commit stops haptic playback, drains pending work, and parks the
chip in reset on shutdown, while also adding suspend and resume handlers
to prevent playback across system sleep.

> diff --git a/drivers/input/misc/aw86927.c b/drivers/input/misc/aw86927.c
> index e8fd880ac1ded..6d45c310a73fd 100644
> --- a/drivers/input/misc/aw86927.c
> +++ b/drivers/input/misc/aw86927.c

[ ... ]

> @@ -900,6 +909,58 @@ static int aw86927_probe(struct i2c_client *client)
>  	return 0;
>  }
> =20
> +static void aw86927_reset(void *data)
> +{
> +	struct aw86927_data *haptics =3D data;
> +
> +	gpiod_set_value_cansleep(haptics->reset_gpio, 1);
> +}
> +
> +static void aw86927_shutdown(struct i2c_client *client)
> +{
> +	struct aw86927_data *haptics =3D i2c_get_clientdata(client);
> +
> +	disable_work_sync(&haptics->play_work);
> +	aw86927_reset(haptics);
> +}

[Severity: Medium]
aw86927_reset() has the void (*)(void *) callback signature for
devm_add_action_or_reset(), but it is only called from aw86927_shutdown().

In aw86927_probe(), reset_gpio is acquired in the asserted state and then
deasserted by aw86927_hw_reset():

drivers/input/misc/aw86927.c:aw86927_probe() {
	...
	haptics->reset_gpio =3D devm_gpiod_get(haptics->dev, "reset", GPIOD_OUT_HI=
GH);
	if (IS_ERR(haptics->reset_gpio))
		return dev_err_probe(haptics->dev, PTR_ERR(haptics->reset_gpio),
				     "Failed to get reset gpio\n");

	/* Hardware reset */
	aw86927_hw_reset(haptics);
	...
}

Should aw86927_reset() also be registered with devm_add_action_or_reset()
after aw86927_hw_reset() in aw86927_probe() so that the chip is placed back
into hardware reset if a subsequent step in aw86927_probe() fails or when
the driver is unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027132929.2421=
58-1-xiaqinghuan@mail.ustc.edu.cn?part=3D5
