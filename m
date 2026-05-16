Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE01F1534;
	Sat, 16 May 2026 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778899627; cv=none; b=ApMHFFawcxOMEICkS1deR9o0gRBwPp49LEvv5zKvGWWxFL8jk6woANkJsvAk4VwyAsfmlLOWZt5NDCFQZKjlwFogOFTXwyHOb5rVM/FpC9b2/E2Lu4/1RvwPuiluZI6lhRYcPUPpCqgACnNmAPWGtLHW+gt9qMT6L074MQCkoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778899627; c=relaxed/simple;
	bh=63M8icfMSKVH2q6Sy2tT4HIRMKohcXCKulLzUbzwl3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey5zO+IsGCxV+SVMkk7IOEODzuTlN8fg4uf9DbSCSmPje6MMI3Qce3U11Ih2kORfH7Rmd8UXJrIyFGTzzqxSZu0erU+o8wfKOBYcCN1DRBaBgBT3YhgRUX72lAPsgRITPx/1Kbd5aUX42wq+25NE7e57XtWlII04LldztJEYVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzC2RnTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzC2RnTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59406C2BCB0;
	Sat, 16 May 2026 02:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778899626;
	bh=63M8icfMSKVH2q6Sy2tT4HIRMKohcXCKulLzUbzwl3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzC2RnTtN/m0qfQSt+emZOpBvOnlFtc/EbUJHfK/nAh9dw0JOd6WIEBmKH0cdemvY
	 UBtnIAzgShi3kTgW2yOvqUesUk4KhQlrgdyDHunytdBCgkg6c7csR4p8KhwBxVn0hE
	 pY3qpm5sYpzQ8viaENQo7O5Er/oISfIgz6wcFvkXz1743d1tzdtkdSoRqi3BdBx2Dm
	 evH0RFbpAwbhnUEKh9/TiNBjak38Z0I3KJZzMT9G3VoMnWiB0sFBr604/yR1fqrbiy
	 6EYzH9rJNfA8BseAICPjcKxJcO0YmxXbhpsA9g4K7secmPjfgPeYWx0MO8JgQkcTGQ
	 9EOxTCuBX4YOg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 3478E1AC5A48; Sat, 16 May 2026 03:47:03 +0100 (BST)
Date: Sat, 16 May 2026 11:47:03 +0900
From: Mark Brown <broonie@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] Input: gpio-keys - add regulator to gpio_keys
Message-ID: <agfap1YZnT_DbSoc@sirena.co.uk>
References: <20260508-gpiokeys-vdd-supply-v1-0-0bb32e8e6428@fairphone.com>
 <20260508-gpiokeys-vdd-supply-v1-3-0bb32e8e6428@fairphone.com>
 <af3oqSshbXrUYMnz@sirena.co.uk>
 <21308d1e-712b-4d3b-b083-251c8d755470@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PkL8tipO6e686OeJ"
Content-Disposition: inline
In-Reply-To: <21308d1e-712b-4d3b-b083-251c8d755470@fairphone.com>
X-Cookie: Truckers welcome.


--PkL8tipO6e686OeJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 01:41:38PM +0200, Griffin Kroah-Hartman wrote:
> On 5/8/26 15:44, Mark Brown wrote:
> > On Fri, May 08, 2026 at 02:53:15PM +0200, Griffin Kroah-Hartman wrote:

> > > +		if (fwnode_property_present(child, "vdd-supply")) {
> > > +			button->regulator = devm_fwnode_regulator_get_optional(dev, child, "vdd");
> > > +			if (IS_ERR(button->regulator)) {

> > As well as the issue I mentioned on a prior thread with this assigning a
> > non-physical "vdd" name to the single supply that these components can
> > have (which has had issues in the past

> Our Hall Effect sensor IC does have a named "vdd" pin, but we are totally
> open to changing this to power-supply or whatever best follows the standard.

The problem is that there is no standard here, this is not specific to a
particular consumer device.  Your device has one supply called VDD but
some other device might have some other name, and another might have two
supplies.

> > painful) the fact that this is fwnode means that this opens up support
> > for using this with ACPI which is very problematic given that ACPI has a
> > strong model of how regulators should work which is that they should not
> > be OS visible at all.

> Would it be more appropriate to drop the devm_fwnode_regulator_get() and
> replace it with a type-casted devm_of_regulator_get()?

I'd feel a lot more comfortable with that.

--PkL8tipO6e686OeJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoH2qYACgkQJNaLcl1U
h9AxbQf/e3lrh6JHJwjEeIXtX0YE2/0n1nF8ce+0pqdWNdeuzYCeMLG5l3c/a16H
Gpl3JRpch2QmD4nAdFMvnBkQleXAUTJTzK82OAI9wQWFoGvLLEguX6UYcPGzb5/A
46nO3wLHPl7/3MEnG4t8ptXNCbPyQ9ssVwPeH09+b+tUZpBDt/2foANPecPe7m2x
RBsMIqhULVuRVtDyc5UAFMsSJ2myhz6tudTzJwdUXZBKkYKciGsCjS3OOcmCZaXG
+AiWyc/Jw4jD9n3MIRZ0Eay5KnOTIZYSPD9yrqqWQuYfbQuU0ehd2yRe8Y6fJWI1
c4ENkv9n7FDmAqHA2au23iKyZHxBsg==
=Kh3N
-----END PGP SIGNATURE-----

--PkL8tipO6e686OeJ--
