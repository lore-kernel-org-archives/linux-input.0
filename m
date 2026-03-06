Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F452347527;
	Fri,  6 Mar 2026 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785104; cv=none; b=CwPJ5WmuIHQS7A6ndHwwyjSbq82M6AIDoR4GZPwm2y/LHG8pQ9xfrqeulrShd9esQhWikRKUn8PFT3jAQ7lbA1M3YVq5yS00LFlRkbtudPDrqDC/rJun15YvAvpLfTaBkzTE57pP4U5JeChAw+keWF5Z9yrF/PXgtKkeUDCYzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785104; c=relaxed/simple;
	bh=IuG+vsZROFDb7NeVDqWVEGbfJg4FLMzqUC6J2najeSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhbNQup7P6sYdE78VjD2D+W1ylNzeeSucIevuAbRJmgNgSY4Q3AGl3qhWdTxe0U4lSBi5VsjXzCFDe+t8D5dx3Uxi69ZvhGyra2jI26i0PFwg6gc4cQ9HoFiDFV87gsecJVtQvccUiTofe5w62dfhTwaItt9VhDIEOWrFyUKXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0el0AhV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0el0AhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C5C4CEF7;
	Fri,  6 Mar 2026 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772785104;
	bh=IuG+vsZROFDb7NeVDqWVEGbfJg4FLMzqUC6J2najeSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0el0AhVp7tvh4fNnLUed+ARY0AUUV5WbxJCXnU41KcRWBiKElkzcQNnpNpRH851g
	 qAuAe2vZRkdAbu388yiczDhpVgmOx1sGMd9KgHnCorrcGej4/YUmXTI9FoZseHylr8
	 IP74jCXxkZy2yfLrWMkrTF2DhWnqwD7/AI7DxP++w//DS2Jrbhl8UJiTAtBQYQjqv5
	 knqUK/dbeLV0W3o8b2V74DzeEu/rLYwTYDUDd/06yLVhBrhGtB84sogJ520k3e8cHr
	 Bm/BLIvSmK7qUqC2RAU6pUcS1fRzFULrFerFJ197175lLD79sDMAdJsHM9B9LYBWcL
	 SLp71mTfcAW5g==
Date: Fri, 6 Mar 2026 09:18:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: phucduc.bui@gmail.com
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	javier.carrasco@wolfvision.net, hechtb@gmail.com, wsa+renesas@sang-engineering.com, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: sitronix,st1232:
 Add wakeup-source
Message-ID: <20260306-fossa-of-unnatural-authority-29e0ed@quoll>
References: <20260305113512.227269-1-phucduc.bui@gmail.com>
 <20260305113512.227269-2-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305113512.227269-2-phucduc.bui@gmail.com>

On Thu, Mar 05, 2026 at 06:35:11PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Document the 'wakeup-source' property for Sitronix ST1232 touchscreen
> controllers to allow the device to wake the system from suspend.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  .../bindings/input/touchscreen/sitronix,st1232.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> index 978afaa4fcef..672544e5a26e 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
> @@ -32,6 +32,10 @@ properties:
>      description: A phandle to the reset GPIO
>      maxItems: 1
>  
> +  wakeup-source:
> +    description: Device can be used as a wakeup source.

Drop description

> +    type: boolean

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

