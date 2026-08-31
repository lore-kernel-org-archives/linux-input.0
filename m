Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627639A07C
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212140; cv=none; b=k6fFFMTlfuIFeFGimphx3LENbviIrZOsvfWMmwnqTYErGndCVcAYDmd0jZN1cWOpGbvFNSCjolj5821bQsKGKBvZ4ga2BhRH6XFb8SiQ5CRc44szVK//fspLtcxS6z+RgjUYP6v/pCnBY6/jCVpS1m+/aiNYlYZ4nEyYHb2itd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212140; c=relaxed/simple;
	bh=4/HuvuQVLU1uXVurq6zUBacO2juR0bEuAkaNllpeeXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tfn79eGN7vyh+M3ZLbd1Ed8Rq3lc3e7KNPqDfLfc/nlKJILJ+Y7nHXBD0pmhEf3jeaooxwHx23pnAG+VLiQBDdIiuAi9T8apbG77g/fi7D5Iv+/cdRgz6mxlw2gX+z899OCsSeXS9V3ukTNHGD50iM/uvKBq4iZxeGh/FbyDP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5ozvGic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5ozvGic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F0A1F000E9;
	Mon, 31 Aug 2026 21:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212139;
	bh=7oDT3E9TcU2O3HyA2HhOpmK6LVtGhMkNRozl6RcD+lI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5ozvGicjAeLpm1RMrv8N4Xgh7Jli2IUus0o2fuwIDJfzIVzwov8Por3hp6P26sbd
	 FgRXZ2kSD3SFPgfhriwPm7ch9iQXg3gKfokW7dbClGLwC4Czx4W22zOLDJNp38oYH+
	 oemsuzOXtQrQNHp3DM4FJLap09czuInJ4I1NjdzU+9L7s1bpozzp6AiOsYwC4I7sVw
	 deFRPvKLoG0RkrSkg90j7i1s2678+Si/DiWOQAEw67QLK+aMXFk1gomPimGVXs8SoJ
	 SGCRylGN+Mdr2nqXOxsCr9CNS8kd2SLgSzUQwj7YEfL4XgaxVFZIFhtGbBRhHbjv7S
	 hKvUgoMxBdM1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Input: evdev: propagate EVIOCSFF copy errors
 correctly
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXbDoW4gRXplcXVpZWwgUm9kcmlndWV6?= <ivanrwcm25@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260831192752.258550-2-ivanrwcm25@gmail.com>
References: <20260831152156.166514-1-ivanrwcm25@gmail.com>
 <20260831192752.258550-2-ivanrwcm25@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:35:39 +0000
Message-Id: <20260831213539.64F0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but an Informati=
on Leak exists: Uninitialized kernel stack bytes from `struct ff_effect eff=
ect` are leaked to userspace.
--

commit bf36b6bd42a34ab4fa65c08221f5186ae11a4eac
Author: Iv=C3=A1n Ezequiel Rodriguez <ivanrwcm25@gmail.com>

Input: evdev: propagate EVIOCSFF copy errors correctly

This commit updates evdev_do_ioctl() to return the actual error code from
input_ff_effect_from_user(), rather than always returning -EFAULT. This
ensures that incorrect buffer sizes correctly surface as -EINVAL.

> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index c7325226cb866..405d43f840f3e 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -1175,8 +1175,9 @@ static long evdev_do_ioctl(struct file *file, unsig=
ned int cmd,
>  		return str_to_user(dev->uniq, size, p);
> =20
>  	case EVIOC_MASK_SIZE(EVIOCSFF):
> -		if (input_ff_effect_from_user(p, size, &effect))
> -			return -EFAULT;
> +		error =3D input_ff_effect_from_user(p, size, &effect);
> +		if (error)
> +			return error;

[Severity: Critical]
This is a pre-existing issue, but could this leak uninitialized stack
memory to userspace?

In evdev_do_ioctl(), the 48-byte effect structure is declared uninitialized
on the stack:

drivers/input/evdev.c:evdev_do_ioctl() {
    ...
    struct ff_effect effect;
    ...
}

If a 32-bit compat application calls the EVIOCSFF ioctl,
input_ff_effect_from_user() in compat mode copies only 44 bytes from
userspace into this structure:

drivers/input/input-compat.c:input_ff_effect_from_user() {
    ...
		compat_effect =3D (struct ff_effect_compat *)effect;

		if (copy_from_user(compat_effect, buffer,
				   sizeof(struct ff_effect_compat)))
    ...
}

This leaves the trailing 4 bytes of kernel stack memory in the effect
structure uninitialized.

The full 48-byte structure, including the uninitialized stack bytes, is
then copied into driver storage by input_ff_upload():

drivers/input/ff-core.c:input_ff_upload() {
    ...
		ff->effects[id] =3D *effect;
    ...
}

If the device is managed by uinput, a 64-bit userspace daemon handling
the virtual device can read the full 48-byte structure, capturing the
uninitialized kernel stack bytes and leaking them to userspace:

drivers/input/misc/uinput.c:uinput_ioctl_handler() {
    ...
		ff_up.effect =3D *req->u.upload.effect;
    ...
}

Could we initialize struct ff_effect effect to zero in evdev_do_ioctl()
to prevent this information leak?

> =20
>  		error =3D input_ff_upload(dev, &effect, file);
>  		if (error)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831152156.1665=
14-1-ivanrwcm25@gmail.com?part=3D1
