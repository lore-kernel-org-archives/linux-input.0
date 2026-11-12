Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508913;
	b=pBjv68qd05v3Ir3USCKy85dzrKgTB0gj67EVefmTmFQXGSCF1pR8/YQHcqToAquhFAWB
	 qNTcxU9VSK0gv7KPYSnSRCVf7qeB7CLjbPzKBpT/UwtnGWwb0MSK/QuojkRL3m76KAJ7U
	 uu1jzXyXy1TGGXrDEhmDRGqrxAAc0b+pu/JNxQYMBbMEZm80njQOdOY9kqZpZBECyexpi
	 GMvxyphih94LojWj1cuGBIuAGGhlvrRM3RaP4v0gZmPPNNNfIJX54QQdwu2y8DdQjrCi1
	 LBUCSpLsy7K6dGLYz6mB21T2vbM8LmRzoEZVH6eY9TNFBT0I21mFT/2Blp+LBZy9FCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508913;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LOpYgV0yLr3QlkSnDH5BGJlte7M5JeRbFUnFQVB79L0=;
	b=QTT5R84egI9bicErVhiqmuHFfQfKX1F4lJxBZMrGXGrOqragK7cooACabY8Z7hhDQPUw
	 7IDse2lVm5fMw/ViO5rnrdavMt+7MM0EDJEPMdEjPvi8/iZuPVUj5/lBttL0jyM5gVLXk
	 MCCDslCHZf6aPqRJOOSRue0FVvJ7rjye+uLhdgfg8XCIYQVYdt7lB3cyNI493IXAGmHWX
	 EQ4fs6Vdo49UlTLnH/iyjOV7nO+PbLDBJFLAPn2jXCx2AVh1u1p4BiyQvT6csD1N4GkM+
	 Z1RkGBOvfJ8vhQevJ46CgGmcgMh2RuRmZXn3SnVOc2BquAzC5MQJHRpXWGTXG8AM7RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrQa24c1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5385606A321;
	Thu, 12 Nov 2026 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrQa24c1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6163F1F000C4;
	Thu, 12 Nov 2026 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508913;
	bh=LOpYgV0yLr3QlkSnDH5BGJlte7M5JeRbFUnFQVB79L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VrQa24c1cgx/A60VqKES5zjmZ6Dd01cgAYXfABvciIPO/J54muL+ci3SRR8qnm3va
	 0VRDFqlvwASUdjn+alUNBUvuTqctx3ZfSbGx3cCBUKuCZuJqJ7fQIuVWZWQkqFTdlP
	 mB8jN0eUcbqUAIXiAzyW7pGGP40cMy+iFcVkOxH1aeK5xHYLM0u6gTv34e6dp19mW8
	 T4TN4B/w1g2NpKT2/RfAO/uHuOyjFujRkzu+BFaDIE9ajQLp9MeR3wIwQTlmS/Vn0c
	 MDRhyYNEVZ5q0mXnbq5K3JAU2wmms6pPR9w+oOWM/+f4AS0XxiwfwZXJ4h7fa0dceZ
	 1xG4LZxhobzeA==
Date: Thu, 12 Nov 2026 18:41:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Tawheed Makhdoomi <_@tawheed.cc>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Jingyuan Liang <jingyliang@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: input: hid-over-spi: add the
 Surface Pro X touch digitizer
Message-ID: <20261112-pawing-salutary-a8fe7f13ce07@spud>
References: <20261112172641.407-1-_@tawheed.cc>
 <20261112172641.407-2-_@tawheed.cc>
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
	protocol="application/pgp-signature"; boundary="486kMrmOr6S/wO5v"
Content-Disposition: inline
In-Reply-To: <20261112172641.407-2-_@tawheed.cc>

--486kMrmOr6S/wO5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

pw-bot: not-applicable
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--486kMrmOr6S/wO5v
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavYIbQAKCRB4tDGHoIJi
0n15AQCBOolPXQLNkq13g/bOCUNC70ijr2+GB4GzgrDrm4H5HQEA3B5CYkdfhc/j
I++7zei8RdNLBlytJl8s1LmwaHHwKg8=
=OVFW
-----END PGP SIGNATURE-----

--486kMrmOr6S/wO5v--
