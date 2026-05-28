Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE43AD527
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960538; cv=none; b=mXASBU7EtoheNR8iaRfwqQItOrYTt84x6G5zEAYgdvqKriAQAybQdS1rwDgNwaBN/sg5695o80IDw9TR4V518ZmZDRYhxYR8GFMzAPIROxi8OenfKP197qUPydr84/dM18EA6P0WTrvut1n6IMPZ2rhQQWZAm/xtTXKhfVvI99Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960538; c=relaxed/simple;
	bh=HEvOfGqyG5EQ+Ecx2RI1uigcNIob/Di24SXOthxyXTA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qm/pYVopg02h4OBitKDSTBCQL+592vItms8PYrnZj/cihoeK/Is7GeuW1P9hSOjCuvKU6GuOaPukpaWs9Kt3ya3l9a8YH4FTu/NxVJE743hTYtSp/1Y/hl/WKAxeyXvIKFV0WOsrCvBFTXdpL4x0R6cr+ixspksZJj2cxjrYsv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYNO3m+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYNO3m+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D781F000E9;
	Thu, 28 May 2026 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960537;
	bh=s74bflgT3syJf6CO7B9qujowTigZhScTNiAtlw3YO+o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYNO3m+9oUT71GvoCUwPZbgtyrSQUojmIZXMK0l7WsNVn9vwwH8twow6xe2bKiyl0
	 /DMTGiTn9aMNTl4bu3MkDGRuCxP1cZO62Uxh5bL6JhrqkLb2lcenPnQxZ8iaxTDzxZ
	 8jOxY63SCfTGoquyMkJTiplKGWqB/846wLYS+5dWBUGlqXhEFzTSX72+J5QKGoxIIq
	 i+AsNF927lDHP5znWAN8wnSJfpY4ENnPjVwwvWkXxRHLPifT28kvQTxWeMJM4XS8aX
	 cmq09W4Nxug/XaI3yq5Q8yhLj+sZmVbLBT5/7OBnPbisboEpXbw32/4GltWUh+rqaG
	 y9p1a8b0rHFxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] Input: atmel_mxt_ts: Allow per-machine config
 via DT compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hendrik Noack" <hendrik-noack@gmx.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260528074317.9604-2-hendrik-noack@gmx.de>
References: <20260528074317.9604-2-hendrik-noack@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 09:28:56 +0000
Message-Id: <20260528092857.28D781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of 'mxt_load_fw' via the 'update_fw' sysfs at=
tribute lacks locking, leading to double-free of the input device, TOCTOU r=
aces, and interleaved I2C commands.
--

commit eb7b8b6b98800084b750dc1b902ad664e878e3d8
Author: Hendrik Noack <hendrik-noack@gmx.de>

Input: atmel_mxt_ts: Allow per-machine config via DT compatible

The Atmel maXTouch config is machine-dependent, different panels and
layouts require different configs even when the same controller and
firmware is used.

> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index a88dc7e6827c7..5ac123d4ed036 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
[ ... ]
> @@ -2291,12 +2351,9 @@ static int mxt_initialize(struct mxt_data *data)
>  		return -EBUSY;
>  	}
> =20
> -	error =3D request_firmware_nowait(THIS_MODULE, true, MXT_CFG_NAME,
> -					&client->dev, GFP_KERNEL, data,
> -					mxt_config_cb);
> +	error =3D mxt_invoke_config_loader(data, true);
>  	if (error) {
> -		dev_err(&client->dev, "Failed to invoke firmware loader: %d\n",
> -			error);
> +		dev_err(&client->dev, "Failed to invoke config loader: %d\n", error);
>  		complete(&data->config_completion);
>  		return error;
>  	}

[Severity: High]
This is a pre-existing issue, but I noticed that mxt_update_fw_store()
invokes mxt_load_fw() without any locking to serialize concurrent execution.

Since sysfs write operations don't hold a global lock like device_lock,
could multiple threads concurrently writing to the update_fw attribute race
when checking and setting data->in_bootloader?

If so, could both threads concurrently execute mxt_free_input_device(),
observe a non-null data->input_dev, and invoke input_unregister_device() on
the same pointer before it is set to NULL?

This seems like it might lead to a double-free or use-after-free since
input_unregister_device() drops the reference count.

Could this also race with PM callbacks like mxt_suspend() attempting to
acquire input_dev->mutex, operating on freed memory if
mxt_free_input_device() is executed concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528074317.9604=
-1-hendrik-noack@gmx.de?part=3D2
