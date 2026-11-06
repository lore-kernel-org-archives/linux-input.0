Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986998;
	b=UvxhSCKbDISlLmpIUS5y3nfP8aW/+T2FX64zsArLDpW9cfqbIpxFjx7WgUJHqdMVV+ir
	 497vk9SbF0bk28H8MGA6R/Mo9oKFZljNt7LVUUcTVMdzz6TEMvlUL5JWaCpjERUsfda8+
	 qhFqV9Y597jjCvlbDk2okfqL4zEfx+rsOKyo1mXJgYdKUu7LPe9sYVBwtj/UZBibl0uG2
	 oae8M+zunf9AlHAnp3+O2RTScSRxxvFzMkt0aMJkkMQWotAmxbJ2WAJet0cv52QwD4e91
	 upf3GEGwYI/9eiq23D3PAENIlFLb2mRx70rP371IstB+EFhzEbGC+RkeonbihzTHcLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986998;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2bsl3HcOpokhw2h9bHTtGtU5dNcR70Nby9xgUtQM0tU=;
	b=i68+r7iAhPde61qBxpd47WBHn+aELHdh/vOFWHefMQ8F2z67pBRep7loAaeKC1Uq0Ivv
	 syfrMyZ4e8odvUe/mpaUyZ1HqORJo57Gf1N99yzgF3nIp5tHmMQ5Ju9AafvWsOd41bmvU
	 /jQ+1QgQcHJdRXUReE6fCAjGiH1cTkZa/+iW3Le0y4+N33HBbgmQ5p7N7Zvx57kGO4jwj
	 syPL6MUhglMUlznf0eHMtxgeozQwS7SiOwI4wGSUOA+GSnkhbsvLqXF2I6qLBWihqPz1C
	 Kmd0+yYlZKxvsap6FMn8QC1UiAas00hacM4qwmJUSt9uMATpu4e0hazwsOkYYZIxAhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlrNzNss;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73B606A32D;
	Fri,  6 Nov 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlrNzNss
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ADA1F0089F;
	Fri,  6 Nov 2026 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986998;
	bh=2bsl3HcOpokhw2h9bHTtGtU5dNcR70Nby9xgUtQM0tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GlrNzNssHuihwsxdlP0L8AFour+ufncj/OZQhTh5SH4VFffQ9idD3Uohkk5jxPHqy
	 tdQg6xSmWPwil3VxUW0/yYMllrJfhR4BiIBar2Y9UtnJcJH3ObsmEpRet+5LadeC4X
	 i9yriBhlE3vD7Z4WZl/wM5IXeqdfsxdAjUbr1NvPjMiJmlgpWToMYMAqqBFZimZ3Nd
	 d+3t4YL7iVAx2Wn3XHPi5jW8Og4mBZtUZ6NvxgTxMwxaVlqlk1wqjCWWPb64yAEuzH
	 T+T30p2iMWHlPoUCR6z6HxjGFDrrRPy7q7/c+YEzFCtoB4G8yEGtW1G98ZmeNPUPm/
	 0BzqrRTyDJhCg==
Date: Fri, 6 Nov 2026 17:43:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Jizhou Tong <fqwqf@fqwqf.xyz>
Cc: Jingyuan Liang <jingyliang@chromium.org>, jikos@kernel.org,
	bentiss@kernel.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	daleyo@gmail.com, broonie@kernel.org, u.kleine-koenig@baylibre.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [RFC PATCH v3 4/5] dt-bindings: input: hid-over-spi: add the
 Surface Laptop 7 touchpad
Message-ID: <20261106-provoke-capably-b7de457b9710@spud>
References: <010601a1ad274a9c-ca2fc8f5-d3fb-435d-8572-c0d3eb701649-000000@ap-northeast-1.amazonses.com>
 <010601a1ad2a2dba-85a8b4dd-f21b-4dbf-afae-9a40b533338d-000000@ap-northeast-1.amazonses.com>
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
	protocol="application/pgp-signature"; boundary="wftLhdEoMcbIPuoZ"
Content-Disposition: inline
In-Reply-To: <010601a1ad2a2dba-85a8b4dd-f21b-4dbf-afae-9a40b533338d-000000@ap-northeast-1.amazonses.com>

--wftLhdEoMcbIPuoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026 at 07:23:05PM +0000, Jizhou Tong wrote:
> The Surface Laptop 7 13.8-inch (Romulus13) touchpad uses HID-over-SPI
> with quad address/data transfers. Add its compatible to the common
> binding, with both bus widths fixed to four and a 20 MHz clock limit.
> The existing supply and active-low reset properties cover this device.
>=20
> Keep the G6 digitizer constraints unchanged. Pinctrl properties are
> already permitted by the common schemas and need no local definitions.
>=20
> Signed-off-by: Jizhou Tong <fqwqf@fqwqf.xyz>
> ---
>  .../bindings/input/hid-over-spi.yaml          | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/hid-over-spi.yaml b/=
Documentation/devicetree/bindings/input/hid-over-spi.yaml
> index bed0746f00..ec8c72493d 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> +++ b/Documentation/devicetree/bindings/input/hid-over-spi.yaml
> @@ -22,11 +22,30 @@ description: |+
>  allOf:
>    - $ref: /schemas/input/touchscreen/touchscreen.yaml#
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: microsoft,romulus13-touchpad
> +    then:
> +      properties:
> +        spi-max-frequency:
> +          maximum: 20000000
> +        spi-rx-bus-width:
> +          items:
> +            - const: 4

Should this not just be "const: 4", since the property is not an array?

Cheers,
Conor.

> +        spi-tx-bus-width:
> +          items:
> +            - const: 4
> +      required:
> +        - spi-rx-bus-width
> +        - spi-tx-bus-width
> =20
>  properties:
>    compatible:
>      enum:
>        - microsoft,g6-touch-digitizer
> +      - microsoft,romulus13-touchpad
> =20
>    reg:
>      maxItems: 1
> @@ -73,3 +92,24 @@ examples:
>          pinctrl-0 =3D <&ts_d6_int_bias>;
>        };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      touchpad@0 {
> +        compatible =3D "microsoft,romulus13-touchpad";
> +        reg =3D <0>;
> +        spi-max-frequency =3D <20000000>;
> +        spi-rx-bus-width =3D <4>;
> +        spi-tx-bus-width =3D <4>;
> +        interrupts-extended =3D <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
> +        vdd-supply =3D <&vreg_ts_5p0>;
> +        reset-gpios =3D <&tlmm 120 GPIO_ACTIVE_LOW>;
> +        pinctrl-0 =3D <&touchpad_reset>;
> +        pinctrl-names =3D "default";
> +      };
> +    };

--wftLhdEoMcbIPuoZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4RsQAKCRB4tDGHoIJi
0jZzAQDeKBGTodyokA8FFYhJM2LUflFK8kWeqNNxmlnbNRvLZAD6AoJYpapFagEN
ggC7VYtemx7OuaGF3yM9r4KkPaGn4g8=
=7zi0
-----END PGP SIGNATURE-----

--wftLhdEoMcbIPuoZ--
