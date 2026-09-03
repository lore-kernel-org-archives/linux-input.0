Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994B426EBB
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452748; cv=none; b=pL/kZwMlDdk8FPOihAwLsDISKQ/6zE5C7VM0vIJuJaVS5oRp7w6eJC1hpL5oleBrC7ya7ghhROriDlepwnb4cDBSuye4e0X1EYNC+lOmmYztc7deZj9O2NomnBYWvnp/IyNz3aRwu/x5XCVlRjUYyzD5XURtSZVRuEfLDf0Zc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452748; c=relaxed/simple;
	bh=pIi1DCG1QsfHyWwGadPo+jpOINBY5Lrq4d3iaGUVTUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ULU329GwV+4v4yTDcPX8qHDg6D876qgtXL9txSc5jP+V/QZJoHPVzkXMVuPMXnsYJvP9nlM41ux12d2EHY6Q4H3uS7QQ5pkNGvh4c/n+RthvHK1kShPtm1nyu5Rx12eYTyo1kUI2iVMf8JhTWWD/MOiIL7ChdJvjXWwiu/hY1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USmA5HvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USmA5HvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462241F000E9;
	Thu,  3 Sep 2026 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452747;
	bh=IBQDQYczjg0iY/o422TMu3icA36VrGQm2lIv447wPPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USmA5HvVhcjbWY68O3VQ5xaOoQeqqZlmaJPwz0vAiqv2wdXAclCnW253FMojB+slO
	 7OidQEdyvq7k29Cxz6KWMrDIDwZzzk+c3OTO1Lo7fEy8efE370wQevYI3MtfZmJttc
	 IQmVIzxu0elrKIc22p3n90KtCiUDytkGe9DDW6ace6NiWwMMZIxKSbKHBxUVeYKn2q
	 2n9LmxxQgAWu1ojlDg7PpRUMHozH1Nbb66vR1qhxyBBm85kMV/1rQmIymAdfpOy60I
	 7eVsNFev1TnoBYGAygTG/aKRsZoegR/HbdGVHgobEUGWVhHVkW9aNcdxENEW7iOWaM
	 NHpiJcoEyrzJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: i2c-hid: Add i2c-hid-quirk-bad-input-size quirk
 for 0911:5288 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Youth Cao" <cocoh2os08@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260903161444.786-1-cocoh2os08@gmail.com>
References: <20260903161444.786-1-cocoh2os08@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 16:25:46 +0000
Message-Id: <20260903162547.462241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] An embedded struct member (which is not cacheline-aligned) is pass=
ed to an I2C transfer explicitly marked with I2C_M_DMA_SAFE, causing memory=
 corruption if the adapter attempts direct DMA mapping.
--

commit 4324d522e00df3b4f32a9d44f12c88ed0a6abf38
Author: Youth Cao <cocoh2os08@gmail.com>

HID: i2c-hid: Add i2c-hid-quirk-bad-input-size quirk for 0911:5288 device

This commit adds the I2C_HID_QUIRK_BAD_INPUT_SIZE quirk option to the
existing Hantick 5288 quirk entry. This suppresses a kernel log flood
caused by incomplete reports from the Hynitron CST128-A touchpad controller.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 0e725a0f0abee..776dd14feba79 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -123,7 +123,7 @@ static const struct i2c_hid_quirks {
>  	__u32 quirks;
>  } i2c_hid_quirks[] =3D {
>  	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
> -		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> +		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET | I2C_HID_QUIRK_BAD_INPUT_SIZE },
>  	{ I2C_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_VOYO_WINPAD_A15,
>  		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
>  	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_3118,

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory corruption
in how I2C HID devices are probed.

During device probe, i2c_hid_fetch_hid_descriptor() calls
i2c_hid_read_register() and passes the embedded struct member &ihid->hdesc
as the receive buffer:

drivers/hid/i2c-hid/i2c-hid-core.c:i2c_hid_fetch_hid_descriptor() {
	...
		error =3D i2c_hid_read_register(ihid,
					      ihid->wHIDDescRegister,
					      &ihid->hdesc,
					      sizeof(ihid->hdesc));
	...
}

This buffer is eventually passed to i2c_hid_xfer(), which explicitly sets t=
he
I2C_M_DMA_SAFE flag on the message:

drivers/hid/i2c-hid/i2c-hid-core.c:i2c_hid_xfer() {
	...
	if (recv_len) {
		msgs[n].addr =3D client->addr;
		msgs[n].flags =3D (client->flags & I2C_M_TEN) |
				I2C_M_RD | I2C_M_DMA_SAFE;
		msgs[n].len =3D recv_len;
		msgs[n].buf =3D recv_buf;
		n++;
	}
	...
}

Since &ihid->hdesc is an embedded struct member and not cacheline-aligned,
explicitly marking it as I2C_M_DMA_SAFE bypasses the I2C core's bounce
buffering.

Could this cause memory corruption if the adapter attempts direct DMA mappi=
ng,
flushing or invalidating the shared cacheline and corrupting adjacent membe=
rs
(like the client and hid pointers in struct i2c_hid)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903161444.786-=
1-cocoh2os08@gmail.com?part=3D1
