Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6A2517A5;
	Sun, 15 Mar 2026 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773564302; cv=none; b=kBJbjNaQC2pj4dBehUY4desazwvU2AU39GG+EBm3Np8Fh9L7c8dIMUMsSpS94BN0gG0zkhzGfeE0c9fTjIOgkzMsEJ5TPQH5g2OjUh12/vadmw9BZ6eyfXRKlYXzG2BtURsvSQP+cxn84W/xzVOr1mNWfzgfB/abb7FS4XXFcr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773564302; c=relaxed/simple;
	bh=g43A6WEq2SBZBiNNplmDLAL0RokmrBa6D3MnvDz0b8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqJt5jEpynyDa64yB6VYm4NQNq0pLF6JrxOp+/R5k0gD4MM3mRi6Gn8OBZSgOYbmk0kKQLDPQjB49QfA6GeExVZT6uEp/atlj9oQT5woUT+OabH4rN582nkUK1MnsnCVvTLQPs8wG1FJZntaV4Luxaj6Qj8+R5NkDdy4saLKFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAWOWz17; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAWOWz17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583D9C4CEF7;
	Sun, 15 Mar 2026 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773564302;
	bh=g43A6WEq2SBZBiNNplmDLAL0RokmrBa6D3MnvDz0b8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAWOWz17HHSNZcghqZr5s/2zxSV17DckZLSec6qzhP9WRZjP7FsIsx2PeRcqgsjdl
	 Jr86eqXq2eLT1RCvVc98UEUtBimzdpkvm6Cc2J0z6UBuMSPIL6fStvXg9SomkrzUq2
	 5vOpAOIosDAzcdogcoNT68KiXaTiibWCxKXQLcJzwTqp9wXJbeCkQXMyXSnDC7AGHM
	 CekdnPotYXjLLOPGCBkPdTG6rLgZ+K3FOvenzN6g/tgiI8bRVvb2jgnxREuEeTCJBq
	 JUqJR24cS8Zq6qWnH0LUYke9doMqtWFlU8YLK6clHaYiXqQ/HoavnUeutmoQiyckAO
	 b+V5ZJAvKp2Tw==
Date: Sun, 15 Mar 2026 09:44:59 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bhushan Shah <bhushan.shah@machinesoul.in>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3519
Message-ID: <20260315-warping-airborne-cassowary-5ee6fd@quoll>
References: <20260314-edt-ft3519-v3-1-5ee91b408ed6@machinesoul.in>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260314-edt-ft3519-v3-1-5ee91b408ed6@machinesoul.in>

On Sat, Mar 14, 2026 at 08:27:58PM +0530, Bhushan Shah wrote:
> Document FocalTech FT3519 support by adding the compatible. It's 10
> point touchscreen, which is compatible with FT3518
> 
> Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

