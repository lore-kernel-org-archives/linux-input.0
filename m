Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5A3F7AAC
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464537; cv=none; b=Nzxn3SreCWoHRHDzF7wKkNxbb4uCrF/AnWGlhPiqXxx1tE9DhFr37ckPckHW2Zetw+5tumOZkIs5I8ZPkZCMw75a1f3ZWFSihR39M4aESmfj3srYQ5+v9ZNhwdl8Mad6z2YUEAYZHpZBL2Qxt8CJ9LZr7pzLndLKy+v9lJk6XNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464537; c=relaxed/simple;
	bh=oraSUHEe7dpF0iHsYyWQDi4xWHcD7v9qoBaqrySAPtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ayPttKJ+2u1GXdV2CFsOKQN5G+PcP4uJcBRBgkLpdvgKyP7AJRyWJWdAs+2Xbvqf8ewd2QexQYghPse1ulKvj/GcNNqT53CsI1lk3eHK58gH0i2lXQjuLkajcuA6C7TDlPHAuRvYeL70oyDmnUHSjUktc/jCrW6IQZsuVLks/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2h75D/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2h75D/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9454D1F000E9;
	Thu,  3 Sep 2026 19:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788464525;
	bh=oNV/OFNBI4tS0ILwDpXmrGqXvYTjYRIPX547z9mQiKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2h75D/3Pw76F2NBBJi9bd6z8s5kNpR128UtGh2VJiBdx5SK2C1EME0KOfK+dvrvh
	 dEpg/6Ck3e6Zkd7iUx8yS+Ny6xhkC/lQDJTDe91IFQDKV9bVP/y+/gnQhG6CHCggj1
	 jTwhQGr7Ulcth1gPa03PbdP9qsU3q41fRoUAWuvdskSD0yM2y4RnsXA+ofANhdKx7j
	 oexfh8Qr8A5bbqdnkZoaxjstoNoqz9g+sHafWF6dFIPUubGYTq5gZ+iDj27YY+DxOM
	 o1GBNSqQTztEpWfo8I/zOSG7nO91UoeKGIG+y4LqpRD+2HlaOnVqtIM2MQ1LAqPT50
	 Z/7pHEzBcf3GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: tca8418_keypad -  Add devm cleanup to
 disable interrupts on unload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhian Liang" <liangzhan5dev@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260903192942.21906-1-liangzhan5dev@gmail.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 19:42:05 +0000
Message-Id: <20260903194205.9454D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The patch introduces two typos in function names that prevent the c=
ode from compiling due to undefined references.

Pre-existing issues:
- [High] An attacker controlling the I2C device can send a malicious key ev=
ent code to trigger an out-of-bounds read on the `keymap` array, potentiall=
y causing a kernel panic or leaking memory.
--

commit b2a2e3b9a8117d6e6005216e2f4bd8fe76dd2fc6
Author: Zhian Liang <liangzhan5dev@gmail.com>

Input: tca8418_keypad - Add devm cleanup to disable interrupts on unload

This patch adds a devm action to disable interrupts on the TCA8418 device
upon probe failure or driver unbind. It clears the configuration register a=
nd
the interrupt status to ensure the hardware is left in a safe state.

> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyb=
oard/tca8418_keypad.c
> index 4616afa0286c3..d917de848a213 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -260,6 +260,20 @@ static int tca8418_configure(struct tca8418_keypad *=
keypad_data,
>  	return error;
>  }
> =20
> +static void tca8418_disable_hw(void *data)
> +{
> +	struct tca8418_keypad *keypad_data =3D data;
> +	int error;
> +
> +	error =3D tca84818_write_byte(keypad_data, REG_CFG, 0);
[Severity: Low]
Is there a typo in the function name here? It looks like an extra '8' was
added to tca8418_write_byte, which will cause an undefined reference error
during compilation.

> +	if (error)
> +		dev_warn(&keypad_data->client->dev, "unable to disable interrupts: %d\=
n", error);
> +
> +	error =3D tca8418_write_byte(keypad_data, REG_INT_STAT, 0xff);
> +	if (error)
> +		dev_warn(&keypad_data->client->dev, "unable to clear interrupt status:=
 %d\n", error);
> +}
> +
>  static int tca8418_keypad_probe(struct i2c_client *client)
>  {
>  	struct device *dev =3D &client->dev;
> @@ -344,6 +358,10 @@ static int tca8418_keypad_probe(struct i2c_client *c=
lient)
>  	if (error < 0)
>  		return error;
> =20
> +	error =3D devm_add_action_or_reset(dev, tca8418_diable_hw, keypad_data);
[Severity: Low]
Does this refer to the tca8418_disable_hw() function added above? It seems
to be missing an 's', which will also prevent the driver from compiling.

> +	if (error)
> +		return error;
> +
>  	error =3D input_register_device(input);
>  	if (error) {
>  		dev_err(dev, "Unable to register input device, error: %d\n",

While reviewing this patch, I noticed a pre-existing issue in the
tca8418_read_keypad() function:

drivers/input/keyboard/tca8418_keypad.c:tca8418_read_keypad() {
[ ... ]
		state =3D reg & KEY_EVENT_VALUE;
		code  =3D reg & KEY_EVENT_CODE;

		row =3D code / TCA8418_MAX_COLS;
		col =3D code % TCA8418_MAX_COLS;

		row =3D (col) ? row : row - 1;
		col =3D (col) ? col - 1 : TCA8418_MAX_COLS - 1;

		code =3D MATRIX_SCAN_CODE(row, col, keypad_data->row_shift);
		input_event(input, EV_MSC, MSC_SCAN, code);
		input_report_key(input, keymap[code], state);
[ ... ]
}

[Severity: High]
This isn't a bug introduced by this patch, but can a malfunctioning or
malicious I2C device cause an out-of-bounds read on the keymap array here?

If the device returns a large register value (e.g., reg & 0x7F is 127), the
calculated row and col are not verified against the actual matrix dimension=
s.
Will this produce a code index that exceeds the keymap array's allocated
size when passed to input_report_key()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903192942.2190=
6-1-liangzhan5dev@gmail.com?part=3D1
