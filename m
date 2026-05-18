Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064E371CF1
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121437; cv=none; b=BU3dEVJHKh3qC9GQE+K632o6H5DcM5tcU1CQnt1PQkiMFPOXZ5Q9Ot+4hLXPwFk0d1hYGtG3zB250qNW6BuozzUhKY9HXWEs8GkIiscKNkrMXUPYbnEa5TWIf7aRZzM9exmkGEVJJdwIv2JFKWDHcB9/5KMjS26CCbm2bt+Px9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121437; c=relaxed/simple;
	bh=zy0+m4X2Cz29q5SgTncdR0gd8GW/hMQlFmoYbzABHUw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r2kvZsf+LvCJo0S//mGFufdsXaOFQlfp4d3VrGfo0DwfsrjJstwx8ekH95GuiIKQihPtMyoX16uU0xWAltfalmgtTHPwdlMxWZu+l8ATqYqQbFZExIYYs4ibOU/J/GJvyZOn/eWsjUTip/VPW8LL3RYRvvasDtpFeDgrmE5+VgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdFSVCmI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdFSVCmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D5C2BCB7;
	Mon, 18 May 2026 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121436;
	bh=zy0+m4X2Cz29q5SgTncdR0gd8GW/hMQlFmoYbzABHUw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=mdFSVCmISwktcm69dXOC2cUh9zP7rXUizq5lSZbJWrqJdKOmVOf/I5LyUttyrCp19
	 EGqwpJ0mQNUlY3o3Q+HjN4cFXHW/gs4WT7KR9HIL9Bu6adi6PHpG2JMj3b3AkV6mhF
	 Ovrsnga6ds9flkONsimrrwRqp8eNVm65Xd3Pjj+8k+NDegqcCbnhALhnZbz2WQ4an6
	 JlWb9mzR8yAlzHw0VIedTiUuDdsZixlwWhj6FMcPmpTsGtf2SXA32ykLqlQIS02TKM
	 2hyKY+T96AIjJOS5LtOQVHTOlmdU9vap92NJuvQaWxho4EjxsSrqrTlZl541grmDKI
	 nWUYwE8AeNtng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] HID: wacom: use 'hid_device_id::driver_data_ptr'
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-11-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-11-a08e3989c283@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:23:55 +0000
Message-Id: <20260518162356.C60D5C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Incomplete refactoring of `id->driver_data` to `id->driver_data_ptr=
`.
- [Low] Mixed declarations and code in `wacom_probe()` and `wacom_wireless_=
work()`.
- [Low] Typo in the commit message.
--

commit 83b980c631eb908ccc27340ea394dd0fc86c568e
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

HID: wacom: use 'hid_device_id::driver_data_ptr'

This commit updates the wacom driver to use the driver_data_ptr field of
struct hid_device_id instead of casting the driver_data field. It improves
code readability by avoiding explicit casts to kernel_ulong_t and
struct wacom_features *.

> Remove the casts to (kernel_ulong_t) and (struct wacom_features *)
> and use the 'drvier_data_ptr' field instead to improve readability
> of the code.

This isn't a bug, but there's a typo (drvier_data_ptr) in the commit messag=
e.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0d1c6d90fe21c..25408676c5f61 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -2555,8 +2555,9 @@ static void wacom_wireless_work(struct work_struct =
*work)
>  		}
> =20
>  		/* Stylus interface */
> -		wacom_wac1->features =3D
> -			*((struct wacom_features *)id->driver_data);
> +		const struct wacom_features *features =3D id->driver_data_ptr;
> +
> +		wacom_wac1->features =3D *features;

Does this introduce a mixed declaration and code warning? The variable
declaration is placed in the middle of a block after executable statements.

[ ... ]

> @@ -2839,7 +2839,11 @@ static int wacom_probe(struct hid_device *hdev,
>  	wacom->hdev =3D hdev;
> =20
>  	wacom_wac =3D &wacom->wacom_wac;
> -	wacom_wac->features =3D *((struct wacom_features *)id->driver_data);
> +
> +	const struct wacom_features *id_features =3D id->driver_data_ptr;
> +
> +	wacom_wac->features =3D *id_features;

Similarly, does this placement of id_features violate the coding style by
mixing declarations and code?

Additionally, earlier in wacom_probe() there is this check:

	if (!id->driver_data)
		return -EINVAL;

Since the goal is to transition to driver_data_ptr, should that check also =
be
updated to use id->driver_data_ptr for consistency?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-mod-device=
table-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk?part=3D11
