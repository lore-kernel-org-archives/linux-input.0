Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE340B366;
	Mon, 15 Jun 2026 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540650; cv=none; b=MFXfzq2Ok252br/M8nOw3EKuM0BnQ1/JWQYrTfCW4NamdYNGSeuKXRLabDxVCxVgapnBvXfbEyeiSUpSyjceG2Zaikrsd4j2ERrLjNJ1VMQFNgyxJ7sH34EQsRq4aqoPU9r013nSkXPPpe6zGdfAJpoGYlLrA4STr6z/jG0jwT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540650; c=relaxed/simple;
	bh=QqSUCvXakGCXOHzTYq9e16MZRtA/TXmvVJTgGSt5cvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJo2XnqSfZUNPa/F1BqOMplZ+YNcHkzIdbmZy+dK+HodzyM7iPvZKN8qRieCsmwZlCE1wuhAihNyebAyaCdFI+ikfZbTX1B3xPZvcyQpQP6LTb9HWNjK4tejJUGbQXSP2IMehpVtPWTm6gow9SDu3nPQNX3a687GWQvIzZYblNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKKy2DpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKKy2DpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986E81F000E9;
	Mon, 15 Jun 2026 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540649;
	bh=QqSUCvXakGCXOHzTYq9e16MZRtA/TXmvVJTgGSt5cvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JKKy2DpWNmq720pF/PB5KSr+weE5MyTL87curqIHufOINihT+mpINezPy2VePi2Nv
	 QZYMeqSBzoeFN7ieGE5Z0X+orSJlTu7s0m0GTSeawK1YZe0zgPxUyfIMvz2xOBkwn3
	 KUnhG6E0+5NGz1Js5AQN2J8dAUY7QUifqD3esmpw9pLGgYg9ELEsO2mVlXMXcn3lNy
	 Md3O5ST78sg8KhQKcQAlc1+mHKGx4hn2wzJLdYvDEt0vXLgE8lYl29XSTw3RJW/QAX
	 uEFIn5jTEb7GgtJ0MSDuFX93G//QYlSa3BvuMvOwIKpKESOzhiM0moTdgi5kPIZLVd
	 UFAicr9H0DRdA==
Date: Mon, 15 Jun 2026 17:24:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/10] dt-bindings: input: microchip,cap11xx: Add
 CAP1114 support
Message-ID: <20260615-favorable-pagan-0e6f9f0657d8@spud>
References: <20260615142103.352163-1-jerrysteve1101@gmail.com>
 <20260615142103.352163-10-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxybJmG6AY0PhMvB"
Content-Disposition: inline
In-Reply-To: <20260615142103.352163-10-jerrysteve1101@gmail.com>


--bxybJmG6AY0PhMvB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--bxybJmG6AY0PhMvB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAnJQAKCRB4tDGHoIJi
0jY+AQCIVdu0SbgMnpaCBXGRzcYb8fKEa2tMg3zucXoWALMqoQEAkcT10et4BzU5
R/S63Z6vpcV1Q0z6/sJlgwcIxZCKjAw=
=JUsK
-----END PGP SIGNATURE-----

--bxybJmG6AY0PhMvB--
