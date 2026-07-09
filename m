Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA01E633C;
	Thu,  9 Jul 2026 05:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783573591; cv=none; b=QSF3Poxj+Zsj5lTl09KvkCSpKOUfZru9PY+iFEK/S7sFVeiwQMxNID6beo3mmecxnFMmJmP6zOwYpvIOnxOm8a7LX49kdJYfuvsinHOYP9sGLIwslEyy5BEM50bpxifl0XhvMvg93fGrwWlYiMe8v95wBHwsdUi0TaZ/ajY2Wcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783573591; c=relaxed/simple;
	bh=/2C8aJgDuJioyp59wKJcXUItJqNTYb2/kvM5Khca6iA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EZayLXM3TqF7lD3AV8jVrUG+9aJrkI7gTWzzmjGToxgfGtyVE2Kdg6htTPaq/pTwOK5upPLdhC/cVjiw1f/1LoH29D/T+l172Lo6U8b0dcYjbXz1Q6fg4E1HATiVMR08P0ccndyOWLTzNitNnbbxwdEuqqeStdVqbErANO3o5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDLiveJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDLiveJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBD81F000E9;
	Thu,  9 Jul 2026 05:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783573590;
	bh=lBd/AEOwFIJjqmiEGoQ77PFU1QqpGxax73B9Pm5ZnXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDLiveJOF0N2h0ShNUdlLPLBQJCmEbCiCg0VE1kIc3Qxd+DxyODE+JKCu01atza2q
	 Is45AJjabwffBczFe5pxfG5P9NtPUEgp3MAt+ykpR37pwQnPmd+Hfqb3dLyJw+kV6l
	 pATyOQ8KF/DKdJkCH2op74VKj+yryKR0KJo4M1KzSR6MthPf8UKrw+dJNZF+hWQqnK
	 66ieNvy/fDf0nH1H0cmzYNqr3irfhRwFPrxCKZiB8XRa3C4AsEW0Df/S3WJ8He7gzv
	 LbcYgtoghgLZfms5yWYHn6eti+5pgy/ORF8OHwclnInIlT5/UdepfkGu4Lv3LNtK5Z
	 z3mSt4gJoRgog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] Input: samsung-keypad - handle compact binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260708-samsung-kp-v2-2-3c6ed4c9b3b6@gmail.com>
References: <20260708-samsung-kp-v2-0-3c6ed4c9b3b6@gmail.com>
 <20260708-samsung-kp-v2-2-3c6ed4c9b3b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 05:06:29 +0000
Message-Id: <20260709050629.BEBD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Legacy device tree bindings for keypad row/column count are ignore=
d and overwritten, breaking existing platforms.
--

--- Patch [2]: [PATCH v2 02/11] Input: samsung-keypad - handle compact bind=
ing ---
commit 43d179d444ff3e714e66f7ac32f10fcc817c6f15
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: samsung-keypad - handle compact binding

Adds support for standard matrix keymap bindings to the Samsung keypad
driver, allowing easier conversions from platform data to static device
properties.

> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyb=
oard/samsung-keypad.c
> index 17127269e3f05..b9d4ea5f202ae 100644
> --- a/drivers/input/keyboard/samsung-keypad.c
> +++ b/drivers/input/keyboard/samsung-keypad.c

[ ... ]

> +static const struct samsung_keypad_platdata *
> +samsung_keypad_parse_properties(struct device *dev)
> +{
> +	const struct matrix_keymap_data *keymap_data;
> +	struct samsung_keypad_platdata *pdata;
> +	u32 num_rows =3D 0, num_cols =3D 0;
> +	int error;
> +
>  	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata) {
> -		dev_err(dev, "could not allocate memory for platform data\n");
> +	if (!pdata)
>  		return ERR_PTR(-ENOMEM);
> -	}
> =20
> -	of_property_read_u32(np, "samsung,keypad-num-rows", &num_rows);
> -	of_property_read_u32(np, "samsung,keypad-num-columns", &num_cols);
> -	if (!num_rows || !num_cols) {
> -		dev_err(dev, "number of keypad rows/columns not specified\n");
> -		return ERR_PTR(-EINVAL);
> -	}
> +	device_property_read_u32(dev, "samsung,keypad-num-rows", &num_rows);
> +	device_property_read_u32(dev, "samsung,keypad-num-columns", &num_cols);
> +
> +	error =3D matrix_keypad_parse_properties(dev, &num_rows, &num_cols);
> +	if (error)
> +		return ERR_PTR(error);

[Severity: High]
Will this break probing on existing platforms that use the legacy bindings?

Looking at matrix_keypad_parse_properties() in drivers/input/matrix-keymap.=
c,
it unconditionally resets the row and column pointers to 0 before attempting
to read the modern properties:

int matrix_keypad_parse_properties(struct device *dev,
				   unsigned int *rows, unsigned int *cols)
{
	*rows =3D *cols =3D 0;

	device_property_read_u32(dev, "keypad,num-rows", rows);
	...

If the modern "keypad,num-rows" properties are absent, it seems this will
wipe out the successfully parsed legacy "samsung,keypad-num-rows" values
and return an error, causing the probe to abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-samsung-kp=
-v2-0-3c6ed4c9b3b6@gmail.com?part=3D2
