Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954371D54FA;
	Tue,  6 Oct 2026 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255097; cv=none; b=JkqYAQgWTCnG2xWbKeTf8+0S6KNaiI6obdijnnpS2GGT/rw4JZJ/k+inL/g2i/YEfiaPQpQl64lIsLM0Iv3w/RoRI3p74KlWevGpNDjnRNbFmSlDuTRS8jr5kSGLkdRHBtpKhypU7Pdbu6/9hPtc/5cbSDHrt/kZ33aFDCS5UDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255097; c=relaxed/simple;
	bh=jS736NCLKlqUzM3K/UsY+I5hzehFJt1Tp1gqmsfmwHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrQqKKiQCNXULXhJsdnleR2iFkUhVzWZLpSbqKAIjExdGpsVXTQkJuMX+pX8XmgM0taWbttRPWS3pOzJMJFlB5MXku3io869q8uD+ccF61cBiSJgfkRIB3dG6mJ3IzMBGx4HwS6m9WcVoVm3W+LtXVXRtV1fX7prk16sQnysQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKBusOi5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKBusOi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C82F1F000FF;
	Tue,  6 Oct 2026 02:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791255096;
	bh=D5XeWpRzY3qwfLhe/IHQ1vMz6pDRxXqLX1+AWz2NPws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EKBusOi5WnqFKKz+jdDnos80qqAfdQWcf48V379NXawCyG/flC/aDZUrl+0ciJqbI
	 QA/7pN3yyJGFXcJm0G+ufdaeRoXSrC6Un75u2xJxR9X9PjFBi6AZnwSRUdtK3m/m0E
	 IPsL8GzLdpTDFVyxHyw1wgaBlrenL8Q3HCtxoPLFepgOzJbRzvOczFZBeLFpuG4Ker
	 k7oGH27riJgs0UWVZdkvh1Gio2xevHJdgbkMpnfh3wgt4BS06sJm1EJ0Bkag2q9vy9
	 vhvfIsKUJYAsivYwYllgHono0sSgqEnq7Mwrfibl01Ipfgf76JApLjTIxprXWa2qPo
	 yobmIkxfqvevw==
Date: Mon, 5 Oct 2026 21:51:35 -0500
From: Rob Herring <robh@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Oleh Kuzhylnyi <kuzhylol@gmail.com>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: input: touchscreen:
 hynitron,cst816x: axes and panel
Message-ID: <20261006025135.GA3437621-robh@kernel.org>
References: <cover.1791233147.git.daniel@makrotopia.org>
 <614a8ac3f9e568d6ccf4787f48b894ba8ce4b584.1791233147.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614a8ac3f9e568d6ccf4787f48b894ba8ce4b584.1791233147.git.daniel@makrotopia.org>

On Mon, Oct 05, 2026 at 10:11:10PM +0100, Daniel Golle wrote:
> The chip hands out coordinates in its own frame and knows nothing of
> the panel it is glued to, so how it is oriented against that panel,
> which coordinate range the assembly reports and how noisy it is are
> properties of the board. Reference touchscreen.yaml and let its
> properties through, among them the 'panel' phandle naming the panel a
> controller is mounted on, which asks for the two to be power sequenced
> together.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Missing Krzysztof's Reviewed-by
