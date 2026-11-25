Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573170;
	b=N8ARq3cGtvS+W5b7bXmBOkdhkJxnY3HyfVNGRpCZ5rCXzbKbxifwkC5OwZI6kHU+UBL9
	 bk9dEOjXV19d1L98BCIZmFCqjvrOFAUOv/UJ6rikZEzgyBJICqFfQrZPBPwP0bzkvKtat
	 DPfz8Figc8DQSCG/9CaggEYyN9zigSqh+9s720PojL4vSrrYCJY/gZEnYWCWiTsIMzQvD
	 fJTWpDbvEoWMlito993XZTtHK6tshJKKCOnODiQq4dZciyX4KgtFBzHYJ4QbnZGJOXYqB
	 6JhtAQHe7jmFpJGql1yuN7EGhJ4cPLmPhNi7q9G1lLY/57BMCGap0ptYSOCg2S455vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y6lFZz4Fpy3uKtsMrfEHfrJltL2TqjLKliIhVZ69M0k=;
	b=dSqshogTLdKNa0ZAR5bLTD+1v9YjsCPRJcScY7U5kNbVzNNViFsRKKth39/LIfXWyvKi
	 n2YDyYjt5np3XbdHc4TysgK1FIaf6k/UmQ4F+Zp2XzRtUxN5gkFZWqRpMrt2UMyBqTX2+
	 9LxaXDRkTsV9/dP/jyTn9cpqw1Br2qFcos4sXl7kCJXes9E3mwCYFkdNW4h+rdjOmloe6
	 y8RPZnU4Yt5mLDx8xgCiHyx8/vmFYz3n3FoFaDYt6ESXJPhLgjunEgTEZdkLaLiCLi9Oi
	 Opzps/idt0GA+JxlJDXmG++yANd1a4wy9n8w9bFg3tzov299etPiNPVQ+ketG1U6l4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cl+ar3mT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8B606A321;
	Wed, 25 Nov 2026 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cl+ar3mT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D11F000D0;
	Wed, 25 Nov 2026 02:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573169;
	bh=y6lFZz4Fpy3uKtsMrfEHfrJltL2TqjLKliIhVZ69M0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cl+ar3mTIiDw0bVLHuC/pzi703kn0cy1BUef/AocukAuAfjPp0rP+l4SySMu+2tU5
	 0XxVD0nqkvRxRWT4ca7ayP7d1K+cMCYVd6/2MUvRPtlcTScWn8zlB/NNRfUfp4HjEE
	 N0lg4tB8+T+bNeijzSx6b0ViR8OE7gkvgwf12hUyI5scGg9WSfiPEfaH0IKbh318Gg
	 DO3Cm7fgXhJfJvag/5n/O+C9O+Bd4H/VH55H70L71R6bPkxc8V/zbsynMaPZb6Zzwu
	 zwoUlW+TYF+BSKasvWfNJwVtI536l67POApavSkQhjnAmlLKaM8JQ4TTovem4DSL8p
	 36Bd5uGw8PPuw==
Message-ID: <sashiko-outbox-232401@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: backlight: add VIEWE I2C backlight
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_33047574BCFD03DA2AE57B9890EB09FE7705@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_33047574BCFD03DA2AE57B9890EB09FE7705@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:19:29 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Low] dt-bindings: backlight: undocumented vendor prefix viewe in
  compatible
- [Low] dt-bindings: backlight: schema filename mismatches
  viewe,7kf82-backlight
- [Low] dt-bindings: backlight: redundant binding in subject and empty
  changelog
--

commit b74671fa2d89ece52daffc3be1232b5909e8c227
Author: Hefei <3066883572@qq.com>

> dt-bindings: backlight: add VIEWE I2C backlight binding
>
> Signed-off-by: Hefei <3066883572@qq.com>

[Severity: Low]
The dt-bindings: prefix already indicates a binding patch, so the trailing
word "binding" in the subject is redundant.  Could you drop it and add a
commit message body describing the hardware?

> diff --git a/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-b=
acklight.yaml b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-=
backlight.yaml
> new file mode 100644
> index 0000000000000..9be4bc93087ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backligh=
t.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/viewe,i2c-backlight.ya=
ml#

[Severity: Low]
Should the schema filename and $id be viewe,7kf82-backlight.yaml to match
the sole compatible string defined below, as required by
Documentation/devicetree/bindings/writing-bindings.rst?

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: VIEWE 7KF82 I2C panel backlight
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  I2C backlight MCU used on the VIEWE 7KF82 DSI module. Protocol is devi=
ce
> +  address 0x45, register 0x86, brightness 0..255. A discrete MCU part nu=
mber
> +  is not exposed on the FPC silk; the binding is therefore keyed to the
> +  module.
> +
> +allOf:
> +  - $ref: common.yaml#
> +
> +properties:
> +  compatible:
> +    const: viewe,7kf82-backlight

[Severity: Low]
Is there a patch registering the viewe vendor prefix in
Documentation/devicetree/bindings/vendor-prefixes.yaml?  Without an entry
for ^viewe,.*, make dt_binding_check and checkpatch.pl fail on
viewe,7kf82-backlight.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A3BF23A8B6E=
3691F0D567ADF8B84194F4408@qq.com?part=3D3
