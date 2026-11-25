Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573355;
	b=hPOHRVBOZBzT1hkdyrQW59Vngwr4GNnKI3IeK4aOWm9MiRigkLp97fWmytJA/xf/Vo03
	 nEVynRUvzA1B5uQHl5bcg4fJMQwTMm1/2h/OvvPD3SrYftGH3331pusEVTaYJh18HfPXI
	 /6Fgqyw67RIVeiOu7FbskYjNyOFa2GL175t9jw/2d99tQ4El8O/4vGmf4b43rLi6I/r4C
	 LvkNNml0ULGLGd65MJVQtdGVmakiWgK0SDGKs1jF2Ch4rxqOv1etHXjLY131gtDYnZ8eK
	 o3GIW8YgYfjVsw/rPi/+Kbop82DKodgTYuRcJcRzkrRvByOqGIghb5H5lB6Qu2p80lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lfG5kzfz0wdgX84/eQurjgqv/6koU/i9+timkfE8dC4=;
	b=lAI6AqSBifPoMAcEKhfNjZelk6UCWBMkGcSyKTuZ8cBO4nN5fysXnbtaI/0l+Zso+A3v
	 fV3lA/jQ2NFco1a5mIe3jpzcld6DPWxxZ+SF29ULo/MiwqY09b6rhF82URNwZrjUhmFVK
	 OxCutXTKpdkG4tNgyrvb0++rHFH60sP/iJKKkluhWyLHJRA34lzTCb4HOII+ETKbN/dWM
	 WNwz8Hiz1BcD8ZV2WPFUgrgrjBYL/qYmq76heDb04GcQNvkl9yf69qXrwPDvMGJbRpi/t
	 rxMZtGGzKP5bMBpkrcgDNaz0aQELjBbA3xRdNKzhFrCaTXGMePqQYClPvkFNSpmDLTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BKt9jBm/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C8F606A31E;
	Wed, 25 Nov 2026 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKt9jBm/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14531F000CA;
	Wed, 25 Nov 2026 02:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573354;
	bh=lfG5kzfz0wdgX84/eQurjgqv/6koU/i9+timkfE8dC4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKt9jBm/yXF62tRIzNdwXyhkW675bOCzTUz80CL3dXj+JmsqC8UOzNfFkQEpwmGGR
	 7SBzIe4QWjLC8OtcIFUm9453ezjWvtNnTwa3GGRwNNrmSVEYy5l9Rdw4lAaUd0tYcc
	 XuCQoqaranzFTbXypFUb7xXDLzKXOywhJTKGgS2B065WXSNJ/TRh2z9bjWrJEBArxN
	 o75zSz0dqGQ/3BAnBo+f/qzz5UJXIogrn9dG8iPmBddUVricu5z6kMjcT8TN18pfHn
	 L8J69LPgesMgyELzIvQKk19l4PZ3dS/SoGjCjnKgX4IypAOWhwMHZw1WO0WvxwNHo2
	 o6NDD8CikQ/rA==
Message-ID: <sashiko-outbox-232406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] dt-bindings: input: add Jadard JD9365TX
 touchscreen binding
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_50B2DF6754BBF1EA8F2CABA66F0342A8A707@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:22:34 +0000
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
- [Low] dt-bindings: input: redundant binding in subject and empty
  commit message
- [Low] dt-bindings: input: jadard,jd9365tx: inconsistent supplies and
  missing irq
--

commit c7b2ac3eb48ad13c122965f49f5eb842ca510a8c
Author: Hefei <3066883572@qq.com>

> dt-bindings: input: add Jadard JD9365TX touchscreen binding
>
> Signed-off-by: Hefei <3066883572@qq.com>

[Severity: Low]
The dt-bindings: prefix already indicates a Device Tree binding, so the
trailing word "binding" in the subject can be dropped:

  dt-bindings: input: add Jadard JD9365TX touchscreen

Also, please add a commit message body describing the Jadard JD9365TX
hardware and why the binding is being added.

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml
> new file mode 100644
> index 0000000000000..aaf2a7e00ff04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx=
.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/touchscreen/jadard,jd9365tx.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Jadard JD9365TX in-cell touchscreen
> +
> +maintainers:
> +  - Hefei <3066883572@qq.com>
> +
> +description: |
> +  In-cell touch integrated with Jadard JD9365TX DSI panels. The module F=
PC
> +  often exposes only I2C (no interrupt GPIO); the driver polls coordinate
> +  reports. The touch controller is commonly powered from the same rails =
as
> +  the panel; those supplies should still be described here when dedicated
> +  regulators exist.
> +
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    const: jadard,jd9365tx
> +
> +  reg:
> +    maxItems: 1
> +
> +  poll-interval: true
> +
> +  vdd-supply:
> +    description: Analog / touch power supply
> +
> +  iovcc-supply:
> +    description: Digital I/O power supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - iovcc-supply
> +
> +unevaluatedProperties: false

[Severity: Low]
Does the schema match the hardware description above?

The description says that vdd-supply and iovcc-supply should be described
when dedicated regulators exist, yet both are listed under required:.  In
addition, the description notes that the module FPC often omits the
interrupt GPIO (and mentions Linux driver polling, which is OS policy rather
than hardware description), but the schema uses the chip-level compatible
jadard,jd9365tx with unevaluatedProperties: false without allowing an
optional interrupts property (maxItems: 1) for modules or boards that wire
the interrupt line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A3BF23A8B6E=
3691F0D567ADF8B84194F4408@qq.com?part=3D2
