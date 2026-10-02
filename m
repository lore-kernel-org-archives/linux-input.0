Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A587938F251;
	Fri,  2 Oct 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932134; cv=none; b=DPtWsnwSSddm425tVS49TjiPYboEj2wjqfrTeEpdSnYRWoriMkHXsRPgRpuskxr49MwTxWEFKccdwQh4aXKuNoH2eyt5Qc4/yLftVD+5TXOUbeKAt51ZIW9ItO/yFbQyOOZ5Pszz8M7RpJINqPDIgFjdNLboNhOt1ZJjpu8yqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932134; c=relaxed/simple;
	bh=KDmcrbZA4mCPUE3gKeaqVbBkG3FzKXp+aBhOs9svpxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9n55jYaE2JgTZWSA0U3ES0edQz77i6D6o+t3d02ZjKioXvxssLoktXLAIRfzntke1BFXXFQh1cISlvCyIKMly/FRV4iHgqTnYTox9qRXrsDVNqFaKnAuA7RgMAF8Aku/g2KhhlVLqlBDHS3nVRNZ9ZnEdxdudLK0Zk6V0bF3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUTQ0oY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUTQ0oY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5DB1F000FF;
	Fri,  2 Oct 2026 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932133;
	bh=cFMz/nr5oTKEcBntuw89xkR5a5XE2zMGmBljRI6NqrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UUTQ0oY7EoVC/JRxP30IJPQiCBHQTDPhQY7tSw/xZDmqXnE8r6IBLbdlSs6x+BeTH
	 gAGwMwzGIaCqA2zwdegIuhwDj54BqniE4RRA4eXH42KX+wOIUSykwpuP52Mc/0pazy
	 eoGiInRpE8MxIeX/ybV1+bcGeToPwuZuIQBYhy+iY9bMaZyI0kKaxHcRggz3nZDqIC
	 IGrLfnpZobMZeNLAEQr/oK7C1b9BNl4n0NI+nQzS3Lx+tGuKpRmfcsLLKTvBjryp7A
	 MPGmPILjXOVuD0ZnLLPC62UDjLjfssh82IgIKSFdusG3DeU7GeBLjwqgaOY/2Z3ck9
	 cggKlXfmIyHvQ==
Date: Fri, 2 Oct 2026 11:08:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: input: Add compatibility for Awinic
 AW8695
Message-ID: <20261002-evasive-mussel-of-defiance-07a7da@quoll>
References: <20261001-aw8695_haptic_fp4_driver-v2-0-1bd38b1943de@fairphone.com>
 <20261001-aw8695_haptic_fp4_driver-v2-1-1bd38b1943de@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261001-aw8695_haptic_fp4_driver-v2-1-1bd38b1943de@fairphone.com>

On Thu, Oct 01, 2026 at 02:38:50PM +0200, Griffin Kroah-Hartman wrote:
> Add the AW8695 haptic driver to the binding documentation for the
> AW86927 and AW86938, as this binding needs the same properties.
> 
> They are not compatible though, because the chip identification works
> differently compared to the 86927/86938
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  Documentation/devicetree/bindings/input/awinic,aw86927.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> index bd74b81488f61d72b675b5701b321b30b3430be0..d7a2fe62c1b76456b0ea3260172d523f2761ea01 100644
> --- a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> +++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
> @@ -12,7 +12,10 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> -      - const: awinic,aw86927
> +      - items:

Drop items, this is just enum, like the other patch on the lists.

Best regards,
Krzysztof

