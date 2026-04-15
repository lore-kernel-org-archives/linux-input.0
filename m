Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F77384246;
	Wed, 15 Apr 2026 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291556; cv=none; b=CC331nobXWmxS93+4KZCGDPmXtSCSpp7F94HFVPf4byva0FIZv/I//gVt/p90DyZLsS9W/Y/qc/Q2EsJDvNZa1tJ7F3EUbINdV54b7O3/7wyoDiXnn+Hj1QFhzigU1jpRzSoY1Vj7sUekdmD1yIByCZ8GXauv0kcAH+ixSJrQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291556; c=relaxed/simple;
	bh=mRess9A22TiEIHAr1pMNzwfEEnZOrtxnuNvs8DfH/ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpsgGkpUXsYrQbPEBFEHMm58x1CY0NMo8WogRmjzRksz1A1vbKj+dbOcGxDZ/9M7pVSW8a876rcOHjIUmFNICQd/YXq2oGzv5IJhfLfE2mGbre4eROOguso23U95eBRJ5E5T9uiPhcH2aS2VpzqJO+aA394FH8ege1g6XtPBTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRpznHNS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRpznHNS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF61C19424;
	Wed, 15 Apr 2026 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776291555;
	bh=mRess9A22TiEIHAr1pMNzwfEEnZOrtxnuNvs8DfH/ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRpznHNSJps8tAiOqTCFPPCaloTKdTXsut7aAvF7j4LFJ2yptKptuffjty43Evm0f
	 uQ71Fpo9n0FSNNSHaUbuJpmwYLmC/jkHDkMzv7IbHANU+BuL2stxKwByGu6m9r0zcK
	 HEoEAawskEqfOcisvoR1j2GK+HLR/2R1QX2PEwoG1V8muyst0eN2kqeBaOFRSjTfoY
	 vEfOKAGoGxHgKBaATQvR0JGoCkMP3rIXiJLWnBeUc9QQ3WwjWQykuJhFBA9Jh1R2Ru
	 sr9QV24qrS4EueJALfbGZT7ofJD63BS2cx7shkxu5itm3VB+DEeXIrXm6XvBB8FXhJ
	 eqSWnI7lpe4cA==
Date: Wed, 15 Apr 2026 17:19:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: adc-keys: allow all input
 properties
Message-ID: <177629155084.842035.13171332724449829324.robh@kernel.org>
References: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
 <20260408-rock4d-audio-v3-1-49e43c3c2a68@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-rock4d-audio-v3-1-49e43c3c2a68@collabora.com>


On Wed, 08 Apr 2026 19:49:39 +0200, Nicolas Frattaroli wrote:
> adc-keys, unlike gpio-keys, does not allow linux,input-type as a valid
> property. This makes it impossible to model devices that have ADC inputs
> that should generate switch events.
> 
> Replace "additionalProperties" with "unevaluatedProperties", so that any
> of the properties in the referenced input.yaml schema can be used.
> Consequently, throw out the explicit mention of "linux,code" and extend
> the example to verify.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  Documentation/devicetree/bindings/input/adc-keys.yaml | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

