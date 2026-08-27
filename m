Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFF5446C17;
	Thu, 27 Aug 2026 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830703; cv=none; b=YieupWNpTg1Cp61SxBfnCkqMTG/USAAl5fwbXy1d17fKJlDeKdqSYNVld9id+rxZ+TA72JTzuBvpjyZyfZ9YaUS5Pq+gszqiKFeHfA92p5wu93EwUp7eSUPZKmzJ+dGU+dINFjN9CF6TE7+yTMa8SlhVJ42/LuwtjwjrPCDNeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830703; c=relaxed/simple;
	bh=82Bcn+pJFIYqOSABLEVb/rS1dDSNK/q0xz+ld9Y0rUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpMopizMagzSjto8T2uLWmO6JOZib0t8Q6RZCEel/EN8f5gMZwismEFq4Mm8Epl7wxud9Wr0JLHrYF2ro9ZhrLb+YU6W7mpIu7rEs6cw9QpiCPdrQWrPy6XJgmkWRo+BUKBohgULGn6xuCS0J2fQF4xMq0KKmEKE4XZFF7ankmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlK41TVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlK41TVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE091F00A3A;
	Thu, 27 Aug 2026 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787830702;
	bh=sDj4ankPeR3/i6HG2u/6SSzlV/Mwesa1U4xXTKGItxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AlK41TVIBzq1lMO/e+rKCx4H3hXagATqZXbYuiIaz0Ar+GcZfu3KePKjXazReZrp0
	 7nhxVLaS3zFlQ2qBQbIR3vbk8ey25LuvocO8zYhNzYDyGmHkK++XR+p6d9k1xArheL
	 Duuqx713xf7rlFqXDGAMt0WkAqFZbUViH4+GRMTYkXT3QwUbtJ7CHUcS8V9LGIBF0b
	 ltqTc+awORwIw970hVf+98zLhKPucqFcCQowUHv3a/MfQ6xJnosf15r5x6P+iV/Gji
	 mJn/kKi5Nhc2aln33Bp2XxrC+EdiQalJV10UFeJSqwSzbKRaIvE64hZnoHIR1MC8hu
	 pIQcIVj8WDVZg==
Date: Thu, 27 Aug 2026 13:38:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Job Noorman <job@noorman.info>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: touchscreen: trivial-touch: Add Himax
 HX83112A
Message-ID: <20260827-miniature-tarantula-of-experiment-c57c23@quoll>
References: <20260821-fp4-hx83112a-v1-0-474941bd8860@fairphone.com>
 <20260821-fp4-hx83112a-v1-1-474941bd8860@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821-fp4-hx83112a-v1-1-474941bd8860@fairphone.com>

On Fri, Aug 21, 2026 at 09:12:18AM +0200, Luca Weiss wrote:
> Describe the compatible for the Himax HX83112A touchscreen controller,
> which doesn't need any special resources not described in the
> trivial-touch bindings.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/trivial-touch.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

