Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA2F48FF77;
	Thu, 17 Sep 2026 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634354; cv=none; b=aZGNRkf8WMcVgyiyTiiSJLz5/05xlZCz2Lk/AL9iOrcPeE96OGcEKibtiODcNCPfRqK1IwvM2iJ+sxmZ6/+vjgycbB+YwcmlZuFVuc5JHWplo6xAY5D1JmF8tHkFZqumVhp+85mQ/aKJRxueSAdbFQh/WcoebCy/c5Nf3T3Q3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634354; c=relaxed/simple;
	bh=GynwFI5vip7Kr6umZm873EPrEE38lvHB75YMQiazVS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMTj01Axo2l1ZHb6vUwP0M4nYRrfE0Kr4EbDTaYehU3yLPKqeQLISS4tN36ueF7RIFb86sCpNSsnk1x3m6wqxpYzACjDg/ObFKmur2sD+b6yGACDeYzfxLMny55yhN6gjhO9kh3OeGo9FzvdSm9cF9wsZNdEuVixf4GyCyAEmKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGOGmkLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGOGmkLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE921F000FF;
	Thu, 17 Sep 2026 08:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789634335;
	bh=23XbxxprwWAPo80YX3fykLj/tp02PZCODbSLdyrtjZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZGOGmkLCTT7Bs5w8cPdOHQn1CdbXRD2L8uTmHCuTN2MDz8opdkBmptV09MIQeDuAK
	 lIvvFuu8+EKC0IuI8HTBEapSViryR+G1F/9xkidm43ayb0oz70WllhQe/3inBJQVrp
	 DSIZ+JnzOoQXHjNDjY+eFJd5JpJhYQ2343mhmEiMSS/RRdyPgLetKFkIvF6tXoH62B
	 Srch9mvOtOZVvXZ2wL0qy/TVJzCm/TKQ3tBjdrQcAyRAjXSSzvPdMlwblznmujK2Tk
	 m7z+oyCxrdDkx/ZcfhDgGa1EzKtEbsZNkE999EeG0V6wbxBcZX+QmcxTb7mq7IwGcJ
	 GHE5aPTT/uSew==
Date: Thu, 17 Sep 2026 10:38:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: input: Add compatibility for Awinic
 AW8695
Message-ID: <20260917-dancing-stork-from-shambhala-ff49ab@quoll>
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
 <20260914-aw8695_haptic_fp4_driver-v1-1-156f7549149a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-1-156f7549149a@fairphone.com>

On Mon, Sep 14, 2026 at 04:37:47PM +0200, Griffin Kroah-Hartman wrote:
> Add the AW8695 haptic driver to the binding documentation for the
> AW86927 and AW86938, as this binding needs the same properties.
> 
> They are not compatible though, because the chip identification works
> differently compared to the 86927/86938
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> index bd74b81488f61d72b675b5701b321b30b3430be0..d9da85499cda4d62f14f36f1ce77627e37e348d7 100644
> --- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> +++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> @@ -17,6 +17,7 @@ properties:
>            - enum:
>                - awinic,aw86938
>            - const: awinic,aw86927
> +      - const: awinic,aw8695

This should be combined with the first item (const for aw86927) and turned into enum.

Best regards,
Krzysztof

