Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCB840756D
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893749; cv=none; b=L1vKRGcvSQ1sWldVgzBHxMnMav1207CSCob2J9m2fZ7lh+kUt7o8LatQOA9mscRK8DNxbWwscGiAWcCO5V2xA0/Zf773nV15kRkFpZDVqPcz5MCPZqbpeDshZv/zgl2Wrn46+QStSAMJ9QXbbNtWxFK27hkZjs1+oI09cSJE2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893749; c=relaxed/simple;
	bh=dZPBYcmW5EWskoZMvG7nwr+KyMV8tsiVkX5T3aEYLwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DPsIr36audaZqM2TAwx9CL9427aqq317lJeL49dJ4hqhhymphjdaMXQJZFBO+5x/antNTxfJmudu251wKaGvErrIpjXmm3mj3UahdaEkDRPX/5i60JX1WKjzUCsWM3e6vE2MZLx1/hdK+2rfWGgde+VAxs2KFeF6YAv8av+tSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgbLnXuZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgbLnXuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE4B1F000E9;
	Wed, 27 May 2026 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893747;
	bh=1uFpeM5Fh8xqsUKKaUskCGeAFbzZb3p61cdY48JGvqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QgbLnXuZeA5ei2hKDXcqQEkgpz03wmrbAZPzXOQcKm/k0Wzsyw01WwjsZZ5Gs82Ly
	 9GPZeGlbVJu4nVQkY/63kv5Hnu0CEXl8noAv/RKKrHCn2kZMbLOoyEhyayKX93JaSf
	 mj2O1KdoLcGNh7vxoLY8yynV8ZHbeBHRL4COC64s/02X1iPvWK12Jf2LvioG5iDuim
	 Da20PaN+3YUNFXhckTWc+Vai0e5Hxl+iKVTwgG32Bj6VIqKkuo/zC6xV5EPk2FqHch
	 jhhF4wNWDm05pWy0HZx4JzO/lUZOmdE88fyq9uJjaSz2Aq/plgMhZtcXt8N8e+aj+E
	 K87qckntTNZbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: Fix multiple Use-After-Free issues in
 shared state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260527140731.642783-1-lee@kernel.org>
References: <20260527140731.642783-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:55:46 +0000
Message-Id: <20260527145547.AEE4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to fully resolve the Use-After-Free vulnerability =
for `touch_input` because interrupt handlers access it locklessly, leading =
to a Time-of-Check to Time-of-Use (TOCTOU) race condition.
- [High] A race condition exists between `kref_put()` and concurrent `kref_=
get()` due to missing list-level locking during object removal.
- [High] Unprotected and temporally separated assignments of `shared->touch=
` and `shared->touch_input` during probe allow concurrent `uhid` devices to=
 desynchronize the shared state.
--

commit 007cb667e9154320e49d7d42911e8193520da3fe
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix multiple Use-After-Free issues in shared state

This commit redesigns the wacom_hdev_data structure to store stable static
copies of required attributes instead of a fragile representative pointer.
It explicitly clears the touch_input pointer in wacom_remove_shared_data()
under the wacom_udev_list_lock to address use-after-free vulnerabilities.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b351e3e..9e4819c197c1b 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -871,10 +884,14 @@ static void wacom_remove_shared_data(void *res)
>  		data =3D container_of(wacom_wac->shared, struct wacom_hdev_data,
>  				    shared);
> =20
> -		if (wacom_wac->shared->touch =3D=3D wacom->hdev)
> +		mutex_lock(&wacom_udev_list_lock);
> +		if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
>  			wacom_wac->shared->touch =3D NULL;
> -		else if (wacom_wac->shared->pen =3D=3D wacom->hdev)
> +			wacom_wac->shared->touch_input =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but does clearing this pointer u=
nder
the lock fully prevent use-after-free conditions?

Interrupt handlers read shared->touch_input locklessly (for example, in
wacom_wireless_irq()). An interrupt handler could check that
shared->touch_input is valid, but then get preempted.

Concurrently, wacom_remove_shared_data() clears the pointer here, and the
input device is subsequently unregistered and freed by devres.

When the interrupt handler resumes, could it pass the freed pointer to
input_report_switch(), causing a use-after-free? The lock protects writers,
but it appears readers remain vulnerable to this time-of-check to
time-of-use race.

> +		} else if (wacom_wac->shared->pen =3D=3D wacom->hdev) {
>  			wacom_wac->shared->pen =3D NULL;
> +		}
> +		mutex_unlock(&wacom_udev_list_lock);
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);

[Severity: High]
This is a pre-existing issue, but can this kref_put() race with concurrent
list traversal?

It is called outside of wacom_udev_list_lock. If the reference count drops =
to 0,
another thread probing a sibling device could simultaneously acquire the li=
st
lock in wacom_add_shared_data(), find the logically dead object before it is
removed from the list, and call kref_get().

This would attempt to increment a 0 refcount, returning a pointer to an obj=
ect
that will unconditionally be freed as soon as the first thread acquires the
lock in wacom_release_shared_data(), leading to a use-after-free.

>  		wacom_wac->shared =3D NULL;

[ ... ]

> @@ -899,8 +916,13 @@ static int wacom_add_shared_data(struct hid_device *=
hdev)
>  		}
> =20
>  		kref_init(&data->kref);
> -		data->dev =3D hdev;
> +		strscpy(data->phys, hdev->phys, sizeof(data->phys));
> +		data->vendor =3D hdev->vendor;
> +		data->product =3D hdev->product;
> +		data->device_type =3D wacom_wac->features.device_type;
>  		list_add_tail(&data->list, &wacom_udev_list);
> +	} else {
> +		data->device_type |=3D wacom_wac->features.device_type;
>  	}
> =20
>  	mutex_unlock(&wacom_udev_list_lock);

[Severity: High]
This is a pre-existing issue, but do the assignments to shared->touch and
shared->touch_input that follow this unlock need protection?

They are performed sequentially outside of any lock during device probe:

	if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
		wacom_wac->shared->touch =3D hdev;

If two virtual devices with the same physical path are created concurrently
(for example, via uhid), they will share the same wacom_hdev_data structure.

Could a race in the probe sequence result in shared->touch pointing to
device B, while shared->touch_input points to device A?

If device A is then disconnected, wacom_remove_shared_data() would see
shared->touch =3D=3D wacom->hdev as false and skip clearing shared->touch_i=
nput.
Device A's input device would be freed, leaving a dangling pointer that cou=
ld
be dereferenced by sibling devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527140731.6427=
83-1-lee@kernel.org?part=3D1
