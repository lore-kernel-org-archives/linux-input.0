Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A9537BE7F;
	Fri,  8 May 2026 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274519; cv=none; b=jiEnDIQ41IC7zS7nBiRhJEux3T+fq11dxEeKFm8CVBi4ycVTi/1V5Lbd0Rx7DXdZ8xdV4r0TqOmfamPd/oMjY7YFv/8S+WCS8RKP5lUyxDuMLfYl6AkSjs4VtJq4XzRanCw9QBmfRz+NHlFln2QuYILw+KLOO1Oehi6kPXiVB4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274519; c=relaxed/simple;
	bh=98quRLMATQhWGfD9gWu8KTNWF9K7mefZB6Q3iAHqbh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SMkd8FneDF/dAdw1yH/ysqf9Jph6mJVQLPjM4OTdVdpwnCpGoman8kuCw7G2jQCSCoDYW/q773hH9uwZXgndIvULTE308buNW70xXnGrBPHMDlV/ttaf/Pgob4EBRwlLHL1pCBw4Jy3iT0ggutoYYYECsdchLy5YBZyuqrT3JAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avrzus1X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avrzus1X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A149C2BCB0;
	Fri,  8 May 2026 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274518;
	bh=98quRLMATQhWGfD9gWu8KTNWF9K7mefZB6Q3iAHqbh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=avrzus1Xzu8B5aWuGuR+JKrmoTUa8UioywzamgUxTHzO1QycXOSmNcyCNQltHg3ip
	 1WZxshkd3iEfHyLN1uKJqMTeD0UJz+CM3zC0XSF9ayJ7yjpll3PP2Kg9fHA5pOxUva
	 XQe5MagIOoSX9rD6NnBnbM4Ggq7k0z2OX0tcepb5E9w14hd0KRYPpfwgk7Zw18DaL4
	 /WeFDpSXOA/1pA2h6GoibV++afp72dWKUBcmQl8twCB9foS/q3i4lpCOJM6iWN23AT
	 FN78EbKI03fdxnAbhiZJuZibHK2NC2KGx+5G0gg0tragpIM/NfyLTIkKJTv/gmDTZL
	 DGug1ogyr39NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/4] regulator: add devm_fwnode family of functions
Reply-To: sashiko@lists.linux.dev
To: "Griffin Kroah-Hartman" <griffin.kroah@fairphone.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260508-gpiokeys-vdd-supply-v1-1-0bb32e8e6428@fairphone.com>
References: <20260508-gpiokeys-vdd-supply-v1-1-0bb32e8e6428@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 21:08:37 +0000
Message-Id: <20260508210838.4A149C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The fallback stubs for `devm_fwnode_regulator_get` and its variant=
s incorrectly return `NULL` instead of `ERR_PTR(-ENODEV)` when `CONFIG_OF` =
is disabled but `CONFIG_REGULATOR` is enabled, leading to a guaranteed kern=
el panic on non-OF systems.
--

commit f8899ceec7e07e935c3ae44032450cd2b8f68352
Author: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

regulator: add devm_fwnode family of functions

Add devm_fwnode_regulator_get and variants.

These function wrappers allow regulators to be accessed from the fwnode
struct without any casts.

> diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator=
/consumer.h
> --- a/include/linux/regulator/consumer.h
> +++ b/include/linux/regulator/consumer.h
[ ... ]
> +static inline struct regulator *__must_check
> +devm_fwnode_regulator_get(struct device *dev, struct fwnode_handle *fwno=
de,
> +	const char *id)
> +{
> +	return NULL;
> +}

Will returning NULL here instead of ERR_PTR(-ENODEV) cause a panic on non-OF
systems?

If CONFIG_REGULATOR is enabled but CONFIG_OF is disabled, a driver calling
this will get NULL. Since drivers typically check the return value with
IS_ERR(), IS_ERR(NULL) evaluates to false. The driver would assume it
successfully acquired a valid regulator.

Later, when the driver calls regulator_enable(), it will pass this NULL
pointer. Since CONFIG_REGULATOR is enabled, regulator_enable() is not stubb=
ed
out and will unconditionally dereference the pointer, leading to a NULL
pointer dereference.

Should these stubs return ERR_PTR(-ENODEV) instead to safely signal the
absence of a regulator and match the expected regulator API semantics?

> +
> +static inline struct regulator *__must_check
> +devm_fwnode_regulator_get_exclusive(struct device *dev, struct fwnode_ha=
ndle *fwnode,
> +	const char *id)
> +{
> +	return NULL;
> +}
> +
> +static inline struct regulator *__must_check
> +devm_fwnode_regulator_get_optional(struct device *dev, struct fwnode_han=
dle *fwnode,
> +	const char *id)
> +{
> +	return NULL;
> +}

Does returning NULL for the optional and exclusive variants violate the
regulator API semantics which require returning ERR_PTR(-ENODEV) to safely
signal the absence of a regulator?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508-gpiokeys-v=
dd-supply-v1-0-0bb32e8e6428@fairphone.com?part=3D1
