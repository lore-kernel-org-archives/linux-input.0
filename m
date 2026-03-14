Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0C309F1D;
	Sat, 14 Mar 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773484187; cv=none; b=kGxw8BlfeJqPd9P2/Y8Bir6RuN+ITTUoXE1DBvTrWvRFaxyyq4Vrm63oeZrYD4f1+xgEKdKQKQr3ecIEzrfs5mIn1+AlQbTJ4u5RmIrXv3obbVF+2rMAd1BRGLYlaW2KOEJf60E2iYIlTB5cUMjMCChEcfG3HWOCyaUaBN514rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773484187; c=relaxed/simple;
	bh=LbZE2tIZtV1BbAIKK4JoVe1rS8yz4CCgYC5HhqTjvXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBW4+mTkQ3ZS+UGWl1Czz3Xg5h3ys1LwzKbWwyNHWilbIS6/sdbRpR6sBU5AUUdQthpfQZchtBd5ez4P0p+7YLiDujpZ+v9V+Ik3dvfYtHYSO8H9KszzPZfvtzuGvVV0MS9chNOUwX2RBP0PWcscix5zVttwvsQauhT03GMv66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxsaN69w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxsaN69w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF401C116C6;
	Sat, 14 Mar 2026 10:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773484187;
	bh=LbZE2tIZtV1BbAIKK4JoVe1rS8yz4CCgYC5HhqTjvXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gxsaN69w8yD7YfTscU6wFWpC7syAQfk9CTcQsPWCt97iRfNu41fFmy48Vh4fIAVGU
	 pFljSu7gzMmFC8tQfPQBHDY20eAWpTJoQP7qQUfR1l3JNEscAnv/wYtNQgf9w80nSm
	 6niQRKPbIDqJw2ThD4BvWJxBORjeIKCsqQ5+pTMjOw1qCKppzSsxWfNZ+p2ObDsw9t
	 QgkgNBQXCMNZJWbF2TudpyALai513XkmPVLGCMQHWZ+JABHgXKgQCOckYRvaP8Pnvy
	 2jqXBu+lYFEGBEU4oHv+z4LSXFWZkAjvU1oNFM/WH4LBZnuEz60hK/sTfHg4hcIl2t
	 6krCRhweCE8WQ==
Date: Sat, 14 Mar 2026 11:29:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhushan Shah <bhushan.shah@machinesoul.in>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3519
Message-ID: <20260314-enthusiastic-singing-duck-5fa4aa@quoll>
References: <20260313-edt-ft3519-v1-0-fe5ffc632fd2@machinesoul.in>
 <20260313-edt-ft3519-v1-1-fe5ffc632fd2@machinesoul.in>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260313-edt-ft3519-v1-1-fe5ffc632fd2@machinesoul.in>

On Fri, Mar 13, 2026 at 12:09:50PM +0530, Bhushan Shah wrote:
> Document FocalTech FT3519 support by adding the compatible. It's 10
> point touchscreen, which works with same driver.
> 
> Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> index 6f90522de8c0..34161af90156 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -40,6 +40,7 @@ properties:
>        - edt,edt-ft5506
>        - evervision,ev-ft5726
>        - focaltech,ft3518
> +      - focaltech,ft3519

Driver clearly indicates it is compatible with 3518 so express it with
fallback (see writing bindings, writing schema, example schema, DTS101
presentation slides).

Best regards,
Krzysztof

