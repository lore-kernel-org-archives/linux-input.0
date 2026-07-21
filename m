Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B969415F36
	for <linux-input@vger.kernel.org>; Tue, 21 Jul 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656470; cv=none; b=BYOPjC0IUBiXuVx3YMIUav1jfRov0CxiErs9fH1gvP/CNqu3mmC9THEZAzlfvJH0Y35+yKzmfItTaC0KSD6bHtUtRGvWVFTZF19IJ4YihzfYoPdvGANOnDYFsJskYrCqS5Qx8Cdz7iOjwKeRfSHg/nA2Yu5RfFkdIlqYdvKnpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656470; c=relaxed/simple;
	bh=0szb4urJtqrDjbMoY7tWxaaoQ5bkGRmDSTBdEoo5cQc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPyblPN20kXmjOJnSHUY2V4fBbhBRU7kLy9klEZUknVLYw197CDhoWvuoHPAgrmUZPSKC7UkQLYUt62eJUver/HP+i3RTtx7ZzwNVATutkETxSRz976msAVHkSr2dmwzkjo/AWqMFdnA/3LXMMjXC6qZIImD/gFaSYRsqK5S0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXV0AARW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXV0AARW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BF81F00A3E;
	Tue, 21 Jul 2026 17:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656469;
	bh=4uVu3aMRvzYmKPOJ9Fh274BxQ4/F8LT8JL/LJit+2zk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXV0AARWRdEdgWv9XMTmdghw37brszqOn/Icn9ttrzoS9ko3NmP6aqy0obq3kVMES
	 vxgKkAePDIcgo28ISK4nUGGMIIuzxaJdnBz8uBWYnM+QaaV6Wbu4fm611sO4G9YFMx
	 J0q2A+aSNuv9aAiNNI3zSuB3o7jtwXIvgfpas953Ak+Det4PlzdkYvglDyc3mkDyOJ
	 fhXItgIovlgbnNk6vVwonxHHVP/hLRkGk8qcUtsCChw4e/sXEdp+VnMlykHvKXa97Q
	 tdBEIDUoUqocZLudbmNu2/SLfw9EtgYlz2R0W85lHHWRdNUjN5QnT3FvdxtlNKt4x+
	 HZy86tfJF4nGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Input: misc: Add AMD SFH tablet-mode switch driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Basavaraj Natikar" <Basavaraj.Natikar@amd.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721174422.3109166-4-Basavaraj.Natikar@amd.com>
References: <20260721174422.3109166-1-Basavaraj.Natikar@amd.com>
 <20260721174422.3109166-4-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:54:28 +0000
Message-Id: <20260721175429.32BF81F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The initial hardware state of the tablet mode switch is redundan=
tly queried and synchronized after `input_register_device()` exposes the de=
vice to userspace, creating a race condition.
- [Low] Violation of input subsystem naming convention for error variables.
--

--- Patch [3]: [PATCH 3/3] Input: misc: Add AMD SFH tablet-mode switch driv=
er ---
commit e88c97b2482f6ed434b346336b9c6f9164d73473
Author: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Input: misc: Add AMD SFH tablet-mode switch driver

This commit introduces a new driver for AMD convertible laptops. It exposes
the SW_TABLET_MODE switch by polling the operating-mode sensor provided by
the AMD Sensor Fusion Hub.

> diff --git a/drivers/input/misc/amd_sfh_tabletmode.c b/drivers/input/misc=
/amd_sfh_tabletmode.c
> new file mode 100644
> index 0000000000000..f88edebbf35d5
> --- /dev/null
> +++ b/drivers/input/misc/amd_sfh_tabletmode.c

[ ... ]

> +static int sfh_tm_probe(struct auxiliary_device *auxdev,
> +			const struct auxiliary_device_id *id)
> +{
> +	struct amd_sfh_info info =3D {};
> +	struct device *dev =3D &auxdev->dev;
> +	struct input_dev *input;
> +	int rc;

[Severity: Low]
This isn't a bug, but does using 'rc' instead of 'error' or 'err' violate
the input subsystem maintainer preference?=20

The input subsystem guidelines suggest using 'error' or 'err' for variables
that only hold negative error codes and 0 for success.

[ ... ]

> +	rc =3D input_setup_polling(input, sfh_tm_poll);
> +	if (rc)
> +		return rc;
> +	input_set_poll_interval(input, POLL_INTERVAL_MS);
> +
> +	rc =3D input_register_device(input);
> +	if (rc)
> +		return rc;
> +
> +	sfh_tm_poll(input);

[Severity: Medium]
Should sfh_tm_poll() be called before input_register_device()?

Calling it after registration exposes a race condition where userspace
components reacting to the device creation uevent might read the
SW_TABLET_MODE state before sfh_tm_poll() executes.

They will read the default uninitialized state (0), which may incorrectly
leave the keyboard and touchpad active if the device is actually folded into
tablet mode.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721174422.3109=
166-1-Basavaraj.Natikar@amd.com?part=3D3
