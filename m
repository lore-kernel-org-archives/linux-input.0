Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3B4E8E16
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859620; cv=none; b=Bi7dL1WbRkTT6XP+BP+8kvxSNOmvrp22jfWOtNvZ/lNV4t745bcTT1VVjkGZB4bRiNMp+RIFzfdkkEdHBCSywnZVPjRfjxxc7z4eDVQL4mG2T3QX+yusx4Xx8q3elD2SaS/CNuN5B05V4WI3OWO/kp5WHzey1ILVe14+v/PmOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859620; c=relaxed/simple;
	bh=Kk7rgxnJE9jBisQFnIhAu9JCB47OG2OwNaMgOjpITmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qexjQ7b96qCjiQqY72zU1yMQXXRKuR//+73JaPLiNgI9/RbI82aBL+HIew0KlNvGTZ8CsqDS+QPjmxT22wk44qECI/Z8XthKhCHIUozFrXKFiTSAAEBTzwZarbpd0hAtcloqZvVUSdA/Ogud3bxoYElMRfHvpsLVKxBHoGIw1ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoCRG5XI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoCRG5XI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486A91F00A3F;
	Tue,  8 Sep 2026 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859618;
	bh=jFStHhh6cYCWcRQlHvrkh69PtDXZ57SOmolL39RZx8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DoCRG5XIGIVkF8Sew2alhnC7Na4/hDPM2aSVM72YCaWToVZkxObtxzBGdxJHHgzh6
	 XXjF1KcaZrIgS9I7hCU5OFjCscYuyoh5HlPLVQWtsS82vquV2AzpjU6bjlKeO2IGRv
	 7Fvv9eba8ObLPdEGBCFLLOktbk92qxgyuFUqGCEA5CGDh0DTVrflKaomD81gowkn+3
	 AfLMPpWECUY6zbV9joM40vl2F+c6r3rjRnSS16YPfxpkI2aQgm3jBcvRlpTjKzr4FS
	 t6VG8evRRmihLcoo1Mxs0/t4TMxgVuYmyWif0LuNMnWB2ZZ3u1QLkIbbmF5o2znhHs
	 3gDymRD+/44Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x
 Gen 11 keyboard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Keri" <okerixx@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908091926.5773-1-okerixx@gmail.com>
References: <20260908091926.5773-1-okerixx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:26:57 +0000
Message-Id: <20260908092658.486A91F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] An embedded struct field (not cacheline-aligned) is passed to =
a DMA-safe I2C transfer.
--

commit 6f11ed5908d69555e4526207fed1941b2bc9d3c9
Author: Oleg Keri <okerixx@gmail.com>

HID: i2c-hid: add reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard
   =20
The ITE controller behind the keyboard of the Lenovo Yoga Slim 7x Gen 11
(048d:83db) carries out a reset but never raises the interrupt that
acknowledges it. This commit sets I2C_HID_QUIRK_NO_IRQ_AFTER_RESET for it.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 0ff07fdab442a..ad8d9f329404a 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -126,6 +126,8 @@ static const struct i2c_hid_quirks {
>  		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
>  	{ I2C_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_VOYO_WINPAD_A15,
>  		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> +	{ USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD,
> +		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
>  	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_3118,
>  		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },

[Severity: Critical]
This is a pre-existing issue, but does i2c_hid_fetch_hid_descriptor()
pass an unaligned embedded struct field to a DMA-safe I2C transfer?

Looking at i2c_hid_fetch_hid_descriptor(), it reads the HID descriptor into
ihid->hdesc:

drivers/hid/i2c-hid/i2c-hid-core.c:i2c_hid_fetch_hid_descriptor() {
    ...
	error =3D i2c_hid_read_register(ihid,
				      ihid->wHIDDescRegister,
				      &ihid->hdesc,
				      sizeof(ihid->hdesc));
    ...
}

This buffer is passed down to i2c_hid_xfer(), which forces the message to
bypass I2C bounce buffering by explicitly setting I2C_M_DMA_SAFE:

drivers/hid/i2c-hid/i2c-hid-core.c:i2c_hid_xfer() {
    ...
		msgs[n].flags =3D (client->flags & I2C_M_TEN) |
				I2C_M_RD | I2C_M_DMA_SAFE;
		msgs[n].len =3D recv_len;
		msgs[n].buf =3D recv_buf;
    ...
}

Because ihid->hdesc is an embedded field that shares a cacheline with other
members of struct i2c_hid, processing this message via a DMA-capable I2C
controller violates the I2C subsystem rule against passing
non-cacheline-aligned buffers to I2C_M_DMA_SAFE.

Could this result in DMA cacheline sharing corruption of adjacent fields wh=
en
the cacheline is invalidated upon transfer completion during local probe
execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908091926.5773=
-1-okerixx@gmail.com?part=3D1
