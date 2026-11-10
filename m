Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309856;
	b=nB+suZ1KBF6xKij5gIGJAVfMGRWAGUHH/rnrbie2FAH08FXvXB1Ol4z6040c3EV+9mDJ
	 bW/Eu43v9NvwWKjjuwHt0/zD9kTYggGzxBJ1zA6hLXgsuqpQNidoKGY976wLFL5kKnfQ2
	 Y0B4YLxeGnFuwDdGTqUXKcTVj/gN7vAcNeS1fvGGKWGnavPfuDYk0AMkdkInfHEjKnPqD
	 ig3PF9TteKJ28NSEBmo/o3BkAANwNTrxpebEfAGR6LB6Ey7YWNetwPzpWXjawWkkruMU/
	 yVY1DZlJFEiMkXdhPUJ6q927x5RTv7Em/2AXqjzJAx26Uf5uo9Ok1NTF7Iw0O0BCN/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zxfEo05d3HNTWnzd801saX8OfzMQSeuSFTz5EeiTFBg=;
	b=DQRcVB35H1QW+TmcBkkPfB2BNwM6l6uraJR3qyaZMEKD+OUkfwPFimJ9bWLWvcZpUj8p
	 ch4BT5jekzkWprHfiozgqZtSGxYPLz5f5TVF+YII89jlUU60Y5Wb7T2Z5nEeVlC07azED
	 1Q5bAwBWOxuHyegq6CmCvPbGLdyVWfpD7n+kPW7fM5YNV1YIe/PXPeeLlNemj0RjAHwh6
	 gfj3mbqrLMWq84gyEMXKInJOZ4vn9FxHEdNoTZ5HYe8uCQYs2AXwdJn7s9p5GORVBOJqs
	 y6C91xufT1jLECg6ZcWADpa/fjwy46k5c9CtXOwXNyMsUJG1lihL8Z5NYsA++JW7G+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZoKwIf/6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCC60A2605;
	Tue, 10 Nov 2026 11:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZoKwIf/6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4491F008A3;
	Tue, 10 Nov 2026 11:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309855;
	bh=zxfEo05d3HNTWnzd801saX8OfzMQSeuSFTz5EeiTFBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZoKwIf/65uB6e1rEdHR5ogaU9bng8w+uni3NH6b8xzdnAYMiIy8TBe2oFNkeZF173
	 7JV9LQlS+uH3IPNnj4jbl+p9M2SwdMatcuuyY1HKuWjGxoDSjJtpnUb/S8j7tjIgFk
	 TKRcyg7LZRv73PP9zBldaFGedIaOY7sih+Qmawch9zQMBkHqSpuxxHjqkYklNOEfKA
	 X2cgOrBg001KsVPX9xweuPvYtpCCUpGWAQKI7eGbmryAHm0PKKXS1iR1ipkDDEalKI
	 6LvTqRlvQJEaUFsBA8U72YObRGFwGq2y94VIy7l9ylD4JfYAcjh7k5AqOhRV5gD1HO
	 XLqvVU8+2oUUQ==
Message-ID: <sashiko-outbox-206933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] Input: keyboard: Add Nuvoton MA35D1 keypad
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Feng-Yi Hsueh" <fyhsueh4linux@gmail.com>, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110111419.89535-3-fyhsueh4linux@gmail.com>
References: <20261110111419.89535-1-fyhsueh4linux@gmail.com>
 <20261110111419.89535-3-fyhsueh4linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 11:24:15 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] Input: ma35d1_keypad - use guard(mutex) in suspend and resume
  callbacks
- [Low] Input: ma35d1_keypad - name errno variables error and return 0
  explicitly
--

commit ca9c8a019e4d03872087b6ba2c747cf4ce6faf45
Author: Feng-Yi Hsueh <fyhsueh4linux@gmail.com>

Input: keyboard: Add Nuvoton MA35D1 keypad driver

This commit adds an input driver for the Nuvoton MA35D1 hardware matrix
keypad controller, handling key press/release interrupts, input event
reporting, and clock management across open, close, suspend, and resume.

> diff --git a/drivers/input/keyboard/ma35d1_keypad.c b/drivers/input/keybo=
ard/ma35d1_keypad.c
> new file mode 100644
> index 0000000000000..673ad8b9704bd
> --- /dev/null
> +++ b/drivers/input/keyboard/ma35d1_keypad.c

[ ... ]

> +/* Called with input->mutex held (open, PM resume). */
> +static int ma35d1_keypad_enable(struct ma35d1_keypad *keypad)
> +{
> +	int ret;
> +
> +	if (keypad->running)
> +		return 0;
> +
> +	ret =3D clk_prepare_enable(keypad->clk);
> +	if (ret)
> +		return ret;

[Severity: Low]
This isn't a bug, but in the input subsystem, variables that only hold 0
or a negative error code are conventionally named error or err rather than
ret.  The same applies to ma35d1_keypad_resume() and ma35d1_keypad_probe(),
and ma35d1_keypad_resume() should also explicitly return 0 on the success
path rather than returning the error variable directly.

[ ... ]

> +static int ma35d1_keypad_suspend(struct device *dev)
> +{
> +	struct ma35d1_keypad *keypad =3D dev_get_drvdata(dev);
> +	struct input_dev *input =3D keypad->input;
> +
> +	mutex_lock(&input->mutex);
> +	if (input_device_enabled(input))
> +		ma35d1_keypad_disable(keypad);
> +	mutex_unlock(&input->mutex);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_keypad_resume(struct device *dev)
> +{
> +	struct ma35d1_keypad *keypad =3D dev_get_drvdata(dev);
> +	struct input_dev *input =3D keypad->input;
> +	int ret =3D 0;
> +
> +	mutex_lock(&input->mutex);
> +	if (input_device_enabled(input))
> +		ret =3D ma35d1_keypad_enable(keypad);
> +	mutex_unlock(&input->mutex);
> +
> +	return ret;
> +}

[Severity: Low]
This isn't a bug, but new input drivers prefer guard(mutex)(&input->mutex)
over manual mutex_lock() and mutex_unlock() calls in
ma35d1_keypad_suspend() and ma35d1_keypad_resume().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110111419.8953=
5-1-fyhsueh4linux@gmail.com?part=3D2
