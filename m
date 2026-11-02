Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618362;
	b=ShGgGeumY73M+Tl3gaVZuYj+pe6vryyrZ0lHQ5aGP7WOIRzV5/P2SXDinR/T+RSgYb5u
	 qNjiG0SzgjB3MzCfz74PWeBPb9uXD2BWZV1DcZ4mH1OZlCagmsXxv/5qXtU5qmq6uaTyg
	 kNMD9TuuuPTUZVB+lmLnaSN7g+6Yj1EryYuZGtRO6+YdZHsuRxjs8l/DEC+v2jtz7Dz0C
	 hpyDuDt64ukskDqucynmqVPfPOBcUpnXkLsoJRuFXmuQFZr5xjgztWTHwO9n0ajG4yenM
	 SXsWyTZu3mXX57FUY//JQHA3MTt93eFNK16i1btSrqNW28zl1xeLbVfuCc9UCHMmt8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618362;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BOA/Lb6f70vlXVQPGhNBLcYBTasUfJk9dhVpXsxirCg=;
	b=2fWqTDm36oHSsA4Glm76imRlPANKRUtjYVSFCUEHagNPNrh4E7jgzqrZg2ZrADxiW/gO
	 qOcurIXeY280aqtt6lclbx+QElJLrsFc6M6yXiMbsp/oCurT7N4Og0H5ohCmJmdVJj3b5
	 aIAY2FrwuyWl8bHazLCAVAl821LhuN5uwgQI7ARewiwaKTGFJ9JlceRbi/sIOwkxoCRuc
	 5HJS+JPLRjlf8x91U8PuFzhjLxVyDCCS4av0rNqv+qPHukCBUc/4/+XBMr6M9iGMg9Uib
	 Sb9jTnGfmsCug5j6AxO/3zOqPoKDgTXaIO/7l65k0b/Ob+93QwYBYqIxDj4ukOjBjaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oe85Ha8o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F74606A329;
	Mon,  2 Nov 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oe85Ha8o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35511F00A1B;
	Mon,  2 Nov 2026 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618361;
	bh=BOA/Lb6f70vlXVQPGhNBLcYBTasUfJk9dhVpXsxirCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oe85Ha8o+nbO/ly6VjqCOoBYC8tie7qIOvHe8d2It3PXrD6kvZECyr7V18fDPgmQ7
	 wlYAAJqw7Fz5nw/JB+covyXs3WpittKsvEPJT0FngR55oHNWvrsRLr9ER2wOuJSElk
	 dVAKnqjEazTU+uWYiMubaSN3NJewjOc3YdwkB9cfuSO0jOZ5KrQY0SOsHz/ijNQSjo
	 u2U/8NVy4ldrRLBXuCSXRF3RpEePcM+OxodzjACovi//FWWQXubWz1QBvRV9JymXyJ
	 aiHBosBGUNqxji0dMYw2CrcZ9gW+H3Z/kWIOFdbYqm5Vv1V5paxziQ8A5P4Q8Ox+Xy
	 Ue9UtZBNHhcXA==
Date: Mon, 2 Nov 2026 12:19:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: Document FocalTech
 FT3683G
Message-ID: <20261102-objective-sparkling-pelican-876ddf@quoll>
References: <20261030-focaltech-ft3683g-v1-0-38b2f941b039@pm.me>
 <20261030-focaltech-ft3683g-v1-1-38b2f941b039@pm.me>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261030-focaltech-ft3683g-v1-1-38b2f941b039@pm.me>

On Fri, Oct 30, 2026 at 05:27:11AM +0000, Alexander Koskovich wrote:
> Document the FocalTech FT3683G, a capacitive touchscreen controller
> connected over SPI.
> 
> It is not compatible with the FocalTech controllers described in
> edt-ft5x06.yaml, as it uses a different bus and touch report format.
> 
> Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> ---
>  .../input/touchscreen/focaltech,ft3683g.yaml       | 74 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 80 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

