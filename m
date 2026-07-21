Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9837BE75;
	Tue, 21 Jul 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633383; cv=none; b=SMFT4FPWXwVVfq5RxFo1cA5qOf5xe51n6jo3wgYeZS/lcU75ghwwTaBn9F4gJ4Yu2N4r41VAQS3WbfA86UPF4b/GqmWDWyi5GzF3NwaE1E0Xe3ShApiZpA3/L52TY+0yyOQsiNBSmC1CX8FTN+c1cle7yfwPHhZV1L1nHIrZ6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633383; c=relaxed/simple;
	bh=MU1/EUDyWtbMoFfhZ2juuSvXZvG0pugYlJPBFI9Xnzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y6ehP6Q8goCtl2K/e8aeB48lYX/HBSzM1AldkgDWIPZGce8jefvNKb+ekiynlIqs1pB+FTLILBbO5PxUsiG8d8dj+IWYxrBWi6cPapKKcRrGEADiC8S5Mu3pTSeejENNHIGWYpOl25pmnWkrO1KjYfUmH+aDdC2OONQfH3Y0I6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyr1wqhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyr1wqhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB511F00A3A;
	Tue, 21 Jul 2026 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784633381;
	bh=t6xHG5vDB/uOSrEsDNOgnHVxiTWU3BpUyvABOs9c/mM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dyr1wqhSojRwQXeexjnLHDOJ8FEwXLymYq6jBZbw8vzhyhupSXc3tXMp09qEtSHPi
	 Py8O6IG8aRCamhGyMj8EU4Ct85b5RKf1jBzUse2MVvQnmaZ9ANSzek+A1opEThaLjv
	 apSzZ7YdIakYnDO/V55teA1ta/WFywucbwQH7wKQt6cTTTWK833E2H9kYc5IbnzJ3G
	 Y4gPy/ycdL9TPo6rjsRMA92cyME3GsM5toThrwRqgsDQEWcU+P3znQRKlW0BPNbKhi
	 aDBHtEUjtYIjEisb+eQvUW38uO/vqkeF57rv3LfmpNIEVBIQvX80rnMkqfB4RWexSP
	 w1Xj4zp4jzquw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS65217
 to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: linux-leds@vger.kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260721112133.70382-5-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-5-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:29:40 +0000
Message-Id: <20260721112940.8DB511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The patch converts the TPS65217 backlight binding to a comprehen=
sive PMIC schema but fails to delete the existing `regulator/tps65217.txt` =
binding, resulting in duplicate bindings.
- [Medium] The binding adds interrupt controller capabilities but omits `in=
terrupt-controller` and `#interrupt-cells` from the `required` list.
--

--- Patch [4]: [PATCH v3 4/4] dt-bindings: leds: backlight: Convert TPS6521=
7 to DT schema ---
commit 280c44c9d977e107c7e28a27785e5c9c3dbde99e
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: leds: backlight: Convert TPS65217 to DT schema

This commit converts the Texas Instruments TPS65217 backlight binding to
DT schema, adding child nodes for regulators, charger, and pwrbutton,
as well as documenting interrupt and shutdown controller properties.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217=
.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> new file mode 100644
> index 0000000000000..4d2f4dbd2d52e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ti,tps65217.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TPS65217 family of regulators

[Severity: Medium]
This schema defines a comprehensive PMIC with regulators and chargers
rather than just a backlight, but it is placed in the leds/backlight
directory. Should this be moved to a more central MFD or regulator schema
location?

Additionally, it appears the existing regulator binding documentation at
Documentation/devicetree/bindings/regulator/tps65217.txt was not deleted
in this patch, leaving duplicate bindings for the ti,tps65217 compatible
string. Should that file be removed as part of this conversion so schema
validation is not split and inconsistent?

[ ... ]

> +  pwrbutton:
> +    $ref: /schemas/input/ti,tps65217-pwrbutton.yaml#
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg

[Severity: Medium]
Because this binding allows the device to act as an interrupt controller,
do interrupt-controller and #interrupt-cells need to be included in this
required list?

The device tree binding guidelines indicate that when hardware provides
these capabilities, the corresponding properties must be required so
incomplete device tree nodes don't silently pass validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721112133.7038=
2-1-egbostina@gmail.com?part=3D4
