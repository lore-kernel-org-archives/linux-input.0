Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C023D8100
	for <linux-input@vger.kernel.org>; Thu,  1 Oct 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845005; cv=none; b=OQswMgZFDQ3L3QkxAMvfnQV0l1SCTW30dPSYbCHMGRNKXprVe6gmRsrrhDQVzLMUbXiesj3g2F6BUihZFgug6Yrke0xUHW2Cjp/g+etFkIwmyky8oRbHgGpoSBnSbu45A6cJgagxSOjpTE96lt75I5wHx+gbLbc89HKOMaJxQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845005; c=relaxed/simple;
	bh=oa42E4hDYBlQTdmIta9l811OwedGBPYln+1X2DMZDL8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LQTjGXTgzCeDJ7xHuYQ/SPkya3/c4NV/fsx5NwUUh/EXxiK4EJnqS0ybQouNBPK7Ymp/Mxhv9yvxCtcsRQwfcFFpCA4FSj60z3LHRR9HrU7vxNpLpob4hTjCM7s5p0O4DxbU3kJQfBRKK8YuthGIX2Dd3VThOz15nDo2k+bpQx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bICmwZsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bICmwZsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6DC1F000FF;
	Thu,  1 Oct 2026 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790845004;
	bh=K8N4H1C3SOSarq3TtCAct9bkkyMuFyLH9J33b9YxmAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bICmwZsnQO7Q1nR6HE67UTwDc8/BF+cQRwNfby09PUkDhfe7lDiLGPk1/HHzyU56f
	 Zk1uzJaoxoV4sBfXUjwDlF5eqfNxDLsvBXcDkGdHjWXVKUlgvUXgoks6QWfeEA3wh4
	 HAAz5jKDiYzPLsF0RG7n/PdQ+ZJ9zAx7wkBXETfo+8rPB/BiWKk1ArYbqgTprcHs3O
	 noDRTgwMjBszEPZ21UL9LK8XFTl1ow16Gj71UVy8l7mICaOMOuo4i8TuwSDYsxbGdR
	 01QoIQhYSUKbPYHL+B68CTV0lly8f+df+0ADniWc2R6eR4PG5Id9sAUzjv3/AMw9ll
	 Q/2fTsV9G0rOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: applespi - turn the keyboard backlight off
 across suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Szpakowski" <michi.szpakowski@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261001084154.4703-1-michi.szpakowski@gmail.com>
References: <20261001084154.4703-1-michi.szpakowski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 08:56:42 +0000
Message-Id: <20261001085643.CE6DC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] input: applespi: backlight level saved as 0 during hibernation
- [Medium] input: applespi: caps-lock LED fails to turn off during suspend
--

commit 37ebd40953a1312d5d67af7477063eae746c320a
Author: Michal Szpakowski <michi.szpakowski@gmail.com>

Input: applespi - turn the keyboard backlight off across suspend

The patch sets the LED_CORE_SUSPENDRESUME flag for the keyboard backlight,
allowing the LED core to blank it during suspend and restore it on resume.
This resolves an issue where the backlight stayed lit through s2idle.

Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Cc: stable@vger.kernel.org

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index b5ff71cd5a701..838b380bde6e1 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1772,6 +1772,7 @@ static int applespi_probe(struct spi_device *spi)
>  	applespi->backlight_info.name            =3D "spi::kbd_backlight";
>  	applespi->backlight_info.default_trigger =3D "kbd-backlight";
>  	applespi->backlight_info.brightness_set  =3D applespi_set_bl_level;
> +	applespi->backlight_info.flags           =3D LED_CORE_SUSPENDRESUME;

[Severity: Medium]
During hibernation, the PM core calls led_suspend(), which updates
applespi->have_bl_level to 0. Does this cause the user's preferred backlight
level to be permanently overwritten with 0 when applespi_poweroff_late()
later saves the state?

For example, in drivers/input/keyboard/applespi.c:

applespi_poweroff_late() {
    ...
    applespi_save_bl_level(applespi, applespi->have_bl_level);
}

[Severity: Medium]
Could adding this flag also block applespi_suspend() from successfully turn=
ing
off the caps-lock LED?

If the LED core initiates an asynchronous backlight SPI write to dim the
keyboard before suspend, applespi->cmd_msg_queued will be set.

When applespi_suspend() then calls applespi_set_capsl_led(), the call to
applespi_send_cmd_msg() returns early without queueing the caps-lock command
because the backlight command is still in flight.

applespi_suspend() then calls applespi_drain_writes(), which sets
applespi->drain =3D true. When the backlight write eventually completes, the
pending caps-lock off command is permanently aborted because the drain flag
is set, potentially leaving the caps-lock LED in an incorrect state.

> =20
>  	sts =3D devm_led_classdev_register(&spi->dev, &applespi->backlight_info=
);
>  	if (sts)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001084154.4703=
-1-michi.szpakowski@gmail.com?part=3D1
