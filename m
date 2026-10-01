Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3930D3EE;
	Thu,  1 Oct 2026 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881295; cv=none; b=KLVuTpWKfCrThSnd8o4+dUwC51h7wdvuorv0WgY10eDcjvjaZ/BPsDzy2AdBoXvkUHAz/vmJxiHKveWOYbPBtzUtnBbxRAOiNqk1MaNAPUh6WieiFI1R0MywPPAjz24Jf9J9Ra37TbgQJ0Xi013YkC1w9kOr3IAcf92AQ68FIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881295; c=relaxed/simple;
	bh=naaofPLz+eVZUA5dRqQnlQXrYE+NvgiNN9jc6qs1v2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2wQ1WxPVyo8F7I1/L3SYlDS/z5myYu8Aq8AJh+vVdKlOBeH8pKEK7L+okfPFJwW136Ihpg1QekHO/bbrcT4Rawzg/Kz65lBuwlpnoVx707r+v6terKKSf1+ookj37VWVEYkOqD4ZfCdhFGXiBw7Js/+0m6xf6rIbwRJX9CYi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3gslfp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3gslfp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142861F000FF;
	Thu,  1 Oct 2026 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790881294;
	bh=GWNWpQ2eHdazpKjdnJTkioc9xf2U5wFkrBfmQYi2Wn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m3gslfp0pVwiFOtPqrzJ2hGy3n1/SsMs2p94OoTiwgeg9pMsuEMF6KF1JwonAO/nn
	 f+9S2kANDJIw6zQHUyjjdL9WVmVELKsXe885fdK2Yi9wvTW4Lomr9mJXkdxf8VkzdN
	 goU6WgZ9HwO2/JipU3DdO8kuYuiHxXWEWCJ3L7QbQZXKQmOBF7JwdtZ1IlKWSf3riy
	 Q6QhIxgVujOCXzTQ9vCufyCB+uE1MvwYIKD4qKv3ArrrPAZuh8hzLHRAiwM+af7kIp
	 wWvBfHFqVy1j8IvPdaR7Vd7m2l41qXgOiFp8b3zAQX9Xv82F25gKeyNPQmBWFgC2et
	 2i9+v+WvZncgA==
Date: Thu, 1 Oct 2026 20:01:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH 1/4] dt-bindings: input: touchscreen: hynitron,cst816x:
 configure axes
Message-ID: <20261001-roundup-variably-0113ae7c21cd@spud>
References: <cover.1790851590.git.daniel@makrotopia.org>
 <d18629ede3f2fd5a08d0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QS45YFD/wi4jfYsw"
Content-Disposition: inline
In-Reply-To: <d18629ede3f2fd5a08d0cbdaf82f4254e89500ed.1790851590.git.daniel@makrotopia.org>

--QS45YFD/wi4jfYsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 11:52:31AM +0100, Daniel Golle wrote:
> Reference touchscreen.yaml and allow properties
> 'touchscreen-inverted-x', 'touchscreen-inverted-y' and
> 'touchscreen-swapped-x-y'.

This is a useless commit message, it just says what the diff does.
Please provide a justification for why this is the right thing to do.
pw-bot: changes-requested

>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../bindings/input/touchscreen/hynitron,cst816x.yaml      | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron=
,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitro=
n,cst816x.yaml
> index 72d4da636881e..ba56bf61038c5 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816=
x.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816=
x.yaml
> @@ -36,6 +36,10 @@ properties:
>        - description: Slide right gesture
>        - description: Long press gesture
> =20
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-swapped-x-y: true
> +
>  required:
>    - compatible
>    - reg
> @@ -43,6 +47,9 @@ required:
> =20
>  additionalProperties: false
> =20
> +allOf:
> +  - $ref: touchscreen.yaml#
> +
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> @@ -59,6 +66,7 @@ examples:
>              reset-gpios =3D <&gpio 17 GPIO_ACTIVE_LOW>;
>              linux,keycodes =3D <KEY_UP>, <KEY_DOWN>, <KEY_LEFT>, <KEY_RI=
GHT>,
>                               <BTN_TOOL_TRIPLETAP>;
> +            touchscreen-swapped-x-y;
>          };
>      };
> =20
> --=20
> 2.55.0

--QS45YFD/wi4jfYsw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar6uCQAKCRB4tDGHoIJi
0uj+AQCvn0YDvZEvx4tzA6Gh2ziefjsofjBQWtlVr8PoKmPgVgEA20jfQAaeSg4k
emQh/LYYUXBoj/+8pg+Kk+kt/s+xMQ0=
=TeEk
-----END PGP SIGNATURE-----

--QS45YFD/wi4jfYsw--
