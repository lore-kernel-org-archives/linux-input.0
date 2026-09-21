Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1830D3E5;
	Mon, 21 Sep 2026 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033814; cv=none; b=A6+Bynf5IM2imlJed1ljUCPJWvudO1Q1lYn2MAPF+2AIjQ5TaZgXbqE7c7kYzbtYTSmzozToB0I+aOflUUMfFqYcgrFzVhrFQ7Pq3fqtL46zdHOnq2FtFkPUnMtsfHP8jUfa9Yq23cgHmf3vlJ+TextWdnjGsWa86jWyFy0PwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033814; c=relaxed/simple;
	bh=3Q9pdgkrdk6mdLZBR1rc2e02l+AI2ALJjxiBRa/ybLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rbIhtlR2WItb9zmsHKUdjqT6GjCAAp0RN8AhRIqMoI6tz3UNcLr4mHPSJfiiw2+UDVscPc0VDxQxF4dLIFyC7UDeug+J6Wr+WnKgAE+aHzjN4YMUhV1FXz0xNWRrzOTDgR81pSY3RwVynNjYEkv6M2hoYEk8Cq6cc36psVVhwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/QzSmAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/QzSmAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351B91F00893;
	Mon, 21 Sep 2026 23:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033812;
	bh=ygI2ai84Knhk5ozhg3KmcGVQadBxiin6ncXyTHgH6qI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/QzSmAbyhpYIomNY2uzUSzTzKwXhyWtV2yGOYIhzEzfNEEh0c1ayBLawn1sEqHAe
	 0IlA8f9XScXkunR/Toz74NP+dXcQTwuFPaxcqcFSeHDDz67jKqon2gbxMYTcLNMvBC
	 gjYSxs2YDnFyn04oE/pSMf6E0Frrb/T6b1RFTAM0Iyil+njqTfAbgJXYxtoRBEcO4v
	 V5+NC/Fc7vRlf2cvak3yBwat2lqTShoqgLcz1MIuP8HJgXeYivBb90ZOXyqVMuazs2
	 awxCLQXNq82AE3MsvUrxxRg3dP1VsG20DGJ24DHDw0MR03AxYWoPhaJQk3hg2U4K3d
	 +mTQo13QtfLCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: input: Add AD7147 CapTouch schema
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260921232731.3134965-1-robh@kernel.org>
References: <20260921232731.3134965-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:36:51 +0000
Message-Id: <20260921233652.351B91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dt-bindings: compatible string inappropriately encodes Linux dri=
ver name
- [Medium] dt-bindings: schema omits essential properties for programmable =
layout
--

commit e423e496cad8df9cf9b56b68a72e3590fb50e497
Author: Rob Herring (Arm) <robh@kernel.org>

dt-bindings: input: Add AD7147 CapTouch schema

Add a schema for the Analog Devices AD7147 CapTouch controller used by
the Microsoft Lumia 950 and Lumia 950 XL device trees. Document its I2C
address, interrupt, and optional vcc supply.

> diff --git a/Documentation/devicetree/bindings/input/adi,ad714x.yaml b/Do=
cumentation/devicetree/bindings/input/adi,ad714x.yaml
> new file mode 100644
> index 0000000000000..8351c28147ee1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adi,ad714x.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/adi,ad714x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7147 CapTouch Programmable Controller
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +properties:
> +  compatible:
> +    const: adi,ad7147_captouch

[Severity: Medium]
Does this compatible string inappropriately encode a Linux-specific driver
name?

The correct hardware name is adi,ad7147. By defining adi,ad7147_captouch
instead, it seems to exploit the Linux I2C subsystem's fallback match to
the existing ad7147_captouch I2C ID in ad714x-i2c.c, avoiding the need to
properly patch the driver with an of_match_table.

Because Device Tree bindings form a cross-OS ABI contract, encoding a
Linux-specific abstraction leaks Linux internals to bootloaders and other
operating systems, establishing a permanently flawed ABI for this hardware.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vcc-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false

[Severity: Medium]
Does this schema omit the essential properties needed to describe the
physical layout of this programmable controller?

The AD7147 requires its physical layout (number of sliders, buttons,
wheels, touchpads, and stages) to be configured. The Linux driver (ad714x.c)
currently relies entirely on struct ad714x_platform_data for this, but the
provided schema completely omits any properties or child nodes to express
this physical layout in the Device Tree.

Because the schema enforces additionalProperties: false, any attempt by a
board device tree (like the Lumia 950) to actually add the missing but
essential configuration properties will be strictly rejected by
dt_binding_check, making it functionally useless for platform initializatio=
n.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921232731.3134=
965-1-robh@kernel.org?part=3D1
