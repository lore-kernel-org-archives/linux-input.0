Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C19D4E3EEF;
	Mon, 19 Oct 2026 12:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414797; cv=none; b=ukm+XRpGx1c31oyOHZy441Ct4hRfBT9o0gnV8MQIPfhMkA0lCHa+vDMqDLNubeM3GO0/2WmQLGvm/x7dDgQWA/cHveGPCV/3rPDKHnOexC7d31G+h1eumIEPMLP7FJVNcPLx5iMf+cq+OpDnLlD6ltAHHoAVo+YbHtx6asgkWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414797; c=relaxed/simple;
	bh=wJQe/RHMCwpliomwiNGW7DEjkmZi/G6TXWBu2c8yoxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6R9DyeJBZD5trj6NLX73n3a+XN3RYm8ExzbC46iJ385oqxP6juGn3MRB9enrYOVTw0F2ZlBUBgGOJAVsgY2MuyG4TZu12sXEx1kKEyixKg7N+nS71pv1ew0oOsLi6AKQIwwFLJdlWf7b7daAKDxGO3ejGjFcEjJ4YxtwDU2SIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OwtqiSn/; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OwtqiSn/"
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 1A4171FB78;
	Mon, 19 Oct 2026 14:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1792414784;
	bh=eqw1GXGCRAW1PgP9DMPctNibwOSw+urfwmSp78HtwzA=; h=From:To:Subject;
	b=OwtqiSn/XhoR2HA4ujVyBsokug4TuRkkpktuPpRhVXM9lTnfxp+1bWYL39vXxzO09
	 XvZm1BPZIPVJKv1YaKGq7fUMdYQXGjxMOM8kMLPAs9Fb5evb7smyvzoVaKivgvIgDX
	 gZ+5rQyya33N7C+mnWCQ8BQG4CbVic7jAHYmiJ+j34WS3R0MjjH1RgPKOPzvANWTiC
	 h85U4vYAWHGvbRlqOjdhy1aWT42ZrLbpi8EOPegmogg5WRNMdqpynDz1mUc5ODzdxO
	 8UZQx2LdMenvJwUn0RpoFpKjWPzuhFaMQqXUnKZelBey5aA+t6rskJ/bw9xGQkLTbo
	 g/H8HISqOSqZQ==
Date: Mon, 19 Oct 2026 14:59:40 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Kendall Willis <k-willis@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, msp@baylibre.com,
	s-kochidanadu@ti.com, a-kaur@ti.com, s-tripathi1@ti.com,
	vishalm@ti.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Input: gpio-keys - support wakeup pinctrl state
Message-ID: <20261019125925.GA149024@francesco-nb>
References: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-upstream-gpio-wakeup-v4-0-96f092de4690@ti.com>

Hello Kendall,

On Mon, Oct 05, 2026 at 03:47:03PM -0500, Kendall Willis wrote:
> Add 'wakeup' pinctrl state to support separate pin wakeup
> configurations for GPIO. Upon suspend the 'wakeup' pinctrl state is
> chosen if it exists. On resume the 'default' pinctrl state is selected.
> The 'wakeup' pinctrl state allows wakeup from low-power states if a
> specific pin configuration is needed.
> 
> On TI K3 AM62 family of devices, the GPIO controller is turned off in
> suspend to RAM states, so no interrupt can be received by the
> controller. This prevents system wakeup from low-power states.
> Alternatively, the pins can wakeup the system if a wakeup flag is set on
> the pin by using pinctrl.
> 
> A corresponding device tree patch using the 'wakeup' pinctrl state can
> be found under "arm64: dts: ti: k3-am62l3-evm: add wakeup-source for GPIO
> button" [1].
> 
> Tested GPIO wakeup from suspend on AM62L EVM and AM62P EVM.
> 
> [1] https://lore.kernel.org/all/20260912-upstream-gpio-wakeup-dts-v1-1-2057d76c63aa@ti.com/
> 
> Signed-off-by: Kendall Willis <k-willis@ti.com>

What's the plan/status on this? I see rob reviewed the bindings patch
(in v3), but the tag is lost here.

We would benefit for having this merged, Toradex Verdin AM62 needs this
feature.

Francesco

