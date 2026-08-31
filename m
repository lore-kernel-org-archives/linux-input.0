Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0536212C
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201752; cv=none; b=dYK/68IxGiJ50DdlxkhrBwko9oFLFknuxT5qDRBLHAgKVTg25S0XVuQzpNmuWVy4sdMRjzga7rdaEkwymmJTx08n5MDi50QFGAjZqw82S+XEwRCA+Ys5Kd75t7UC50i40xxzSpvGmvhnAkllSs/7y44gl96lrm0mthtB6LmSs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201752; c=relaxed/simple;
	bh=kzo44AwYWj6Cq8Y8YcAc1b5Yp9P739kug4D3j/NhuCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T4KJwHE0a/L1SPfFWRDzGEwS4NhMZcMK26lefWNFkCQjRYZG4gPt+8clUQ7ZxpdlnVZMnDG2Dk6EDfv7giNxLa0ASdnjqJ+7TGiEpw05MRYu3jOjEjGYuB9DxrLJAr+3w+nWz9aGJe0xQLdU6x5wrs0k3voyvsUWdoO8WaeCSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWqTpIeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWqTpIeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649881F000E9;
	Mon, 31 Aug 2026 18:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201750;
	bh=y0t5uoF/JC+j8gWi+Q9qMHXClH3eeyhFdVojV4nU44w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nWqTpIeVUUUTMq78lEC3xIo6/3td2uMxyzzyNeMIXnGq3NGsVskuCxecA++N+Eu8O
	 rsLzIX/g/FToZsJ0Z6BTliqPfeUWJHe7arSk5R5J2ZTuLciblz4QGTSwwxfWE4swa3
	 cJhmASuMHwW6zYqBpwDT915Dr1NL+wLwrPJRDge84kGH/cxSZQ1WW2wBwQIF45XRxN
	 jupdHnSIoRRdFjye9kp9TkTqOZWvzXl7BmKuhX7YMgTU7aU86VRjtoafOGi71W8q1z
	 VQBD4FbCr0J4u65QOsYlWQ1bzkfeDF40/A6UqjO4w4pDoQ6EMWwmUdcuc1OabZN0sX
	 TXmOtD8evJDyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] Input: uinput: align UI_ABS_SETUP validation
 with uapi docs
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SXbDoW4gRXplcXVpZWwgUm9kcmlndWV6?= <ivanrwcm25@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260831152156.166514-3-ivanrwcm25@gmail.com>
References: <20260831152156.166514-1-ivanrwcm25@gmail.com>
 <20260831152156.166514-3-ivanrwcm25@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:42:29 +0000
Message-Id: <20260831184230.649881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Adding a strict minimum =3D=3D 0 validation for ABS_MT_SLOT br=
eaks backward compatibility by rejecting previously accepted configurations.
--

commit 12ce67adcfd7a78984b09163e522a86103b65a3c
Author: Iv=C3=A1n Ezequiel Rodriguez <ivanrwcm25@gmail.com>

Input: uinput: align UI_ABS_SETUP validation with uapi docs

This commit updates uinput to align with UAPI documentation by returning
-EINVAL for out-of-range axis codes. It also adds a strict validation check
to reject ABS_MT_SLOT configurations if the minimum value is not zero.

> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index d32fa4b508fc5..e05c80182252d 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -424,6 +424,13 @@ static int uinput_validate_absinfo(struct input_dev =
*dev, unsigned int code,
>  	min =3D abs->minimum;
>  	max =3D abs->maximum;
> =20
> +	if (code =3D=3D ABS_MT_SLOT && min !=3D 0) {
> +		printk(KERN_DEBUG
> +		       "%s: abs[%02x] minimum must be 0\n",
> +		       UINPUT_NAME, code);
> +		return -EINVAL;
> +	}

[Severity: Critical]
Does adding this strict validation break backward compatibility for existing
userspace applications?=20

Applications that historically passed non-zero minimum values for ABS_MT_SL=
OT
(which the kernel silently accepted and later clamped to 0) will now fail to
initialize uinput devices, receiving -EINVAL during the UI_ABS_SETUP ioctl.
This introduces a userspace regression by rejecting previously accepted=20
configurations.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831152156.1665=
14-1-ivanrwcm25@gmail.com?part=3D2
