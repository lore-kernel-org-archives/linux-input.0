Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921717;
	b=CfytQ/FkjH6oN3LAkhGsCbklq3OJ8XfS3Jy5nuSlc0FswxtOcBpdhVsiWONfPeB76om4
	 vE028zuVfl1m3r2ajXkiXi12vEISI7kBlSuppR4yxUYLYP+FFy0ocugesbAhh1oYOY48d
	 iT1vyeb6lEL8LG2iB1zwVgm2Lj5V3avIAabb3BgAq8wjl6u+kflIzsxG1+YZ/DYL2YujG
	 IywPpinL+J5AsBbRxeODM4GmsSlylRuuKNbsLnT0b+Kd+CirL7c+rrQ+j60GoQ09swYaF
	 uZ1v8Tz/HQatuVa0+rz1W0unxlv/dsSG4X19UnxVO4SSu9DXeS82YVVNiUMquME/wbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921717;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fBFjmkON8jYjHlOo/RYAnQzCaJbcqc1Y4SIpfBAajuQ=;
	b=T5X4gY4lDFLzeExUN9Z2eEW+mMoHznYnvtIgE0IK/rCcxQnNrVM3eSSF76EJXQlWl+pw
	 2TMmOo8Q03aNDk0Rs0pPNCrmVdImyS9vqLlKHss3bZzkn8TftZn6lgmt3Bjwv2dKIw6S1
	 xtBTBBkq6l8s/yGw6DMyzhCeb58yNasflA3XPYMSSwVunj67+dzUVtx3eYC8C3p7lWB3c
	 p2klP7i1XXPHa8QlzMr3miWi0pr19UrZ8mW0a92FRXB7f8gx3kuzayG1e88LjvUWf8a50
	 zqGLpHM37d/8rVVytTqx4l7TdG57IBjYbH/s3Su8rDKU1+j2tvPE2Ex7F3JY8+2Plpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R17dOf5I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD0606A329;
	Tue, 17 Nov 2026 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R17dOf5I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9131A1F000C8;
	Tue, 17 Nov 2026 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921716;
	bh=fBFjmkON8jYjHlOo/RYAnQzCaJbcqc1Y4SIpfBAajuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R17dOf5IshNIzwJc7rhJfpaswx7D1oe+99Fgky4k9l1XmVrDTwREKOp/8qQxloK6V
	 +suqu+41hvL6R4qhKF2TYqebWNJ0yCPKo7dKhkFDZYBLAttArJGIE2BQOADA+Gy01h
	 WDpLhSUOPYsb21JIWFV+Hep/0kjVQggZkXUtcSemBiaygkmPWPWUhfoosl8YflxBjI
	 q/9fdXJiKDWyS1nsG5uXJt2SVthBYw70qQ875pqZD/Wq8DpLFZmTZveVZsX2G3FxBf
	 dTzRjLVN6qJuPDgzg6+o7izGCzqdRK8aQVehWCg6tNakqHl6f7LehcDrn4qR/8wlnW
	 OZYrfIlvcvBaQ==
Message-ID: <sashiko-outbox-218867@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/6] dt-bindings: add SiRF AT550 and Yupiteru
 YPL514si descriptions
Reply-To: sashiko-reviews@lists.linux.dev
To: yy-Local-LLM <yogo.0917.sabu@gmail.com>, devicetree@vger.kernel.org
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261117-at550-rfc-v1-v1-1-5879573cb825@gmail.com>
References: <20261117-at550-rfc-v1-v1-0-5879573cb825@gmail.com>
 <20261117-at550-rfc-v1-v1-1-5879573cb825@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:21:56 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] dt-bindings: sirf: non-human handle yy-Local-LLM in
  Signed-off-by and maintainers
- [Medium] dt-bindings: sirf: AT550 schemas encode driver and firmware
  limits instead of hardware
--

commit 2d786eae9bbdb4eb26a31d6594cf77ebf8a38f4c
Author: yy-Local-LLM <yogo.0917.sabu@gmail.com>

dt-bindings: add SiRF AT550 and Yupiteru YPL514si descriptions

