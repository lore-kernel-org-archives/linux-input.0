Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CE3D410E
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031501; cv=none; b=ZIXUTdRjaS0+pBOK5C0d9OfNjdV8KEurHdpaee4oL1xCTn9UsubuNtLtwdQIx65/xIsljyXL8I2WyfpJcxuG1JU8GdmHXhaD7Tzy7p4XU/tgxt4a2gUIA4NZsPyL1Jqr3VQ7jpNPXjxZDlMx+MLjoS1UOeh4GvcGprVqj9cep/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031501; c=relaxed/simple;
	bh=JusIu5UVETw7OuN77TxRenw9uuqI/hp41Az6snl4TzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cDJ7DIMy5bZ0bGxW7L+zLueFGS0fsrWWIsRg/mfcuLhnHNR+YllwYu5q1mLOjwgpwRKEfuaaj6z6/qwAmXM4U5X6XW3ajnxNKKgkJkLaDKhztcWlXtu4ihUKUhoZxapnCc/vtPyY4biwxLqE/XkxQVhHyMAS8g+t/6sOA4Jk7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk/z0Ydq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk/z0Ydq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCC91F00A3A;
	Tue, 14 Jul 2026 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784031499;
	bh=IzQc1yo3lVRht3DtBUPv+zzFVY2+43J0MufoW2tcUCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rk/z0Ydql8P50kZgX08Xvl+g+mlTcEwYQjlcNUaP6r2R00onYKYrT/rbSaEmtGpIz
	 Chm7K+K3wzfnXR1IJAqCT14zmCtBDT3chEE5uZeOGG+vQcl0YPwUiYMjwt2TSfSEqd
	 bzCESjhX5dXC0nDbsrECDZWMQqBJzF2sLIQh71xjOmtlamfp9Deer5GYmYVdHY6KQy
	 gkspVnE08OKMvF1w/X3yrYNsH5EFGs8A3sKqMLAy8olspjMRNYOrppHaadaXURRlvu
	 GzU+Jwho8vUYEt65JfAV8Xu2xXrbipm923ZWyNFKib+XU9bk6q74Ji7l43KWjqkqWK
	 YH12x06ODkrMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: input: allocate input_dev name/phys/uniq using hid
 device devres
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hyeonsu Choi" <chlgustn3171@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714120052.255085-1-chlgustn3171@gmail.com>
References: <20260714120052.255085-1-chlgustn3171@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 12:18:18 +0000
Message-Id: <20260714121819.5FCC91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Use-After-Free of input_dev string fields (name, phys, uniq) on de=
vice unbind.
- [Low] Memory leak of devm_kstrdup strings in the error path.
--

--- Patch [1]: [PATCH] HID: input: allocate input_dev name/phys/uniq using =
hid device devres ---
commit ae1934cecc0a7213604df29b6d6486b4090d9b54
Author: Hyeonsu Choi <chlgustn3171@gmail.com>

HID: input: allocate input_dev name/phys/uniq using hid device devres

This commit modifies hidinput_allocate() to dynamically allocate the
input_dev name, phys, and uniq strings using devm_kstrdup() tied to
the parent HID device. It also introduces an error handling path to
clean up if the allocations fail.

> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -2126,9 +2126,20 @@ static struct hid_input *hidinput_allocate(struct =
hid_device *hid,
[ ... ]
> -	input_dev->name =3D hidinput->name ? hidinput->name : hid->name;
> -	input_dev->phys =3D hid->phys;
> -	input_dev->uniq =3D hid->uniq;
> +	const char *name =3D hidinput->name ? hidinput->name : hid->name;
> +
> +	input_dev->name =3D devm_kstrdup(&hid->dev, name, GFP_KERNEL);
> +	if (!input_dev->name)
> +		goto fail;
> +
> +	input_dev->phys =3D devm_kstrdup(&hid->dev, hid->phys, GFP_KERNEL);

[Severity: High]
If a userspace process holds an open file descriptor for the evdev node
(/dev/input/eventX), the input_dev will outlive the parent hid->dev.
When the HID device is unbound, devres will free these strings.

Can this cause a use-after-free when userspace later queries the
name, phys, or uniq strings via ioctl (e.g., EVIOCGNAME)?

> +	if (!input_dev->phys)
> +		goto fail;
> +
> +	input_dev->uniq =3D devm_kstrdup(&hid->dev, hid->uniq, GFP_KERNEL);
> +	if (!input_dev->uniq)
> +		goto fail;
> +
[ ... ]
> @@ -2144,6 +2155,8 @@ static struct hid_input *hidinput_allocate(struct h=
id_device *hid,
>  	return hidinput;
> =20
>  fail:
> +	if (hidinput)
> +                kfree(hidinput->name);
>  	kfree(hidinput);
>  	input_free_device(input_dev);
>  	hid_err(hid, "Out of memory during hid input probe\n");

[Severity: Low]
If devm_kstrdup() fails for phys or uniq, the code jumps here to the
error path. The earlier successful devm_kstrdup() allocations remain
tied to &hid->dev.

If the caller continues the device probe successfully after this failure,
will these strings be leaked for the lifetime of the HID device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714120052.2550=
85-1-chlgustn3171@gmail.com?part=3D1
