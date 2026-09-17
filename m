Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AB43B4BF;
	Thu, 17 Sep 2026 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634638; cv=none; b=qWQL69vcdDmgIzFr2gkmjPH5LUxO6sHrbrkPmbcpc3cv+VInNCyrQNHIc0B0k/sg5T2HlRzG7dLESUmRFtD4oipSLacAF2mxjvj4wLr/53HMeXxVoI7jIdXEwAEQ059JUsNZY2m0XFkvdFUbJ49R0NyWJLjbamXOp/0qfu/UXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634638; c=relaxed/simple;
	bh=gabtB3LhvDpwGxM60+CDmRYzOClz8MHrctbfhZ7+Cxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ89OrdRRHvIEg3E22hT1fWCGaT2mJShH673jlJI4qr4BGez8ZKsSkH+Mk0sm9kCQxG1HNMwnGbMmy4czC+zkz/VJwnzKrZp9iBZEkB82DSBupJktmR8Ph5g4LUh3jrOXLyNK0e6JAqIU0W4dS+Lsy6rHkNJ7qGPEAcnLiFgjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d70TY05y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d70TY05y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2EB1F00893;
	Thu, 17 Sep 2026 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789634608;
	bh=buD3ErXVY00qtOfbbN+g2a6i1tZgMgrKCslFRQUKThs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d70TY05yyHQ7s2d6aSQmpJlbvfjb565Jt22UNJ1P7e9d3NyE2FF+DoyrPsOggbevm
	 bJw33nP1ZR/98zM56CUm6S+gL4n4VOlF5ppTlVIZgQalMBgpk3OOgpuShZmz0ZiEI8
	 GHzVhc6aMEZXhSKfSSpp1JzhE/Wnj793p8O9uiHdX1qBiQV1OT+UXsUqd59S1A/5BC
	 UfeEdUfm/wup58vramzigPRPAJYE4PscTiIG99QTELI5RipVlkRx3hjja3XsaZKae1
	 T7tKFlaVdrRDmcbZeVv0X4c0/ZPw0qmevM7HzhewDDvX6uw2vhUD9vFcvdJPeBXLaW
	 ejh1+7jRDjIVA==
Date: Thu, 17 Sep 2026 10:43:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] Input - aw8695: Add driver for AW8695 haptics
Message-ID: <20260917-slim-smart-rook-1dc942@quoll>
References: <20260914-aw8695_haptic_fp4_driver-v1-0-156f7549149a@fairphone.com>
 <20260914-aw8695_haptic_fp4_driver-v1-2-156f7549149a@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-aw8695_haptic_fp4_driver-v1-2-156f7549149a@fairphone.com>

On Mon, Sep 14, 2026 at 04:37:48PM +0200, Griffin Kroah-Hartman wrote:
> From: Luca Weiss <luca.weiss@fairphone.com>
> 
> Add a driver for interfacing with the Awinic AW8695 LRA Haptic Driver.
> 
> The chip supports multiple modes of which only RAM mode is implemented.
> RTP mode would enable a user to "stream" waveform data but to my
> knowledge no such user space API exists in the kernel yet.
> 
> We upload a basic sine wave to the chip and play this on request.
> 
> Co-developed-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Your SoB should be the last, after your codev, after author's.

> +static irqreturn_t aw8695_irq(int irq, void *data)
> +{
> +	struct aw8695_data *haptics = data;
> +	struct device *dev = &haptics->client->dev;
> +	unsigned int read_buf;
> +	int err;
> +
> +	err = regmap_read(haptics->regmap, AW8695_SYSINT_REG, &read_buf);
> +	if (err) {
> +		dev_err(dev, "Failed to read SYSINT register: %d\n", err);
> +		return IRQ_NONE;
> +	}
> +	dev_dbg(dev, "Interrupt: SYSINT=0x%x\n", read_buf);
> +
> +	if (read_buf & AW8695_SYSINT_BSTERRI)
> +		dev_err(dev, "Received boost short circuit protection or over-voltage protection interrupt!\n");
> +	if (read_buf & AW8695_SYSINT_OVI)
> +		dev_err(dev, "Received wave data overflow or DPWM DC error interrupt!\n");
> +	if (read_buf & AW8695_SYSINT_UVLI)
> +		dev_err(dev, "Received under voltage lock out interrupt!\n");
> +	if (read_buf & AW8695_SYSINT_OCDI)
> +		dev_err(dev, "Received over current interrupt!\n");
> +	if (read_buf & AW8695_SYSINT_OTI)
> +		dev_err(dev, "Received over temperature interrupt!\n");
> +
> +	if (read_buf & AW8695_SYSINT_DONEI)
> +		dev_dbg(dev, "Received playback done interrupt\n");
> +	/* FIFO mode is not (yet) implemented in this driver */
> +	if (read_buf & AW8695_SYSINT_FF_AEI)
> +		dev_dbg(dev, "Received FIFO almost empty interrupt\n");
> +	if (read_buf & AW8695_SYSINT_FF_AFI)
> +		dev_dbg(dev, "Received FIFO almost full interrupt\n");
> +
> +	err = regmap_read(haptics->regmap, AW8695_DBGSTAT_REG, &read_buf);
> +	if (err) {
> +		dev_err(dev, "Failed to read DBGSTAT register: %d\n", err);
> +		return IRQ_NONE;
> +	}
> +	dev_dbg(dev, "Interrupt: DBGSTAT=0x%x\n", read_buf);
> +
> +	err = regmap_read(haptics->regmap, AW8695_SYSST_REG, &read_buf);
> +	if (err) {
> +		dev_err(dev, "Failed to read SYSST register: %d\n", err);
> +		return IRQ_NONE;
> +	}
> +	dev_dbg(dev, "Interrupt: SYSST=0x%x\n", read_buf);

You should not have three debugs (and possibly +3 more in if()
conditions) in interrupt handler. In case of irq
storm this still will overwhelm the log. This should be only one and
most likely dev_dbg_ratelimited(). Errors should also have ratelimit,
even if IRQ storm with errors is unlikely or even drop them completely -
isn't regmap already going to print some errors in such case?

> +
> +	return IRQ_HANDLED;
> +}

Best regards,
Krzysztof

