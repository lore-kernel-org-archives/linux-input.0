Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D077227BB9
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468259; cv=none; b=K5dyljW1jELbUHV89UrSnnG5RgzVp61hZE/pDSi7w9Wa7Ui+TWtpEthgAAUl5QSlmkUAzfBWitIWMp1P+4ZLUhe/PTISsQ+507lgmelFiYrtvOMHiJUTdVyfm/b3mvUFqmaVGox0Ljs3E+0hAiWZs7y4+QzKQjVm0EsdyNMtKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468259; c=relaxed/simple;
	bh=sf2UnXAHmJFMc4ZPyvDHE0i5phwvXqNJCnnJWWu/rQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R5gsK8wZBQDiVt+us5+j6daJoszI7JyaDkJGGkxOBzG+5c2tCwq+C/eG3TdxozS6R383rUg9OP/3OKnxsmjlDw458l/W9maaMcp+tI/vnOjwgPssEV/OtEdB5menrvjV4cVVDHy12CP7MzFOLO5OFFeqIzOOE1rYqmjlk4qCHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoZcbUJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoZcbUJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFF11F000E9;
	Tue,  7 Jul 2026 23:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783468257;
	bh=kp5pAvS3/2CBVdp1azU3s4SuJbNksyvF0O0igvO6/Ew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MoZcbUJDAXMuF3SMEAx3+Jnx4z+QpLeqU9sPzcmVsi/XL0+mNTRCMXqnFgTi6Tj9u
	 q5MiYpi4VLEytgAK3TRXaJ8ns03AltnaWXVFXKpuQ9E2feG/egFNMmgVhDZn26ljxd
	 wDkHkFiCEtO68EYUAWFo9GIe2vixYo6VMMqCMgvgmjZYjFDtQfPrSiisE8Y704h47j
	 aVUvdmuSYMxRivsbGa/2430k3Pwh35TrHd5pygJgkB3rkh72kGzBqgBBnUE1fkEZq4
	 RAIp1YqaTMCS7uPAPIqx6tCEhkxT72UK1b8CxuWpLHJx+7x0jcfz1RA7hgYLFGF4ub
	 p/5juMRHbPtrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] HID: steam: Add support for sensor events on
 the Steam Controller (2015)
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260707233241.2644971-5-vi@endrift.com>
References: <20260707233241.2644971-1-vi@endrift.com>
 <20260707233241.2644971-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 23:50:56 +0000
Message-Id: <20260707235056.ECFF11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `steam_register()` fails during probe for a wired device, the `=
steam` struct is left on the global `steam_devices` list but its memory is =
freed, leading to a Use-After-Free.
--

--- Patch [4]: [PATCH v2 04/10] HID: steam: Add support for sensor events o=
n the Steam Controller (2015) ---
commit d6e009f462fb9aec26d7157d6389455fb438d8e1
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Add support for sensor events on the Steam Controller (2015)

Sensor support was added for the Steam Deck previously, but Steam Controller
sensor events were never added. This adds that missing support, bringing St=
eam
Controller support much closer to feature parity with things like SDL and S=
team
itself.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index add9f4f27fff9..6029c055a6cf3 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -968,6 +1077,12 @@ static int steam_register(struct steam_device *stea=
m)
>  			strscpy(steam->serial_no, "XXXXXXXXXX",
>  					sizeof(steam->serial_no));
> =20
> +		ret =3D steam_get_attributes(steam);
> +		if (ret < 0)
> +			hid_err(steam->hdev,
> +				"%s:steam_get_attributes failed with error %d\n",
> +				__func__, ret);
> +
>  		hid_info(steam->hdev, "Steam Controller '%s' connected",
>  				steam->serial_no);
> =20

[Severity: High]
This is a pre-existing issue, but can the error path in steam_probe() lead =
to
a use-after-free if steam_register() fails?

In steam_register(), the device is added to the global steam_devices list:

		mutex_lock(&steam_devices_lock);
		if (list_empty(&steam->list))
			list_add(&steam->list, &steam_devices);
		mutex_unlock(&steam_devices_lock);

If a subsequent registration step (like steam_input_register() or
steam_sensors_register()) fails, steam_register() returns an error without
removing the device from the list.

Then, back in steam_probe(), if steam_register() fails, it jumps to
err_hw_close, bypassing the unregister cleanup:

err_steam_unregister:
	if (steam->connected)
		steam_unregister(steam);
err_hw_close:
	hid_hw_close(hdev);

Because the steam device was allocated with devm_kzalloc(), devres will
automatically free the structure upon probe failure. Does this leave a dang=
ling
pointer in the global steam_devices list, which could cause memory corrupti=
on
when the list is later iterated (e.g., when setting the lizard_mode module
parameter)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707233241.2644=
971-1-vi@endrift.com?part=3D4
