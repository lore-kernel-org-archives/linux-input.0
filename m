Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5E486640
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037346; cv=none; b=tKYgro4/d/psh+nmoatvGwn4cGzC6FHkGRT1l274rQe3+vlZENHwX+bu8BOqHSzSfVyLCjmmZLORkNSNQt3mg0WoxjyyltPtPwPFxc/yzYd/mJtiPFevXVigXhf6ZwD2tTnAoqhkpuOOJlKpryhOvV7jiipFfDj+xstC9d1aLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037346; c=relaxed/simple;
	bh=GSCsX0gAScTj45KyWMVpPpz835c8oi+QC6bEdb85Zi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MqzE8+x84miROln8oeGFasGWfsp2YGLUvRm9BmrJtEAom3fZgtj2EcqTGsjmKuNCnhQa2phVoU+531gBFgdqyQmAwwDtkYxY+ZgGv+/QTsIzrSXhBZcOwcaj5q8rJggJU2vjVKb4/LGFk2ir4JJorHMl+uWZJyEOFA6hbiNAY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlGVbpjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlGVbpjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EAE1F00A3A;
	Thu,  6 Aug 2026 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037344;
	bh=XEtD9/a7TEz+2Fcf6oMNvOzsTYk9UN2iDRHZ7ktTL2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PlGVbpjtHo1FMIF3ExA36/TV6LRWtgBc+WwLBOsyE0nYGYS5b/iWHhM3rD1OgrPzK
	 FZxN2AgMF7fr5wkkEjLZc2yhmwYOTub22eVs4WhkOJPhS3lVE6v+9z3lmgXDN59chC
	 ciOuKJwHlU1RXLBGUfdyr9hGJxg2KPfNy1LQAJzloUv/K8a1S1k+krh37wix9wKsQ8
	 MS6NX9U6lMgT21wuBv+DCSlARrLIBRTRCIkKYAypAJK/JhAVFe1LSp3SPYGo2ndReT
	 F4KCJXV5xvZtJJQ8Wo4lNrUVeYH/fr8SoYWHQ/IVrTX3KORg2cybzK6lyJ85GMSz1s
	 BU60eFNGk68XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: rmi4 - Use platform data instead of query,
 when available
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806-respect-x-y-mm-v2-1-e0681ed3d63c@ixit.cz>
References: <20260806-respect-x-y-mm-v2-1-e0681ed3d63c@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 17:29:04 +0000
Message-Id: <20260806172904.A0EAE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential kernel panic due to division by zero if hardware returns=
 0 for DPM resolution.
- [High] Read of uninitialized kernel stack memory if a device provides a s=
mall `reg_size` but claims presence of multiple subpackets.
--

--- Patch [1]: [PATCH v2] Input: rmi4 - Use platform data instead of query,=
 when available ---
commit abbd3f045bbd60bcd7253a3917acc57dc4a898a0
Author: David Heidelberg <david@ixit.cz>
Subject: Input: rmi4 - Use platform data instead of query, when available

This commit updates the RMI4 F12 driver to respect device-tree provided
touchscreen-x-mm and touchscreen-y-mm values. It prevents overriding
these values with sensor-provided data if they are already defined.

Link: https://patch.msgid.link/20260731-respect-x-y-mm-v1-0-3e85a4bec745@ix=
it.cz

> diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
> index 88c28089de993..841884d967a3d 100644
> --- a/drivers/input/rmi4/rmi_f12.c
> +++ b/drivers/input/rmi4/rmi_f12.c
> @@ -155,6 +155,10 @@ static int rmi_f12_read_sensor_tuning(struct f12_dat=
a *f12)

[Severity: High]
This is a pre-existing issue, but can this function leak uninitialized kern=
el
stack memory?

In rmi_f12_read_sensor_tuning(), a buffer is allocated on the stack without
initialization:

    u8 buf[15];

Later, rmi_read_block() populates item->reg_size bytes. If a malicious
peripheral provides a descriptor with a small reg_size but sets multiple bi=
ts
in subpacket_map, the function reads past the initialized portion of buf:

    sensor->max_x =3D get_unaligned_le16(&buf[offset]);

Is it possible to initialize buf to zero to prevent exposing stack contents
when the hardware-provided reg_size is less than the offset required by the
advertised subpackets?

>  		offset +=3D 4;
>  	}
> =20
> +	/* When platform data are provided, we're done */
> +	if (sensor->x_mm && sensor->y_mm)
> +		return 0;
> +

[ ... ]

>  		dpm_resolution =3D buf[0];
> =20
> -		sensor->x_mm =3D sensor->max_x / dpm_resolution;
> -		sensor->y_mm =3D sensor->max_y / dpm_resolution;
> +		if (!sensor->x_mm)
> +			sensor->x_mm =3D sensor->max_x / dpm_resolution;

[Severity: High]
This is a pre-existing issue, but could this division cause a kernel panic?

If a misconfigured or malicious hardware peripheral returns 0 when the DPM
resolution query register is read, buf[0] and thus dpm_resolution will be 0.

Does this require a check to ensure dpm_resolution is non-zero before using
it as a divisor?

> +		if (!sensor->y_mm)
> +			sensor->y_mm =3D sensor->max_y / dpm_resolution;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-respect-x-=
y-mm-v2-1-e0681ed3d63c@ixit.cz?part=3D1
