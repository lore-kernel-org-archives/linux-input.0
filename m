Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309F49B46B
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574229; cv=none; b=s+tTBdY3iM9L0oicg0ywu8nWDp50putGpQqdsppeEfVVbtYoFksXbIdpR9Np5fiTTLRETlm2Mk4w5noeFYsQkEjqV92kiKsd7EXZkUxzzjIIvxagyQxoWZOZUFeEwf9pRm+8H2a4imq/A+aqfNzNZFNmyFXeXg7385UKtcNEhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574229; c=relaxed/simple;
	bh=jBBzlJJz9zMUii9LNX9EMwupKP+TMMNHx/nq9CfUlGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQIjcVt8MF+12/aNUCkyLelCJQEp7WRdtsStOMVhgl7OJIMPlo3rLkhSCKpS69tKRcEMSKPoMma+upgWKvyD9O9ZaQXwdYKNXuJQIgmc835aO1o5V4yoGvff4/QSgWF8zb9VtVLuT4xuPeT8Y4mYUMYIy69Y5iAkGRV+WizvIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB0mWP4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB0mWP4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC61B1F000FF;
	Wed, 16 Sep 2026 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574207;
	bh=i+8U0eqJI1YLWfOsVXvx3JaCsLSYzrHFSL3t1tJk6qQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OB0mWP4EbZjMG8ujAW+g0tcpnuVhUkV6KmLDFURTzuSLoQU2mRMWA/ARgiofVUh1v
	 Z2Jl1cosaOzvfw6b/QZfYdzsMjwaiAroIKE6jLfIeq67tZAUWK2hEcEnFT27HEtOTD
	 EQZwDnrJmoKs58d16O6SmRSUd+g2ZxNx/OaVWeHT8t0IlXxo6SIOI7QiZvPJnUIXyg
	 je02fkUXFMhUf0HBFIL73tEuyM4Pil42eIl5UnBFjR6Wgu5emidZN6lo/ZDUaMTHiV
	 3UQuA87HhVa7xsI1tqMHBeHES3WfADsutPitnQWwB+sKtHx5ePrmA0PSPV9XrXJ1Nf
	 n259JVYWppRIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] HID: roccat: use device_is_registered() to check
 whether device is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260916154733.78464-2-dmantipov@yandex.ru>
References: <20260916154733.78464-1-dmantipov@yandex.ru>
 <20260916154733.78464-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 15:56:46 +0000
Message-Id: <20260916155646.EC61B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: roccat: use-after-free of device->dev in roccat_device_availa=
ble()
--

commit 10e7416f7d2b9142317f413c7988155b077d1914
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: use device_is_registered() to check whether device is available

This commit introduces roccat_device_available() to check if the device
is registered rather than relying on a boolean exist flag. It replaces
the flag checks in the read, poll, and release paths with the new helper.

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 5deb6da8d4f74..96aa508111a1b 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -70,6 +69,13 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICE=
S];
>  /* protects modifications of devices array */
>  static DEFINE_MUTEX(devices_lock);
> =20
> +static bool roccat_device_available(struct roccat_device *device)
> +{
> +	struct device *dev =3D READ_ONCE(device->dev);
> +
> +	return dev ? device_is_registered(dev) : false;

[Severity: High]
Does this lockless check risk a use-after-free of the dev pointer in
drivers/hid/hid-roccat.c?

If a userspace process calls roccat_read() or roccat_poll() on the character
device while the physical device is simultaneously unplugged,
roccat_disconnect() can run concurrently. Since roccat_disconnect() unregis=
ters
and drops the reference to the device, dev could be freed after the
READ_ONCE() but before device_is_registered() accesses
dev->kobj.state_in_sysfs.

> +}
> +
[ ... ]
> @@ -369,10 +374,8 @@ void roccat_disconnect(int minor)
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> =20
> -	device->exist =3D 0; /* TODO exist maybe not needed */
> -
>  	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> -
> +	WRITE_ONCE(device->dev, NULL);

[Severity: High]
Could this synchronously free the struct device while concurrent readers
still hold the raw pointer in roccat_disconnect() in drivers/hid/hid-roccat=
.c?

device_destroy() synchronously unregisters and drops the final reference to
the struct device, freeing it. Because roccat_device_available() doesn't
hold a reference or lock when checking device_is_registered(), this opens a
time-of-check to time-of-use (TOCTOU) race window.

>  	devices[minor] =3D NULL;
> =20
>  	if (device->open) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916154733.7846=
4-1-dmantipov@yandex.ru?part=3D2
