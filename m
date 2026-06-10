Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7765933F5AC
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105529; cv=none; b=p5lsbFtUVfrrtkU2PDco/pWL3z/oUwvsRxRDZAf2Rg7OA1FyLZI9s8AGRvc6EwQcSz0j9ZxIJfZHWsEdr9ell40VtCo28NapCRxW6vLmLRuaDvQjb0aTuwHbV2QT8bVy5qbSHRE8JxuE2sPh0xVrvVpcGQK+fD0Rmv2qgSTd/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105529; c=relaxed/simple;
	bh=FOuC9Py/dw1TU5PQvg7V7Fa5oalbO8KnTc0Z51SX8Hk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F3qDyy2WktRFAhMuCfZR7T3M+77dUJm4Lz7MyAmhHwB2xU7QrBFl+IFCMi/ggJCMwAfhp7nr9fzaTGS5Ouf8Fp36kYM8KgeLmJApyQgm8Xa5GIemTvbJ6la0Db66Fv1b5tZcK457GpR8MeVPRoQTanzUMBpggGEobLfD3ZRs6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHMgZcIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHMgZcIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34F91F00893;
	Wed, 10 Jun 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781105528;
	bh=OqF0Y8rzN2OsvPET1QVXxZ0Wb++PCjAaZDipWWnHSRw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aHMgZcIBC+3WYkCmAur8aNzs7oHXsxtpxRQPRSM6kKS92qF565fjU6n1jfAFAHWW6
	 LlnkMfdQduIwLWpsprheWPT8t9LKlaLjTtRypjSIMvRx98PdYgvzJrjqz/ERodQujZ
	 zoTpVDyWAyiqLjYFHlpMM6+kkLRZQBW9y5svtTBsfW2UCsVpjSCQWT/WtfcIBopPpW
	 dGhqtZRxDapqb2nC+dk/127Nt4d4qsuGDw+grDO227WSa7ZlPA9O8zjSZNjiEIdvqg
	 6MoSa75+r3vkEIVeVBAW5foNbzBk0cjPFYaWPhP0hzSZIN3BFZRx/EiifSmGFdJUPm
	 R34NmPnVTa+iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] HID: hid-core: sanitize user input in
 'new_id_store'
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-11-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-11-a1d7473ccd9c@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 15:32:07 +0000
Message-Id: <20260610153207.E34F91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Restricting `driver_data` to strictly match an existing `id_table`=
 entry breaks backward compatibility and defeats the purpose of the `new_id=
` interface.
--

commit 613c086c5db811baec4d7b28a4e3757a62048b24
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
Subject: HID: hid-core: sanitize user input in 'new_id_store'

This commit modifies the new_id sysfs interface for HID drivers. It adds a
check to ensure that any provided driver_data value strictly matches an
existing entry within the driver's id_table, preventing arbitrary values
from being passed.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 41a79e43c82b3..e060e5ec4ea62 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2647,6 +2647,8 @@ static ssize_t new_id_store(struct device_driver *d=
rv, const char *buf,
>  		size_t count)
>  {
>  	struct hid_driver *hdrv =3D to_hid_driver(drv);
> +	const struct hid_device_id *ids =3D hdrv->id_table;
> +
>  	struct hid_dynid *dynid;
>  	__u32 bus, vendor, product;
>  	unsigned long driver_data =3D 0;
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
> +	}
> +

[Severity: High]
Does this change break backward compatibility and the intended purpose of t=
he
new_id interface?

Previously, users could write just the bus, vendor, and product to new_id,
leaving driver_data to default to 0. With this patch, if a driver's id_table
only contains entries with non-zero driver_data (such as quirk bitmasks in
hid-apple), wouldn't the sysfs write now fail with -EINVAL?

Additionally, does this prevent developers from testing unsupported hardware
by passing custom quirk bitmasks (or passing 0 to test without quirks) via
the driver_data field?

>  	dynid =3D kzalloc_obj(*dynid);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-mod-device=
table-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk?part=3D11
