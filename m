Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697840B36A;
	Mon, 15 Jun 2026 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540671; cv=none; b=dBSMWCoOBDNNZ2sN99znTsDvRH2j/lyfSNdlXJBgLXQTyCKN1oPiLyyhw2JB/altzNY/1vS+ybFLAFXysi8LzppHXryU9DjVi1pIVa/UQ/3ECwacspL1UvEBYLMEXgOBV9C1AYBFm538Rp2sCqFOxLCMBU76whQXCvrW9RPqpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540671; c=relaxed/simple;
	bh=VD4gWciO7XbH307WFhQ3+84rem9LCvgkUBcnAYffrU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVZi+dL63DeUUO9wqZmehZz5prCDOo4hsFyRmQEWXjxbrHdlZG4N3w9XGSjLvuP9N+azQ7LpPuH7+DrLfOm/xok/bVM0g15koscLFvu4fGs6S/q549HnWqP7/vqJSO7xiduJrxRirfUoTYmp8AX5QQtSwk0pup61+nMgukE9O2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1DFtggS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1DFtggS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBAA1F000E9;
	Mon, 15 Jun 2026 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540670;
	bh=VD4gWciO7XbH307WFhQ3+84rem9LCvgkUBcnAYffrU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G1DFtggSu8cmR98uspVsx5OiCy6Q1fSsxU+5Bu7kzvSTzIsu14lNDptPOeiJZvQiO
	 8wo580jtX9hSWa7a4DiyGjTuZcgzzvz/gADDyGccqtXq31zYaKPL1uXuj72DpqPEZP
	 oLVljmWv0ePycxRgKGLoXYEkwbKu/czjNWYyaOaGn53a5l7ppPs0n6FNSlqzgF+KEM
	 HH4itRBzJ9BQCgZEHu7hJjP6D7Hxq3e9P1R3aMJf17E4fD8sQCSFGRDp2UYpfCpkLx
	 3+S0m1YhjR8uLXM/GmP6ropvcysqd7rD7z0bl/kzS4lfjBCsXOTxx35LIvE9C0WXPJ
	 RwsLf8YxfiOhQ==
Date: Mon, 15 Jun 2026 17:24:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] dt-bindings: input: microchip,cap11xx: Add
 microchip,cap1126 LED reg constraints
Message-ID: <20260615-fiction-twig-84c754b36a85@spud>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
 <20260615142103.352163-5-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2KRTIjmYZz7ZtxZb"
Content-Disposition: inline
In-Reply-To: <20260615142103.352163-5-jerrysteve1101@gmail.com>


--2KRTIjmYZz7ZtxZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--2KRTIjmYZz7ZtxZb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAnOgAKCRB4tDGHoIJi
0o/dAP9hQZQkUbsVidcAlaBzeilYHdLRROy2NNRuE4Y76YNpQQD8DMg7lGetgVt6
7JapW54EctA+50nch6m+fHs8kQT1Ygo=
=PzHU
-----END PGP SIGNATURE-----

--2KRTIjmYZz7ZtxZb--
