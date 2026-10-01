Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55345223DE5;
	Thu,  1 Oct 2026 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790884903; cv=none; b=A9VZTF03VAbnahOTcy0/hcuhQntMEiB7KbTReIBQWaCRmgoXclxkW8Lo+0viOu49Sdgf2R/mN5PQGWal407AbeswDgUfbm1FeturFKn8BUwyO/hFB27uHbGduTXXjTX/VWTSO3qNJSdHz//RCihaMrQDI2UrzJJgBY9OUEZx/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790884903; c=relaxed/simple;
	bh=ggxNSpP3Hn1LcPdUV/KR2cbbD88ahegm5TbfX0Ae29g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+NtFdm/sF1mNn3ma5Fr9q9u63jkuUSREVSQS2zB9SeRkArZ9npRxipfb5UtxwievQ80IeKmzO3njdnDjjzGj2knoExPkKlAeNHCyFrWkCOCMxRJZrhj0tnEm1MX8iBM36SrykNxw0OMy14fHFY9F8QaMpIdlaStD+a11gD1byU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkh6s/5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkh6s/5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05FD1F00893;
	Thu,  1 Oct 2026 20:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790884895;
	bh=2rQ3MjhUL67IRerVEtD/pq8p5QhM7sDP0ixSOCswnuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bkh6s/5RELFUQKTJE6EOYDIR8GmI1OaKrtIbrs1kxEzBuGuRuWsGgtXLbOnkgHvjb
	 UFbehAuDPTc4r7ld5CnZgDfwfVl77CyX2ffEa5nYM3mM0vcR/lOV2QPEQxS2f6u0RY
	 /9PMsjwzTGFbyO6scHsD98F2CM2eGGrf//m3YMSJ+crQwcbK6SVE/Z5jiXuLJthrjp
	 f40VP6h0I/eiZYYGRdxaP4h5d2ZMTu0kiNMI7xYPQPYpI78R66HS4tUwRBVYlOhrXm
	 joxzt9hIi7DJ6XwwZvhYY156MvPcbSGphOggOHHw0ggZGdBsHX5y1A+twmKz4eINVP
	 ikveMW4UiOuEQ==
Date: Thu, 1 Oct 2026 15:01:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kendall Willis <k-willis@ti.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, msp@baylibre.com,
	s-tripathi1@ti.com, vishalm@ti.com, linux-input@vger.kernel.org,
	a-kaur@ti.com, s-kochidanadu@ti.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Message-ID: <179088489296.1749674.5492156640851777675.robh@kernel.org>
References: <20261001-upstream-gpio-wakeup-v3-0-6f3bcde367a3@ti.com>
 <20261001-upstream-gpio-wakeup-v3-1-6f3bcde367a3@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-upstream-gpio-wakeup-v3-1-6f3bcde367a3@ti.com>


On Thu, 01 Oct 2026 10:50:33 -0500, Kendall Willis wrote:
> Document pinctrl properties on the gpio-keys device node. The default
> pinctrl state describes the default pin configuration. The wakeup state
> configures pins to be able to wakeup the system from suspend if GPIO is a
> wakeup source.
> 
> The pinctrl sleep state is not defined here despite being used to configure
> pins for system suspend to save power. It is not defined since no
> gpio-key device tree nodes utilize it. If the sleep state was added, a
> device could use both the wakeup state and sleep state. The sleep state
> would be entered upon suspend when wakeup is disabled for the device,
> whereas the wakeup state would be entered upon suspend if wakeup is enabled
> for the device. For now only the wakeup state is defined since it is
> used specifically to enable pin configurations that can wakeup the
> system from suspend.
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

