Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC9258EFF
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779552083; cv=none; b=o/fGdoxR1lo4WgJPrfq07M6oWPqVHb69lMe0VZYRixBAgfVfK2qoXZjcVYxohYvPIAi9P8kSbtKH71KMb762xfvBECgiXSv3UXVpD/xLQgmIqG+gL/Z+WBG4x156HJP19cV5ehyqlt+kUOB20kFKxBaJbIebObEOfGgCThCKCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779552083; c=relaxed/simple;
	bh=36Nb1YIGk1Mo9VsKIhQbLP9IvxnuvuZlwBs7iOidGbc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPynWoSVexhNmt5HuBJ8MlMyUo7mOGgxU4vZttZAod1YGuNrQHhvcWx0/hVek8am9OT0d4Ox1XFvcgnb80PkbLrbTzZJXLZHLUlmz/xgqUM8Kiz0aXhYdiNok4v/aGDgfKT+hY+AY/o3RlGRJBRKO5MGpFXKs/Y0ATTxWM5oirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRimJLmi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRimJLmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E737F1F000E9;
	Sat, 23 May 2026 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779552082;
	bh=dTjoW/CVoS8QEM5r1krrzfoQAQfAwBTGHxsreqEvhes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jRimJLmi2wG4LyFi7tcTUxR9z+C1R7tQqdgVB1MtLC5U+Mkut2oSB9gD5udsoKG0m
	 llGDEkBQ01ku5esB5q3MZjMHA8DZ6k5lygbVL4Q/2iSqPHXNL6yD21eCavR99qh6Fg
	 wU22QkD6opE8KvK/ztHOr82La9iIG/aF51uZ54LHJ6KkJCX9K3KOEuTnr2fPAewkir
	 wm+a3M0rkZw+Kplm53zXzmkbkTrcyL5owjtsclwzlFW9/5bsw+/OqF89XT0ZOq7v7X
	 WnYwmf4HNNYuxS8gNyLJV3xSb+Xtm81ry/gXmGLgbsS6d5HHAgs4JzW7oyd95EHjAk
	 uBOmE+vddmL7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Input: atmel_mxt_ts: Fix async config
 use-after-free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hendrik Noack" <hendrik-noack@gmx.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260523152332.86864-1-hendrik-noack@gmx.de>
References: <20260523152332.86864-1-hendrik-noack@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 16:01:21 +0000
Message-Id: <20260523160121.E737F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] The newly added `config_lock` mutex in `struct mxt_data` is us=
ed without being initialized.
- [High] If `mxt_initialize()` aborts due to `shutting_down =3D=3D true`, i=
t consumes the completion but fails to restore it, leading to a permanent h=
ang.
- [High] The `config_lock` mutex is held across a potentially unbounded wai=
t, defeating the purpose of the `shutting_down` flag.
- [Medium] A time-of-check to time-of-use (TOCTOU) race allows asynchronous=
 firmware loading to start after device removal has begun.

Pre-existing issues:
- [High] Concurrent sysfs writes to the `update_fw` attribute can trigger a=
 double free of the input device.
--

commit a6627582981aef52fbfe146ee37db19f67d402dd
Author: Hendrik Noack <hendrik-noack@gmx.de>
Input: atmel_mxt_ts: Fix async config use-after-free

This commit attempts to fix a use-after-free by adding a mutex and a
completion to serialize the asynchronous firmware loading and the device
removal process.

> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index a9e86ad7ed5ef..07690c3bff06e 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c

[ ... ]

> @@ -2271,12 +2279,22 @@ static int mxt_initialize(struct mxt_data *data)
>  	if (error)
>  		return error;
> =20
> +	scoped_guard(mutex, &data->config_lock) {
> +		wait_for_completion(&data->config_completion);

[Severity: High]
Is it safe to hold the config_lock mutex across this wait_for_completion()
call?=20

Since the lock is held while waiting for a potentially long firmware load,
and mxt_remove() needs this same lock to set shutting_down to true, would
this cause mxt_remove() to block indefinitely, defeating the early shutdown
check?

> +
> +		if (data->shutting_down)
> +			return -EBUSY;

[Severity: High]
If shutting_down is true, the wait_for_completion() above has already
decremented the completion's counter.=20

Returning -EBUSY here without calling complete(&data->config_completion)
leaves the completion consumed. When mxt_remove() later calls
wait_for_completion(), will it hang forever waiting for a completion that
is never restored?

> +
> +		reinit_completion(&data->config_completion);
> +	}
> +
>  	error =3D request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
>  					&client->dev, GFP_KERNEL, data,
>  					mxt_config_cb);

[Severity: Medium]
Because request_firmware_nowait() is called after the config_lock is
released, is there a race condition here?=20

If mxt_remove() runs immediately after the lock is dropped, it will acquire
the lock and set shutting_down to true, but request_firmware_nowait() will
still be invoked, starting a new asynchronous load while the device is
actively being removed.

[ ... ]

> @@ -3237,6 +3255,9 @@ static int mxt_probe(struct i2c_client *client)
>  	init_completion(&data->bl_completion);
>  	init_completion(&data->reset_completion);
>  	init_completion(&data->crc_completion);
> +	init_completion(&data->config_completion);
> +	complete(&data->config_completion);
> +	data->shutting_down =3D false;

[Severity: Critical]
Does the config_lock mutex need to be initialized here?=20

The mxt_data structure is allocated with devm_kzalloc(), which=20
zero-initializes the memory. Using an uninitialized mutex with=20
scoped_guard() will cause a NULL pointer dereference when contention=20
occurs. Should there be a call to mutex_init(&data->config_lock)?

[ ... ]

> @@ -3342,6 +3363,12 @@ static void mxt_remove(struct i2c_client *client)
>  {
>  	struct mxt_data *data =3D i2c_get_clientdata(client);
> =20
> +	scoped_guard(mutex, &data->config_lock) {
> +		data->shutting_down =3D true;
> +	}
> +
> +	wait_for_completion(&data->config_completion);
> +
>  	disable_irq(data->irq);
>  	mxt_free_input_device(data);

[Severity: High]
This is a pre-existing issue, but looking at mxt_free_input_device(), it
checks if data->input_dev is non-NULL and then unregisters it.

If concurrent sysfs writes to the update_fw attribute occur, multiple
threads can enter mxt_load_fw() and call mxt_free_input_device() at the
same time. Since sysfs doesn't serialize these writes and there is no
internal locking, could both threads pass the NULL check before either
sets it to NULL, resulting in a use-after-free and double-free of the
input device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523152332.8686=
4-1-hendrik-noack@gmx.de?part=3D1
