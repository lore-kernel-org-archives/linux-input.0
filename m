Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1248400E1A;
	Tue, 21 Jul 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646169; cv=none; b=txiBrg8XXJRAmftgBDX8OJI/P2wh7cr7mLyFXfDkm0aI6fGSyI5YZWe51pVedEi/Tv5cu/Sp20ccvu4exNs91v+Dk072BlxLYhhpiMVJLaOEYtcYD58WS6tZbYcyEbhNMVhmEClQzXMBOSYtXvYh/nsiX4yVEk9Ahz3cmrwTcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646169; c=relaxed/simple;
	bh=xDVAjw1evmPbhCtSHBvAWHar0M7/zS3n1eBSUkO14R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJxjhShxp6CvbWCfW3TQaFbBgS7pYODYU6/g2+EsIi9SnwLUdwELs8TNhTqKYEsvXqodgSrdKRz5yxx4WHdkuy8hGm9tghkzdt2+nsq7LedrqZ+x80zrhrFFU7W/wy3zpnlEqBmW73gf/gnAxK4xuDY2Hii1WNsEQWfRQqFMAZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPBZDEjG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPBZDEjG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751AE1F000E9;
	Tue, 21 Jul 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784646168;
	bh=eRxy9o7bxYedbpNQw5m8RnT/2fuzGv+0CqJ7qJPopw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fPBZDEjGx4jjMacBFM4owxlS8aPseFZd/MW3q3Pq9fEjSM3BRd2V44b6MZoVB0uob
	 N1QHjh4dKn/SnC8rkUqGFvKsPy2ZTgiNMsCOQeV/7gf4ZftUVW1PAZIEtV2NBqqSvY
	 um+ljf+VZho7K1fPcEsY0759OuVP/0yHYfa3WZDJiWikO4PWhoYiM+CyjdYKiRy466
	 Lgra2Gll9qOnJk6sxh7i0P0LUR+0+E7tDbM4F9mlShSeLx43WrcGCaS04m2IB5IBJB
	 Kaj0CJffjWcHG5JT+1O8eobw39OvAFo+myCINfb0frqCBF9B+6+PjINoaakxrI8uo2
	 uXoPfg2wZMgYw==
Date: Tue, 21 Jul 2026 10:02:47 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Eduard Bostina <egbostina@gmail.com>, conor+dt@kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	lee@kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v3 3/4] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <20260721150247.GA3820183-robh@kernel.org>
References: <20260721112133.70382-1-egbostina@gmail.com>
 <20260721112133.70382-4-egbostina@gmail.com>
 <20260721113408.655C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721113408.655C01F000E9@smtp.kernel.org>

On Tue, Jul 21, 2026 at 11:34:07AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing NULL check on `dev_get_regmap` can lead to a kernel panic in the IRQ handler.
> - [High] The driver incorrectly masks `platform_get_irq()` error codes with `-EINVAL`, breaking probe deferral.
> --

Why is sashiko pointing out driver issues on a DT binding patch? This 
series doesn't even touch the driver. This seems to be a re-occurring 
problem.

Rob
