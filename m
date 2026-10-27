Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125076;
	b=iNvxSoFsjjq4R6tzklBWmuEzx6GJt8Q/N5dG0bXhSwfc1ss9/GdbsEB8BVtSNF6uvTyn
	 R9uuObc+fH+9alI2MfmTDNj5Yk+QulgouvdqmcEp//wK9IOcZHTN+BKR84JALSRg3+Y+0
	 LvdZ6WL5oaEGOEBuijFSR3IG7xppX4IR5R4nhlcTNjcr4ErR6SyR/zhEV3DlLIMUlgSE3
	 Dw/egDzRajzqBTVjjtFOMpIXb2ZIfBQFPSJ8L/cZEhHBECCWZzq3wkt6fYLISVo12D2zI
	 +Mpym2B9H3pym86aX+lGoj3MpdMiX2Qdtn4BI3nnfL6FzV3efiYC7fPXVduSaHI4H6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125076;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nfV/S6ZwmWtNZwuWmh/T74T1NcuFLfcIht1ObLXQeHw=;
	b=FRPu1C0OylQU3H4qTrCzTbuSSx8wSluEhWiUv27yajNG2yIr5/Dr+4wzGJTfcMoEsQLz
	 MRr3w49DSyg4SiF/5H0/PAPoMsqEb0jegWUTgLVmzlTWLth/Y9W/+AZ17QgKV2Ih+u4Dm
	 Q9Diz6u7o2bMivFA04Xub2pOIv8AVmivltq4gYmwbK1ZLvIZixX8HXBAnqoC/cfwUi9yv
	 YLeF5Scpz7rIenbAqZpno+7yBJe3cdiOgTS87dEMW1G6K0nteUX2b+g1nh83J/cU27fbh
	 98tcR9Sxs+7iLQU1x6tUWeMYcIyi4GP4l990KDy0NsEkX7Vf8Uzm6Ag+nj80RylwYTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCH1OTqA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D98606A31D;
	Tue, 27 Oct 2026 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCH1OTqA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C15A1F031E2;
	Tue, 27 Oct 2026 18:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793125075;
	bh=nfV/S6ZwmWtNZwuWmh/T74T1NcuFLfcIht1ObLXQeHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bCH1OTqAzL9dmzm6I8uZ52UowYU2/3TVuL06jub41yZWTF8PwHko1pmJX6VeLxJJo
	 0mrjVn0kShRShtVp7ShvjN9qHL4wC4igbKQAD/fAl6aVZoHXKudwZL/3bsW3tXilVG
	 dQH80Fsc3wd/Fnx/HYSCKDMWxM7W1D0WzcTYbz6348UvytYMDPqyXLA9IAqG+ugB1p
	 thpxznbkMj4i6VuDSYvRAQZ3omCVXumSmrlZuGHIo9a9Nr6B7Qaa1qlJKY1lToMpxy
	 RH1FPRcnMxu42QD3oWDHu/27k46rbWVHXYoPdfWuPZca0fipWVhWuKSR5eBLMZu7jG
	 BukhMhiuO8XaQ==
Date: Tue, 27 Oct 2026 18:17:49 +0000
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
	tfiga@chromium.org, fqwqf@fqwqf.xyz, daleyo@gmail.com,
	Dmitry Antipov <dmanti@microsoft.com>,
	Jarrett Schultz <jaschultz@microsoft.com>
Subject: Re: [PATCH v7 08/11] dt-bindings: input: Document hid-over-spi DT
 schema
Message-ID: <20261027-silicon-unvented-a0c8dc394e87@spud>
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-8-abad13174b43@chromium.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8sC1crqEc4kNm6ti"
Content-Disposition: inline
In-Reply-To: <20261024-send-upstream-v7-8-abad13174b43@chromium.org>

--8sC1crqEc4kNm6ti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 12:51:42AM +0000, Jingyuan Liang wrote:
> From: Dmitry Antipov <dmanti@microsoft.com>
>=20
> Documentation describes the required and optional properties for
> implementing Device Tree for a Microsoft G6 Touch Digitizer that
> supports HID over SPI Protocol 1.0 specification.
>=20
> Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>

Personally I prefer how this is done now, but definitely worth those who
approved the previous iteration taking a look at this because it has
changed significantly and no longer contains any of the properties that
cover the timings etc anymore.

Worth noting that this changed since the previous version after I
pointed out that the second hid-over-spi device did not make use of them
at all and needed specific handling in the driver.

> ---
>  .../devicetree/bindings/input/hid-over-spi.yaml    | 75 ++++++++++++++++=
++++++
>  1 file changed, 75 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/=
Documentation/devicetree/bindings/input/hid-over-spi.yaml

Typically this would need to match a compatible, but I think this is okay
provided other hid-over-spi devices actually get added here - the series
adding the second hid-over-spi device didn't do so but should be able to
I think?

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> new file mode 100644
> index 000000000000..bed0746f004c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/hid-over-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HID over SPI Devices
> +
> +maintainers:
> +  - Benjamin Tissoires <bentiss@kernel.org>
> +  - Jiri Kosina <jikos@kernel.org>
> +  - Jingyuan Liang <jingyliang@chromium.org>
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
> +allOf:
> +  - $ref: /schemas/input/touchscreen/touchscreen.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microsoft,g6-touch-digitizer
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
> +      GPIO specifier for the device's reset line. The HID over SPI
> +      specification requires a dedicated, host-driven, active-low reset
> +      line. The line must be flagged with GPIO_ACTIVE_LOW.
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the VDD supply voltage.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - reset-gpios
> +  - vdd-supply
> +
> +unevaluatedProperties: false
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
> +        compatible =3D "microsoft,g6-touch-digitizer";
> +        reg =3D <0x0>;
> +        interrupts-extended =3D <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
> +        reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> +        vdd-supply =3D <&pm8350c_l3>;
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&ts_d6_int_bias>;
> +      };
> +    };
>=20
> --=20
> 2.56.0.257.gf7497c7d27-goog
>=20

--8sC1crqEc4kNm6ti
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauDqzQAKCRB4tDGHoIJi
0purAQCYkv7CUzklUUDgE+JeGoIkAHm0JC3f3mTJttH7XxBzAQEA7mawrnCg1cIq
AdfoN1FM3DllFm3RVC+pmpw1NcGdYQA=
=3dUb
-----END PGP SIGNATURE-----

--8sC1crqEc4kNm6ti--
