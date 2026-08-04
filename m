Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A20831F995
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840433; cv=none; b=D1i/5rmxC7F0hIfLc9U98rPy1bra84yR5RF/KnQgIf4guIgcPNdgaAQjQldAG4BFuvnn+xy5Z67s+bDBzw7I1/Mcn+gDCLw3NrafrJDWIOoImIKSdpzyB/C3SE47P+JGezap10jqyr9pYsT+Y+Z3HhyokDekh9/hbpn67wvZ2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840433; c=relaxed/simple;
	bh=Jtevs9RMYlBs4FRFfsEJ+9ipbO0SrpWQAoe9UYvuTkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TLe82zzVh1DZYWGyCAHQ6kEnxDBKCMVjabIQHdIgTrVNiSdcviru8ANQXkvN7qxPRTREUwCPXB1WtyEdV/HPr/umFGna/SxJHpuJqLYs3YHFR16geGhrS7j/6+Vrs74hJG5cdQE2c++SVGgKw/vWgySXqBSRV+4e2FGWkkxzhiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVB2l2fQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVB2l2fQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECE51F000E9;
	Tue,  4 Aug 2026 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840432;
	bh=RWZ8DoO4Vh/aiRixvtnsr7bx6EQc+XxwvzY+Ppem0no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YVB2l2fQEsqjV+XI0QU8/2UTUvYylKQCd1gkwjrgpeVIjZ9jijIEs0rGJSyat43lW
	 r1WGsS15F/z3Gp+eIVOt9mQYBNQuAnLsGARSNM7B89YhttDuouoaK8po6h5/7zpXnX
	 kkEetHjg59FoLbLSm4ifxpd5ElwekEtgCwsa5IAFGRsQ8C0PNcGXc7hI+B7r6iPLcR
	 tAgCiob4MtViDd5VV4GX/BLFfPOod+bPJzY2P2qZyjfG2qjvjzdqk7XiayLps0MHtf
	 L5lt8vHACdY6hJJKB9vFY1HHwBeCGf5d8xv6JQJ1nyHtYS0PK7ENkrNXY5zDJgBz3T
	 QW9oSnQYx+OZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260804103209.1496683-2-lee@kernel.org>
References: <20260804103209.1496683-1-lee@kernel.org>
 <20260804103209.1496683-2-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 10:47:11 +0000
Message-Id: <20260804104711.DECE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to sibling `hid_device` pointers (`shared->touch` =
and `shared->pen`) in `wacom_mode_change_work()` causes a TOCTOU race leadi=
ng to Use-After-Free if a sibling device is disconnected concurrently.
- [High] Race condition between `kref_put()` in `wacom_remove_shared_data()=
` and `kref_get()` in `wacom_get_hdev_data()` leads to Use-After-Free of th=
e shared data structure.
--

--- Patch [2]: [PATCH v7 2/4] HID: wacom: Fix Use-After-Free in wacom_intuo=
s_pad ---
commit 17f29646966a71681ee3c27f7476ff3314a2db05
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_intuos_pad

This commit introduces RCU protection for the touch_input pointer to resolve
a TOCTOU race condition in wacom_intuos_pad(). It also serializes probe
assignments and removal in the shared data struct using wacom_udev_list_loc=
k.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -875,10 +875,16 @@ static void wacom_remove_shared_data(void *res)
>  		data =3D container_of(wacom_wac->shared, struct wacom_hdev_data,
>  				    shared);
> =20
> -		if (wacom_wac->shared->touch =3D=3D wacom->hdev)
> -			wacom_wac->shared->touch =3D NULL;
> -		else if (wacom_wac->shared->pen =3D=3D wacom->hdev)
> -			wacom_wac->shared->pen =3D NULL;
> +		scoped_guard(mutex, &wacom_udev_list_lock) {
> +			if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> +				wacom_wac->shared->touch =3D NULL;
> +				rcu_assign_pointer(wacom_wac->shared->touch_input, NULL);
> +			} else if (wacom_wac->shared->pen =3D=3D wacom->hdev) {
> +				wacom_wac->shared->pen =3D NULL;
> +			}

[Severity: High]
This isn't a bug introduced by this patch, but it looks like shared->pen and
shared->touch can still be accessed locklessly in wacom_mode_change_work().

If the sibling pen device is dynamically unbound via sysfs or unplugged,
this path clears the pointer under the lock, frees the wacom structure,
and drops the hid_device reference.

Could a preempted wacom_mode_change_work() worker thread read the valid
shared->pen pointer before it is cleared, resume after the unbind completes,
and then dereference the freed pointer?

    if (shared->pen) {
        wacom1 =3D hid_get_drvdata(shared->pen);
        wacom_release_resources(wacom1);
        hid_hw_stop(wacom1->hdev);
    }

> +		}
> +
> +		synchronize_rcu();
> =20
>  		kref_put(&data->kref, wacom_release_shared_data);

[Severity: High]
This is a pre-existing issue, but I have a question about this kref_put()
call happening outside of the wacom_udev_list_lock.

If the refcount drops to 0, wacom_release_shared_data() is queued and will
block on acquiring wacom_udev_list_lock to remove the data object from
wacom_udev_list.

Concurrently, if wacom_add_shared_data() is probing on another CPU, it holds
the mutex and calls wacom_get_hdev_data(). That function iterates the list
and calls kref_get() unconditionally on the matching item:

    list_for_each_entry(data, &wacom_udev_list, list) {
        if (hid_compare_device_paths(hdev, data->dev, '/')) {
            kref_get(&data->kref);
            return data;
        }
    }

Does this create a race where wacom_get_hdev_data() can acquire a reference
to a 0-refcount object just before wacom_release_shared_data() removes it
and calls kfree(data), leading to a use-after-free in the concurrent probe?
Should this perhaps use kref_put_mutex() to ensure atomicity?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804103209.1496=
683-1-lee@kernel.org?part=3D2
