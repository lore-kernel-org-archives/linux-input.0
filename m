Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F0335066;
	Fri,  2 Oct 2026 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921703; cv=none; b=LR/PLOOEXdvls7YE5F9UCRkBb5atSGb5W108j5JScGD0hKh6yndyNA42I7m5Xzvi64ShzhRRjMpjnPo1YmYymTz6D1pMZNf1TnYlgX7PudpI5ID+lfhhO84kmMgo6dZIdglEGw8V7Q9qUzTOX2wThfTp+rWsDnBsgClbIaP2FFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921703; c=relaxed/simple;
	bh=jedHPmEYEI+tjy8Wuul556rnB6qzV4B52PGH4/ifBKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyWLViBZB4vou+h4GkT9UIFSdqsN6HtJu2deazJsrew4C1IC4KO+mnyYWqGOA4tFSTWFshkai/aXgqkirOrlr8rLz1OxPgYM8OS8s6nawWAS3WWKW/1Q/Vbb8FlOHHcmFWivrjMV95A1OZ8qirDibMAuIq7ood0xVGPZWxwLXow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4oFs6Bg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4oFs6Bg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385C71F000FF;
	Fri,  2 Oct 2026 06:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790921702;
	bh=hi6XHWyTJQffUT25/ok7QOTOJdQy8n9yJbOZN0HylOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4oFs6BgKw8tvxO1GYbihnYs4/9F4OH5ILJdfr3VNvjsFdkZWK5JRdhL4JjB6ObhF
	 aOaW7HbN0UCoAaXcRcD4iuP0nmEUknpo0VO2/y6HWqwUZhjwmZ9m3O98IDY+8lydFi
	 qYAhraNCh6MDCRjI6MX/T1+oqwId7bt2Pof8WGcpbGHwQ2eBVMr9OBofQkZUSbo5Ji
	 YClSMU6jsgAi8eMknjotu1pF+6PKcXtmkQYEO9w43B16nm3/TiIch0zJAl2anpf1Eo
	 QWRDHlqFlkgYCruv7er+RhkC2xVje4lydbYvBkc7ZvFfyCk4DJhyfQSiqvRYikkEim
	 rTkR3JUpThikA==
Date: Fri, 2 Oct 2026 08:14:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Armandas Kvietkus <armandas.kvietkus@proton.me>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: input: awinic,aw86927: Add Awinic
 AW8697
Message-ID: <20261002-glaring-raccoon-of-bliss-ba5e3f@quoll>
References: <20260930-mainlining-v2-0-40bb1b3943db@proton.me>
 <20260930-mainlining-v2-1-40bb1b3943db@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930-mainlining-v2-1-40bb1b3943db@proton.me>

On Wed, Sep 30, 2026 at 07:18:50PM +0200, Armandas Kvietkus wrote:
> The AW8697 uses the same bus, interrupt and reset lines as the AW86927.
> The register map is different, so there is no fallback compatible.
> 
> Signed-off-by: Armandas Kvietkus <armandas.kvietkus@proton.me>
> ---
>  Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

