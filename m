Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD52BEC3F;
	Fri, 13 Mar 2026 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773444229; cv=none; b=k7DFHpLUsO4NLQVPz7dmv7El6bw10SXYurHpTChlUwTJm9Ry1BGjffmZhh+73Dv2iiucnevvlFZ/UARQIyTq6+rJCEaF+1dSuX6i4M2gwxap/tHdlecpEIh1woeFei05LUOUx0BBeNgVNP4CJsyfPyFkDXEJI99/GKtgNtpFIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773444229; c=relaxed/simple;
	bh=5JC0kBxNUeYclQxqfiad8IJjbCeElWbnMOROfgzi4y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNkn8sQz2oxFSn0IVyPKa/Sd44/SYoEPs08uGL3yvmhdxG0C7H70KwYJuy2i4YALA0cwfWPJA8kej0e4quc19awHFo8i2qCLjKPNVWRcRYHuD0q7yJK3e2mOzUYMDqdlCNvDe/jtgHrn39lqYCVOT0q+VaKnE9klIEeL6erczmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfGkN4d5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfGkN4d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D70C19421;
	Fri, 13 Mar 2026 23:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773444228;
	bh=5JC0kBxNUeYclQxqfiad8IJjbCeElWbnMOROfgzi4y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfGkN4d5rvbM/MIbmI88kGw1lINj0haC+phuhEtcnMN3//8JMsFqnJmAbo4LKKIhf
	 FHA5ZqdHx/RPb0yMPge7Z1pMiYsP9kOECVBLXlA/QmsgG5MbuavWHEGx6Ng2aYlfo9
	 K5lA/ghPFrXEWzJqgrWxkFVaUH7CY/hREvhnjSHvugn+pbEDYL/4SkXcQos46WTLcl
	 hX427ZPGsfYJPDUciQrAfGT8Cci3k5EO7B3kYWO3z6A6m4MTuLrcMC0qy1e5a3r0Ip
	 V8jeuk5FVpwQl3DTt0ikk6HlO8pVSepc2M7Qv3w0ZiSAiUmfyG7herouvANL2WV0AA
	 iF2N/61NeQ5lQ==
Date: Fri, 13 Mar 2026 18:23:47 -0500
From: Rob Herring <robh@kernel.org>
To: phucduc.bui@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Marek Vasut <marex@denx.de>,
	Michael Welling <mwelling@ieee.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: ti,tsc2005: Add
 wakeup-source
Message-ID: <20260313232347.GA3629471-robh@kernel.org>
References: <20260309110045.108209-1-phucduc.bui@gmail.com>
 <20260309110045.108209-2-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309110045.108209-2-phucduc.bui@gmail.com>

On Mon, Mar 09, 2026 at 06:00:43PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The tsc200x driver uses the "wakeup-source" device tree property to
> determine whether the device should be configured as a system wakeup
> source.
> 
> In the driver, this property is read with:
> 
>     device_init_wakeup(dev,
>                        device_property_read_bool(dev, "wakeup-source"));

Write your commit messages independent of the Linux driver.

> 
> Document this property in the binding to make it visible to DT schema
> validation tools and to clarify its usage in device tree descriptions.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>  .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
> index 7187c390b2f5..c0aae044d7d4 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.yaml
> @@ -55,6 +55,9 @@ properties:
>    touchscreen-size-x: true
>    touchscreen-size-y: true
>  
> +  wakeup-source:
> +    type: boolean
> +
>  allOf:
>    - $ref: touchscreen.yaml#
>    - if:
> @@ -97,6 +100,8 @@ examples:
>  
>              ti,x-plate-ohms = <280>;
>              ti,esd-recovery-timeout-ms = <8000>;
> +
> +            wakeup-source;
>          };
>      };
>    - |
> @@ -124,5 +129,7 @@ examples:
>  
>              ti,x-plate-ohms = <280>;
>              ti,esd-recovery-timeout-ms = <8000>;
> +
> +            wakeup-source;
>          };
>      };
> -- 
> 2.43.0
> 
