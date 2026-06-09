Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694A1DF25C;
	Tue,  9 Jun 2026 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980603; cv=none; b=FKCfqKeCp/Vf1f/Sgu6pkUbG3PeNynGx5dQwOcvt2K/jN2U4sz4DoIjI8zjDr5o0JoRxNhjNdv1cw3A4ol9JbbqUPfc1fcUYnTdwL0nwZw8YRBeIvQZSjjLK6O77jBFt2mbGHSwwSqZ8Bc8GKVBNI2p3evASqX5OZCWmRLE8uQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980603; c=relaxed/simple;
	bh=tspIE+sV5b7YDYT/ZY6MPksXdF2jRpg5llp6ZxvCxkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oAxPdV+gNmXYHYqpPbH6zXASyajxT2Y7Adday5cOGZ+MDdedtwm+U1tWlOaex8TRhVY85Sq41ewEhrVcY1YZEDZ5qV2V4qHvsHYc8rS/54/sQNooAUknKuVWJ0RRdRAWN/eUjAcLL+8Jq9nNCRkkAxGoEQRAHyvpA58IQedUyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beTeooNN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beTeooNN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D621F00893;
	Tue,  9 Jun 2026 04:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780980601;
	bh=VIDMIc/0iO4r3+ivMwZqmky942lcMW/8AdCV+1WC/gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=beTeooNN16zTsJyI9kTYpTw6LITKUq1hp8LbGsLokFmZb0jBJa1PHktFtaibRQ77h
	 ay6ops4j5KRwUr/ksV8RQNa0uR4QwL1VJRtENZwK43fnB1mypZjOhztNTxnOroEGzE
	 51wXuuSQ05KBOrHGtevaCbfVKSmLUHxZSgD8Ncatfxvx4oingLK8zQVA1vUaR/nyVs
	 TsnswidB79jXM8m/XZGEp1bXZppdKYj4onfSi8COSTk7dOeiIdhH27FpLFx7tktMSy
	 fh+0aQnGVcIj/4jLUwH4rJ76lPovwFskfjZ5v3AXmHxHHgpbABW/bYZ+9qhcrTMtXx
	 fiZskIHqqsJZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260609-send-upstream-v4-9-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-9-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 04:50:00 +0000
Message-Id: <20260609045001.61D621F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `read-opcode` and `write-opcode` properties are defined as `ui=
nt8`, which will cause the driver to fail probing with `-EOVERFLOW` if usin=
g u32 reads.
- [Low] Missing 'reg' property in the 'required' list for an SPI peripheral.
--

commit 455b6048d6e6dd86252693c3c8edc0762c5dbba4
Author: Jingyuan Liang <jingyliang@chromium.org>

dt-bindings: input: Document hid-over-spi DT schema

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/=
Documentation/devicetree/bindings/input/hid-over-spi.yaml
> new file mode 100644
> index 0000000000000..27cf311e0aab0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml

[ ... ]

> +  read-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Read Approval packets. 1 byte.
> +
> +  write-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Write Approval packets. 1 byte.

[Severity: High]
Will defining these as uint8 cause the driver probe to fail?

In the driver (drivers/hid/spi-hid/spi-hid-of.c), spi_hid_of_populate_confi=
g()
reads these using device_property_read_u32().

If a conforming device tree provides 1-byte properties,
device_property_read_u32() will return -EOVERFLOW because the property leng=
th
is less than 4 bytes, causing the probe to abort.

Should the driver be updated to use device_property_read_u8(), or should
these schema properties be uint32?

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply

[Severity: Low]
Should 'reg' be included in this required list?

Although spi-controller.yaml enforces 'reg' for child nodes matching the
@[0-9a-f]+$ pattern, a malformed node without a unit address would bypass
this check and silently pass schema validation against this binding.

> +  - input-report-header-address
> +  - input-report-body-address
> +  - output-report-address
> +  - read-opcode
> +  - write-opcode

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D9
