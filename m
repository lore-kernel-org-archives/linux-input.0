Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2C318BA6;
	Fri,  6 Mar 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786466; cv=none; b=YFPi4zPjm/J0LHx52MwK6+AOh71JJkJdt19VzbsXe7f4kONH9ue5Yj4ChDNqpxM8nDqPLNiVReZQqTIu9MCjbAUuLYfusufDNzRmilJc6MmO4oFdhoIUPrLP8Qk+9coLgVmRLpbJJzfEtSDGaCXvjIiS6wybL5oxCiWBQfldbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786466; c=relaxed/simple;
	bh=j/AAC+/G7iFDybe4b1BJg3KemjHoaKjMY6v7YfzaANE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGhN3i7eakXyL2hISlPm0FyNOc0O3CSgnTS8EwxJNF9v3FEM8KKSBHEmgfT9pYHZKOf2dAJ7KvfsIcrfud+9yOeIGyPr3C4YtPCWtI6R1QpMaFFNKdF0wnLaJQAiGjN0MKZ28cXMTkWMMEb1ZrHkTADoTitdflIAdQc4g1Pe7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ5e010Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ5e010Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09BFC4CEF7;
	Fri,  6 Mar 2026 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772786466;
	bh=j/AAC+/G7iFDybe4b1BJg3KemjHoaKjMY6v7YfzaANE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJ5e010Y3U0wBDmIdaqJO0tkBECkdYO1pyyEUPfBlZk5vAjPa8tXp3VMdh3Uu4b7K
	 3ku9tBo85IAYvrBsOy817jTxgLBa5yfxWiO9TzFXgA6fzH6GnQXP+9JvT052dEpFPh
	 +F95jPEsCcM9N36cu5k8CWLJzxQU55WhL6hKr4jlUr7g79CEC8nL2W0+4vYUx4Z5LD
	 +fQ6fruNWyp6ibU5hFfgcoyzcvY9dF/HsMG4RnmcIB+ieZsbCUHMqyFSSYHr17RYlr
	 IWNn9I//lnmfoDrSXWgvoKVLZAuCyCbCT5K32x8bGddh63w9kIGzlX1MKKZBytxN6o
	 sw45EEuAPXZzw==
Date: Fri, 6 Mar 2026 09:41:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yedaya Katsman <yedaya.ka@gmail.com>, 
	Joel Selvaraj <foss@joelselvaraj.com>, Jens Reidel <adrian@mainlining.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: input: touchscreen: edt-ft5x06: add
 edt,edt-ft5x06 for legacy platforms
Message-ID: <20260306-wolf-of-striking-fragrance-0dee0e@quoll>
References: <20260305223731.4088953-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305223731.4088953-1-Frank.Li@nxp.com>

On Thu, Mar 05, 2026 at 05:37:29PM -0500, Frank Li wrote:
> The compatible string "edt,edt-ft5x06" has been used for more than a decade
> on older platforms such as i.MX6 and OMAP. However, it is currently missing
> from the binding documentation.
> 
> Add it to the binding to document existing usage and fix the following
> CHECK_DTBS warnings.
>   arch/arm/boot/dts/nxp/imx/imx6dl-nit6xlite.dtb: /soc/bus@2100000/i2c@21a8000/touchscreen@38: failed to match any schema with compatible: ['edt,edt-ft5x06'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> index 6f90522de8c0a..213451f823369 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -38,6 +38,7 @@ properties:
>        - edt,edt-ft5306
>        - edt,edt-ft5406
>        - edt,edt-ft5506
> +      - edt,edt-ft5x06 # Deprecated, not use for new platform.

Then document it as deprecated one.

OTOH, this above is clearly not correct because we also have
"edt,edt-ft5506", "edt,edt-ft5x06". Just use git grep.

I don't understand, though, what is the point of documenting it if there
is no ABI implemented (nothing in the driver) and it cannot work.

Best regards,
Krzysztof

