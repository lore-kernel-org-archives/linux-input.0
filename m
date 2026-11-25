Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633915;
	b=JNxmXQnY6pncXcyW7Eca+DZp7pcvHTagTOUuPptieR5q1gZfz038sfNV6U27hBMUoUB/
	 XaSbvR8WK1coghPvdViduIrRZTnJPXr8rSykoepciAZ3mI0SjiZsfufOhTeVd5IegiqQy
	 Cuzo7zKolxakr3kwjn1hjgXS6pXxir+rAW2FNxAAqUH75CdtQkvUPc9CQ8YqRptoo1tB5
	 YN6zt27KWX0RVHGLYNdw2sl/DWSpMLctMHP/XsbaxOqwbhYBg0WZTwSRfhS6gAHjmctly
	 79t0tpIqry5lM+aZdGqdU8MH4+U8uBHD5wJRn6FI7bf0qx4/Jt+AZIaJy5Mcpiuvtaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XerPqGdIF4A2cvW5B9n/ySkD7hAGOVGFbBI2WeLPp8c=;
	b=5JrijTx0gk68QMaN1+iY9CWl6/a6+5bJkQnXk9iDvJLOHqYen5uYBh2r5RiwvrWzvCCm
	 tyRtqklMsHokOpGvpvQZXiFdjcaQIwbKovgfNRWRcAkvFivLgqzYEXqh9jA2K5W5RXgS1
	 Q1ts4GfAiVQ7FVpwgcmAePp6IXrZT0XYlwNKwLwx7XPj48iZtFhiJVSSkrjKb2M4igrZ0
	 c44+KuxLOLtZfOjTUvY/kxyRyTZEtsUcZOSL+Bo4SlP0W90qKF7/Z8AvnfL+O0NlWNFji
	 tG6NIqr7k3Q7FoPOJAOA4n1iUA0FhgFqlerRWyya1QeWxcp95t2Nb1yf3g5Fg+/zFEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFh4ixSA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D0606A31E
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFh4ixSA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191471F000C6;
	Wed, 25 Nov 2026 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633915;
	bh=XerPqGdIF4A2cvW5B9n/ySkD7hAGOVGFbBI2WeLPp8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFh4ixSAIQZH/hKZo9ff9Y9sjsxtPxOx+iZq1paPu+aAu6Qq4COpqHdRW3lFc7xL7
	 aaOtFsgti/IxUWZbR879Mt7mOGsSOWWMeu9J7LQTD+j6yBOJ8/gOwyPg32ZI3r+IRF
	 B9L6glVHKiDmkZzpcqiRtEQa681H99NnJNiXxUCTbXN/0Ly0vuDEHfLxka2JLiepB5
	 n2EIlkPTv9oOrvewC4QmeBRSfstmtOd2rPlrUIlatgd5gTLx4465mILhT7hE82CKZF
	 GRrb+hCQk+jseJIdW/tj4Qo9qrsJ1sVgs4WpW3o5adHn4ZViMagvr6s+VXMI+wRsHh
	 lXUJrXzRkr3mQ==
Message-ID: <sashiko-outbox-234036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] docs: ABI: hid-lenovo-go: Point one entry at the
 version group
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261125190742.2420486-2-takano32@gmail.com>
References: <20261125190742.2420486-1-takano32@gmail.com>
 <20261125190742.2420486-2-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 19:11:54 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] docs: ABI: hid-lenovo-go: internal MCU protocol_version uses
  nonexistent path
--

commit 59c6e641f7a91e766d489a67c548d903d75c5b71
Author: TAKANO Mitsuhiro <takano32@gmail.com>

docs: ABI: hid-lenovo-go: Point one entry at the version group

This commit updates the sysfs ABI path for the internal MCU
protocol_version attribute to avoid a duplicate right_handle/protocol_versi=
on
entry in Documentation/ABI/testing/sysfs-driver-hid-lenovo-go.

> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go
> index c8221373ef76a..ed8d9a35b8ca4 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> @@ -386,7 +386,7 @@ Description:	This displays the product version of the=
 internal MCU.
> =20
>  		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
> =20
> -What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface nu=
m>/<hid-bus>:<vendor-id>:<product-id>.<num>/right_handle/protocol_version
> +What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface nu=
m>/<hid-bus>:<vendor-id>:<product-id>.<num>/version/protocol_version
>  Date:		April 2026
>  Contact:	linux-input@vger.kernel.org
>  Description:	This displays the protocol version of the internal MCU.

[Severity: Low]
Should this path be top-level .../protocol_version without the version/
subdirectory?

In LEGO_DEVICE_ATTR_RO(_name, _attrname, _dtype, _group), the fourth
argument selects the _group##_show() callback prefix (version_show()), not
a sysfs attribute group name.  dev_attr_version_protocol_mcu.attr is added
to mcu_attr_group, which has no .name field, so protocol_version is
exposed directly in the HID device top-level directory alongside
product_version and firmware_version:

drivers/hid/hid-lenovo-go.c:
    ...
	&dev_attr_version_product_mcu.attr,
	&dev_attr_version_protocol_mcu.attr,
	NULL,
};

static const struct attribute_group mcu_attr_group =3D {
	.attrs =3D mcu_attrs,
};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125190742.2420=
486-1-takano32@gmail.com?part=3D2
