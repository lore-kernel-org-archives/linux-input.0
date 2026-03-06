Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E031339A4;
	Fri,  6 Mar 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772826342; cv=none; b=D00OG/NP22Oa4z3kuNnowExmw8HrLpslbNOPAguD2Yb1LnRQAopzXiwk5tJiHOoPkqgncDK0Tb+ZARVB8pfX94eJgMSzb6I9H1VoIwp05HInGrs8n5HgGsYFOxeerdsvPaR+8h/REOBvFKFGoG6U8DlNsoDbyNjOg0p2fTZt53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772826342; c=relaxed/simple;
	bh=x+3NTRRRtkgOTvh5mtd+iKhL1Y2otrgIc1JfWN0MOUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RU39GiyDJ1aMmfkI0tBIlUffmeKBN5N+IUHL+s2E68AAebpnb9XDOJAafOa6cXV435I2IJp2AWyp64i0ntn4FUQnpuyAOwSfeNel0g936AuP3dOHNJsVUobr5HoYVRjuIJk15tLTSzcKyIfE+WJ2n/sm3DQxYOo4jH1JNikmLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lugK7+sc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lugK7+sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D4C4CEF7;
	Fri,  6 Mar 2026 19:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772826341;
	bh=x+3NTRRRtkgOTvh5mtd+iKhL1Y2otrgIc1JfWN0MOUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lugK7+scdJBBhiZq7oTAcGs9SAzNLQGkGinHM39UgUtCk37lQ0ue0jJ/93NWH5iXI
	 Mi3hAHfVtTzu/EjCt7gi4SoixNl6t6yMT6Y7zQT8TAihU1LndL/eRi5SxceE/KY/1m
	 hVE89Rs002u3eU5o1zpiQ8PPtTxkQnB4B1Y93gSRb5He2kfrUkzqHmKRxSLAogWlgx
	 0rrmNp9pEmD5wIv7bjK6kO2DzxVFP8qhuPNleJRNLZLXItsDKyAy89CuwyxMFTSt8P
	 O+DXLMzAI1QBJ/ZMH26MYd0gkCwBLj4KNng4lGSdrrR1Z/9zp21HsGVf+oQ+hxjfSP
	 DtO+WQlht1LLA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id A0A0C1AC52D4; Fri, 06 Mar 2026 19:45:37 +0000 (GMT)
Date: Fri, 6 Mar 2026 19:45:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: regulator: add support for MT6392
Message-ID: <aasu4UqZv7HMXX6V@sirena.co.uk>
References: <20260306120521.163654-1-l.scorcia@gmail.com>
 <20260306120521.163654-3-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/GMRHJnvF89z60eQ"
Content-Disposition: inline
In-Reply-To: <20260306120521.163654-3-l.scorcia@gmail.com>
X-Cookie: Think big.  Pollute the Mississippi.


--/GMRHJnvF89z60eQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 12:03:06PM +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
>=20
> Add binding documentation of the regulator for MT6392 SoCs.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Acked-by: Mark Brown <broonie@kernel.org>

--/GMRHJnvF89z60eQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrLuAACgkQJNaLcl1U
h9AXeAf+PIlXpslfrQ8vsFtLhhUNWSZSG2c6ukWLzTxJvTlhYNpKzP2XF//6/nvm
nLOsknmi8T7cornx+o6miEp6e88p5JtEiAaYeupKHrUi+GbOhFf364SiHG6U7TF+
eG1zvzep5B0vPGc2GqKWOcHAG4+3xIVxYbF3rnG0gHct/qXK7S1J7RQxaA4DAdNv
OfxEIGzD5qR/yJCjtYioMDnBibUnj9vPyrt0G3Ekcgiptn4gWziw5HnhjKacbECL
dwlH2HrVrEB2VocQGishwscx+TftyqSSm1NiAWRtOuroXq5/a6GLX9lYvqTMlWVJ
EtubtKoks2gAKmRLIP67uKQgfyPzww==
=inXS
-----END PGP SIGNATURE-----

--/GMRHJnvF89z60eQ--
