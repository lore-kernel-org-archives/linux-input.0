Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795864;
	b=FwdLQLzsdJ9AAe4ge0djUJ706aKfIg/wUkuTIW7oTYlwtX2pP+/LKBzG79oAoO85RXRG
	 Q9f/02Cn7SPigJnoFqv0/CUoASgmXwF0zxqzTp3y2WsR7/EcGn0UFb/rwqwZ/FutW6+St
	 6wjH/8LGJJ7iUJtF+xVD9uE0LQQYq6yAIaKVKYpbv3bqgx81ebIE+NECanLrRBdfrO4FV
	 xcQ8WKnlCKhhvZc0vj4xMRvG/Zm4TNhiz+FnghgSV3RTT1JHGpR0iKB/hdD5ogvYmI5Ur
	 Zr9p5495e+p7HmsFJKTHk4droso9P571VlXjPCbvn+bzUEdu36cvS8MfzRM0NxMwdUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Uzs9tgXMo/gBxJ/DqX5HGe+Gu8apxwwxv9Nc9U33Zq4=;
	b=TTKQvriiXazcFD/tesUqZiL2Ob0YGPeygwlQFm1PbqUqMHGAlNXZ90ywElfmuZsTh4nu
	 acyNEPcM3MicwJiAcOmzEaWGOi7xxLdjtAbaNqvzJsVe3P7gTpNFH/4xbaSDq+l5Mjss7
	 gcZAUAgKxtHWhX/zqLS6Ts/RGViiDjSLMl+Vh7U8bSpcj2VoDktB2P7pirrTEXFqFtv+m
	 ihcJHJyDzR0IkDbtOvRaR2XxZcuDnjdVlsStPbZ3zRWJJaHaG9AOv0Zdioin8/z8LLDOB
	 pzYIbJ/voV057MSt0L1lkZY5eAUPaJghx3hkA/M2ekz1GZe0QXoRYXffFxUOWCUBzpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc2FAXLH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBD2606A31E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tc2FAXLH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB9C1F000C1;
	Fri, 27 Nov 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795864;
	bh=Uzs9tgXMo/gBxJ/DqX5HGe+Gu8apxwwxv9Nc9U33Zq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tc2FAXLH5vZnkcgq22Iw1Il0F3AGqwcRVe8lMYjQ7DSCVO0PJ2lTcM/szZxF3BqaP
	 OhKGYkdu5ok4DnoZ0Df7ibsu9DxXVu3X49yuDeBDAcKwVg0/0t23Z3xgxshrvx64uy
	 ldUQtOI9xLkEXoZ4DQxvYSZYtyz0pe72dQCv7bFzcwmCdIv39g2eM5vK3nz83E/+6i
	 /aEST+IhJoAVPMOTaQSEEJfmP2pkOEAKey02CyYA6QICQCTXCMKcSuxdlxXKyZtjCO
	 qhybBSMy1Y/uJOyiVqVLQy242Nix0xPNaAs8Z2XpXUFWsxTmSiKUTFlRa3prgalSch
	 CGAkFaoGqEl4w==
Message-ID: <sashiko-outbox-237844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/6] HID: intel-thc-hid: intel-ipts: bring up the
 port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <011c212a1187be630f0106a059adc16ba7540fec.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
 <011c212a1187be630f0106a059adc16ba7540fec.1795794049.git.emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:11:03 +0000
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
- [Medium] HID: intel-thc-hid: 100 Hz rounding in thc_spi_hz_from_div()
  misses slow gears
--

commit 9057f6d4695018de027656c79eb1b4c3207e3b0b
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-ipts: bring up the port

This commit adds the intel-ipts PCI port driver to initialize Intel Touch
Host Controller ports in IPTS mode, read the controller's configuration
block over PIO, configure SPI timing, and enable the touch engine.

> diff --git a/drivers/hid/intel-thc-hid/intel-ipts/ipts.c b/drivers/hid/in=
tel-thc-hid/intel-ipts/ipts.c
> new file mode 100644
> index 0000000000000..c680b09265667
> --- /dev/null
> +++ b/drivers/hid/intel-thc-hid/intel-ipts/ipts.c
[ ... ]
> +/* The core takes the fastest gear that is not above the request. */
> +static void thc_ipts_spi_from_cfg(struct thc_ipts *idev, u32 *hz, u32 *m=
ode)
> +{
> +	u32 cfg =3D le32_to_cpu(idev->cfg.spi_cfg);
> +
> +	*hz =3D thc_spi_hz_from_div(THC_IPTS_SPI_CLKDIV(cfg),
> +				  cfg & THC_IPTS_SPI_CLKDIV8);
> +	if (!*hz) {
> +		dev_warn_once(idev->dev, "controller asks for divisor 0\n");
> +		*hz =3D THC_IPTS_SPI_MIN_HZ;
> +	}
> +
> +	/*
> +	 * THC_IPTS_SPI_MIN_HZ is the slowest gear the core has, so a lower
> +	 * request would be refused: run at the floor and keep the port.
> +	 */
> +	if (*hz < THC_IPTS_SPI_MIN_HZ) {
> +		dev_warn_once(idev->dev,
> +			      "controller asks for %u Hz, running at %u Hz\n",
> +			      *hz, THC_IPTS_SPI_MIN_HZ);
> +		*hz =3D THC_IPTS_SPI_MIN_HZ;
> +	}

[Severity: Medium]
Does the 100 Hz rounding in thc_spi_hz_from_div() cause slow SPI gears
with THC_IPTS_SPI_CLKDIV8 set to miss their target frequencies?

thc_spi_hz_from_div() rounds the computed frequency to the nearest 100 Hz,
whereas the low-frequency gear constants in intel-thc-dev.c and
THC_IPTS_SPI_MIN_HZ in ipts.h are specified to 1 Hz precision:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:
    #define THC_SPI_FREQUENCY_2M2	2232143
    #define THC_SPI_FREQUENCY_2M6	2604167
    #define THC_SPI_FREQUENCY_3M1	3125000
    #define THC_SPI_FREQUENCY_3M9	3906250
    #define THC_SPI_FREQUENCY_5M2	5208333

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:thc_spi_hz_from_div() {
    ...
	hz =3D THC_SPI_BASE_HZ / div;
	if (div8)
		hz /=3D 8;
    ...
	return DIV_ROUND_CLOSEST(hz, 100) * 100;
}

When a controller requests divisor 3 with divide-by-8 enabled,
thc_spi_hz_from_div(3, true) rounds 5208333 down to 5208300.  Because
5208300 is below THC_SPI_FREQUENCY_5M2 (5208333),
thc_get_spi_freq_div_val() falls back to THC_SPI_FREQUENCY_3M9 (3906250
Hz, THC_SPI_FRQ_DIV_4), running the SPI bus 25% slower than requested.

Similarly, when a controller requests the valid slowest hardware gear
(divisor 7 with divide-by-8 enabled), thc_spi_hz_from_div(7, true)
returns 2232100, which is below THC_IPTS_SPI_MIN_HZ (2232143) and
triggers a spurious warning in thc_ipts_spi_from_cfg().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795794049.gi=
t.emfox@debian.org?part=3D2
