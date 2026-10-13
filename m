Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3032C8B
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 05:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869320; cv=none; b=gR0sAWZNviSjLJEIsGlDdekcosULW+XqwbVyHLeNjQv9cRNFXol+jccFjIH8IY5naTMJU/FwP7xWzdw+8Fw6ziIJLw5V18G42oCVE+mdweXFRm66kZtAHlDiMIV/hTtfsBlnd0T01nsOnawga98hIDfkNTKvuQI5qaTLe18N/pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869320; c=relaxed/simple;
	bh=M22S7mWiw2I1y/JYB1d5dvUVe0smmUjxk2FG2PRCp7I=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u7998OBd6hYZ1QxCoPI2JkEcDACgxRo6GhThzqQR4Ia2Gpmg0YltiGPMwmjZm1bl+kP7pt4xn6DtRY36UogVEQDd1+CufrVaP0jluT3MBuLBPNjnhubR9laVSWZbfVKK0lkCaDerJCli/eE7mJDAt+BpB0snc19sC9w0dgF+IRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz6+hFCy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz6+hFCy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF621F000FF;
	Tue, 13 Oct 2026 05:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791869318;
	bh=Z4+voNCxDV8J5ySMZXKoEBhzq+VwYv+PF4XWyXw8jqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qz6+hFCyURoTMcALIJGmitxI5GQa6hFD+Y5kQSyvG7oKjsAoQzkFt3iyglS0exhBb
	 OrkJ7qlQdSn7VeVYethMbLh7SEduW6v2X5Bd/Jev8GBFb0pb0o0eUkOiut9RKQaF9A
	 /jW8e93cBT6DOyznew6bAgZRtO3b1VpIsAII43VPndLNS7F5NLa7LsKlNUoZ1340E7
	 eWxE+XtyHk5C2Iy9eHLqo00ZeGn61XQ8uBacwecj6v1C9wtL9MOkgOTe7cJsvPy399
	 jD3fR34aeOT4RAlSNgoNA84dtmJLrtZBg470iARobWHBox4ZVnyjRdm3Nfzyiw4g8x
	 /9N/pHRJU9xxw==
Message-ID: <sashiko-outbox-168999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: uinput - fix use-after-free of FF requests in
 ioctl handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQp?= <cenzhang@linux.microsoft.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261013051553.71887-1-cenzhang@linux.microsoft.com>
References: <20261013051553.71887-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 05:28:37 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] input: uinput: data race on request->retval in submitter
--

commit 8d5b9600ec78cd8cecd500a481ecb1dea1d928da
Author: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>

Input: uinput - fix use-after-free of FF requests in ioctl handlers

This commit fixes a use-after-free issue in uinput ioctl handlers by holding
requests_lock during request lookup and usage. It introduces helper functio=
ns
such as uinput_ff_request_end() to safely encapsulate the request completion
logic under the spinlock.

Link: https://lore.kernel.org/all/20240521113619.2092-1-hdanton@sina.com/

> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index d32fa4b508fc5..1a294f4e941b8 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c

[ ... ]

> +static int uinput_ff_request_end(struct uinput_device *udev,
> +				 unsigned int id, unsigned int code, int retval)
> +{
> +	struct uinput_request *req;
> +
> +	guard(spinlock)(&udev->requests_lock);
> +
> +	req =3D uinput_request_find(udev, id);
> +	if (!req || req->code !=3D code)
> +		return -EINVAL;
> +
> +	if (code =3D=3D UI_FF_UPLOAD && !req->u.upload.effect)
> +		return -EINVAL;
> +
> +	req->retval =3D retval;
> +	complete(&req->done);

[Severity: Low]
Does this code leave a data race on req->retval with the submitter?

Looking at uinput_request_submit(), the submitter reads request->retval
without holding requests_lock:

drivers/input/misc/uinput.c:uinput_request_submit() {
    ...
	if (!wait_for_completion_timeout(&request->done, 30 * HZ)) {
		retval =3D -ETIMEDOUT;
		goto out;
	}

	retval =3D request->retval;
    ...
}

If the completion is triggered by uinput_flush_requests() or if multiple
ioctls race to complete the same request, could the submitter wake up and
read request->retval outside of requests_lock concurrently with this write?

Should this use READ_ONCE()/WRITE_ONCE() or extend the lock to prevent
undefined behavior and KCSAN warnings?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013051553.7188=
7-1-cenzhang@linux.microsoft.com?part=3D1
