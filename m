Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988F469830
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345412; cv=none; b=konfPs126p1NOy18z6cW+dAfmg/EXLkGEjtZrFpvdfPayTcBdFf9xUZFwnUIrEbDyHI7o6/6sybFAJiR4prxyOtAajubx+bnUodHC8m3tNRZ6yINiJ3/erdXo1noXTMHd32dBXm6xjroWhZxHgImHzC1E51XPWS50yRW1jZOCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345412; c=relaxed/simple;
	bh=LLGPXzXFSvcifVqgxUnjJ/Qmkb3yalhVsbpUz6jSS3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NkC90K81TT8+CKVGYkmW144cka0C1av0GkkvPpmCnMlfRbjc7TXcI7wU+5l9jLBMSYdG4QNzwQYcfyED3eaV3boDwo0xB3RatNJJgnG+iIkqH/apFWosLfaczP6JEqBqCjsHhtEonO3syrYmGdcjzhbHc0isK4LY7ffvXvI+Gu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh36Gm8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh36Gm8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FDC1F000E9;
	Wed, 29 Jul 2026 17:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345411;
	bh=OlfRnn+ENroBcn2QXbB+WZugj1a67e+I9eHwMsgpXPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dh36Gm8FwGDHh6DsA5RM/POxiilLJk+zE6vvuqCwzi5QdzOO+ThB2T+YHGON8XdEb
	 mddmvh/bgpYmXHTq6fbUqzVF+231dKAuVV3OWCJTGtuzQdVvoVswzfwwj2o65t9GQo
	 QMySU/o2I6IAXRtyKrcQK6FPtaNkpIKp6dFeQ08xniFxoYaJ4XeRDG9Cuu0XrQtHAw
	 S6uLZ39lCIqa5V5MECbEIdB6hMScuw6Ajy/wCFpuXvWS9BqOJJwq4uQKrj7iChKohg
	 LbPe/t/Wy6jhLQx1SBPgcU3C8VG3rkTw0vBoYvyvC3xVpSWBiZQZIAqzmd0920dM+G
	 dnJ++esv/3rMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] Input: synaptics_i2c - return 0 explicitly on
 success
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sang-Heon Jeon" <ekffu200098@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260729171001.260698-4-ekffu200098@gmail.com>
References: <20260729171001.260698-1-ekffu200098@gmail.com>
 <20260729171001.260698-4-ekffu200098@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:16:50 +0000
Message-Id: <20260729171651.15FDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The delayed work `touch->dwork` is not cancelled on driver unbind =
or probe failure, leading to a use-after-free.
--

--- Patch [3]: [PATCH v2 3/3] Input: synaptics_i2c - return 0 explicitly on=
 success ---
commit 2cc2d0ff5c54be0c06b9f9251e169b1467e86f9b
Author: Sang-Heon Jeon <ekffu200098@gmail.com>

Input: synaptics_i2c - return 0 explicitly on success

error is always zero at the last return in synaptics_i2c_reg_set().
Explicitly return 0 on the success path instead of returning error,
which is the preferred way when there are multiple failure points.

> diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/sy=
naptics_i2c.c
> index d4cf982f12632..66e833974c6da 100644
> --- a/drivers/input/mouse/synaptics_i2c.c
> +++ b/drivers/input/mouse/synaptics_i2c.c
> @@ -261,7 +261,7 @@ static s32 synaptics_i2c_reg_set(struct i2c_client *c=
lient, u16 reg, u8 val)
>  	if (error)
>  		return error;
> =20
> -	return error;
> +	return 0;
>  }
> =20
>  static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)

[Severity: High]
This is a pre-existing issue, but I noticed that the delayed work touch->dw=
ork
doesn't appear to be cancelled on driver unbind or probe failure.

In synaptics_i2c_probe(), interrupts are enabled and devm_request_irq() is
called before input_register_device(). The IRQ handler can immediately sche=
dule
touch->dwork.

If input_register_device() fails:

drivers/input/mouse/synaptics_i2c.c:synaptics_i2c_probe() {
	...
	error =3D input_register_device(touch->input);
	if (error) {
		dev_err(dev, "Input device register failed: %d\n", error);
		return error;
	}
	...
}

The probe function returns the error directly. Since devres will automatica=
lly
free the IRQ and the touch structure, but the pending work on system_dfl_wq=
 is
never cancelled, could the delayed work run later and access the freed touch
memory?

Furthermore, the driver lacks a remove callback entirely:

drivers/input/mouse/synaptics_i2c.c:
static struct i2c_driver synaptics_i2c_driver =3D {
	.driver =3D {
		.name	=3D DRIVER_NAME,
		.of_match_table =3D of_match_ptr(synaptics_i2c_of_match),
		.pm	=3D pm_sleep_ptr(&synaptics_i2c_pm),
	},

	.probe		=3D synaptics_i2c_probe,
	.id_table	=3D synaptics_i2c_id_table,
};

If the device is unbound via sysfs, devres will automatically tear down
resources. However, the delayed work is only explicitly cancelled if the in=
put
device is currently open (via synaptics_i2c_close()).

If the device was never opened before it is unbound, does this mean the work
is never cancelled before the memory is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729171001.2606=
98-1-ekffu200098@gmail.com?part=3D3
