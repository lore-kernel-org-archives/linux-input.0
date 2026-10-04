Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456763EB11C;
	Sun,  4 Oct 2026 07:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098670; cv=none; b=Ye9ogCisn46CwyEj24KLcIaHuIrjdhEZmn+JLf1by8L7tlw2YvhSlkwJ0AYF4jUa1Wi7m+n9yD3vNeBcNVNy9nBZ9EJC9sWNc15BQXA/LQq0skU+m0zvDSwRiLZFfi8+PRPR9pt8D3cz2eIJM4ZPv97m/HTLmOYasI827zKJAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098670; c=relaxed/simple;
	bh=7wVLnZ5aKPjSHndJGLA8SeyXwYiVxkyOJMv/I9qGBiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMUUvdzAtSgL8tCNTQlsS9ROgFGvp3MoYhrCLSueGbQ0g+7Yavm7VfpNIH7SHUy3SacyQqzptFQnvocq7FDfzOlrZxGPlAVWj+Mf16vZWx1XqtG8MOSQyN+U06nesbqFzo0hqK2ssfyiWH1+NPnugBkjsX+TzQaTcRjcV3WvGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd6M8Qvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd6M8Qvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A031F000FF;
	Sun,  4 Oct 2026 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791098668;
	bh=Xa7jvq/Hrco6wAxevCltMhRtEr5i7J1hN07rRZ/osl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yd6M8QvjtVQeJAPcO6orijayNHA6UVZX/v70y1VWncldFTLvAdR6SeC4u1wZLendC
	 vJ8OmCOs95VX/moAa2KPAPkDm6hs7C74NkLxrB4DAELwCxY1LFtMNBON3thY66H4Z5
	 vWAgHUd/SOp8+LnsGjuUXx43EoFKMC2Zx3S/8fSuCL1H4NQTMX8jFwW7yT0SAKhs4Q
	 fA4O+6AtS6//VX94juw19TwWc+v0vNVA7IIKy2tPg5mKDdikp3oAUbRlnFgIi9Nqth
	 9h0/pOkuweH1J4WlstsAKtIt9OvYpblSDoitsyEKhlfxFQTaiPqIWnyrx0si9V8Oom
	 0iGrWMHr3yiWA==
Date: Sun, 4 Oct 2026 09:24:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>, 
	Arnd Bergmann <arnd@arndb.de>, Ferass El Hafidi <funderscore@postmarketos.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chad Monroe <chad@monroe.io>, 
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: input: touchscreen:
 hynitron,cst816x: axes and panel
Message-ID: <20261004-unbreakable-funny-guan-73da47@quoll>
References: <cover.1790944534.git.daniel@makrotopia.org>
 <04a70b1cb0969ec4e4b38f7945e0b22a977b038b.1790944534.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04a70b1cb0969ec4e4b38f7945e0b22a977b038b.1790944534.git.daniel@makrotopia.org>

On Fri, Oct 02, 2026 at 01:47:21PM +0100, Daniel Golle wrote:
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
> index 72d4da636881e..027a2b3dcf2e8 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/hynitron,cst816x.yaml
> @@ -36,6 +36,18 @@ properties:
>        - description: Slide right gesture
>        - description: Long press gesture
>  
> +  panel: true
> +
> +  touchscreen-min-x: true
> +  touchscreen-min-y: true
> +  touchscreen-size-x: true
> +  touchscreen-size-y: true
> +  touchscreen-fuzz-x: true
> +  touchscreen-fuzz-y: true
> +  touchscreen-inverted-x: true
> +  touchscreen-inverted-y: true
> +  touchscreen-swapped-x-y: true
> +
>  required:
>    - compatible
>    - reg
> @@ -43,6 +55,9 @@ required:
>  
>  additionalProperties: false

So just use unevaluatedProperties instead of listing almost entire
contents of touchscreen.yaml.


