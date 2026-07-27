Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5337E5D1
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164938; cv=none; b=nKjxhsVfzwNjRCNVXGB8HtUE3qBCdz9vj5wrbNvpOE/PmW/FQHipujco2NuodZSvZNq8l8z2y4faMywGA2bgMZYss9mPKTl6rfTf1XIuFYzZhRIvekmAHy29p1afI/p6pmApfyv4q0b7xcOtk4kNWv1l/pHaCUe2bB0tFr4xj9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164938; c=relaxed/simple;
	bh=qUw+CjvjKvJX7dBChFVlw7f+EZ0nhFGRWMx0nkiY5q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jY66D7TIxY3ismmlfZiHqx/08nvz1xR5jS99tFjkmxB1iJbPI4JHOHj5C7+rhKb3pdlHfIAtQlVq2+qgzQ1uQNMfIPORl94UDCi1Vysjq0SjWgVitfH2Q925cZ69hwyZGb6wMbMnM1s1LTy+J+OdfAFNXzVkZf0i9SR5vJ04Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3s/UPyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3s/UPyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAAA1F000E9;
	Mon, 27 Jul 2026 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164937;
	bh=TKMQy46b+zRM7TzWWjyZhRoTPg9ACYNHTq8sddHrWuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K3s/UPyXZn4iGuE85s1Hfu2tHe+DoRkx5x0f8kOszXJdxr7XCqo+M19Ayj1vBnczW
	 YB5mfx4sfZ57dMhLapXeBWQMo5ySI5Kn8nkpSb7VRqDiVM3NpiKrHM9t3LbkECwunl
	 cwSRG+3Dyma2xDOocBKW7h0Lohp5gn/O7da2vtHwigVuXbbWzIejd78fxpObL+sz3K
	 Gi36TSsZdU/Gejf0o4l+FQhHuybiZTXu97ulHr3HMj2tRY+RSF3wI41JiRpQ6tY6Ia
	 cR3Khl694EhN8y6wIGXgZulnjKqE0p+MvDOIvUgbGg04eHa920iI11ABkad+uLNTIL
	 /1ikbppsdKKKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] HID: hid-core: sanitize user input in
 'new_id_store'
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UGF3ZWwgWmFsZXdza2kgKFRoZSBDYXBhYmxlIEh1Yik=?= <pzalewski@thegoodpenguin.co.uk>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260727-mod-devicetable-hid_device_id-v3-7-980896ca283e@thegoodpenguin.co.uk>
References: <20260727-mod-devicetable-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk>
 <20260727-mod-devicetable-hid_device_id-v3-7-980896ca283e@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:08:56 +0000
Message-Id: <20260727150856.CEAAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] UAPI/ABI regression in sysfs `new_id` interface due to strict =
`driver_data` validation.
--

--- Patch [7]: [PATCH v3 7/8] HID: hid-core: sanitize user input in 'new_id=
_store' ---
commit af3e08832a7fc0ca5b1869fbb2a41b16e167f98f
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

HID: hid-core: sanitize user input in 'new_id_store'

This commit restricts the driver_data field in the new_id sysfs interface
to only accept values that match an existing entry in the driver's id_table.
It aims to prevent overriding predefined values within the driver module
with arbitrary entries from the command line.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c

[ ... ]

> @@ -2657,6 +2659,22 @@ static ssize_t new_id_store(struct device_driver *=
drv, const char *buf,
>  	if (ret < 3)
>  		return -EINVAL;
> =20
> +	/* Only accept driver_data values that match an
> +	 * existing id_table entry
> +	 */
> +	if (ids) {
> +		ret =3D -EINVAL;
> +		while (ids->bus) {
> +			if (driver_data =3D=3D ids->driver_data) {
> +				ret =3D 0;
> +				break;
> +			}
> +			ids++;
> +		}
> +		if (ret)	/* No match */
> +			return ret;

[Severity: Critical]
Does this loop break the existing userspace ABI for drivers that do not have
an explicit driver_data =3D=3D 0 entry?

The sysfs new_id interface historically allows users to bind devices dynami=
cally
by writing 3 arguments (bus, vendor, product), which defaults driver_data t=
o 0.
Because this loop terminates when ids->bus =3D=3D 0, it skips the sentinel =
entry.=20
If a driver's id_table lacks an explicit entry with driver_data =3D=3D 0, w=
riting
a 3-argument string will now be rejected with -EINVAL.

Can this be adjusted so it doesn't break existing scripts or udev rules that
rely on the default driver_data behavior, or prevent users from testing cus=
tom
combinations of quirks?

> +	}
> +
>  	dynid =3D kzalloc_obj(*dynid);
>  	if (!dynid)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-mod-device=
table-hid_device_id-v3-0-980896ca283e@thegoodpenguin.co.uk?part=3D7
