Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F437475E
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025535; cv=none; b=fn5FWyKnQYltWuhGV06UHFHNy8usMRC+cvrKodh+rxkLcLIcDcgYb5FqdPi6fEPTPCiwbRbSd3eKnyzvx8mFb1dR5rz9NUZ6eVtc253cjMuAvMKenA+0Lc1b3o+QvmSIYdQYf6N4toMFYLaMTwzO+0BzvE6SO/07cgrDOtrcRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025535; c=relaxed/simple;
	bh=kZG8OKolA6ePXyBVGcSIBd/Qrghl+vRQ7AP5WPbJATA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aVHvrIw4+3ddqdCCioL+2JluL+3krLrmL5AQ3kG2/nAqG+jWvVMuvbwWe3PftfpQwi6VxWgbZcX1lOZKbn2GbUZaNNZ+IyxEaAk/ODsmEdwUC8Kvz4TJhkmFy27hi55FQXIvF6GFYa0wCDZoQX9RFnlUHDiFGCSAt1Rp3fddQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddZ8ihbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddZ8ihbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6181F000E9;
	Tue, 14 Jul 2026 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025534;
	bh=dRj+pTqfQqkYikutd/iD344BTYKJMBOV51G7XeJi8j0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddZ8ihbU3Zy2a96iafwjbhkdGW8PAAT22CzgkAtytIwB9uYJgmgKBAtwpLbe/G5mM
	 R2J9aklo8mouEcCZH4g73vbA1nRNOBx2BJwh/Rd6875NWsNYWJxqvAmfySaal9ECmu
	 BUKVJfpeqqX1vALtKVybxNYsxSTaOtq9cKZhM5h7WPUIYi+uzZiVq66r4o90iFYS4C
	 VVj060AQk7NJwXYLDn74ikeXe+W07MisiWHMfPtiTqnyaLI47J5uXlgVSDWSggbwQb
	 U6iI1tr3tKNJ86dryzHt6vhMKGi3Fe4COnf1FTNeKf0WCmKNd60Y7j+fRIaZrcHR/F
	 nw9HbrhGwaEyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/4] HID: hid-msi: Add MSI Claw configuration driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260714102640.18075-2-derekjohn.clark@gmail.com>
References: <20260714102640.18075-1-derekjohn.clark@gmail.com>
 <20260714102640.18075-2-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:38:53 +0000
Message-Id: <20260714103853.CD6181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Inconsistent use of `pm_ptr()` for Power Management callbacks.
--

--- Patch [1]: [PATCH v12 1/4] HID: hid-msi: Add MSI Claw configuration dri=
ver ---
commit 7e5a7560f52892f9ee5835a5c33181e068f459aa
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add MSI Claw configuration driver

Adds configuration HID driver for the MSI Claw series of handheld PC's.
In this initial patch add the initial driver outline and attributes for
changing the gamepad mode, M-key behavior, and add a WO reset function.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> --- /dev/null
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static struct hid_driver msi_driver =3D {
> +	.name		=3D "hid-msi",
> +	.id_table	=3D msi_devices,
> +	.raw_event	=3D msi_raw_event,
> +	.probe		=3D msi_probe,
> +	.remove		=3D msi_remove,
> +	.resume		=3D msi_resume,

[Severity: Low]
Should msi_resume be wrapped in pm_ptr() here?

The struct assignment for .suspend uses pm_ptr(msi_suspend), but .resume
is assigned msi_resume unconditionally. Missing pm_ptr() on .resume
prevents dead-code elimination on msi_resume and its dependencies when
CONFIG_PM is disabled.

> +	.suspend	=3D pm_ptr(msi_suspend),
> +};
> +module_hid_driver(msi_driver);
> +
> +MODULE_LICENSE("GPL");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714102640.1807=
5-1-derekjohn.clark@gmail.com?part=3D1
