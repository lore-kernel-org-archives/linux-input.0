Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110598;
	b=K9CXuQfI1o0yHF3WboZNux/maloOq44Y6Z3UPd0K5EWo6/NLTv0AsKq+lTNt1eKpX5Zn
	 cZ4F3Y4U6J0M8C5M98Wab4uRLWQTEdZfuxsspPD9Y7vrBWv1e1O93V/ntMeD4a4mrAoPJ
	 UB09dCSUIbq9pB3w7XtZ1VgYXcUKNPpve0gu5BN8stAN+aDXwHn0NaqJnQLNQauID9lW9
	 MXpTxx0GI9m4oxeRx1vtUuhGoYHnjoujmKe8Vc3zGQRnIhpX8WnlSW092O2/oIDkR281R
	 8iMA0A85glO1BjES89uGYyHad3mweWWIoYV/oM7vQbnwLEyhkVhbYjM1MIbWmFUzojA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110598;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cwnvE5ZeFGIwub6ucKfZkEWrWwezozotlhK7iduubCE=;
	b=Gg/CYXleRM/QiOHiE01iVrApwN3kceuvCaMKq/7+dnmuFWRUvTWRIkn4WkOQAsRwVF3H
	 bQgrW0axwqM42gwRdZAcStWnrzVlz3aEtmgn/yIZWzt9RTL9CU6edt0n0hE/J9AA49RzZ
	 RhUN/sbY5sorqOomLCcCyq1EMBHSBF1kvvYjtCy22t8k0LNZMXBr5/QFIuf18Uk0Iv+M5
	 R5NI9nP3Jsmbjwgb39UgJvDME4gLHTApgTJkIDMP40AldYDoLiHRhkyJ0stceE1gshkDI
	 OW7GHYY+XO9TQtUow5E5s5XdCxqdJ8pUE8XNrQeDrosAgj2SnNJIgOiIK4/BM5PeQEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAc2NLRm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3535606A325;
	Thu, 19 Nov 2026 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAc2NLRm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258EE1F000C4;
	Thu, 19 Nov 2026 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795110598;
	bh=cwnvE5ZeFGIwub6ucKfZkEWrWwezozotlhK7iduubCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KAc2NLRm9bBMbaYzslkI2E7t9znLMFgTCz25Ken+tEwfdtfHw+myyGC000vz0xCiv
	 oL7f5XLuHnWxyYk4zM8e2wu1ZMA+2raBxfNrMwaMZnDgWR8VFngA3LpLGkyy6rynMI
	 Swvaf+1clJ1+U3beasLHqkMmaMyrWjCev7U5XprvFxynrBiIiH6S1zCtitrk+hrqAY
	 TXc/44uzqnym5iidQfbfsNP4xX/bUzeK2p6EitfVvdRywsZfbcjeZrynkw1PCbUHTo
	 BstFTzQjn2AQ1U6gL/YVdqAHM4ggmW9/5oI+w/ugiV/02A3I6Zcc92wIRHA1LlH/lH
	 +S4OiIV7zIlIg==
Date: Thu, 19 Nov 2026 17:49:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: input: add Jadard JD9365TX touchscreen
 binding
Message-ID: <20261119-unmindful-bagel-6405d83c4fbc@spud>
References: <tencent_BF0B9E6C7E95501FC63D3F98AD08BEF70909@qq.com>
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
	protocol="application/pgp-signature"; boundary="X7+UfeTsliGi7hlS"
Content-Disposition: inline
In-Reply-To: <tencent_BF0B9E6C7E95501FC63D3F98AD08BEF70909@qq.com>

--X7+UfeTsliGi7hlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 10:48:03AM +0800, Hefei wrote:
> Add the binding for the Jadard JD9365TX in-cell touchscreen used on
> the VIEWE 7KF82 module.
>=20
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../input/touchscreen/jadard,jd9365tx.yaml    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/j=
adard,jd9365tx.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml b/Documentation/devicetree/bindings/input/touchscreen/jadard,j=
d9365tx.yaml
> new file mode 100644
> index 0000000..23696a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/jadard,jd9365tx=
=2Eyaml
> @@ -0,0 +1,53 @@
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
> +  reports.
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
> +  jadard,coord-addr:
> +    description: Optional fixed coordinate SRAM address override
> +    $ref: /schemas/types.yaml#/definitions/uint32

Input folks, this does not really parse to me - does it make sense?

> +
> +required:
> +  - compatible
> +  - reg

The device has no power supplies?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        touchscreen@68 {
> +            compatible =3D "jadard,jd9365tx";
> +            reg =3D <0x68>;
> +            touchscreen-size-x =3D <720>;
> +            touchscreen-size-y =3D <1280>;
> +            poll-interval =3D <16>;
> +        };
> +    };
> +...
> --=20
> 2.55.0.windows.5
>=20
>=20

--X7+UfeTsliGi7hlS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav82wgAKCRB4tDGHoIJi
0tHZAQC77AEClONCxlm2UftDzEnXPGEa0ZEewI6ktZlLmnBKLgD/a5xaq6VMlvcb
CTWDw3M2i/CHGG8q88NZWCjVCHIiBwU=
=0lw2
-----END PGP SIGNATURE-----

--X7+UfeTsliGi7hlS--
