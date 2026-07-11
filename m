Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E84374198
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783762770; cv=none; b=qqvfdWDHyv7nqkdz+PmjgkYgNVsBuSaXTpNCbLk6hhZzbp+K+lnEXXnySAa51E6H0xRs9Ibi2E+wrcLJ/xoFZik1m0yKXnwDxYC3/QWRsJbiIKXYY9J3B33T3TCr6LzeTv+8LTr//dlDyPXz1sSFGCRiYn8eGt3kKFrzkKHMxxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783762770; c=relaxed/simple;
	bh=1DiijfKJXANP7+8dgTDXObjY5I6QWlQ++sUz+o1o/y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RjAo/exGbMnHqANFFU2hQKkSb9m5zxA4QceI8w8fO1Re6lb4Iof1xoX30n8nzYE+NXbSPoc2fcD0ogkdZp8v6TnhEQgHYEMCuZOBf1TidAwL1eDMgW885ZvNknJmm/Lv/F63OXPh8lJhEAVMH2L+p4kKpvynkl68zZgSXvz/a00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJszOAvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJszOAvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4691F000E9;
	Sat, 11 Jul 2026 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783762769;
	bh=ZMHt0UnvBBGZ6tahiXTjR/EQMLHJ1glTYt8J+u7QpPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TJszOAvJBrOeviC/PI6povxtHrLLmreul+UCKzoba+i4GX55u0Ll4s4QE5rMkZW4c
	 vsONCriX0pQrtNqUKE7Dw8Lb+kBzyMiArSEQAq43oe7oipAZ0w56fv/7UDolexAoik
	 jX6CLMoUKegWFdv4vShzCKn/f0CLE9k4PjBnOhAcs9sMnnU1R5XUTi/IG36tRsHuxG
	 JvD3LUSF4C4prylwCowCnvqD+KPFtLpRUFt3biGtBkkrSFUwzEnLUEAwh1SyilTRD7
	 dYiAgXsR7CaL3gMFfWxiJtUZ8LYbyaW/P78FwTBkEbu2SUC/K9C8/57YZBt5xHNmUD
	 voMvQJMpg9vOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] Input: applespi - fix NULL pointer dereference
 in tp_dim open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shih-Yuan Lee" <fourdollars@debian.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260711092054.13818-4-fourdollars@debian.org>
References: <20260711092054.13818-1-fourdollars@debian.org>
 <20260711092054.13818-4-fourdollars@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 09:39:28 +0000
Message-Id: <20260711093928.BF4691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Repeated processing of expected or malicious hardware `PACKET_DEV_=
INFO` responses causes unbounded allocation and registration of `devm`-mana=
ged input devices.
- [High] Use-After-Free of `applespi` private data in the asynchronous SPI =
read callback during driver unbind.
- [High] Missing bounds check on keyboard release events causes an out-of-b=
ounds read of kernel memory, leading to an information leak.
--

--- Patch [3]: [PATCH v3 3/3] Input: applespi - fix NULL pointer dereferenc=
e in tp_dim open ---
commit 44778c849d055105696c2f1ad69bc1cf09ff47d0
Author: Shih-Yuan Lee <fourdollars@debian.org>

Input: applespi - fix NULL pointer dereference in tp_dim open

This commit fixes a NULL pointer dereference in applespi_tp_dim_open()
when userspace accesses the debugfs file before asynchronous initialization
completes. It uses smp_load_acquire() to safely load the touchpad input
device and returns -ENODEV if not initialized.

> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/a=
pplespi.c
> index fd785dba1174e..e3e239f430bd9 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -972,12 +972,18 @@ static void applespi_debug_update_dimensions(struct=
 applespi_data *applespi,
>  static int applespi_tp_dim_open(struct inode *inode, struct file *file)
>  {
>  	struct applespi_data *applespi =3D inode->i_private;
> +	struct input_dev *touchpad;
> =20
>  	file->private_data =3D applespi;
> =20
> +	/* Pairs with smp_store_release in applespi_register_touchpad_device() =
*/
> +	touchpad =3D smp_load_acquire(&applespi->touchpad_input_dev);
> +	if (!touchpad)
> +		return -ENODEV;
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the driver leak resourc=
es
if it repeatedly processes hardware device info responses?

If applespi_handle_cmd_response() receives this packet, it schedules the
worker:

applespi_handle_cmd_response() {
    ...
    schedule_work(&applespi->work);
}

The worker unconditionally calls applespi_register_touchpad_device(), which
allocates a new devm-managed device:

applespi_register_touchpad_device() {
    ...
    touchpad_input_dev =3D devm_input_allocate_device(&applespi->spi->dev);
    ...
}

Could this lead to unbounded allocation and registration of devm-managed in=
put
devices, losing the reference to the old ones and eventually exhausting mem=
ory?

[Severity: High]
This is a pre-existing issue, but is there a potential use-after-free in the
asynchronous SPI read callback during driver unbind?

During driver removal, applespi_remove() calls applespi_drain_reads(), which
waits for read_active to become false:

applespi_remove() {
    ...
    applespi_drain_reads(applespi);
    ...
}

In applespi_async_read_complete(), applespi_msg_complete() sets read_active
to false and wakes the waitqueue, then proceeds to use applespi->gpe:

applespi_async_read_complete() {
    ...
    applespi_msg_complete(applespi, false, false);
    ...
    acpi_finish_gpe(NULL, applespi->gpe);
}

If devres cleanup frees the applespi struct immediately after
applespi_drain_reads() returns, could accessing applespi->gpe cause a
use-after-free?

[Severity: High]
This isn't a bug introduced by this patch, but is there an out-of-bounds re=
ad
when processing keyboard release events?

In applespi_handle_keyboard_event(), the unvalidated keys_pressed array is
copied directly into last_keys_pressed:

applespi_handle_keyboard_event() {
    ...
    memcpy(&applespi->last_keys_pressed, keyboard_protocol->keys_pressed,
           sizeof(applespi->last_keys_pressed));
    ...
}

On a subsequent keyboard event, if a previously stored invalid keycode is
processed as released, it is passed to applespi_code_to_key():

applespi_handle_keyboard_event() {
    ...
    key =3D applespi_code_to_key(applespi->last_keys_pressed[i],
                               applespi->last_keys_fn_pressed[i]);
    ...
}

applespi_code_to_key() uses this unvalidated keycode to index the
applespi_scancodes array:

applespi_code_to_key() {
    ...
    unsigned int key =3D applespi_scancodes[code];
    ...
}

Could a maliciously crafted SPI packet cause an out-of-bounds read of
applespi_scancodes leading to an information leak?

>  	snprintf(applespi->tp_dim_val, sizeof(applespi->tp_dim_val),
>  		 "0x%.4x %dx%d+%u+%u\n",
> -		 applespi->touchpad_input_dev->id.product,
> +		 touchpad->id.product,
>  		 applespi->tp_dim_min_x, applespi->tp_dim_min_y,
>  		 applespi->tp_dim_max_x - applespi->tp_dim_min_x,
>  		 applespi->tp_dim_max_y - applespi->tp_dim_min_y);
>=20
>  	return nonseekable_open(inode, file);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711092054.1381=
8-1-fourdollars@debian.org?part=3D3
