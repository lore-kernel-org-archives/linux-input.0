Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDFD45C6E0
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151184; cv=none; b=k0KugWS62Uu/TlUCYEVrZT+Sa+yEAUAuAWf4nuF4rlpbf3jGIVVbt/9e+Xo3MbyZuTNuWzf1Sjc3ZsdbE6Q09mmK9lkXXFuOXkmDrMN3x+VPlSjbr1vi7c1mWdbAk4X+HPG2RU12nUTa23Q2XUpbojO5AZ/2n4ZSkE8P9UKMEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151184; c=relaxed/simple;
	bh=rhluozYKxXw6NI522eYfhI8raVCMBIXHo/2VaDzyZz4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BYomEGsgyZPnOuBNIY22O0KEDiJAkpnT37k9MLQR9iheo7mSvfDqEnjFBIVMKR5Lb7AhNvxJYMTk9KNZkXoBxOlzkoRyxuUbfE5Y9MIWWF2PcbY3wWa0KaBUArYeitKLUOFZkl0lvZUkYbgFNAoIhCceuSLMTbuOx0TZE0xSK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swvv4yj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swvv4yj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0BE1F000C4;
	Fri, 16 Oct 2026 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792151182;
	bh=MP1mIlP9BB37zIUXPx3KdDyBue3JKDhNBt4FzOBnUpA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Swvv4yj18zt9dV7FqkYeFRW6Nft+/LjbhFk/VEo21vSTxwWVs1XscGX1S8qeuWK9s
	 oLiaQB0poPkSRyx+gC+wKAcV92oMRwtcQPI5NHP9Y8EZm/uR2ePZxDPFx0t505TfIF
	 tSwQCskLzS2QdPbqZ8beY4pNbo0YuFtE94jYEJbiN9PhglvlROkNkxNMbEIb03nWos
	 V0RJeTQeB7WLYgpCYnTzWvFV/oLKUe/tBJwZxVxVc5AXkN2IvhUXOCmRyepke4ShrE
	 NI49bYBlZek+HmvVewY7b1CnABLb1tfsSHW8IFSg7B+mGuhJQ+JUh3dqGmwwHMdN/Q
	 eMUusTXtFyz0A==
Message-ID: <sashiko-outbox-174249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] HID: roccat: use kref to manage device instances
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016113321.892452-3-dmantipov@yandex.ru>
References: <atECwbWrAQFpbELS@beelink>
 <20261016113321.892452-1-dmantipov@yandex.ru>
 <20261016113321.892452-3-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 11:46:21 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: roccat: UAF in roccat_device_available() during disconnect
--

commit bc24653b7f3a809f26552e2e26b0e0b92e805ecd
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: use kref to manage device instances

Use kref to manage 'struct roccat_device' instances and fix both memory
leaks and UaF-triggering races between roccat_open()/roccat_release()
and roccat_connect()/roccat_disconnect() pairs. To avoid the scenario
when opened device is disconnected and its slot indexed by minor number
is reused by another device, release the slot in roccat_free_device()
rather than in roccat_disconnect(). This way, there is a time frame when
disconnected device may still occupy the slot; to reject such a device,
add extra roccat_device_available() checks to roccat_open() and
roccat_ioctl(). Add extra WARN_ON() device check to roccat_disconnect()
and a few debugging quirks to roccat_free_device() as well.

Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yand=
ex.ru?part=3D2

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 92a9b9f14f591..581dedde6d66e 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -370,23 +380,25 @@ EXPORT_SYMBOL_GPL(roccat_connect);
>  void roccat_disconnect(int minor)
>  {
>  	struct roccat_device *device;
> -	struct device *dev;
> =20
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> +	if (WARN_ON(!device))
> +		goto out;
> =20
> -	dev =3D xchg(&device->dev, NULL);
> -	device_destroy(dev->class, MKDEV(roccat_major, minor));
> +	if (!WARN_ON(!roccat_device_available(device))) {
> +		struct device *dev =3D xchg(&device->dev, NULL);
> =20
> -	devices[minor] =3D NULL;
> +		device_destroy(dev->class, MKDEV(roccat_major, minor));
> +	}
> =20
>  	if (device->open) {
>  		hid_hw_close(device->hid);
>  		wake_up_interruptible(&device->wait);
> -	} else {
> -		roccat_free_device(device);
>  	}
> =20
> +	kref_put(&device->ref, roccat_free_device);
> +out:
>  	mutex_unlock(&devices_lock);
>  }

[Severity: High]
Can this concurrent disconnect path trigger a use-after-free in readers?

If CPU1 calls roccat_poll() or roccat_read(), they invoke
roccat_device_available() without holding devices_lock. That helper loads t=
he
pointer locklessly:

drivers/hid/hid-roccat.c:roccat_device_available() {
	struct device *dev =3D smp_load_acquire(&device->dev);

	return dev ? device_is_registered(dev) : false;
}

If CPU1 is preempted right after smp_load_acquire(), and CPU2 runs
roccat_disconnect(), CPU2 will exchange device->dev to NULL and call
device_destroy(). This drops the final reference and frees the device memor=
y.

When CPU1 resumes, it will pass the now-freed dev pointer to
device_is_registered(), causing a use-after-free when accessing
dev->kobj.state_in_sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016113321.8924=
52-1-dmantipov@yandex.ru?part=3D2
