Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A46C30D3F6
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343456; cv=none; b=csTsQWAK6UgYkv3NrQEREUX8turSVFMhJq7lk/THEQUfZq+IAEYBtJJ+M+C2QRy7O4E+L6BmD/GTpZWLjtbzj5Wi0gPVTJqKB7DkY9ukIA1Gn868JhfNVqJQuIJTE0HPnuL/rkdW7ASV6k0A/dugn8FRHrqN2ACiU9OVxNqYlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343456; c=relaxed/simple;
	bh=U+6OSj4fGbiMRa7IW1c5O+xqIcEENWStUWTz7QTHVMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MPKbYt4Ua2MpBO9NuDo1pv3i9xiXRGuz1IKNeUPoS2yjncQhE319LcO8tcuDmMjWLWubR2BIO+X/uw5eM5rLbExHZHGIpLuxGJz0CPFtQZTz67cqQO0cunF+hweqLSCkYthg1nnsgVTXmDuWFfkyzdfksyrGddYPVnn8X80vqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvq+4vvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvq+4vvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F4F1F000E9;
	Wed,  2 Sep 2026 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788343454;
	bh=qvmNFCh7D/DhKvC52cHWFKNg4s88Cb0fdq41H8c4cB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cvq+4vvrbBsMHeOCcFSUx/SJCq3u6eASTUHugtsEdsGKiMO2vEXgmntOOl0/cXxs/
	 03vY346V9a21UxCl39lQMf5fSLudYNAEBly1EhuCze3s/8YtiuHrYI3tgSkEbT+7lg
	 D1ZvQAirSQPQkpd0Hhd/B45viGFnCAQMA7ZuZj1/uoBj9SRznTcMbcV4x7WORwIk39
	 QtKOQYb3+4djAIFkKhb5rs4tXPhp0A2IEdL67h3vUDG5JCkmdFbo4LyviVU2l/QS4i
	 VPuuv1K9DEHV5HmjkTIPgubTmdT0OUQHG+QlxsdvbdQRtVUhkxTAH/pT2X6QDRKCga
	 uSnbf5NSy7UoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: roccat: use kref to manage device instances
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260902094551.200587-2-dmantipov@yandex.ru>
References: <20260902094551.200587-1-dmantipov@yandex.ru>
 <20260902094551.200587-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:04:13 +0000
Message-Id: <20260902100414.54F4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Removal of the unconditional `devices[minor] =3D NULL` in `roc=
cat_disconnect()` leaves a dangling pointer in the global array, allowing r=
acing `open()` calls to access a freed `hid_device`.
- [High] Mismatched kref accounting permanently leaks `struct roccat_device=
` references on every open cycle.

Pre-existing issues:
- [Critical] Pre-existing logic flaw: `roccat_release()` incorrectly looks =
up the device via the global `devices` array instead of using `file->privat=
e_data`.
--

commit 215425e9faf722882019fabfa914bec7f0229c93
Author: Dmitry Antipov <dmantipov@yandex.ru>

    HID: roccat: use kref to manage device instances

This patch introduces a kref to manage the lifecycle of roccat_device
instances. It replaces custom lifecycle tracking in an attempt to resolve
Use-After-Free conditions between open/release and connect/disconnect.

Link: https://syzkaller.appspot.com/bug?extid=3Dd632e93ffcd1452bc61e

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 5deb6da8d4f74..264977e8e3010 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c

[ ... ]

> @@ -193,6 +196,7 @@ static int roccat_open(struct inode *inode, struct fi=
le *file)
>  		}
>  	}
> =20
> +	kref_get(&device->ref);

[Severity: High]
Does this unconditionally acquire a reference for every open file descriptor
without a corresponding unconditional release?

In roccat_connect(), the kref is initialized to 1. Here in roccat_open(), a
reference is added for every reader.

However, roccat_release() only drops a reference if it is the last reader a=
nd
the device is already disconnected. Any open/close cycle while the device is
still connected will leak a reference.

[ ... ]

> @@ -235,7 +239,8 @@ static int roccat_release(struct inode *inode, struct=
 file *file)
>  			hid_hw_power(device->hid, PM_HINT_NORMAL);
>  			hid_hw_close(device->hid);
>  		} else {
> -			roccat_free_device(device);
> +			if (kref_put(&device->ref, roccat_free_device))
> +				devices[minor] =3D NULL;
>  		}
>  	}

[Severity: Critical]
This is a pre-existing issue, but does roccat_release() look up the device
incorrectly?

roccat_release() retrieves the device from the global array:

    device =3D devices[minor];

If the original device was disconnected and a new device connected in the s=
ame
minor slot, this lookup grabs the new device instead of the one associated
with the closing file descriptor via reader->device. This can corrupt the
readers list and incorrectly alter the open count of the new device.

[Severity: High]
Additionally, since kref_put() is only called in the else branch (when it is
the last reader and the device no longer exists), won't this leak references
for all standard open/close operations when the device is still connected?

[ ... ]

> @@ -367,21 +373,22 @@ void roccat_disconnect(int minor)
>  	struct roccat_device *device;
> =20
>  	mutex_lock(&devices_lock);
> +
>  	device =3D devices[minor];
> +	if (!device)
> +		goto out;
> =20
>  	device->exist =3D 0; /* TODO exist maybe not needed */
> -
>  	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> =20
> -	devices[minor] =3D NULL;
> -

[Severity: Critical]
Can removing this unconditional clearance leave a dangling pointer in the
global devices array?

If the device is disconnected while held open, the open count is > 0, so the
kref_put() below is bypassed. This means devices[minor] is not cleared to
NULL.

After disconnect, the HID subsystem will eventually free the underlying
device->hid. If a user subsequently closes their file descriptor, the
device->open count reaches 0. Due to the kref leaks, the device structure is
still not freed.

If a new roccat_open() call occurs, it will find the stale pointer in
devices[minor]. Because device->open is now 0, it will execute:

    error =3D hid_hw_power(device->hid, PM_HINT_FULLON);

Can this cause a use-after-free on the hid_device pointer?

>  	if (device->open) {
>  		hid_hw_close(device->hid);
>  		wake_up_interruptible(&device->wait);
>  	} else {
> -		roccat_free_device(device);
> +		if (kref_put(&device->ref, roccat_free_device))
> +			devices[minor] =3D NULL;
>  	}

[Severity: High]
Does this also fail to drop the initial connection reference if the device =
is
disconnected while open?

Because the kref_put() is only in the else branch, a device that is unplugg=
ed
while open will never drop its initial reference from roccat_connect(),
causing it to permanently leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902094551.2005=
87-1-dmantipov@yandex.ru?part=3D2
