Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C6425CD9;
	Mon, 15 Jun 2026 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542254; cv=none; b=OyY2bFm2QixLzbTMt71dQSIrttl76FiWey0uj+iB3fAh8iXefNCpUiOXTGIhf43Ptpc9RUezafXkL/U1uWDOcfZ64y4WiOHXVlBQsPF4uxD6Q05qIMIG7z60wRvszXlwTF5Ivway3n9HUYJVxwINmtN3qpLTQ8gC20AkBM3iaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542254; c=relaxed/simple;
	bh=264sTPiHUU2YAsS4bDy8zfm9w1WgkxKbERNnliUhW0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw6yoC9FdTUZi4sbIQlJFS2aoMyHpfdvmRTQy/Ck/tXF2FB7BJaSZ6nuaWNGknAmokg+0Ru9+kwOYIUj9ljOnrvGm44+HYDQtONVMil8oxiWgSqSt8dfpjztkKKWt1FGhg/e3zF4B/hReFPRWILTk8xkgF/l6wTQZmkJCFERbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hvf+Yhe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hvf+Yhe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C561F000E9;
	Mon, 15 Jun 2026 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781542253;
	bh=U6qil9iuskcq565f92CxzO/PVU3LBt8X6GHty7Rhshs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hvf+Yhe7M1mM95dD/AvLFHxJWbjm/PTd0rhLL0kAC30Xl7GlI3Oj3He+9xGJyj3up
	 TCgoB+zQ+I4ylsuIkzJsYkqn1pASs9GxwiymN5myf4Qa4EnL9VADgyKW0p/tmfG+ta
	 7naTKl9OZ9skgbhrdL90OOkX/jEpWKew0F9aWhSOp+k0HXZBu6UBZFIM03nXmMgy2M
	 1aZUqgNSiPNL20P53sPaGy7+qd0izRoThnx7MtN1rkG/Lrs71guKP3ZGCmlMfEsLG2
	 iy8F7T7aHKheGebQsFaPxuCoKhvVamSuLvcUXkvJ4o0s8eED0coURDlhSbG2K5r7wd
	 M42Uwv+8cB1ZQ==
Date: Mon, 15 Jun 2026 17:50:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 1/7] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Message-ID: <20260615-palatable-aerobics-3091229b6ada@spud>
References: <20260612200717.361018-1-l.scorcia@gmail.com>
 <20260612200717.361018-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+xo6jb+RodJNhcuh"
Content-Disposition: inline
In-Reply-To: <20260612200717.361018-2-l.scorcia@gmail.com>


--+xo6jb+RodJNhcuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 10:04:06PM +0200, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
>=20
> Add the initial bindings for the MT6392 PMIC and its RTC device.
>=20
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Sashiko complaint about missing regulators looks valid.
Is it?

Cheers,
Conor.

> ---
>  .../devicetree/bindings/mfd/mediatek,mt6397.yaml          | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b=
/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 3cbc0dc12c31..e39e81aa9924 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -40,6 +40,10 @@ properties:
>            - mediatek,mt6358
>            - mediatek,mt6359
>            - mediatek,mt6397
> +      - items:
> +          - enum:
> +              - mediatek,mt6392
> +          - const: mediatek,mt6323
>        - items:
>            - enum:
>                - mediatek,mt6366
> @@ -72,6 +76,10 @@ properties:
>                - mediatek,mt6331-rtc
>                - mediatek,mt6358-rtc
>                - mediatek,mt6397-rtc
> +          - items:
> +              - enum:
> +                  - mediatek,mt6392-rtc
> +              - const: mediatek,mt6323-rtc
>            - items:
>                - enum:
>                    - mediatek,mt6359-rtc
> --=20
> 2.43.0
>=20

--+xo6jb+RodJNhcuh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAtZgAKCRB4tDGHoIJi
0kh/AP0S8SUOa/7yYlYdJV+kZosCAS4XWBkKJawzUXPJ+jM2pQEA2UwxVuo4IfxX
O/GQiDMzLWE+ZX7CA1kOU6s4DZysnQc=
=q55h
-----END PGP SIGNATURE-----

--+xo6jb+RodJNhcuh--
