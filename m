Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FA448CED;
	Thu, 17 Sep 2026 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634127; cv=none; b=mZrTDKADkEovpDUIaG8QtnuvubM7TvNQ83stW7smcFYpFc5oBGVEOsMYSGX3LGDWOsPE6cziwVv9rw04p4B2vDBpCVjQn8g+jlmRNJaZaf21XeaFA2Mgx0HCRaTQXf74GVKqMc4kFFYWKjhpyl5CD9yEnBBQZKrE6J9h2vQUe/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634127; c=relaxed/simple;
	bh=oXON2f9bkcv6xlMxmeaSORdAvyn+kqMh97XQBzM3x2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fNTcUgLXCi1XnIIKPtH4Yi9qM57Q6NPcK2VFnxcruEE/eSuu/vfVp+D2BvlkjR4x6jcJkZdDoPrImeSJtrGRrfqXeHcU13NaxPMF76NXccbl2CPZJxXG+LVgngs9LmQvbAPr/VNe6bps90dD4ImJ8sVXWAuJgOHS5vP35EvVrDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtm8o8Gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtm8o8Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092F21F000FF;
	Thu, 17 Sep 2026 08:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789634110;
	bh=btoqsva7HCSTivJzXmSqtuKbuJZ3tspB+VplxGWmavU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mtm8o8Ggcmjl4voiMNfPOMcavGrxruEL8ddtlai69gIcOvx65z0PAwNwKdlt0XlXq
	 +jvoWLGD4tHjuO8MixcxPTe6/oLgqRVYh6Sj2fQ8ruBB1FkFZO3A3R8qdP/cNfc6jR
	 9uQioi+xHFGFtWOuTHuWWgMfLjY3jVEnvt0L2BLprHcd8DMoAXOyAYoD6WCNMoCJTF
	 Mj5J1n8BCWO9D6mF0rPwCoXYfjVgg6Zqk3OpMLVvdLWyPmexVGYUaCf0728lf8sZ7G
	 PEKKd0xPYARpnWHroCrZFbyiaYeTCFYnSUTLRVl5iqF5M+6w2jE47ZSO/Ok/1ybIjy
	 Cy2rBoIIyjXiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] Input: Add driver for ESWIN EPH8621 touchscreen
 IC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Weiss" <luca.weiss@fairphone.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260917-eswin-eph8621-v2-2-f534080a6338@fairphone.com>
References: <20260917-eswin-eph8621-v2-0-f534080a6338@fairphone.com>
 <20260917-eswin-eph8621-v2-2-f534080a6338@fairphone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 08:35:09 +0000
Message-Id: <20260917083510.092F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] input: unhandled SPI errors in IRQ handler cause IRQ storm
- [Low] input: implicit return of input_register_device() in probe
--

commit 72cf856c7b1ca07b03f9ce8e0bf75be42e60151c
Author: Luca Weiss <luca.weiss@fairphone.com>

Input: Add driver for ESWIN EPH8621 touchscreen IC

This commit adds a new SPI driver for the ESWIN EPH8621 series touchscreen
controllers.

> diff --git a/drivers/input/touchscreen/eswin_eph8621.c b/drivers/input/to=
uchscreen/eswin_eph8621.c
> index 0000000000000..866cdc7e9334d
> --- /dev/null
> +++ b/drivers/input/touchscreen/eswin_eph8621.c
[ ... ]
> +static irqreturn_t eswin_interrupt(int irq, void *dev_id)
> +{
> +	struct eswin_touch *ts =3D dev_id;
> +	int payload_len;
> +
> +	payload_len =3D eswin_comms_two_stage_read(ts, ts->rx_buf);
> +	if (payload_len > 0)
> +		eswin_process_report(ts, ts->rx_buf, payload_len);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Will this cause an interrupt storm if a communication error occurs?

If eswin_comms_two_stage_read() fails and returns a negative error code
(like -EINVAL), the device's interrupt condition isn't cleared. By
unconditionally returning IRQ_HANDLED, the kernel's spurious IRQ detector
is bypassed. Because the physical interrupt line is still asserted, won't
the interrupt immediately fire again and lead to an infinite CPU loop?

[ ... ]
> +static int eswin_probe(struct spi_device *spi)
> +{
[ ... ]
> +	error =3D devm_request_threaded_irq(dev, spi->irq, NULL, eswin_interrup=
t,
> +					  IRQF_ONESHOT, dev_name(dev), ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed to request IRQ\n");
> +
> +	return input_register_device(ts->input);
> +}

[Severity: Low]
This isn't a bug, but does this violate the input subsystem's style
preferences for explicit failure paths?

The subsystem guidelines recommend against using `return action(...);` where
the action returns an error code in functions with multiple failure points.
Should this be expanded to capture the return value of=20
input_register_device(), check it, and explicitly return 0 on success?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-eswin-eph8=
621-v2-0-f534080a6338@fairphone.com?part=3D2