This commit adds Devicetree binding schemas for the SiRF AT550 platform,
touchscreen, interrupt controller, SDHCI controller, and system timer, along
with the Yupiteru vendor prefix and a MAINTAINERS entry.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sirf,at5=
50-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550=
-ts.yaml
> new file mode 100644
> index 0000000000000..0458db2419c3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.y=
aml
> @@ -0,0 +1,36 @@
[ ... ]
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: sirf,at550-ts
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
[ ... ]
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sirf,=
at550-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/si=
rf,at550-intc.yaml
> new file mode 100644
> index 0000000000000..ec68afa805e94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sirf,at550-i=
ntc.yaml
> @@ -0,0 +1,46 @@
[ ... ]
> +description:
> +  The AT550 controller routes 64 level-sensitive interrupt sources to the
> +  ARM1136 IRQ input. Each source has a fixed active level; the single in=
terrupt
> +  cell is the source number. Firmware FIQ routes are not exposed by this=
 driver.
[ ... ]
> diff --git a/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml =
b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> new file mode 100644
> index 0000000000000..7129aaeec2bb7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> @@ -0,0 +1,51 @@
[ ... ]
> +description:
> +  AT550 removable SD controller. Initial support uses programmed I/O and
> +  firmware-configured clocks and pin multiplexing. DMA address translati=
on
> +  and 1.8 V operation are not described by this binding.
> +
> +allOf:
> +  - $ref: mmc-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: sirf,at550-sdhci
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +  bus-width:
> +    enum: [1, 4]
> +  no-1-8-v: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - no-1-8-v
> +
> +unevaluatedProperties: false
[ ... ]
> diff --git a/Documentation/devicetree/bindings/timer/sirf,at550-timer.yam=
l b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
> new file mode 100644
> index 0000000000000..d1465d438d10e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml
> @@ -0,0 +1,47 @@
[ ... ]
> +description:
> +  A free-running counter with six match channels. The Linux driver uses =
the
> +  low 32 counter bits and match channel zero. Firmware configures the di=
vider
> +  before boot and supplies the resulting counter clock. A running watchd=
og
> +  must be disabled by firmware before this block is handed to Linux.
> +
> +properties:
> +  compatible:
> +    const: sirf,at550-timer
> +  reg:
> +    maxItems: 1
> +  interrupts:
> +    maxItems: 1
> +  clocks:
> +    items:
> +      - description: Counter clock after the firmware-configured divider

[Severity: Medium]
Should these schemas describe the AT550 hardware capabilities rather than
the current Linux driver implementation and firmware handoff state?

In sirf,at550-ts.yaml, omitting interrupts and clocks while setting
unevaluatedProperties: false causes dtbs_check to reject Devicetrees that
describe the touchscreen interrupt or peripheral clock, since
touchscreen.yaml does not define those properties.

In sirf,at550-sdhci.yaml, clocks is similarly omitted under
unevaluatedProperties: false, and the optional board property no-1-8-v is
made required on all nodes even when 3.3 V-only signaling is implied by the
sirf,at550-sdhci compatible string.

In sirf,at550-timer.yaml, the clock input is defined as the rate after the
firmware-configured divider even though the divider register is internal to
the timer MMIO block, and interrupts is limited to maxItems: 1 despite the
hardware providing six match channels.  The descriptions in
sirf,at550-intc.yaml, sirf,at550-sdhci.yaml, and sirf,at550-timer.yaml also
document Linux driver details rather than the hardware blocks.

[ ... ]

> diff --git a/MAINTAINERS b/MAINTAINERS
> index d738990161bd0..6c3702cd8915a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25847,6 +25847,15 @@ F:	drivers/gpio/gpio-siox.c
>  F:	drivers/siox/*
>  F:	include/trace/events/siox.h
> =20
> +SIRF AT550 PLATFORM
> +M:	yy-Local-LLM <yogo.0917.sabu@gmail.com>
> +S:	Odd Fixes
> +F:	Documentation/devicetree/bindings/arm/sirf,at550.yaml
> +F:	Documentation/devicetree/bindings/input/touchscreen/sirf,at550-ts.yaml
> +F:	Documentation/devicetree/bindings/interrupt-controller/sirf,at550-int=
c.yaml
> +F:	Documentation/devicetree/bindings/mmc/sirf,at550-sdhci.yaml
> +F:	Documentation/devicetree/bindings/timer/sirf,at550-timer.yaml

[Severity: High]
The commit Author, Signed-off-by trailer, MAINTAINERS entry, and the
maintainers list in all five new binding schemas use the handle yy-Local-LLM
instead of a known real human full name, which is required by the
Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-at550-rfc-=
v1-v1-0-5879573cb825@gmail.com?part=3D1
