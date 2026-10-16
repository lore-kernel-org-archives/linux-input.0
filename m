Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323754AF9F1;
	Fri, 16 Oct 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156324; cv=none; b=N3vvU+YcPs82Igu5vU83MxDfeSpaiYIyj+Rz7YoERonGNltOP3yppHy5fJ7yN2m+yoBR6en9pcaIwtCDdJJjXOMwNslh5NFQN+46QqvGaVxF/3itslkyUtVS04Abbl3btWz4T2Y19Cgg45ZXGMVMmCTlVPOOO+Egu+TbZLsVtkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156324; c=relaxed/simple;
	bh=Mpjq3LYtzLfrUi2F+elPsWKNCQDiDtspv0uRGa5Fw00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW/tulFacTajr5V63ZJUdBPHk/LzIVlckFAgEhAdDrlgM00uaGMxnPm0H/dOLyaST/dsPslP9no4FOyumTWks+e19CQkoepUmXPge339EnknJEQ3PK+ZsMalDZtOOXct/FSzZVo8ZdkJVrnnZ0QPCsGtronbbXo27I45pKga+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBMzkgs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBMzkgs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F8B1F000C4;
	Fri, 16 Oct 2026 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792156320;
	bh=nhb5OIVpHqFOrF6xClYD7WXcnh4voUyydkXqrxYmCbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OBMzkgs0e8t0waBRFt/sY8ldf0LBvA7/aJYvUku7PUgVoSWM03C/oO6r1We+3FfQW
	 Auys2/P/NTLURvTzYd5fUD4R5lFR4G/JIlnPgY6TNM3VKI2SjFqoUA8s/5E6a/xbP1
	 F7YpgoN24I8TYxBZLRsVgUAHeiwseVi+iXs/hLBGirRyfRSRn0tVY6Odh1DoQKDa/w
	 OF2Fjx/cZ8rFZKPh4/YrN9+a31BT4LSmevS7VUMzGVuPmJ6JTpa3IOl8oBOuWMxxz/
	 kj1TUoMWD3IyGmaY7OfSpJYUE19JhwyN+QwC7Vvu0DSencxjZfcXL8WJ/FRiF8w6/A
	 5whvBU8TOMzjg==
Date: Fri, 16 Oct 2026 08:11:59 -0500
From: Rob Herring <robh@kernel.org>
To: wyibo6109@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Message-ID: <20261016131159.GG5059-robh@kernel.org>
References: <20261015201547.GA2868930-robh@kernel.org>
 <20261016123255.1019102-1-wyibo6109@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016123255.1019102-1-wyibo6109@gmail.com>

On Fri, Oct 16, 2026 at 07:32:46AM -0500, wyibo6109@gmail.com wrote:
> From: Yibo Wang <wyibo6109@gmail.com>
> 
> Hi Rob,
> 
> thanks for the review.
> 
> On 15/10/2026 15:15, Rob Herring wrote:
> > Don't need '|'.
> 
> Dropped.
> 
> > Wrap lines at 80 char.
> 
> Rewrapped, everything now stays within 75 columns.
> 
> > As this goes under 'serial' nodes:
> >
> > serial {
> 
> Restored.
> 
> v5 follows as a reply to the v4 cover letter.

Please don't send new versions as replies.

Rob
