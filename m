Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32AC3F65EA
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408283; cv=none; b=Rodh4d51s34FUyvMl8eKHGi3K8+E4Vxvq/7gB5cl0nfqtgpRxDQmoBytkY8CVdCoUw6DRn+17Sjx3IELDPM2h8w+4+CcqdbyIIUWvo+lLoJ+OKFvqIoLWOEcOgoLyhDfFO4CH/u7rlK8Y2FKQh07L3rT+zWamI0O8Yod1S0MMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408283; c=relaxed/simple;
	bh=RAmQrOYenlwdNBJDrJsoplW0GHZ9slmZ7mUMHYXxezM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dSRDTo6011dhe3viGeGiIMHdic1PBEtqhwptUlwmvhAbtllr9WmtpLuAAzxzp2DY+5/xRyb2ZXm33VOqgNw2wsQMrN81CBIXCWCXfU6SjPYoRFJ51ePRaHqvRcyhdZ3AS5gWfeJvOsQc6mbegvMqJUn9J7Pq4PgvHRZtQmNgTKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfZgx1Js; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfZgx1Js"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F422E1F00AC4;
	Thu, 30 Jul 2026 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408282;
	bh=If4c9iQHqR2tajTn+d+ikhYgvl2aH1TGtL2Uce6elU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OfZgx1JsaLMiC7Ml3ta45Rm6rfjV6KrpV2U3MQqRsQI1vCZmLSSRY7R4D0vOfBrQ5
	 zSQ3UlYvI1gEgytsiCULFKHjeuVGOnn3GyZrEI9HEZLGToNp7fpzflIG0Hf4ntvh6z
	 Zzz4dGi/ipqfCo/jYwmp6YXsyrFZmTmNG8EXeRgz4fcI0nOmjBJE0PcD1EYCtz6Jkp
	 cW7YrzsY9XVxe4OyPDLHpIDDZ5uj2KmUfo7V8hb1axy2GWQ2hiZ3P0pI5o7JhBfxqG
	 0sHuf4x+R01ylyE5CImGQdtgbLF0UneFDDDQCmsIntCkViVqmT8E4IlNZhEZaSMPZq
	 QdaYzyj6KrueA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo: register input device after capabilities
 are set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiangshan Yi" <yijiangshan@kylinos.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730101506.547340-1-yijiangshan@kylinos.cn>
References: <20260730101506.547340-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:44:41 +0000
Message-Id: <20260730104441.F422E1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The function `joycon_config_rumble()` sets the `EV_FF` capability =
unconditionally and ignores the return value of `input_ff_create_memless()`=
. If memory allocation fails, `dev->ff` remains `NULL`. The device is subse=
quently successfully registered. When a userspace application issues a forc=
e-feedback ioctl (`EVIOCSFF`), `input_ff_upload()` checks `test_bit(EV_FF, =
dev->evbit)` which passes, and then dereferences the `NULL` `dev->ff` point=
er, causing a kernel panic.
- [High] Insufficient length checking on incoming HID reports allows an out=
-of-bounds read on the input buffer, potentially leaking uninitialized kern=
el heap data or causing a crash.
- [Medium] The allocated `player_id` IDA slot is leaked if `joycon_leds_cre=
ate()` fails after successful IDA allocation.
- [Medium] Calling `ida_free()` with `U32_MAX` on a probe failure path caus=
es a kernel warning.
--

--- Patch [1]: [PATCH] HID: nintendo: register input device after capabilit=
ies are set ---
commit 346545e7ce7a9520ab6a8be23f83f920de4db331
Author: Jiangshan Yi <yijiangshan@kylinos.cn>

HID: nintendo: register input device after capabilities are set

This commit moves input_register_device() to the end of
joycon_input_create(). This prevents a race condition where EVIOCSFF could
dereference a NULL dev->ff, and ensures the initial udev event has complete
button and axis information.

