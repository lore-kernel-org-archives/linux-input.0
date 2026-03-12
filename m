Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE68399347;
	Thu, 12 Mar 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327732; cv=none; b=qtActuvGVMvpRUICXrMaYiNZ61J22EOThkoFtgKTAE824k+w5IfxiIIsW3HUeu5qkZwmUP3WfX+jvP/bVMkbR+4SdPwO655MrHDtHiqynUxLNTGg0RwrIXocE1OBn+gW3RY9hocslTjAR/mOkwW1sudgpYtS0ZIy5nCLszwYx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327732; c=relaxed/simple;
	bh=4vUNgw/dIjwg/gDC3g4/SBHB1dI6lecJoQelequ+HGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLQlI3JL+mlq8YprkNWjqr+Phd1LjhrvgOvgUv/Zcm8qxUh59De5bIfP3oLN1QI2Enp2Kc+TK5VeFlbC1d8vqzSju6TiY1Iddw1wQpuLi7IW1OgC4J5ORgdNnYZkARrAzOgoyZ7qIQP9cdJKb0eOg6IBv4j5A0I4pIJnvloiJf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOAGMOCK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOAGMOCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47060C4CEF7;
	Thu, 12 Mar 2026 15:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327731;
	bh=4vUNgw/dIjwg/gDC3g4/SBHB1dI6lecJoQelequ+HGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOAGMOCKc6PZumrHzBjuGeJMib1dbftYNofU/uzf0f0JJOpZHaf6N5ZPUaNdOUfz1
	 dwwLwQCGzQLy50uQjv+YVWB/8/4anKKHJAWcLF+AR1oKZacZZENDZ5uJ0S69+6sE6T
	 0uJh0vlMQqgbClfZaUCIhOQcaBjNQNSrdhSV937l46/rkXXMU7oJwUdCzCbC4o9OBT
	 Py0f3nelL6gX7nPgi5JZym1IB8ANltYOoFGx4XM8J/959YCLqI9iHSvkA68IfL7YnE
	 oge1/pdY0ZZB+z0c1AA9mg8+1ISr6Ax874vQoOJvYDZ5ePfCAJAU43p8J2sXKCv0VP
	 EQnxnLbloFGYw==
Date: Thu, 12 Mar 2026 10:02:10 -0500
From: Rob Herring <robh@kernel.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: robin@protonic.nl, andy@kernel.org, geert@linux-m68k.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com,
	hvilleneuve@dimonoff.com, mkorpershoek@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	lee@kernel.org, alexander.sverdlin@gmail.com, marek.vasut@gmail.com,
	akurz@blala.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 2/4] dt-bindings: input: add settling-time-us common
 property
Message-ID: <20260312150210.GA3121485-robh@kernel.org>
References: <20260305192101.2125660-1-hugo@hugovil.com>
 <20260305192101.2125660-3-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305192101.2125660-3-hugo@hugovil.com>

On Thu, Mar 05, 2026 at 02:20:48PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Add common property that can be reused by other bindings.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> Note: a similar property is used by gpio-matrix-keypad.yaml:
>   col-scan-delay-us
> ---
>  Documentation/devicetree/bindings/input/input.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
> index 502e0b7eb500a..14652d324e2ca 100644
> --- a/Documentation/devicetree/bindings/input/input.yaml
> +++ b/Documentation/devicetree/bindings/input/input.yaml
> @@ -66,6 +66,14 @@ properties:
>        reset automatically. Device with key pressed reset feature can specify
>        this property.
>  
> +  settling-time-us:
> +    description:
> +      Delay, in microseconds, when activating an output line/col/row GPIO
> +      before we can reliably read other input GPIOs that maybe affected by this
> +      output. This can be the case for an output with a RC circuit that affects
> +      ramp-up/down times.

Whether it is GPIOs or not depends on the implementation. Just drop 
'GPIO' and replace 'GPIOs' with 'lines'.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob
