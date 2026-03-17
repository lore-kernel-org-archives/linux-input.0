Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50FE3932E8;
	Tue, 17 Mar 2026 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733816; cv=none; b=SDunzMY+XyypBcWKNgnnsn46tEAJ8cA4dYm2EyyfmcNLEwYPf7MNhk80+dDBYVFHz+IcwNgo4BtIMQCImnNjv5klFI7gUETJf5WDKvlgxQMwn9ofH6oCNAI1p3qD9jO8qLYvEkurMeJ+PyY6Q3jMfkgYgEQfnGdwNR11dgjfR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733816; c=relaxed/simple;
	bh=CnOX+zI0Twxk3ysKMn84HBOYz93GCRkeXrKRUgINw8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PesZ6ICXsMrKNFrYTCgch53KQQZaZrHvsabi1JK+4RIbfv0SGXXMR0F913VuE/Esp3VsY+3jzSOSCjzNIrvmVOiHCv4Ql0pkDULYR6wMLI50BfM9FAIqoTJFR1NPlYRL7g4HmDQQo6+wISzEulG0W9wgMVUL41KcyM02c2YcvF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxoC2bW6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxoC2bW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41CBC4CEF7;
	Tue, 17 Mar 2026 07:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773733816;
	bh=CnOX+zI0Twxk3ysKMn84HBOYz93GCRkeXrKRUgINw8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxoC2bW64jvLYHo28vHnohv5HyUkwdV8LbmcxttP1BqcfU55XGAP4ey2gpElcOcWJ
	 Tf1a1rwBC9hEAjQLskdvuSbkXK71DFL9FveNMau9Cj1Tc3wR6e3Wu/SWxtVbq3wm44
	 wcsEHIOC0/nDjmdQlf0U883vVDMABJsTL5kdQUsORDTVJtfg0p3JoF6RxDIzJaIrY4
	 fxtFvl+YuvudVCY/oX0QcX5LrB4pXoomrD9pF5Y7FToa193zdwgxvu5dtcYrsiM+uV
	 MilB1wWdlKMQyERlHdFIaqsFW6B/x37Wy37yWFECVkDni86P9vy4tHfjeubnYNFcXT
	 9OTSxvQesO3tQ==
Date: Tue, 17 Mar 2026 08:50:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: Convert TS-4800 to DT
 schema
Message-ID: <20260317-auspicious-proud-alligator-fcedb2@quoll>
References: <20260316181038.9771-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316181038.9771-1-egbostina@gmail.com>

On Mon, Mar 16, 2026 at 08:10:37PM +0200, Eduard Bostina wrote:
> Convert the TS-4800 touchscreen bindings to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

