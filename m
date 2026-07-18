Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DDE1FC8;
	Sat, 18 Jul 2026 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412270; cv=none; b=PsKg2uzN+anYqaAdAxQNjkkG4oUxJPr3DCTeM1QojYxTS4PexMnXeMPkLjgiUTfGPkdwL9+z5ksBm4Otu/6N0X/XfH9JKdtWTK2yYatuLze6nQm0uWXbzA8elJa46Xkq2EQ3aSv1T4iOhk/VX+1W17BAe1cEABEse6uFHxfL3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412270; c=relaxed/simple;
	bh=bZhN8OOlRjUK8xhIIm2slfnXqQJdDxMB2i8u6hPZ0as=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hDpuu51ye05r4dlMhwQpRfOEUqpIWNHuumPrJyjV66RkkqMsvonTV84vw+6OR8L0SjXTLwtU3+dz7RvfDRvnUcYX9WtytZsjAToODaMUT8Qj05+DLjhzRtHXksA3FFQUPPkCf6Mr1/3dvcjztDB0z2zcW2Gc84nSAVkMQcQpwSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzSanViu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzSanViu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91301F000E9;
	Sat, 18 Jul 2026 22:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784412269;
	bh=t9fJdyKtbTjoZvZ4Qaab9SXbJza23w5VJsqQLQ/nc8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SzSanViuseiziUGZFLn3q3TofU500fXUMvp9n4U1XzcTh1yZzBpPHQvndhAwY11Dq
	 2DS8rWvhNRuwzwIc5h92Agq6VrxCXNDzX3/c0GYxaUy0qHhuYj+zpwnvPicxagWNzr
	 +n72LZ1fXCyO4Vn63M8bBOUPPlg+mYwWKS9AdtcE5O6OrNWtAjbe8AN19+7j8h0esE
	 AuDWOGN/RKZoteYvdsOFooC+xz+ILQxjVpqBpsvV77A+PwgWcYB7IZwSJZyflADfKs
	 s15oaGYHo6FuTPG4zha1AkhOZGh4a77O0pkw8VkHxfyJ45v6wCsL6+dhe/iTsupWMe
	 faizFYsp7mQyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217
 to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org, linux-leds@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260718215632.3295049-4-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-4-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 22:04:28 +0000
Message-Id: <20260718220428.B91301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Stale and conflicting regulator text binding not deleted during =
schema conversion.
- [Low] Missing `required` constraint for `reg` property in regulator child=
 nodes.
--

--- Patch [3]: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS6521=
7 to DT schema ---
commit 0671f0f93114029deaa2c3fee6b27ad8abd2cb2d
Author: Eduard Bostina <egbostina@gmail.com>

dt-bindings: leds: backlight: Convert TPS65217 to DT schema

This commit converts the Texas Instruments TPS65217 backlight binding to YA=
ML
schema. It also documents missing child nodes, interrupt properties, and
updates regulator names to match what the boards use.

> diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217=
.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> new file mode 100644
> index 0000000000000..9586e08f1b1fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
> @@ -0,0 +1,123 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/ti,tps65217.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TPS65217 family of regulators

[Severity: Medium]
Should Documentation/devicetree/bindings/regulator/tps65217.txt also be
deleted in this patch?

The new YAML schema defines the full MFD device, but conflicts with the
undeleted regulator text binding. The old regulator text binding expects
regulator nodes to be named dcdc[1-3] and ldo[1-4], while the new schema
expects regulator@[0-6], which could cause validation inconsistencies.

[ ... ]

> +    patternProperties:
> +      "^regulator@[0-6]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          regulator-compatible:
> +            $ref: /schemas/types.yaml#/definitions/string

[Severity: Low]
Does this schema need to specify the reg property as required?

Since these regulator child nodes have a unit address in the pattern
(^regulator@[0-6]$), DT validation could incorrectly pass nodes that contai=
n a
unit address but lack the mandatory reg property without a required block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718215632.3295=
049-1-egbostina@gmail.com?part=3D3
