Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181B20E334;
	Sat, 11 Apr 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775916176; cv=none; b=Dfe2ysV16V5djmkYMTVHkrgkfWglja1EGYBqfGKtF2ZXH819bA75t+4wpMPkjmBS8u0f6kWdRIPUzgmy0zvlVWQY7mXLkCEfyBNIs0WM6ySENQe0HBLGhyH86itfYyuV9cbPKc+iozT0O2ORC+vKt8MdYLqsIRxNXXMQ7nAywU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775916176; c=relaxed/simple;
	bh=qTGXf6WynDlhqCeEMRmn0/Jqz0E8aUSyGBpnv9H90GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5zesOLgc/rhkDOqSOrt15solFEyQ1L9fWnIXAsLqRkdfJRbLoDmS1hQ17eGZTVb74HpuUKHCE55opvoK9vDQ2K5bKdcaImmTLJUW4sClYAWhPrJaftAakGKx6sEfEOMZLULxSa5WTpr+7rMaRmdfXd77aJb+AmMDwlPzK0kMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1kpwNnn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1kpwNnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FF3C4CEF7;
	Sat, 11 Apr 2026 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775916176;
	bh=qTGXf6WynDlhqCeEMRmn0/Jqz0E8aUSyGBpnv9H90GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1kpwNnn6yIqce5aPejAr27ABKp8tmHqlIhPh2SZG6WlK+MT+50xikE68MEcRwPXg
	 oC7pR6bUg3H6tHB3Np88jjDfoKs78Cy1yz6LSP7I8ZzCmXP1aK4n50yKcZIxB481GL
	 ASVcppBVzj6w5TGjhKjU6ElNbOMq8hkBHrqKK4tGaabWBNX0pFt0d6CfveL2Nr/tqY
	 EczxhqnBDs9UCmPK/rg6ay8TUyECwTq0lLCWWY9NyD0lMk9QQdPzwCddyoI3G5KYa5
	 oBUX8l70kJqKZuhcNwQ6uDqnhDRIE+oq8Q2FCLH1UreGsYIqgvc27FrgTKEBBfJto7
	 XB9iQ+OC+yaIw==
Date: Sat, 11 Apr 2026 16:02:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 09/11] dt-bindings: input: touchscreen: st,stmfts:
 Introduce STM FTS5
Message-ID: <20260411-banana-coot-from-vega-2f4a96@quoll>
References: <20260409-stmfts5-v4-0-64fe62027db5@ixit.cz>
 <20260409-stmfts5-v4-9-64fe62027db5@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260409-stmfts5-v4-9-64fe62027db5@ixit.cz>

On Thu, Apr 09, 2026 at 12:15:52AM +0200, David Heidelberg wrote:
> Introduce more recent STM FTS5 touchscreen support.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/input/touchscreen/st,stmfts.yaml  | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> index 64c4f24ea3dd0..441fc92b9a4ed 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml
> @@ -16,10 +16,19 @@ description:
>  
>  allOf:
>    - $ref: touchscreen.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: st,stmfts5
> +    then:
> +      required:
> +        - mode-switch-gpios

Does existing variant have these pins? If not, then missing else with
"mode-switch-gpios: false".

Please move entire allOf to the bottom, like in example-schema, so after
"required" block.

>  
>  properties:
>    compatible:
> -    const: st,stmfts
> +    enum:
> +      - st,stmfts
> +      - st,stmfts5

Best regards,
Krzysztof

