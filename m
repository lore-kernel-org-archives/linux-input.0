Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7980D381B1C
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145150; cv=none; b=r1VVSNVFhS8Lw09JXVZyyeH75hvp1dQXfUXLCyt/OwjESEiQQX5k1gnCtQeB1e3cMOW3NaCqR7ppDhkD/9WUL0W8MK9mZ+G5ytQEsSsi5LlxMSflowIoOcOG2JbmKL+/pLW7O9GB0TLlFanv69NDvkrs1jxyzfeQb5uig9B7DUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145150; c=relaxed/simple;
	bh=Ou3a+tGWAfOnMPA7aQA18zUs56MajY6hVo7MTmDPU4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZGwqHPvm3zKfoLqfCMUTw+upE8kkzazGWADeWt4PALlF7Te4mXnwgo3V1nTnTxHcUhPzp4DVmM40U6enL6+ppKSdwE4WQDPyk87lsUPOMPxPv5cVeS9VE2iVaWq16/xohYpbWgbgWMMfmITm3TWiP0DASsp3cOS6eOq9XaUdW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ssr3pbnp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ssr3pbnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915641F000E9;
	Sat,  4 Jul 2026 06:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145147;
	bh=XXkNm+N9VZ2JsaQ9aZyqbpw7tJJqVXKnEYJ22f7Id4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ssr3pbnprQDJn0Y9rEU7c/yuX9OPePiIso0Pmr0GdI1yN6+CoC5XiKMXHVCg5iBxO
	 6BOj5cRZ1HyVjTku+1wJgH6bM2hodhms+gu3S0S2YKR1cNZhoHCyB/KkggjRtkPBjA
	 u7UMdEnuVeRdbaZ5PfV50x9/jtXZHJo8EeyF3Khttlv2qGfRjkrVZQfboscA/bepeb
	 +07LXcZenxkaq5DU+Q1OZbcnKN5K7pghQg8EhjUHS3rX9p0RGp52SbhbwcoELaxoa0
	 bKlItEJSTNo4a8XNm2qt6s2tcAcbzpEduiDKO2cZBR6RyhXgOm/uNU7hF5uUnPcOCR
	 lm1hBTxinbJMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/26] sh: maple: include linux/device.h in
 linux/maple.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260703-b4-maple-cleanup-v1-1-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
 <20260703-b4-maple-cleanup-v1-1-41e424964da5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:05:47 +0000
Message-Id: <20260704060547.915641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in `vmu_queryblocks` frees the `priv` field of prev=
iously registered MTD partitions without unregistering them, leaving dangli=
ng MTD devices that crash the kernel if accessed.
- [High] `vmu_disconnect` assumes all partitions have a fully initialized `=
priv` structure and unconditionally dereferences it, which causes a NULL po=
inter dereference if initialization failed or was incomplete.
- [High] `vmu_disconnect` fails to free multiple dynamically allocated stru=
ctures, causing a severe memory leak on device removal.
- [High] `vmu_flash_read_char` truncates negative error codes into an `unsi=
gned char`, causing the caller to silently misinterpret errors as valid dat=
a.
--

commit 3694a7f48be1fa76db703e9eae953d9ee9757f9f
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

sh: maple: include linux/device.h in linux/maple.h

This commit includes linux/device.h in linux/maple.h to ensure full
definitions of struct device and struct device_driver are available.
This fixes a compilation error in drivers/mtd/maps/vmu-flash.c.

> diff --git a/include/linux/maple.h b/include/linux/maple.h
> index 3be4e567473c8..22f2930251edc 100644
> --- a/include/linux/maple.h
> +++ b/include/linux/maple.h
[ ... ]

While this patch fixes the build, looking at drivers/mtd/maps/vmu-flash.c
revealed a few pre-existing issues:

drivers/mtd/maps/vmu-flash.c:vmu_flash_read_char() {
...
	unsigned char *buf, ret;
...
	error =3D maple_vmu_read_block(vblock->num, buf, mtd);
	if (error) {
		ret =3D error;
		*retval =3D 2;
		goto out_vblock;
	}
...
	return ret;
}

[Severity: High]
This is a pre-existing issue, but does assigning a negative error code
like -ENOMEM or -EIO to the unsigned char ret truncate it? This could
cause the caller to misinterpret errors as valid data instead of properly
propagating the negative error code back to the MTD subsystem.

drivers/mtd/maps/vmu-flash.c:vmu_queryblocks() {
...
	error =3D mtd_device_register(mtd_cur, NULL, 0);
	if (error)
		goto fail_mtd_register;
...
fail_mpart:
	for (error =3D 0; error <=3D card->partition; error++) {
		kfree(((card->mtd)[error]).priv);
		((card->mtd)[error]).priv =3D NULL;
	}
...
}

[Severity: High]
This isn't a bug introduced by this patch, but could this cleanup loop
fail to unregister the previously successfully registered MTD devices?
If a recursive call fails, freeing the priv field without calling
mtd_device_unregister() might leave dangling MTD devices that could
crash the kernel if accessed later.

drivers/mtd/maps/vmu-flash.c:vmu_disconnect() {
...
	for (x =3D 0; x < card->partitions; x++) {
		mpart =3D ((card->mtd)[x]).priv;
		mpart->mdev =3D NULL;
		mtd_device_unregister(&((card->mtd)[x]));
		kfree(((card->parts)[x]).name);
	}
...
}

[Severity: High]
This is a pre-existing issue, but does this assume all partitions have a
fully initialized priv structure? If the device is disconnected before
vmu_queryblocks() finishes initialization or if initialization fails,
can mpart be NULL here, leading to a NULL pointer dereference when
assigning mpart->mdev =3D NULL?

[Severity: High]
This is also a pre-existing issue, but does this disconnect routine leak
resources? It appears to omit freeing the mpart, pcache, and pcache->buffer
resources that were allocated during initialization.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-b4-maple-c=
leanup-v1-0-41e424964da5@gmail.com?part=3D1
