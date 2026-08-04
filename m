Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF051370D47
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813676; cv=none; b=KepdqFOiG9A5vAyWboLitR3vrXVJgwGB3gLos/oMfjWTAg+X0asyvZpLRrrZRVQaSj3eR6WPTJ26r5rwD2iFhAeqx92N39yfQdIiOMNzikfp4vLDXEy5NknKD5s2wO3+fBo+dXz25zbKT5FXgfx4uXGQmo3ji8xget8t/MgElyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813676; c=relaxed/simple;
	bh=VtEv4rfpVGMTmblcSEkvQaKwUEX5rzCbZM9Yvkpfigo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q50e/s2z80LRZGf/j/Hphe0qKIzQPa5zqXHy5taGUrLw6VIKosBH1mMSQh4GiT5jaqRHvqAwVlGz5hZZr+ZRa/68p+r3sustifvcnUIMLCNGgncivcnjPp97O9XFdutY/8mQaRIcmLU+fqg+I0K5aCDZXdSIKdLsusUkfy1e6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0e5QpFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0e5QpFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D491F000E9;
	Tue,  4 Aug 2026 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785813674;
	bh=yrrZjlgqZtVuNu15zEpLQIFvYK2FZHqNizuEDs+0Lu0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0e5QpFEYgxF4B3DsO0rxydosSCNyww1DrBieIfd3pwSopGmmZPmL25xOAfWeZjMS
	 MfD1DS0h9bIUaZ/d84c7sQPGmKxS/3psQvVItpet0LmdKX/PF67nPXEGttF5Zr4iem
	 zYSoQ7FoNDwJLtCpx/bcQ42WYHcu5VI656r+G4eC2RS1X4aE1wsD6gKjXfH1Opjdqu
	 dTnhDJHM4UmAowFp0c6duoZtYm5hA+YpjVs0jT7c19QFJAtlT8bCKzpcxTR37Qajh0
	 Wz+hyI5sLjB600dqAtiS2L1cdO6b8Ft6fPSdpVUsWxzYU+MDQOoTsYYWsUp2plwnD9
	 ExK12PKbfqC1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: hynitron_cstxxx: validate touch count and
 finger IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianing Li" <m13940358460@163.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260804031339.2379-1-m13940358460@163.com>
References: <20260804020314.2082-1-m13940358460@163.com>
 <20260804031339.2379-1-m13940358460@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:21:12 +0000
Message-Id: <20260804032114.46D491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver passes stack-allocated buffers directly to I2C transfer=
 functions, which violates DMA mapping rules and can cause kernel panics or=
 data corruption.
--

--- Patch [1]: [PATCH v2] Input: hynitron_cstxxx: validate touch count and =
finger IDs ---
commit cf5d1ec7af0f8cb9ee23a1f75f59f7e64afb8fe7
Author: Jianing Li <m13940358460@163.com>

Input: hynitron_cstxxx: validate touch count and finger IDs

This commit adds bounds checking for the touch count and finger ID read
from the controller. It ensures that neither exceeds max_touch_num,
preventing out-of-bounds slot accesses during input reporting.

> diff --git a/drivers/input/touchscreen/hynitron_cstxxx.c b/drivers/input/=
touchscreen/hynitron_cstxxx.c
> index f6139b1a86811..5f2737fe99026 100644
> --- a/drivers/input/touchscreen/hynitron_cstxxx.c
> +++ b/drivers/input/touchscreen/hynitron_cstxxx.c
> @@ -312,6 +312,11 @@ static void cst3xx_touch_report(struct i2c_client *c=
lient)
>  		return;
> =20
>  	touch_cnt =3D buf[5] & CST3XX_TOUCH_COUNT_MASK;

[Severity: High]
This is a pre-existing issue, but I noticed that buf is a stack-allocated
array in cst3xx_touch_report() that is passed to i2c_transfer() via
cst3xx_i2c_read_register() earlier in the function.

If the I2C host controller maps the buffers for DMA, passing a stack-alloca=
ted
buffer can lead to memory corruption, kernel panics, or DMA API debug warni=
ngs
because stack memory is not DMA-safe (especially with virtual kernel stacks
enabled).

Looking at the rest of drivers/input/touchscreen/hynitron_cstxxx.c, similar
stack allocations occur in other functions:

cst3xx_i2c_read_register() allocates __le16 buf
cst3xx_firmware_info() allocates unsigned char buf[4]
cst3xx_bootloader_enter() allocates unsigned char buf[3]
cst3xx_finish_touch_read() allocates unsigned char buf[3]

Should these buffers be heap-allocated or moved to a DMA-safe allocation
within the device structure to prevent DMA corruption?

> +	if (touch_cnt > ts_data->chip->max_touch_num) {
> +		dev_err(&client->dev, "cst3xx touch read failure\n");
> +		return;
> +	}
> +
>  	/*
>  	 * Check the check bit of the last touch slot. The check bit is
>  	 * always present after touch point 1 for valid data, and then
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804031339.2379=
-1-m13940358460@163.com?part=3D1
