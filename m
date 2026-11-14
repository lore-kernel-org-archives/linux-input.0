Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676839;
	b=afOm/PcqqBmpkUrgUhjJwZGATpexlmcweYowNfE2U5iHy0G3WT3OnvmxpPSNPFEyHHPQ
	 jI6SYwpKHXNKmWrL2S7z+DSYVgRn1mXzTTJ/0SxFe+DnfOjxNvz/SVUEKjjCrdZaNPzO1
	 lJmd0NMBYwnT7zy6Kz6QThdxsUEtyil61rsTLx4wuAJuwj6n/4eMRE/9nvqFpALK9JiTi
	 xW0iNaDY1rUlokOYxT77u/OgfdaefE7SUjEPvuqyfNRMmUUjFeBxAbg0rKRuMrFkkjtrx
	 sMPTKBPZ7baoLk7LHpZQpqFLIeE8ehpcwApe9uJIgKkf0U1WLpUCnl27yrtzCq8Xqtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676839;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nzMUb0knagtu8dpFPSR7Gi5BZZSsykqcEMcrh+5rCk8=;
	b=0KdJXGskd67UsiFY3e3k3ipGFoErRgOjAavHQ8PZX85CerzoKIhIioze/9ISZeyxSM8c
	 3P3Hi0wxrCs4UIvDeTA9G2pHB8PlROt30TZBIhdBK60ujkqjg/RvWAeB/Dbdp1bKHTx3D
	 zF3IAzs2C1S0BT3XHwB2dPJ79AAkDCrCuWXu3FjbuacwbSvTJATAhV9Ej7xCYUzdylq3m
	 zvEpCYPLJTLcQQRHPgEOJqkcfhwe32rucdaXNQs5Y7HaZRqBo3lBUx7a0sNEPEqLl0Usg
	 2cKIhHgU+MViiiYDmJpcwtshjMBPjTiRyijVCCjlnmjiGnnlUAwlwiUmtuSmM72Ctnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW3KxWb8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DAF606A327
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 17:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW3KxWb8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5AD1F000C4;
	Sat, 14 Nov 2026 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794676839;
	bh=nzMUb0knagtu8dpFPSR7Gi5BZZSsykqcEMcrh+5rCk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IW3KxWb8riWeNT8x4i7wxFGCYKd5ig7LmvECTspqisCTPaMCRfk8/ZuGtu/L4IULX
	 OJeYsO4hfy2fbQp5pI/jFrMUY5yYVBzmHwzoWxmrBwuJtQWVI66Qx7L7ktJK96/Jjl
	 NAj3pb7eezBtbR/IKeMX0Df28vjauYXpdkvAAueQMK28NfyZ7POHAZq/jlNfxTxLGl
	 Q1peh0sd9Bee8g/5aR9ka0B8kxPZxX4kBcFB21bcjDzPfSVtEFYK57TKrzceImsVdG
	 DSFWlzXwEARFaAkjA3TddYhPP0Pem12in/MiLVEbzTC5xFvS/f9a81lpS/gXJPSbzD
	 TWk0BkXy5eAVg==
Message-ID: <sashiko-outbox-214831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] HID: intel-thc-hid: intel-ipts: bring up the
 port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261114170740.2068179-2-emfox@debian.org>
References: <20261114170740.2068179-1-emfox@debian.org>
 <20261114170740.2068179-2-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 17:20:38 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: intel-thc-hid: intel-ipts: set idev->running in
  thc_ipts_port_start()
--

commit 603b533dc41071ba0e983a0108dc8c85c96dd22a
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: bring up the port

This commit adds a PCI driver for Intel Touch Host Controller ports in
IPTS mode that brings up the SPI port, reads the controller configuration
block, configures SPI timing, and enables the touch engine.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> new file mode 100644
> index 0000000000000..f139b8f9443d0
> --- /dev/null
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c

[ ... ]

> +int thc_ipts_port_start(struct thc_ipts *idev)
> +{

[ ... ]

> +	ret =3D thc_ipts_touch_set(idev, true);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * thc_ipts_port_stop - tear one port down
> + * @idev: port to stop
> + */
> +void thc_ipts_port_stop(struct thc_ipts *idev)
> +{
> +	if (!idev->thc)
> +		return;
> +
> +	if (idev->running)
> +		thc_ipts_touch_set(idev, false);
> +
> +	idev->running =3D false;
> +	regmap_clear_bits(idev->thc->thc_regmap,
> +			  THC_M_PRT_CONTROL_OFFSET,
> +			  THC_M_PRT_CONTROL_DEVRST);
> +	thc_ipts_quiesce(idev, true);
> +}

[Severity: Medium]
Should thc_ipts_port_start() set idev->running to true after
thc_ipts_touch_set(idev, true) succeeds?  Without that, idev->running is
never set in this commit, so thc_ipts_port_stop() skips disabling and
powering down the touch engine before asserting hardware reset on driver
removal or shutdown.  Note that a later patch in the series, commit
"HID: intel-thc-hid: intel-ipts: receive reports", adds this assignment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114170740.2068=
179-1-emfox@debian.org?part=3D1
