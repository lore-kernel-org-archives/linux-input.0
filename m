Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BF22F01;
	Fri,  6 Feb 2026 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384795; cv=none; b=P3cNQQ7WHnRrFxjKhuaowfYHvVKRSTLjdmsJh4neEmP4FhEPagl0zlJHU1t5nvvVfs7Lxua2AZPLKer94X8FFHNxM2ymLRgpVYnlbh+o1sS3P86NRcnyZSeHExK085H2GpvF/+ssa/nWXfArj8y3d6RYekHhpGZddemrioQds2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384795; c=relaxed/simple;
	bh=gtYSzhkEuYDjv72idUrtezpfL24N/MczwvG3g37IilE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkQAqEzIaciJE9r8JSeZhELmjn7ugwzXt9oRiB2/Hrd9lavCI+nfe80OHFwTMOX6Dxf55dOnkHLmxvdEjZtcdicx8iZ8n/bVvQRGqInlQdbRTPgTjAGe9Zs8v/Xvd6wHPrdOeRAH1Bt52pgeGsH+1vWaafxNXDth+I8M+7LZaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVdQcPL9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVdQcPL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6C4C19421;
	Fri,  6 Feb 2026 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770384794;
	bh=gtYSzhkEuYDjv72idUrtezpfL24N/MczwvG3g37IilE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HVdQcPL9yCx6DT1nvl3a4XdvttH9ULYU8heFXYtRPXuNWaPMShmKy9pas9c9tl+Aw
	 Sv9WbJ126eBeMUDM/cm9KqLEqbP+jhAWXGIx4bfwPaIaGUN3MPHUGVw3Q/UXiB+z1p
	 KMnthUq4oMQRR3+RnZfO7v/+h3Koa/gwVBVI5SLJ2xcKJRkkvgIt74+Cyyez3WjGHL
	 X4dQWgYnMUs7smD8TIhCR0fYUzNoFsUmghI0r0PvZfOQ45WIVseJ3z/2VHqo6Pv6DV
	 fI7MVEG/xGVSouF1118/zq/DplPC44t5OqymoB1+j2zYr7lCq6S6Z7KH7C51E076Dy
	 OATBBxyPsj0mQ==
Date: Fri, 6 Feb 2026 07:33:14 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-rtc@vger.kernel.org, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>, linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1 05/10] dt-bindings: leds: leds-cpcap: convert to schema
Message-ID: <177038479314.155791.18058264036699050991.robh@kernel.org>
References: <20260125134302.45958-1-clamor95@gmail.com>
 <20260125134302.45958-6-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125134302.45958-6-clamor95@gmail.com>


On Sun, 25 Jan 2026 15:42:57 +0200, Svyatoslav Ryhel wrote:
> Convert leds devicetree bindings for the Motorola CPCAP MFD from TXT to
> YAML format. This patch does not change any functionality; the bindings
> remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../devicetree/bindings/leds/leds-cpcap.txt   | 29 -------------
>  .../bindings/leds/motorola,cpcap-leds.yaml    | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/leds-cpcap.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/motorola,cpcap-leds.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

