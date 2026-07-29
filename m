Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289A399361
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317951; cv=none; b=IqSFKZa1i/FGgHe/Yul0kzNAkmsFM61yYu9DY+QD1BTOE+4Gt2Heo3XGVwJwF5CGW4bqkOrnQIVIu63xhoEXs1f8jIlwDFYHY1u+XBMIa8Deu9ubGqzkv8YXMpG0UV18r7PRNECC5r/Qm/vnsWaN/wXapGqsRHIIo3tHlyzNyj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317951; c=relaxed/simple;
	bh=NVMCRb7yOaV+ztq9WQ8IBN/yQdRd0CxhOKJE4P0u0Ac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=euKaLMiTn7IT17fNXx+9ZnZO4W8jRqJPgBecXMjvcveOFHoupA7fS0/xhoSQzsfq/ypeLxcRzL+9Pwl8QUXcECkMd9jOv8Xb1uATPuvbGDxZg0EGxYZlPVE1z90OUS2R8Q2nWrCvjFySIy0OKlzqxG5VmzssmpUFuhWQ9QVSgfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+aRy31n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+aRy31n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6624B1F000E9;
	Wed, 29 Jul 2026 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785317949;
	bh=FhgLxxWjjBJ2+ypbIgbQKaobAxPytVWdapzU6x2lQgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M+aRy31ndbZB4ve/KO2IIMXIk1SphKEnD0Devm7p5/MgV/gKsqYIve5hw6Owv7ppM
	 zy2NxycNfIV1z+3UBaP+ttXIZC7SOauM0FMZoCYpXvvTFachnZqQI1eQ5dhsrcx1PO
	 n2FtC4FaXiP9koQS1V971JiYZ5hNpMGyClrf1OarZpw0Flcd6t6z+phfrcR/G2Q7ZD
	 0bLUsTuxm6Xex3E2td0YvpIe3qBdMYnhxMR0CmwwGD91f9joETLudNgsPblKLhzw24
	 ZYaArBXa/8JCk1meesg9eK753FnZx50N8ThAHvz+RCDdKk78I/7t0gbKrY45PFuC0X
	 HdpjIxnF2P3SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: evdev: drain queued events before reporting
 device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: zhangliuyang.zly <zhangliuyang.zly@bytedance.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729092753.1596400-1-zhangliuyang.zly@bytedance.com>
References: <20260729092753.1596400-1-zhangliuyang.zly@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 09:39:08 +0000
Message-Id: <20260729093909.6624B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch breaks zero-length O_NONBLOCK reads by returning 0 inste=
ad of -EAGAIN when the queue is empty, altering userspace ABI.
- [High] A TOCTOU race between lockless queue checks and device death drops=
 synthetic key-up events, defeating the patch's purpose.

Pre-existing issues:
- [High] Uninitialized kernel stack memory is leaked to user-space due to m=
issing padding initialization in `struct input_event` on architectures like=
 SPARC64.
--

--- Patch [1]: [PATCH] Input: evdev: drain queued events before reporting d=
evice removal ---
commit 0c2e6f64ca8c023851919612ec0b8e230776b440
Author: zhangliuyang.zly <zhangliuyang.zly@bytedance.com>
Subject: Input: evdev: drain queued events before reporting device removal

This commit modifies the evdev read path to drain the per-client event queue
before reporting -ENODEV when a device is removed. It aims to prevent dropp=
ing
synthetic key-up events generated during device unregistration.

> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c

[ ... ]

> @@ -565,20 +565,38 @@ static ssize_t evdev_read(struct file *file, char _=
_user *buffer,
>  	if (count !=3D 0 && count < input_event_size())
>  		return -EINVAL;
> =20
> -	for (;;) {
> +	/*
> +	 * count =3D=3D 0 is special - no IO is done but we still check for
> +	 * error conditions, preserving the historical behavior.
> +	 */
> +	if (count =3D=3D 0) {
> +		if (!evdev->exist || client->revoked)
> +			return -ENODEV;
> +
> +		return 0;
> +	}

[Severity: High]
Does this change alter the historical behavior for non-blocking reads?

Previously, if count =3D=3D 0 and the file descriptor was set to O_NONBLOCK=
 with
an empty queue, the code would return -EAGAIN. By moving the count =3D=3D 0=
 check
above the loop and unconditionally returning 0, applications checking for q=
ueue
status using a zero-length read might now incorrectly assume events are
available.

> =20
> +	for (;;) {
> +		/*
> +		 * A revoked client must not consume any more events.
> +		 */
> +		if (client->revoked)
> +			return -ENODEV;
> +
> +		/*
> +		 * The input core may queue synthetic release events during
> +		 * device unregister before evdev_disconnect() marks the evdev
> +		 * node dead. Do not drop those already queued events by
> +		 * returning -ENODEV too early. Drain the client queue first and
> +		 * report -ENODEV only when there is nothing left to read.
> +		 */
> +		if (client->packet_head =3D=3D client->tail) {
> +			if (!evdev->exist)
> +				return -ENODEV;

[Severity: High]
Might this lockless conditional block still drop synthetic key-up events due
to a race condition?

Because these checks are performed locklessly without memory barriers, a th=
read
could evaluate packet_head =3D=3D tail as true. If a context switch occurs =
and the
input core queues synthetic events and subsequently marks evdev->exist as f=
alse,
when this thread resumes it will evaluate !evdev->exist as true.

This would result in returning -ENODEV and missing the newly queued synthet=
ic
events entirely, defeating the original purpose of the patch.

> +
> +			if (file->f_flags & O_NONBLOCK)
> +				return -EAGAIN;
> +		}
> =20
>  		while (read + input_event_size() <=3D count &&
>  		       evdev_fetch_next_event(client, &event)) {
> =20
> -			/*
> -			 * count =3D=3D 0 is special - no IO is done but we check
> -			 * for error conditions (see above).
> -			 */
> -			if (count =3D=3D 0)
> -				break;
> +			if (input_event_to_user(buffer + read, &event))
> +				return -EFAULT;

[Severity: High]
This is a pre-existing issue, but could this leak uninitialized kernel stack
memory to userspace?

In evdev_pass_values(), the input_event structure is allocated on the stack
but its padding fields (such as the 32-bit padding on SPARC64) are not fully
initialized before being copied into the client buffer.

When evdev_read() fetches these events via evdev_fetch_next_event() and
subsequently copies them to userspace using input_event_to_user():

evdev_pass_values() {
    struct input_event event;
    ...
    event.type =3D v->type;
    ...
    __pass_event(client, &event);
}

The uninitialized padding bytes are copied out here, potentially leaking
sensitive kernel data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729092753.1596=
400-1-zhangliuyang.zly@bytedance.com?part=3D1
