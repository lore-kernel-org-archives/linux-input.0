Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34774734D9
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546662; cv=none; b=M3Fwg31sQReyIeyzAwPMFeCF8hGVPiwwwE8pKV75epMRbqAH0PFEcdDYUnrzfr/O8/zA0ZOEp3fKMsomM+itvhqf41lkjFbYGtTqCH72QAtXqSEDpjq964ise4HhMr15Lb2tLU0caCEZf0ljXM9AsPu5YQ8sqaBr7cdVGmpC8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546662; c=relaxed/simple;
	bh=85db4dDlY1p8sHYV/QtJuU6jP5zGEtyTOu0/NsF6BNU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RTNRGQzouVKhtKZ9XqiG0FhTjxK414nfiH6UsnvMqBJLneMtwwrUC5vKgEdH+n2xGHTt3D3mIA3rgeoKTjnkyHwGBdNCofD2huwdxLphZc65gUIfkZoo7h7DAJks/7E0vzucYlJ3xGYSEm3H4YwMZVJd9mmtqfpZzNeH9o1YLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDbjqU7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDbjqU7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B411F000FF;
	Wed, 16 Sep 2026 08:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546651;
	bh=q791n5tUj4BepXAnq6cygA0YiWGQQoPG4eY5CIwLdrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDbjqU7vKQGE8Nrn31jk/3Omd9ueKOvkaCOHP2h1gL314lOV9mNx+iza1QGiPLCqM
	 6KAOpWCcLDrvCngVZWm2PGhgkdC5pEJ1o2I9wIHSGDino3vxo0zZwAg6lWhKqU+urC
	 TptX9HrSzG8Zl3mf0+D3oP8e/ML9NuY0cyq9eLYfL0x1gpuHyyMqvH80Uqf/zNRwXP
	 pMXl/OYtFGW/c32ZV3+cmvXUc0abh/9KMteLZj7HH6BrK+LzrXuG8fgmGxh3m6QIXI
	 O0C10pjCzUn7zK7Tz6Y/QUpEP9/I8nBU+RjMG4K7SfAoJW4nRdhpiIMKXzOq66jEnP
	 8UI31AeJilipA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] HID: roccat: use kref to manage device instances
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260916080013.56388-4-dmantipov@yandex.ru>
References: <20260916080013.56388-1-dmantipov@yandex.ru>
 <20260916080013.56388-4-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:17:30 +0000
Message-Id: <20260916081731.27B411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: roccat: UaF in roccat_device_available() due to unlocked devi=
ce->dev access
--

commit 8a69ab520bd366b55b30a21617d1af38b7f66c41
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: use kref to manage device instances

This commit introduces a kref-based lifecycle for roccat_device instances
to resolve memory leaks and use-after-free issues between open/release
and connect/disconnect pairs. The device slot is now released in
roccat_free_device() instead of roccat_disconnect().

Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yand=
ex.ru?part=3D2

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 1e1a76c453bd2..bdf8857509294 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -366,18 +376,20 @@ void roccat_disconnect(int minor)
> =20
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> +	if (WARN_ON(!device))
> +		goto out;
> =20
> -	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> -	device->dev =3D NULL;
> -	devices[minor] =3D NULL;
> +	if (!WARN_ON(!roccat_device_available(device))) {
> +		device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> +		device->dev =3D NULL;
> +	}

[Severity: High]
Can an unlocked reader racing with this code trigger a use-after-free?

If a userspace process calls roccat_read() or roccat_poll() on the device
node concurrently with roccat_disconnect(), they will invoke
roccat_device_available().

Since those read and poll paths are unlocked, a thread could see
device->dev as non-NULL in roccat_device_available():

drivers/hid/hid-roccat.c:roccat_device_available() {
    return device->dev ? device_is_registered(device->dev) : false;
}

If it is preempted right after the ternary check but before calling
device_is_registered(), and this roccat_disconnect() code then runs,
destroying device->dev and setting it to NULL, the reader thread will
resume and dereference the freed pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916080013.5638=
8-1-dmantipov@yandex.ru?part=3D4
