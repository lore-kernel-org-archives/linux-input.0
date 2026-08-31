Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44684CCDDB
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201043; cv=none; b=boJJ8vh/NTL1m6c/QUrHlOBOf2ATdhtD7c5StEa8A0KDKtL6lJEhFtzA6W9T6QeGH62LcLJqoUePb63FSzZUj0hJ1Vy/EbfgCXl4m+0u2gdRcbs0i9zi/cLDB2pHZpRUlAINojG0qQ++19hNn2A+o1vuJo9PQeG0NmzGL5RPiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201043; c=relaxed/simple;
	bh=wsPrMGdf5df4jyZ1Vbx42k8Dqvatgie/fWx9R9nsbhM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qGHLmRIbmE2gNlVWdQnErzM7iLaNWJU72oAuF8Vaz+O7puql+jy4W6dLSnKvF0AO1l/Cy2Rfe1QWtjXeah28tAMxge53fXpjcLVT6Nb0BdKURLga77WT4ntwP+Yva1WML/VDumJGUTWNCX7nsu5gFlUSZaxOjHMCb9smGx/dAco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmrB4XW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmrB4XW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2C21F000E9;
	Mon, 31 Aug 2026 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201041;
	bh=IAINS8d3uUZK58ifxIgCcvQzr20s94z4OFwvovxYTuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UmrB4XW1+8SIJT7iixg9PX7CzsM9GFLtCIhGSx7cUp6/aaje+4FLwf4B65ajWMCnu
	 3hhNDAq+TMT+SWUclmDqtr8GAsZDSxNTpFglQopWOKYfcjcG5bjjrwhHGghHC6tJxV
	 Us9JknIcv4InFe12l+xBr7lg6GtoSfVFrroJSSF0TZSlCJUKgtvthrktiWDAF7RJMw
	 wKnecq/Hu40SPbsqM2pSMPQ9O5kdDfXxWN9gweZ9feWR0kUtzv0wneK0HesilSu8/L
	 ZUdEE2xQ2TzqtMlxsZUcGjlR2CWD4AvOUp0jytqYrjLhUhf885Zdf6SBPw0tG5m92f
	 ycgP66QazWCtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] Input: evdev: propagate EVIOCSFF copy errors
 correctly
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXbDoW4gRXplcXVpZWwgUm9kcmlndWV6?= <ivanrwcm25@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260831152156.166514-2-ivanrwcm25@gmail.com>
References: <20260831152156.166514-1-ivanrwcm25@gmail.com>
 <20260831152156.166514-2-ivanrwcm25@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:30:40 +0000
Message-Id: <20260831183041.5A2C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel stack memory leak via EVIOCSABS and EVIOCGABS ioctls.
- [High] Kernel stack memory leak and KMSAN uninit-value bug in EVIOCSFF io=
ctl for compat tasks.
--

commit a43660053a9496b6179da4d914ad9411bf768ddb
Author: Iv=C3=A1n Ezequiel Rodriguez <ivanrwcm25@gmail.com>

Input: evdev: propagate EVIOCSFF copy errors correctly

Return the error from input_ff_effect_from_user() instead of always
mapping failures to -EFAULT, so wrong buffer sizes surface as -EINVAL.

> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c7325226cb866..405d43f840f3e 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -1175,8 +1175,9 @@ static long evdev_do_ioctl(struct file *file, unsig=
ned int cmd,
[ ... ]
>  	case EVIOC_MASK_SIZE(EVIOCSFF):
> -		if (input_ff_effect_from_user(p, size, &effect))
> -			return -EFAULT;
> +		error =3D input_ff_effect_from_user(p, size, &effect);
> +		if (error)
> +			return error;
> =20
>  		error =3D input_ff_upload(dev, &effect, file);

[Severity: High]
This is a pre-existing issue, but can this leak kernel stack memory and
cause a use of uninitialized memory in compat mode?

In evdev_do_ioctl(), struct ff_effect effect is declared on the stack
without initialization. When a 32-bit compat userspace process calls the
EVIOCSFF ioctl, input_ff_effect_from_user() copies 44 bytes into the 48-byte
native struct, leaving 4 bytes uninitialized:

drivers/input/input-compat.c:input_ff_effect_from_user() {
    ...
    if (copy_from_user(compat_effect, buffer,
                       sizeof(struct ff_effect_compat)))
    ...
}

The kernel then copies the full 48-byte struct to the heap in
input_ff_upload():

drivers/input/ff-core.c:input_ff_upload() {
    ...
    ff->effects[id] =3D *effect;
    ...
}

If the input device is a uinput virtual device managed by a 64-bit daemon,
could the UI_BEGIN_FF_UPLOAD ioctl copy the full 48-byte struct to the
daemon, leaking the 4 bytes of uninitialized kernel stack memory?


While reviewing this, I noticed a similar pre-existing issue in the same
function with the EVIOCSABS and EVIOCGABS ioctls.

[Severity: High]
This is a pre-existing issue, but does this code leak kernel stack memory
to userspace?

In evdev_do_ioctl(), struct input_absinfo abs is declared without
initialization. A malicious user can provide a small size in the EVIOCSABS
ioctl command, causing only a partial copy and leaving the rest of the
struct uninitialized:

drivers/input/evdev.c:evdev_do_ioctl() {
    ...
    if (copy_from_user(&abs, p, min_t(size_t, size,
                                      sizeof(struct input_absinfo))))
    ...
}

The uninitialized stack memory is copied into the device's heap allocation:

drivers/input/evdev.c:evdev_do_ioctl() {
    ...
    dev->absinfo[t] =3D abs;
    ...
}

Can this memory subsequently be leaked to userspace when read back via the
EVIOCGABS ioctl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831152156.1665=
14-1-ivanrwcm25@gmail.com?part=3D1
