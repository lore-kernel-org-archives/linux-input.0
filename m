Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD336F414
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236649; cv=none; b=BNYgxq+9036yD1gUDoNYbszZwb1CKqFtk9W5XFKkFzo0GFGpVZefRT6lHvEXO/xQO8Yzo15hEgKP9hBMRAK5A6f3t0a26Obxh9qcAe2seBTn7aVxzK5DuOjTtXiiB58YBXomUhVvR261EZZp0fuVB9Zllib6ZlKlTwwI4JSHRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236649; c=relaxed/simple;
	bh=epwe3SECL20UgR6tcuyTsYqdPD1wIQnnLOOmDsEbpM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ranwYEKYJCNFUNIr0r45wRp5fjK/z3yHTuVuRld+v6zXJp+3y5x59WlveOeNQb0im+/AOS8QfXedBO8N/EeLeW+qmAjO6imHU66qnHzHkTodelCHa5qPWYinksUKgECqv1PCglG8R/dFGYYUDX2wUBqQMhlJP6l7zRxGNOuMIDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8WWRw9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8WWRw9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302FC1F00893;
	Sat, 12 Sep 2026 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789236648;
	bh=ANkqcrqVW6qZc7lpgdEiWaop8cvz8p5GuDBcQHD/a5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U8WWRw9Xj/ZjEncrvAB3dx+wIifgIjVfG7R5pck1J9j8sv7R3TpTK4BBU1PGFzYY+
	 ety9VankgcJABoFG4is+433qVHOgeMKeYnbNfRoIh/E0cGudFyZfAZwfuQYPjg+fss
	 7oJpEpnQ/s4MZnT3y8WNiSlF0bUeopSCjNhKmlFZoJHRwjStsi9qr5v0R6KgYGMDz9
	 lHVGyra8uuZoXi/EMnx3sO4cL+zgUjrfsap01P0ldh7f2o7t+h3AIuVlv/Wbd3z+3n
	 YeRitMDzTNEwFZB+jK6eZnP31aT6rSz79mFX5gZS0eqzmABqmYYS1edbxidbsIsS8J
	 QicFCQIHiSeFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - add support for reset gpios
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roman Vivchar" <rva333@protonmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912-rmi4-reset-v1-1-4a3fc8856830@protonmail.com>
References: <20260912-rmi4-reset-v1-1-4a3fc8856830@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 18:10:47 +0000
Message-Id: <20260912181048.302FC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing reset GPIO assertion before disabling regulators on driver=
 unbind and probe error paths leads to potential backpowering.
--

commit 11e1dedc5b986fa6ff95c5549b898574a80bff23
Author: Roman Vivchar <rva333@protonmail.com>

Input: synaptics-rmi4 - add support for reset gpios

In some cases, the touchscreen is wired to the always-on regulator, so
resetting is required for proper I2C communication. Add reset support to
the rmi_i2c driver.

> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index e11d0acb9b96d..da560988f44a1 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
[ ... ]
> @@ -235,6 +247,11 @@ static int rmi_i2c_probe(struct i2c_client *client)
>  	if (error < 0)
>  		return error;
> =20
> +	rmi_i2c->reset_gpio =3D devm_gpiod_get_optional(&client->dev, "reset",
> +						      GPIOD_OUT_HIGH);
> +	if (IS_ERR(rmi_i2c->reset_gpio))
> +		return PTR_ERR(rmi_i2c->reset_gpio);
> +
>  	error =3D regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
>  				       rmi_i2c->supplies);
>  	if (error < 0)

[Severity: High]
If a probe error occurs later in rmi_i2c_probe() (for example, when calling
rmi_register_transport_device()), or if the driver is unbound, devres will
run rmi_i2c_regulator_bulk_disable() to disable the regulators.

Should the reset GPIO be asserted before disabling the regulators in the
devres cleanup paths?=20

Unlike the suspend callbacks which do assert the GPIO, the devres cleanup
does not. This appears to leave the reset GPIO driven while the chip is
unpowered, which could lead to backpowering the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-rmi4-reset=
-v1-1-4a3fc8856830@protonmail.com?part=3D1
