Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00503DFC99;
	Fri, 24 Jul 2026 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887022; cv=none; b=p+tdVV5htY6wpMDZd3gNJ/2d6VYe4Z8Vr7qj+5R8paxRlHAAOJmtGqQ3CK76PkZZWkYlSyxo7ml06q9DQBr0jVMLAc9mK8FkNDlBRpdie9glseBHDRwpTBFF7ZWBoFz7qLu+n9NnBaFfqY04gxvrBB2C21r6o4tKstlhtvX0OWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887022; c=relaxed/simple;
	bh=Polwfszr45wyABFQ4a6qYp1a2g3lupj6safwCCCtLCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLuzASwJ9pxo11pbjMNPwXvRVxk0bJDAELZGQxDpwHBtzrKw83oj+79acTac6vRb7GVsPWOB79huZeGCk7UoHoSehsbDON3PrztcAs+lD/LAyjYu7szvC922oxXwAG77uHPjEcHpcyLqQc9cQR5rUJTt5999LDaGTTyBB4z4I+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee1OCH5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee1OCH5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087A01F000E9;
	Fri, 24 Jul 2026 09:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784887020;
	bh=jyfrV6IPcu9aYnh7T4e1n7N5xbj+4GI4NND7Tjzrj/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ee1OCH5XZOCRkCkmSTJ92KBA78L5d/rE7iiYMsVSBojZtNn2AcPdDADImGQM4neEM
	 opp0N/azuu++khI/wIZV/HZp+BCYmGbevYr6/qE6w6JqW94eoXMG6FrrYwgaS++BNG
	 FKSFML9UFlZAeWFCfcfZz/FsXRgONHFdZ9mpXfkw17hXbvcwylH0BgDvcZ/m2zUGid
	 udMbTeIOyhpCa9219KiBtgiTk3CmIuyHJH1RDsKrbcwoxI7hWH8hf4Uca6LG47BYJO
	 hlzgxazQxS2bcQntp/ZbBTDXgVindye6lhkEg9qgwFGS5GpDowO8pbQROm70SODey1
	 HH0FanAJ+FOKw==
Date: Fri, 24 Jul 2026 11:56:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
	Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: input/ts/zinitix: document mode 0
Message-ID: <20260724-lemon-bird-of-opposition-e9dc7e@quoll>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
 <20260724-zinitix-modes-v1-4-f6df7d86a878@disroot.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260724-zinitix-modes-v1-4-f6df7d86a878@disroot.org>

On Fri, Jul 24, 2026 at 12:54:06AM +0530, Kaustabh Chakraborty wrote:
> Zinitix touchscreens support three modes, numbered 0 to 2. These modes
> differ based on their event report schema.
> 
> The devicetree schema does not mention mode 0, thus does not consider it
> as a valid state. Add it.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../devicetree/bindings/input/touchscreen/zinitix,bt400.yaml          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

