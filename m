Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096634;
	b=bHcRJ5byxo6nu1XoeUAoa4cGlDPvGDQaCCbbiheQXRI+nfpQ43Dd4oQO/RAJTT2d6Hwc
	 6Z46zhbLahz1G3Hxklaib+IUgo5tkb/RiaI3cfWmf2dUlUSE3Hc7fa87c41qXs03v6g8W
	 572iKMQZ+LOCz7xZyXNv7U81iRcG9LglTp6N2RBGJikZvIfglv2GeBtNQOtWgdJcjXEmm
	 29o1iaGWLBtQ982wqPgcOh/sbL3faai23AsXiTkLk472P3jXKhYhkrhlb12kC2jvVBhIM
	 TMgCEk+xjA3rIrcNx77dcz83Il28ZLz7Bk32/gVi/Lkv1cmo7Y6fhg5+ylrequVdrjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096634;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=viPD5QM8LO/XbaR69jgwwcj3FPDEs4nmynC/viGreTw=;
	b=QGkhZAizbaK9S1TbJmqQ9mhYnt0o9tCzHrDtvJJZcLCsdkrsojvvoku/+8CcZpKmUc+Q
	 ++R8B0Sq+/vQm4JDJxaVIn0MOz1s3lwWgBMknM7DO3e+qMW25W+JZVoQRwYiEybgodCtV
	 vVOcipjDdUCWtA7WXyDNfqUqo9AvnSGQZHw2YCwVJCtPiZTLWIT6T9NRHWFjyjGPG3w70
	 J0AGmdcUzJ9IdYKs3u2oyALC3Omg+J4cBtB5TXDggQST45W6nviUiBHUs1pU5RBwm8h16
	 49CZg1tKhTYuMF4pTY7OFnQAUlY63kzX+hPW32F+VilTCkACWBN2d0FcvFgMLiS4EHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ctln99Rm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C0606A320;
	Thu, 19 Nov 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ctln99Rm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1181B1F000C4;
	Thu, 19 Nov 2026 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096634;
	bh=viPD5QM8LO/XbaR69jgwwcj3FPDEs4nmynC/viGreTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ctln99Rm3TFndDg4ba68fF1EKgIiUD1p9xtx3TRpcf6sufdOSinxcCBHkTWsvM5wm
	 le+KQqAro29n/q3lncPCAeYk4txGlkNcwmizdZETa0WUVaTE/aJ6IlJ1NQ7xxh/QvR
	 hHOAMIKdbMXa4gryxsqe9tm8fraIefIEZGuiFm7UMNa502bP3vW+Mdj5a+G4PJEFnS
	 jy1bizydEzI72XZhWLBEJE7Y1tNpJc1Se+FD7mrT8cdTeoTvn9YIJaY6xmeudztUbZ
	 B45mJ9rvuvyoKgBg+f3F6EDKLrGEx5yoKD2IaI9qERn12EgBPpe2B1l+TEfb8Rw0PF
	 5UKpCxglUzusQ==
Message-ID: <sashiko-outbox-223226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] input: serio: Enable compile-testing for
 SERIO_ASUS_TRANSFORMER_EC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: mfd@lists.linux.dev, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <3beff0ff365277097d5678a9ee35fe8990f7e7da.1795095742.git.geert+renesas@glider.be>
References: <cover.1795095742.git.geert+renesas@glider.be>
 <3beff0ff365277097d5678a9ee35fe8990f7e7da.1795095742.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 13:57:13 +0000
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
- [Medium] input: serio: missing I2C dependency for
  SERIO_ASUS_TRANSFORMER_EC
--

commit 9aac592895b890fc23d1336a836e2584fd6f0d20
Author: Geert Uytterhoeven <geert+renesas@glider.be>

input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC

This commit relaxes the Kconfig dependency of SERIO_ASUS_TRANSFORMER_EC
to allow compile-testing when MFD_ASUS_TRANSFORMER_EC is disabled.

> diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
> index 58d415ca1d540..87c78a8315fc3 100644
> --- a/drivers/input/serio/Kconfig
> +++ b/drivers/input/serio/Kconfig
> @@ -86,7 +86,7 @@ config SERIO_RPCKBD
> =20
>  config SERIO_ASUS_TRANSFORMER_EC
>  	tristate "Asus Transformer's Dock keyboard and touchpad controller"
> -	depends on MFD_ASUS_TRANSFORMER_EC
> +	depends on MFD_ASUS_TRANSFORMER_EC || COMPILE_TEST

[Severity: Medium]
Should SERIO_ASUS_TRANSFORMER_EC also depend on I2C?

asus_ec_serio_write() calls i2c_smbus_write_word_data(), which is only
declared when CONFIG_I2C is enabled.  Without a dependency on I2C,
enabling COMPILE_TEST allows building the driver with CONFIG_I2C=3Dn (which
fails compilation) or built-in with CONFIG_I2C=3Dm (which fails linking).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795095742.gi=
t.geert+renesas@glider.be?part=3D3
