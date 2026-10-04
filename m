Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AD31716D
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791113294; cv=none; b=dU5hDhzJpLpekAwJQT8DpGXqRXq1RgKn5RiXB53zc2JwI9GIu/OY9Bdt18PJV4ldDEn+41+QaJCKIKSRHnZHRJPfeDIssDJnbz+prF579Q9HoEr0zpUok+4704/uZcSc+oJl6wZpR4vb7F0OkYcpnzryetkYdPSmluSucluWhNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791113294; c=relaxed/simple;
	bh=WW8HjIEMS+WNOuWdVB9arZ8ZWMGWvlE4K9iAwahtNtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trwDT1BaKjTmxiTyqTqjFCe9prK2lrVSXrF7mFbdwNvHnDQMFVKiSia3/scGXSaAOuZrZ37u6Y3Yco5II78K8lCnxAD8eAV6q98AAAVOVfQ3m4aa7QgI52bWqFXlBH/vvH53uy/issC/4XfOMv6roUkscWZAZmDwfuxQT+8sKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqwKG+6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqwKG+6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460B21F000FF;
	Sun,  4 Oct 2026 11:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791113292;
	bh=ioluZzqWNEwdxFPINrS9MxoCywj2Ig37mDH12czexRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqwKG+6vwd2rQI/Q//fbtMxit75nbW1Zga0t//xjSRvtOYNTsta9dskrsB70SLtIv
	 9a4X9JzZrAriMdzQhrFzcgEO9bfFkvfJ7i1VTtooCqf4eKQdHH3bMMGcmIIq1QmhAy
	 VDe0M0JglXJeIX8kAG7xwKv8Q+yD8Dc2+nIrDm41CDCT5xqXkOC3DsvLY9fi2NrvGq
	 HQyEpkYXQ140zTLc1aY8uI7bFHK8IvVJoIeuDeszOpkMDq+QvVcGrRXf+bym6zRr0r
	 qD0etY92Qf3JsBicm25h7ifWtX/FLgENgHrMrMvIIw2XDEEVvODUhWhU2Jlz0KR60h
	 mospTWP9sSEZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: serialize mode changes with device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261004111353.118025-2-jinmo44.yang@gmail.com>
References: <20261004111353.118025-1-jinmo44.yang@gmail.com>
 <20261004111353.118025-2-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 11:28:11 +0000
Message-Id: <20261004112812.460B21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: wacom: Use-After-Free due to sibling worker restarting hardwa=
re during remove
--

commit d345d10fbdd75c5608a4db1f5c93eaec7ccc124e
Author: Jinmo Yang <jinmo44.yang@gmail.com>
Subject: HID: wacom: serialize mode changes with device removal

This commit adds a driver-wide wacom_mode_change_lock mutex to serialize
mode-change workers with wacom_remove(). The goal is to prevent a sibling
device's mode-change worker from accessing a removed device's struct wacom
after it has been freed.

Fixes: 4082da80f46a ("HID: wacom: generic: add mode change touch key")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
[ ... ]
> @@ -2783,22 +2784,32 @@ static void wacom_remote_work(struct work_struct =
*work)
>  static void wacom_mode_change_work(struct work_struct *work)
>  {
[ ... ]
> +	if (pen) {
> +		wacom1 =3D hid_get_drvdata(pen);
>  		wacom_release_resources(wacom1);
>  		hid_hw_stop(wacom1->hdev);

[Severity: High]
If a sibling worker is running concurrently with wacom_remove(), could this
double-stop the hardware of the device being removed?

[ ... ]
>  	if (wacom1) {
>  		error =3D wacom_parse_and_register(wacom1, false);
>  		if (error)
> -			return;
> +			goto out;
>  	}

[Severity: High]
Could the sibling worker restart the hardware via wacom_parse_and_register()
(which calls hid_hw_start()) here, while wacom_remove() is blocked waiting
on the wacom_mode_change_lock?

[ ... ]
> @@ -2916,6 +2928,10 @@ static void wacom_remove(struct hid_device *hdev)
>  	cancel_work_sync(&wacom->battery_work);
>  	cancel_work_sync(&wacom->remote_work);
>  	cancel_work_sync(&wacom->mode_change_work);
> +
> +	/* A sibling's mode-change work can also access this device. */
> +	mutex_lock(&wacom_mode_change_lock);

[Severity: High]
Since wacom_remove() executes teardown steps like hid_hw_stop() before
acquiring the lock, and only cancels its own worker, could a sibling's
worker continue running and bypass these teardown steps?

[ ... ]
>  	if (wacom->wacom_wac.features.type !=3D REMOTE)
>  		wacom_release_resources(wacom);
> +
> +	mutex_unlock(&wacom_mode_change_lock);
>  }

[Severity: High]
If the sibling's worker restarted the hardware via wacom_parse_and_register=
(),
wacom_remove() returns here without calling hid_hw_stop() again.

Will this leave the device's hidraw nodes active and registered after the
driver is unbound, leading to a Use-After-Free of struct wacom when accessed
by userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004111353.1180=
25-1-jinmo44.yang@gmail.com?part=3D1
