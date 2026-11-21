Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265314;
	b=dUnEKxJ3Y+qFRoVnhB6df6LAklTpubfUZvVhIvoC2lcHPlCLtczoXAnBZhKBQXWuwU58
	 77dHASqO9KTQCpSyT6lipkjITHW1r3h40RBKF+376kAuRSEVKT8GwZuHGZmJY4z1u0SA8
	 +mf/TWFjZrurM6PKzSH/fDfRDBOgiVZEREKBUDiupLVBQEDp6c61A1PXLXEsTuVWtRLdu
	 BBhs3uYSLP7x+Ic0ljYLFZNS0jXWuPBYmuQLvubBNZ8znmFqcH2+RnN4w0Bp6y4QwNOvO
	 OpwxfnwAFHRCIxuONL1a9rF8ZgA7gmUx4tsfm7yUIStr2TIoo15o7nTSX22V0lWoAWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265314;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aOQ4WbZ0tzKJl0YWXeT27ZzpO8vn/eAdDKLmFw+vhoQ=;
	b=fZXHgA7N6z0m9nyPJlu3hzTnJcXG2mfGWiK9MjJTodIGgxnAAWuqgalw0/l3cXOstQfC
	 OILaaclhSoyRuDzVqiSN24pOOMBkyQtVRc85ZilScNoKxbo9JZsAWSANnNIGau6TEYYhv
	 LJcLs9LZICAgnnm8wuHPh0UjiIkZkaEGzASbKzPlAv4zIWgC/jFoyBP4wjpa8Ao9iG2e0
	 B/EJiEB7N5O+/NMUiwzkLtgKN5cMK2A9Nc4NADdLVTOS0TBp+i93EZoRVDWg428NtQjUD
	 gIeO6mbeO6/LBo5hb4/HEMKsWF6Fqw28TWXFYmEchT1tyEU9g6Auq6vhus/aEhybKfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WU1pPNtG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C874606A320;
	Sat, 21 Nov 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WU1pPNtG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111511F000CA;
	Sat, 21 Nov 2026 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795265314;
	bh=aOQ4WbZ0tzKJl0YWXeT27ZzpO8vn/eAdDKLmFw+vhoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WU1pPNtG1ep14uHM7muC1ukgXuUx/vQ91UA8ZndbPbxdO1S4KwHboCAyyxkidghGQ
	 l5pRNvkMztcIzqOat6j/pRLUVh4T0tG8s5liotjwVPfmQOpftomYgsR+2lTOdDvkdc
	 GH3vykgO/2FiuSZQEK8ndsI9A7wXggym6fxjr0PfinIQ4VDxdsXai3DobUJUO+uVO4
	 Ec8jQKqwXqTSTV2RBsD1IlsHEojbAn2Qbv/wTs/BPkyhJbxX70kaVCaI2wdgz3CU80
	 5dIRK6p9OU6G0ccY1yYDnXHKsW1o+y9KNq0mY8PP7MTOh7jVutde8tWN7TYhecLIXq
	 ghvNRqWdCT26w==
Message-ID: <sashiko-outbox-227027@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 05/13] dt-bindings: timer: add SiRF AT550 system
 timer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuugo Yoneda" <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261121-at550-rfc-v1-v2-5-b0309d0789b2@gmail.com>
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-5-b0309d0789b2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 12:48:33 +0000
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
- [Low] dt-bindings: timer: interrupts listed before clocks in
  sirf,at550-timer.yaml
--

commit 7d468a2e01539543c583a2c3ed0d939b2fa94299
Author: Yuugo Yoneda <yogo.0917.sabu@gmail.com>

dt-bindings: timer: add SiRF AT550 system timer

This commit adds the Devicetree binding schema for the SiRF AT550 system
timer and lists it in MAINTAINERS.

> diff --git a/Documentation/devicetree/bindings/timer/sirf,at550-timer.yam=
l b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
> new file mode 100644
> index 0000000000000..6611dabe7f554
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
> @@ -0,0 +1,51 @@

[ ... ]

> +properties:
> +  compatible:
> +    const: sirf,at550-timer
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: Match channel 0 interrupt
> +      - description: Match channel 1 interrupt
> +      - description: Match channel 2 interrupt
> +      - description: Match channel 3 interrupt
> +      - description: Match channel 4 interrupt
> +      - description: Match channel 5 interrupt
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    timer@90050000 {
> +        compatible =3D "sirf,at550-timer";
> +        reg =3D <0x90050000 0x1000>;
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <0>;
> +        clocks =3D <&counter_clk>;
> +    };

[Severity: Low]
In DT binding schemas and example nodes, clocks should be listed before
interrupts (compatible, reg, clocks, interrupts) in properties, required,
and examples.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-at550-rfc-=
v1-v2-0-b0309d0789b2@gmail.com?part=3D5
