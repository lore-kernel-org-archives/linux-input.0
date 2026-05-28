Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA8344D8D;
	Thu, 28 May 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957147; cv=none; b=Z69dLlJlPVO/K/dYL+Q9JuigMxtcjVZjw5pg6Jxl3h0H5gjOqL4LDEe9Ra7Lo8oGB+QNuhwLFuaxoC4SmL3pzYCuNi81gyPNyZixOBfvZXnOufkgUPkWRQqbSvwrIAvZGNkU789n0IcD1kAwAedGasfG0Ho3X38YK3Qd/uXoYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957147; c=relaxed/simple;
	bh=xTaxgXVDOEjWvj/t9hgofz0D/HXig+NGcOpEW3rh9rU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tAAustXVYeYD//bG7O8v4LwP/zowM8V5vGH86IsUvyOeByE8z40Jb80r9a0wAOMcfx6zvlydueo/M5sBiPP58VfyzhHVT6LDazqBewHFWhiPwcH+neKFtWTu074CN5EC/ECqmp8H9QOsexo4zorpX53YePYuOf51q8YhfCgaBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKtt6Dm/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKtt6Dm/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5101F00A3A;
	Thu, 28 May 2026 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957145;
	bh=QERFqHwvC9tvCW/3t2EVpneYAbmp+KkezdEANxkuqBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CKtt6Dm/gFMKX01g+uI+Tc6x3EFA0VbTyVHjj8TRb/cuEEGk8zK5/QkUlGaEnui7p
	 8GUgy91Y5JjVn0MuM1rOpaWC8Mkev9ETYk3f0RgFS6NGkIeKgzJNhJArBg5fco6Gn1
	 eU0Rdavbig3tl8UhJq/ERds2YqIPhnNVQSZlpU+Boxv3HuOCfZYEv++vvrpIZrk+dm
	 pTW0CHNng3Cu3wCKArNI/QSSuLlLcW8DGj34L1YWPET0Vji8jCUtffd3O6uT+osnqz
	 HsVOri2byg1EIVSPZP4DpmcZrHftol6LfHNPkaGYkRQ673Skt3GkmNZHjWzG1QtKWN
	 2qYBxXVjXdSFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: Input: Add Wacom W9000-series
 penabled touchscreens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hendrik Noack" <hendrik-noack@gmx.de>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260528074818.12151-2-hendrik-noack@gmx.de>
References: <20260528074818.12151-2-hendrik-noack@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:32:24 +0000
Message-Id: <20260528083225.3A5101F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Vendor-specific property 'flash-mode-gpios' is missing the vendor p=
refix.
- [Low] Node name 'digitizer@56' in the example should be a standard generi=
c name such as 'touchscreen@56'.
- [Low] The binding file is named after a specific variant ('wacom,w9007a-l=
t03.yaml') rather than the first compatible string ('wacom,w9002.yaml').
--

commit d38ecd0efb12cc8efc9000f9c78e8a14387d40c6
Author: Hendrik Noack <hendrik-noack@gmx.de>
Subject: dt-bindings: Input: Add Wacom W9000-series penabled touchscreens

This commit adds bindings for the Wacom W9002, W9007A LT03, and W9007A V1
touchscreen controllers. These controllers differ slightly in their return
message formats.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/wacom,w9=
007a-lt03.yaml b/Documentation/devicetree/bindings/input/touchscreen/wacom,=
w9007a-lt03.yaml
> new file mode 100644
> index 0000000000000..6d1da6a435d39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/wacom,w9007a-lt=
03.yaml

[Severity: Low]
Should this file be named wacom,w9002.yaml after the first compatible strin=
g,
rather than being named after a specific variant?

> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---

[ ... ]

> +  vdd-supply: true
> +
> +  flash-mode-gpios:
> +    maxItems: 1

[Severity: Low]
Does this property need a vendor prefix (wacom,flash-mode-gpios) since it is
hardware-specific?

[ ... ]

> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        digitizer@56 {

[Severity: Low]
Should this node name be changed to a generic class name such as
touchscreen@56?

> +            compatible =3D "wacom,w9007a-lt03";
> +            reg =3D <0x56>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528074818.1215=
1-1-hendrik-noack@gmx.de?part=3D1
