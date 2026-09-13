Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042722541C
	for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789285523; cv=none; b=hXAj3soEQfcXJd+drK2tJ1nwKuEL2CgWUaJpIbtbGbSoafs9QhUQ7LawLLpBtC1dYB736dxHPwrmoQEvGtWfx5FoEsuHnpRbpwpPxUayPy2dmm8mtMMvZ3WpPN0AtMyqgbUoygTKO6PMs9VLLyy6RoZLpNMlVKfbGLDW+QnvUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789285523; c=relaxed/simple;
	bh=GwhdkT+GZAQtUukyCCRdVlLlHIsBZ8UX6Hks6cve7a4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kg3qCilh14rLFpJEe4OI7zDnqVxPi9j3uk8dtTTXDY56Wadvot/iQqRUguDRfF2wJWcdKTp9E/ZXI0Ss5nU+jUJ5kqKmj+f+25v1oKDMe4Dx3k4VlA4MpwQK/uOV2aJG4hnhh3s6OUjChkpjcD6ddLk5Q5IA9cO81sV5gAqAQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTaX5mu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTaX5mu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1581F000FF;
	Sun, 13 Sep 2026 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789285521;
	bh=h5tbdVUQOmeJGwMLAmJihPa1dymNg354vFiD3txQ5qQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTaX5mu/NVm7dWwDttTRkv/K6K8B4qJ9TaTIn/z38ezaQOI9YVsJpALkaVwPzpSpf
	 Y0v/3r8alFH9O3ulzd3+pG7AYcBi5D4jqgWCxml0w9YGKdz555aoXXKer3Ey21W61J
	 ClBYSOuiWYeoLlryvAaxBU6y3d0eEkd9Sj/DYErFiEfZoJzXQTG4oTL/7M8nggi4t5
	 CI2OhyZuCnvXmfxxARLX7R/DadA/o4X/8i0CD1GEz8gfPPvnR5EeY8iiaHjdq3Qf6P
	 HxgVrc0shwo4X+cO2dR/15eCJnaSWpIH8Kc/4LD1K0yxeGIJ6KVoYHuMDDpS3FNAJ8
	 aFlxKE+CnBMHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: sensor-hub: Fail unfinished multi-value reads
 on removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yibo Tan" <lhfff@tju.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260913072910.1944300-1-lhfff@tju.edu.cn>
References: <20260913045411.5e2f5b25@jic23-hlaptop>
 <20260913072910.1944300-1-lhfff@tju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 07:45:20 +0000
Message-Id: <20260913074521.5E1581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless update of hsdev->pending.status upon timeout leads to sta=
ck Use-After-Free, memory leaks, and memory corruption.
--

commit a0af07f0a44e5b5c9aefab2afc1fc904fb7bc800
Author: Yibo Tan <lhfff@tju.edu.cn>

    HID: sensor-hub: Fail unfinished multi-value reads on removal
   =20
    sensor_hub_remove() completes pending reads after stopping the HID devi=
ce,
    but does not record why they completed.  A successful completion wait
    therefore returns zero even if no complete input report was received.
    Multi-value IIO callers then format their untouched automatic buffer as=
 a
    successful result.

Link: https://github.com/kimaiden1984-boop/linux-kernel-poc-collections/tre=
e/main/cases/hid-sensor-quaternion-root-b-kaslr [1]

> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 6470a290ebfc5..a9bd72218c070 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -334,6 +334,8 @@ int sensor_hub_input_attr_read_values(struct hid_sens=
or_hub_device *hsdev,
>  			ret =3D -ETIMEDOUT;
>  		else if (cycles < 0)
>  			ret =3D cycles;
> +		else if (hsdev->pending.shutdown)
> +			ret =3D -ENODEV;
> =20
>  		hsdev->pending.status =3D false;

[Severity: High]
This is a pre-existing issue, but does clearing hsdev->pending.status here
without acquiring data->lock create a race condition with the interrupt
handler?

If a read request times out, this function locklessly assigns status to fal=
se
and returns, freeing the caller's stack frame.=20

Can the interrupt handler in sensor_hub_raw_event() then concurrently read
status as true and call memcpy() into the now-popped stack frame?

drivers/hid/hid-sensor-hub.c:sensor_hub_raw_event() {
	...
	memcpy(hsdev->pending.raw_data + hsdev->pending.index,
	       ptr, copy_size);
	...
}

Would a similar race occur in sensor_hub_input_attr_get_raw_value(), where
the interrupt handler might allocate memory via kmemdup() after the waiter
has already exited, permanently leaking the memory?

>  	}
> @@ -805,8 +807,10 @@ static int sensor_hub_finalize_pending_fn(struct dev=
ice *dev, void *data)
>  {
>  	struct hid_sensor_hub_device *hsdev =3D dev->platform_data;
> =20
> -	if (hsdev->pending.status)
> +	if (hsdev->pending.status) {
> +		hsdev->pending.shutdown =3D true;
>  		complete(&hsdev->pending.ready);
> +	}
> =20
>  	return 0;
>  }

[Severity: High]
This is also a pre-existing issue, but can this read a stale status due to
the lockless update on the timeout path?

If a timeout just occurred and the previous reader locklessly set status to
false, could sensor_hub_finalize_pending_fn() still observe status as true
during device teardown?

If a new reader then concurrently starts and calls memset() and
init_completion(), could the complete() call here corrupt the completion's
internal spinlock?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913072910.1944=
300-1-lhfff@tju.edu.cn?part=3D1
