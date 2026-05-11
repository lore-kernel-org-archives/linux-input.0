Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E82E03E4
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533011; cv=none; b=WWNRvqAKQAbUM4G8NDe8XSlLNq2/0yu//ASQ7kBwfUbnvHYPkZ7pO8p2PfSnT5aB7AOuZVUPzzM4zgZfknwsQ1lASrxTaY4uHlwJG6vt014uPDDccVG7mYZApmC4CwNW+wRYbsqipdlDx2E+A47FLp5fo/i8czq5qjNC+ZOofKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533011; c=relaxed/simple;
	bh=jvCcs63hvWyrQ7uQVbBYJY7X0D5ONTg6zfD80oYfw48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pGXEMWunN0RDOdwxX0TxJuIExaMl3E29W1aaG2ZlBUSLofRqVGPLCVWIm2RXPK3/VxuwWiJ4YcIC1XsA0xMwx417QMVFT0giNglAqQgy5rrtVzbVh0a4Dk8PkGRlEn6jHqZcnn0KrPbwt0VjLAPNfgbTy7UESA683JHR9Ly99pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O599YG5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O599YG5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A9C2BCF5;
	Mon, 11 May 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778533011;
	bh=jvCcs63hvWyrQ7uQVbBYJY7X0D5ONTg6zfD80oYfw48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O599YG5OV+5auqosQoO4nwY+kkJHCn+uIErc1jfxVdHgv5FnVcDpyu7+lOX4hmULG
	 Kaf7R/uDpt2RrLalu7WljaZgRDDL8OglFI91rl3NbmMTks0Bp6ZQms7ui91ZD0AQS7
	 9ZNdhIAIvuM/daPvzhEho9sdzECoMCxnfdqz4w/tLdXuQZrd9mRQ4tW6g57I/T4Au3
	 ew1DtjrBAdPOe5BTvi8N6V58Nz2rR2DnJLRxqim9n2URqzXtCnmEkvrysRvtwAoNHo
	 OIdQpiwFjwhWdXYiewuntJPzsO0TaGw2ESk2nZ/AYs6YxxXSNssARQbPngIStYVoJZ
	 53uhB/VbyJFgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: pidff: Fix integer overflow in pidff_rescale
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?VG9tYXN6IFBha3XFgmE=?= <tomasz.pakula.oficjalny@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260510122352.1161826-1-tomasz.pakula.oficjalny@gmail.com>
References: <20260510122352.1161826-1-tomasz.pakula.oficjalny@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 20:56:50 +0000
Message-Id: <20260511205651.7B4A9C2BCF5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The subtraction `field->logical_maximum - field->logical_minimum` =
is evaluated in 32-bit arithmetic, allowing it to overflow before being pro=
moted to `s64`.
- [High] The adjacent function `pidff_rescale_signed()` suffers from the ex=
act same integer overflow vulnerability but was completely missed by the pa=
tch.
- [High] This problem wasn't introduced by this patch, but missing bounds c=
heck on `unit_exponent` in `pidff_rescale_time()` allows a kernel stall via=
 a malicious HID descriptor.
--

commit d365813aa395ac1ce1eeffd147aa3beb65aba60b
Author: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
HID: pidff: Fix integer overflow in pidff_rescale

This commit attempts to fix an integer overflow in pidff_rescale by using a
64-bit signed integer for calculations. It addresses an issue where rescali=
ng
values close to the maximum could temporarily exceed the 32-bit signed
integer range.

Closes: https://github.com/JacKeTUs/universal-pidff/issues/116

> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidf=
f.c
> index aee8a44433059..c45f182d04480 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c

[ ... ]

> @@ -326,8 +327,10 @@ static s32 pidff_clamp(s32 i, struct hid_field *fiel=
d)
>   */
>  static int pidff_rescale(int i, int max, struct hid_field *field)
>  {
> -	return i * (field->logical_maximum - field->logical_minimum) / max +
> -	       field->logical_minimum;
> +	/* 64 bits needed for big values during rescale */
> +	s64 result =3D field->logical_maximum - field->logical_minimum;

Since both logical_maximum and logical_minimum are 32-bit signed integers,
does the subtraction field->logical_maximum - field->logical_minimum evalua=
te
in 32-bit arithmetic and potentially overflow before being promoted to s64?

If an untrusted USB device provides a descriptor with extreme limits,
this difference could exceed the capacity of a 32-bit signed integer and wr=
ap
around to a negative value. Should at least one operand be explicitly cast
to s64 before the subtraction?

> +
> +	return div_s64(result * i, max) + field->logical_minimum;
>  }
> =20
>  /*

This isn't a regression introduced by this patch, but looking at the
adjacent pidff_rescale_signed() function:

drivers/hid/usbhid/hid-pidff.c:pidff_rescale_signed() {
...
	if (i > 0)
		return i * field->logical_maximum / S16_MAX;
...
}

Does the multiplication i * field->logical_maximum suffer from a similar
overflow?

Since both operands fit into an int, they evaluate in 32-bit signed
arithmetic. If a device advertises a logical_maximum greater than 65535,
could this multiplication silently overflow yielding a wrapped-around
negative value before the division takes place?

Also not introduced by this patch, but looking at pidff_rescale_time():

drivers/hid/usbhid/hid-pidff.c:pidff_rescale_time() {
...
	int exponent =3D field->unit_exponent;

	pr_debug("time field exponent: %d\n", exponent);
	for (; exponent < FF_TIME_EXPONENT; exponent++)
		scaled_time *=3D 10;
	for (; exponent > FF_TIME_EXPONENT; exponent--)
		scaled_time /=3D 10;
...
}

Are there any bounds checks on field->unit_exponent before it is used
in these loops?

The field->unit_exponent is parsed from untrusted USB device descriptors.
If a USB device provides a large 32-bit exponent value, could
this execute up to 2.14 billion iterations doing multiplications or
divisions without any early break checks?

Could this trigger a kernel stall or soft lockup when a user uploads a
force-feedback effect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510122352.1161=
826-1-tomasz.pakula.oficjalny@gmail.com?part=3D1
