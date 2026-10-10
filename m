Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAC8384CEA;
	Sat, 10 Oct 2026 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643632; cv=none; b=sS58K2sw/g/zoz+B8PBwrcjbSuZyJIAyoCs3D/bQwuE54Hp+WdpfwDK6bP7YEFkijgc0Sd/9/EQk3x6gqt4HkDOtjWb2FJaPEIjn4THuQcWL3Bnimj68Bq78bDWe49PY/39JFTUCRBgnNEd9VEz+fOe3S6p7ZfTI+DZEv0W4X8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643632; c=relaxed/simple;
	bh=4bsBIbM/LGaK4k6J0NCGRXKrQux7Bu+uWuWFWzgF6S8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=aO9GDu1QWPTzlkWRipKziVnk8jM3GuwkPhbMfrqCevkgyP0R92dco/igAz0BHm/DCNOPjCL9Aop3qg+9+u14AG7iACRHu5rAJgyvpFYM2TSZkwdh3fm1ubOJsavExI8Ada95hShDvSDxIKPbfegzvSrVz/48jgxrWwqLru/JTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NStF1Kvi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NStF1Kvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998B21F000FF;
	Sat, 10 Oct 2026 14:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643631;
	bh=QPFXye0qrPxOp01fQIl4/yjNK/jeEUjA3skOEj6Hnhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NStF1KviZRrfaA3H3XU2Ig0rmwRoKGaEodkO8nYt6ix0NfD/06zt4fFnfIMD15fDR
	 eHMiLcKEABdRlM71jIx7k6QC2HWBOquFbMbwRM4X3LxI0SUWYwazvEtqZVIGyaMZoY
	 DXb8vO6YaC3Di3vc6kCzOSb2t35pXRHWj+7vLWSE/OP3jAtcQ4mC5agOeWua+FZLVU
	 NLns9UmOiOIToU8Wd4qiSmdzRps7GD1HrTLgGVPOXac9t0LaN6klWNdPGFF2T0bLrL
	 c+mz6PzrYP+8fBmwCvYKzsq0i9ohP/ebcavU6ngBTzGjkmk4kr7KKJe+IdkspySTDp
	 qlnOgZyYurgvg==
Message-ID: <sashiko-outbox-166670@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: add OnePlus pogo-pin
 keyboard
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261010143836.173883-2-wyibo6109@gmail.com>
References: <20261009122046.551915-1-wyibo6109@gmail.com>
 <20261010143836.173883-1-wyibo6109@gmail.com>
 <20261010143836.173883-2-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 14:47:10 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: missing required touchscreen geometry properties
- [Low] dt-bindings: MAINTAINERS entry is not sorted alphabetically
--

commit 6f38b36d3e9ba3bf27f192d07af31696c6e0fdc1
Author: Yibo Wang <wyibo6109@gmail.com>

dt-bindings: input: add OnePlus pogo-pin keyboard

This commit introduces a device tree binding for the Tinno keyboard MCU
used by OnePlus and OPPO smart keyboards. It specifies the properties
for power, transmit gating, and wake GPIOs, along with common touchscreen
attributes.

> diff --git a/Documentation/devicetree/bindings/input/oneplus,pogo-keyboar=
d.yaml b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> index 0000000000000..9055ececc04cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml

[ ... ]

> +required:
> +  - compatible
> +  - power-gpios
> +  - tx-enable-gpios
> +  - wake-gpios

[Severity: Medium]
The commit message states that the MCU protocol has no way to query the
touchpad geometry, meaning the driver strictly requires the touchscreen-siz=
e-x
and touchscreen-size-y properties to function properly.

Should these properties be added to the required array?

Leaving them out might allow incomplete device tree nodes missing the
dimensions to silently pass schema validation, which could then lead to
runtime failures or misconfigured touchpad coordinates when the driver prob=
es.

> +
> +unevaluatedProperties: false

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8c4e1080af94..d81e400059ced 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS

[ ... ]

> @@ -20154,6 +20154,12 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-dev
>  F:	drivers/usb/misc/onboard_usb_dev.c
> =20
> +ONEPLUS POGO-PIN KEYBOARD DRIVER
> +M:	Yibo Wang <wyibo6109@gmail.com>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/input/oneplus,pogo-keyboard.yaml
> +
>  ONENAND FLASH DRIVER

[Severity: Low]
This isn't a bug, but should ONEPLUS POGO-PIN KEYBOARD DRIVER be placed aft=
er
ONENAND FLASH DRIVER?

Alphabetically, P comes after N. Breaking alphabetical sorting in the
MAINTAINERS file can cause script warnings with parse-maintainers.pl and
may lead to future merge conflicts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010143836.1738=
83-1-wyibo6109@gmail.com?part=3D1
