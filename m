Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD592DEA89;
	Thu,  9 Apr 2026 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750537; cv=none; b=cKpiun7IWASpPXebDslb5rUrumsXGzi5d4Or9R2PGZ9crzmexB8AGqPnNlARLai3o+r1MNOnNWR1WmrZ9aEEWaqKJk8I0a5hrvgKoPRhULDyi3AZXB8QxLjvHJz6VCk5AVOmQGBWDbjon1O5F3GVS1mRMGUroQF6FhAGqHdQqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750537; c=relaxed/simple;
	bh=D2j3qbwhqQGKe9s2DH7WKpbyhYIDVOB6XzU6kHeukQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhIgaEhdDcilCLbcB6vOtrGz/pv7ouzK5HF9ZQNzXc052yPntCCyTIb1Qwwle/NxEQRaU58U9QT9sXCk3y5e9ddeiqV/DOafqLnH9BXe1hRvTKV/JnP3jEfPGYgdCZ8BQ74xwPnG/Q9WIzD4+yxMiSNW2mOMjiutlZMgaeybPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxnMZExB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxnMZExB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DADFC4CEF7;
	Thu,  9 Apr 2026 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775750537;
	bh=D2j3qbwhqQGKe9s2DH7WKpbyhYIDVOB6XzU6kHeukQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxnMZExBQ3gW8SYFO2CPCQmhy2d1B/DonzDIR95woSgako9kYYB7fKyUtiDnCIQhX
	 YewfSfugKlZwQGUQwWFa3nb/KYIYeD8C9FgFP+NBgmMQtU+UkbLsEpCMOWslMsWdwp
	 mBrmuu0Pm0Jd+rygJvzqiBd5h5yDRoy4NmcdFVhrvMaFaOHfYLe6wXOvnkCaMgkl5h
	 z3VVB0WVhv6Ns8xtHeedLoQOQz5A9FVAQZH5ao/zaJXTEfbdxcdS2LeUOzVcX60zll
	 VNmRi4vyTqMZqqhqsU3jV3OZEKlshPPxK7osW6vkZgzNWNA9VVcyTRqtvzwzzZR4Jd
	 oVVEgDQX0V7pw==
Date: Thu, 9 Apr 2026 17:02:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Jingyuan Liang <jingyliang@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, hbarnor@chromium.org,
	tfiga@chromium.org, Dmitry Antipov <dmanti@microsoft.com>,
	Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <20260409-defuse-thank-4b038128fac5@spud>
References: <20260402-send-upstream-v3-0-6091c458d357@chromium.org>
 <20260402-send-upstream-v3-9-6091c458d357@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xjdUosusd/iPmbw3"
Content-Disposition: inline
In-Reply-To: <20260402-send-upstream-v3-9-6091c458d357@chromium.org>


--xjdUosusd/iPmbw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 01:59:46AM +0000, Jingyuan Liang wrote:
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
>=20
> The properties are common to HID over SPI.
>=20
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> ---
>  .../devicetree/bindings/input/hid-over-spi.yaml    | 126 +++++++++++++++=
++++++
>  1 file changed, 126 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/=
Documentation/devicetree/bindings/input/hid-over-spi.yaml
> new file mode 100644
> index 000000000000..d1b0a2e26c32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HID over SPI Devices
> +
> +maintainers:
> +  - Benjamin Tissoires <benjamin.tissoires@redhat.com>
> +  - Jiri Kosina <jkosina@suse.cz>

Why them and not you, the developers of the series?

> +
> +description: |+
> +  HID over SPI provides support for various Human Interface Devices over=
 the
> +  SPI bus. These devices can be for example touchpads, keyboards, touch =
screens
> +  or sensors.
> +
> +  The specification has been written by Microsoft and is currently avail=
able
> +  here: https://www.microsoft.com/en-us/download/details.aspx?id=3D103325
> +
> +  If this binding is used, the kernel module spi-hid will handle the
> +  communication with the device and the generic hid core layer will hand=
le the
> +  protocol.

This is not relevant to the binding, please remove it.

> +
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - microsoft,g6-touch-digitizer
> +          - const: hid-over-spi
> +      - description: Just "hid-over-spi" alone is allowed, but not recom=
mended.
> +        const: hid-over-spi

Why is it allowed but not recommended? Seems to me like we should
require device-specific compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for the digitizer's reset pin (active low). The lin=
e must
> +      be flagged with GPIO_ACTIVE_LOW.
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD supply voltage.
> +
> +  input-report-header-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Read Approval packet, listing an add=
ress of
> +      the input report header to be put on the SPI bus. This address has=
 24
> +      bits.
> +
> +  input-report-body-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Read Approval packet, listing an add=
ress of
> +      the input report body to be put on the SPI bus. This address has 2=
4 bits.
> +
> +  output-report-address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 0xffffff
> +    description:
> +      A value to be included in the Output Report sent by the host, list=
ing an
> +      address where the output report on the SPI bus is to be written to=
=2E This
> +      address has 24 bits.
> +
> +  read-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Read Approval packets. 1 byte.
> +
> +  write-opcode:
> +    $ref: /schemas/types.yaml#/definitions/uint8
> +    description:
> +      Value to be used in Write Approval packets. 1 byte.

Why can none of these things be determined from the device's compatible?
On the surface, they like the kinds of things that could/should be.

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply
> +  - input-report-header-address
> +  - input-report-body-address
> +  - output-report-address
> +  - read-opcode
> +  - write-opcode
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      hid@0 {
> +        compatible =3D "microsoft,g6-touch-digitizer", "hid-over-spi";
> +        reg =3D <0x0>;
> +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> +        vdd-supply =3D <&pm8350c_l3>;
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&ts_d6_int_bias>;
> +        input-report-header-address =3D <0x1000>;
> +        input-report-body-address =3D <0x1004>;
> +        output-report-address =3D <0x2000>;
> +        read-opcode =3D /bits/ 8 <0x0b>;
> +        write-opcode =3D /bits/ 8 <0x02>;
> +      };
> +    };
>=20
> --=20
> 2.53.0.1185.g05d4b7b318-goog
>=20

--xjdUosusd/iPmbw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCadfNggAKCRB4tDGHoIJi
0jyaAP4ga4xWcmGKbVNXw4Lm5Bd97wKQOgvbVqLavvPAAlHySQEA5G+qgK4wFX3L
nEcO1AKqEw40cUBqPsv2q3Da+pH74g0=
=JTze
-----END PGP SIGNATURE-----

--xjdUosusd/iPmbw3--