Link: https://sashiko.dev/#/patchset/20260730031927.25444-1-yijiangshan@kyl=
inos.cn?part=3D1

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1f..7f014f3718004 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2162,10 +2162,6 @@ static int joycon_input_create(struct joycon_ctlr =
*ctlr)
>  	ctlr->input->phys =3D hdev->phys;
>  	input_set_drvdata(ctlr->input, ctlr);
> =20
> -	ret =3D input_register_device(ctlr->input);
> -	if (ret)
> -		return ret;
> -
>  	if (joycon_type_is_right_joycon(ctlr)) {
>  		joycon_config_right_stick(ctlr->input);

[ ... ]

> @@ -2208,6 +2204,10 @@ static int joycon_input_create(struct joycon_ctlr =
*ctlr)
>  	if (joycon_has_rumble(ctlr))
>  		joycon_config_rumble(ctlr);

[Severity: High]
This is a pre-existing issue, but does joycon_config_rumble() properly
handle memory allocation failures?

If input_ff_create_memless() fails due to memory pressure, dev->ff remains
NULL. However, the EV_FF capability is still unconditionally set:

joycon_config_rumble() {
        ...
        input_set_capability(ctlr->input, EV_FF, FF_RUMBLE);
        input_ff_create_memless(ctlr->input, NULL, joycon_play_effect);
        ...
}

Could this lead to a kernel panic? If a userspace application subsequently
issues an EVIOCSFF ioctl, input_ff_upload() checks for EV_FF, which passes,
and then it might dereference the NULL dev->ff pointer.

> +	ret =3D input_register_device(ctlr->input);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but does the driver leak the
player_id IDA slot if joycon_leds_create() fails?

In joycon_probe(), if a later step fails, the error path goes to err_close,
which bypasses the err_ida cleanup label:

joycon_probe() {
        ...
        ret =3D joycon_leds_create(ctlr);
        if (ret) {
                hid_err(hdev, "Failed to create leds; ret=3D%d\n", ret);
                goto err_close;
        }
        ...
err_close:
        ...
}

Could this result in permanently leaking the allocated IDA slot since
err_ida is skipped?

[Severity: Medium]
This is a pre-existing issue, but can the driver trigger a kernel warning
by freeing an invalid IDA?

If ida_alloc() fails in joycon_leds_create(), ctlr->player_id is set to
U32_MAX:

joycon_leds_create() {
        ctlr->player_id =3D U32_MAX;
        ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
        if (ret < 0) {
                hid_warn(hdev, "Failed to allocate player ID...\n", ret);
                goto home_led;
        }
        ...
}

If a subsequent initialization step in joycon_probe() fails, the error path
jumps to err_ida:

joycon_probe() {
        ...
err_ida:
        ida_free(&nintendo_player_id_allocator, ctlr->player_id);
}

Does this unconditionally call ida_free() with U32_MAX, triggering a
WARN_ON_ONCE in the IDA subsystem?

[Severity: High]
This isn't a bug introduced by this patch, but is there an out-of-bounds
read vulnerability when parsing incoming HID reports?

In joycon_ctlr_read_handler(), the length check only ensures the payload is
at least 12 bytes:

joycon_ctlr_read_handler() {
        ...
        if (size >=3D 12)
                joycon_parse_report(ctlr, (struct joycon_input_report *)dat=
a);
        ...
}

However, if the report ID is JC_INPUT_IMU_DATA, joycon_parse_report()
delegates to joycon_parse_imu_report():

joycon_parse_report() {
        ...
        if ((rep->id =3D=3D JC_INPUT_IMU_DATA) && joycon_has_imu(ctlr))
                joycon_parse_imu_report(ctlr, rep);
        ...
}

Since joycon_parse_imu_report() expects a full 49-byte payload and reads
36 bytes of IMU data starting at offset 13, could an attacker send a
truncated 12-byte report to force an out-of-bounds read, potentially leaking
uninitialized kernel heap data to userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730101506.5473=
40-1-yijiangshan@kylinos.cn?part=3D1
