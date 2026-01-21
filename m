Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAD1478841;
	Wed, 21 Jan 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983505; cv=none; b=ZlEWrXytB4cMIQiQYAgVIe3k88eXCoGesDFdaMktXk/nm5ehRfjFzY9LWfNRgpEAz0xI3tDMIyzigrUgj2NKXD/bMcU20Ev2uwRz37Ul0tf7o3fKstzbckdiAz650Yx2AMzBsmD9ZaewtxmG03dTMR1YGfPsPaYDiiQzzQ8zjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983505; c=relaxed/simple;
	bh=tYssH+Lu5C0vzNnReP26OP8eha9ihkWF4eUdawHeKw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvartshxrJEZ6Ezbp/KtU4kWBhy7UoS5N4dScgkasHte+xefrQRBT0CdXcoxxh+kJS1bJ5lKRKwWu6XX/Yei/bsz7/DDrNAA4bHja0VysDN7FAhGYHnQd4tkkAc35+r4rSg6g/TmzzmEOHGHjbwVqeZwLXsr/Vrt/wcgrKb90mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPpMnUxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPpMnUxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C43C16AAE;
	Wed, 21 Jan 2026 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983505;
	bh=tYssH+Lu5C0vzNnReP26OP8eha9ihkWF4eUdawHeKw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DPpMnUxOFpv2mPe+P+ryy3aUid6iyGQSyb2AUF/BohYMzs4wy2cmz3VuEnkCn2wkA
	 v2RyDTTLJkNcHcBtvO35aNTUm5SFxvs6WoJ4OddKC8RMLHlSSR/sILnxMDZ7755uA+
	 BkgAUtS2MHI6hVHcct01Ebw9EUvDFbn0Bb7L8F+Ad5sRGks01SoMnz1li0XtUAP7Ji
	 BE0HALe1CjN1n6I/LU7amrken+WAbO4DAqYt4i9qNOWhp/0eYkALcq3e9qcNX5GPLI
	 +kxq1XK9NVm/FkJyieQFeSkgP5moyE4TIwSBUdeTds/gAbqEcK9j4X4Xynv2m542G/
	 oMOgFeRtL7l9Q==
Date: Wed, 21 Jan 2026 09:18:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gianluca Boiano <morf3089@gmail.com>
Cc: hansg@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: novatek,nvt-ts: Add
 nt36672a-e7t-ts compatible
Message-ID: <20260121-rugged-azure-asp-44fa1c@quoll>
References: <20260120193600.1089458-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120193600.1089458-1-morf3089@gmail.com>

On Tue, Jan 20, 2026 at 08:35:59PM +0100, Gianluca Boiano wrote:
> Add compatible string for the Novatek NT36672A e7t touchscreen variant
> found on the Xiaomi Redmi Note 6 Pro (tulip).
> 
> This variant uses different chip parameters compared to the standard
> NT36672A, specifically a different wake_type value.
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> ---
>  .../devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml    | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

