Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00B30AD05;
	Tue, 22 Sep 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100058; cv=none; b=uKeyG6eWDsjWa/DsRy7ipqns+2GKkN6OI6lKC4Fszp114rlzgvsYKb6Cygw3HMBKWM6hBrCqETSFmSKNl+EsniOJuk4SrNd8t4wY44OTLrpDDo/6FsxvrOQlfC2L7Ky54c5jxN6htOiIgso/0swjPdxpaxNUAZQq/dYE3lTfkyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100058; c=relaxed/simple;
	bh=42DQZLqFp7oYhlX9NkbYXOhDpl+saZG9Tw1DzIKLXJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERalV3/Fv0prVJgxDK0YQekEpYfL2/kM9ibandu/b1D6T/plsgucMbkJRrMj1APbvWssAwYu2GU24N3RQZE1ih+9FkKOs6rnCaOf+4s4joX8/l2V6hOOYO2UHrFGrpkBLjHmWJvglsa7ANrLC2C/RS8d79CbdHHSWnT/iHsG/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7xwpxnQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7xwpxnQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDEF1F000FF;
	Tue, 22 Sep 2026 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790100056;
	bh=pgEGK/K6gfGA0zQLl1fXn5s5CcBc4oxK3LTkbFK/s2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F7xwpxnQ0DriQd4DckjZV7FlJf1jIqnHu9esG8IsRwjtioGhbUHIF6m11kZ/8PkPT
	 vafSTouaF+AeEJUK5NL598N2O/JHZ2sACEpwfhCldPRz7lQIF+ewWkKZboLMnvhOBm
	 EJy+3n3faD/FNAhrDQp23SVUWhGYSsnjlhKD1vGF9bDN5EByZkj0SxTcAs8T56WX8f
	 rdapx7exbSfhPaUPquGUDdSrDKC5Jaz3wo+EfZLQK4FLJB/HPiJKBZVgh+eJcAAPua
	 N2FMYUn+EhaVCBPbfWZ+o3sV+m2cTG2lNFk68b6rPd+mMYLI8/5NkcIr0a1v8NSIle
	 Uq7NeYDuaaYEw==
Date: Tue, 22 Sep 2026 19:00:53 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: Add AD7147 CapTouch schema
Message-ID: <20260922-obstacle-gamma-4f9be689bc43@spud>
References: <20260921232731.3134965-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i1inwZDxY93RpURb"
Content-Disposition: inline
In-Reply-To: <20260921232731.3134965-1-robh@kernel.org>

--i1inwZDxY93RpURb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 06:27:30PM -0500, Rob Herring (Arm) wrote:
> Add a schema for the Analog Devices AD7147 CapTouch controller used by
> the Microsoft Lumia 950 and Lumia 950 XL device trees. Document its I2C
> address, interrupt, and optional vcc supply.
>=20
> Assisted-by: LLM
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/input/adi,ad714x.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adi,ad714x.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/input/adi,ad714x.yaml b/Do=
cumentation/devicetree/bindings/input/adi,ad714x.yaml
> new file mode 100644
> index 000000000000..8351c28147ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adi,ad714x.yaml

Does the LLM guidance you provide not include filenames matching
compatibles?

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
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        touch@2c {
> +            compatible =3D "adi,ad7147_captouch";
> +            reg =3D <0x2c>;
> +            interrupt-parent =3D <&tlmm>;
> +            interrupts =3D <96 IRQ_TYPE_EDGE_FALLING>;
> +            vcc-supply =3D <&vreg_l18a_2p85>;
> +        };
> +    };
> +
> +...
> --=20
> 2.53.0
>=20

--i1inwZDxY93RpURb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarLCVQAKCRB4tDGHoIJi
0hQDAQDbxoy6JAmG3eq1k5g3lO1D1x6SXKX9dy7OTKUs2S1YAgEA7TfKfrKtn6uj
83/EECUHjCkSeJeVLYWs5aKaDGazTAo=
=fJxl
-----END PGP SIGNATURE-----

--i1inwZDxY93RpURb--
