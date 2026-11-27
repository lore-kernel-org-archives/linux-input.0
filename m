Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795795298;
	b=5RU0Y7s3dVndwrFp5b58uGCAbp1Clp6EwEFufeoAD024cj6BsFK2ltDdluKLaEsIiard
	 4V64ENQx/pt6A9hu+cy8QPS5XXfLl+KlanTse1DKahciDsoEtAgHuzGA7TyVqVUV/KPU8
	 sRVBkrTfN9nMJzAUIRfiPHGP9HY2xyciDrB0dlp63x/MOyNUqNoQVmpkq/fk7VWPw0rM5
	 d715be0skuhy4I3a5khjBsiJsx23XZ8vL52ioW/LxrtiAcaJ3ShM5vJ/A8IJ4NDeDzn5T
	 np0D92fXxQNZspMqZGrnoDo1XY6XIB8+9RR43HJiWTziIOlP7DdPFWoCN2mCZe2df2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795298;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WXfsxzAl08icYJ8DhSXuMSBzMqbOotHZtVV17wq0xhQ=;
	b=keb/vE9J2htAyLxiGKN6KJvBDrN4SOdxu6hFFY+Yxw7Zu79v9qFiT70kklGMfvHd1QF+
	 kuf5pLjjjTgPUBHrJxndNvsz/SMrqV0wyOMzE2ApXdIwraCi9KBM2xpaKNOjY+eGh0JMr
	 lGw6ic+KYMPPgCRaNUTcTTOUGlJYXMjNZxh1QxMeW2liE8D5EOiuQ4LCt+B+2ro8F/2zl
	 HLFGMKmyk0ShiwtP7p5czzeGok7qC80s7DiZh6SlDjrx76kOH+5I7bb5os5CrHI8BPFc0
	 oIrgbtXp5pyd1T/EJPuCfZdK6QQugMZ2ozz6QrPr6kAO27Gm8GF7VAb8VILJlg020Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXICTDNz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5BD606A321
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXICTDNz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652ED1F00898;
	Fri, 27 Nov 2026 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795795297;
	bh=WXfsxzAl08icYJ8DhSXuMSBzMqbOotHZtVV17wq0xhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXICTDNzwCgEPIvR8TeksnvGykZtvTZVNQLnBNJ6I9mfLw3RJ+is1+JsCd03g7ph9
	 Uu2n4wfT/7i9dtur7PPMSVdio3B+29+NuefX2rcsVtrhAU1utNVoqRZE59O3D+le2S
	 u14VmaFpq9ipqY/vHEiUECMvotbrSudTOrksGVz7IKxhbJofKr5KTymBwDIgkSTsQp
	 kOfGui64DkLjRUaAFVNA1Lb3JADt3ejPQJc87M8fahsA4QlTawK0PMJd4T6XKBh7zL
	 j4xahI0v+rlfXeS5ozDQx9XOsyglCFI3wnS/YVCVammvHVcXRK3oHVzDKKSbm5cFBM
	 LYFqdIde3Ntcw==
Message-ID: <sashiko-outbox-237812@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/6] HID: intel-thc-hid: intel-thc: expose the
 operations an IPTS port needs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <306c05c7d1ddc7f96fd6d3aafb5d6645d04406ed.1795794049.git.emfox@debian.org>
References: <cover.1795794049.git.emfox@debian.org>
 <306c05c7d1ddc7f96fd6d3aafb5d6645d04406ed.1795794049.git.emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:01:37 +0000
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
- [Medium] HID: intel-thc: 100 Hz rounding in thc_spi_hz_from_div()
  misses div8 gears
--

commit 7cfe4283a39cc31a3e9b305786a30873184104d6
Author: Emfox Zhou <emfox@debian.org>

HID: intel-thc-hid: intel-thc: expose the operations an IPTS port needs

This commit adds helper functions to check port support, control port
reset, and convert SPI base clock divisors into bus frequencies, and stops
warning in thc_interrupt_quiesce() when the port is already in the target
state.

> diff --git a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c b/driver=
s/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
> index 03d3b60b35cf1..d98c450c2b402 100644
> --- a/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c
> +++ b/drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c

[ ... ]

> @@ -1207,6 +1267,37 @@ static bool thc_spi_needs_half_div(u8 freq_div, u3=
2 spi_freq_val,
>  	       spi_freq_val < THC_SPI_FREQUENCY_15M;
>  }
> =20
> +/**
> + * thc_spi_hz_from_div - Turn a base clock divisor into a bus frequency
> + *
> + * @div: divisor, zero when the device did not provide one
> + * @div8: divide the result by eight as well
> + *
> + * A device that describes its bus timing as a divisor has to come back
> + * through here rather than through a copy of the base clock of its own:=
 the
> + * gears thc_spi_read_config() programs are fractions of that clock, and=
 a
> + * frequency computed from another base lands on the wrong one.
> + *
> + * Return: the frequency in Hz, or 0 for a divisor of zero
> + */
> +u32 thc_spi_hz_from_div(u8 div, bool div8)
> +{
> +	u32 hz;
> +
> +	if (!div)
> +		return 0;
> +
> +	hz =3D THC_SPI_BASE_HZ / div;
> +	if (div8)
> +		hz /=3D 8;
> +
> +	/* Geared frequencies are compared rounded to 100 Hz: round the same
> +	 * way here, or divisor 3 lands just below the 41 MHz gear.
> +	 */
> +	return DIV_ROUND_CLOSEST(hz, 100) * 100;
> +}

[Severity: Medium]
Does rounding to 100 Hz in thc_spi_hz_from_div() miss the low-frequency
gears when div8 is true?

Unlike the high-frequency gears, the div8 thresholds in frequency[] are
defined to 1 Hz precision:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dev.c:
    #define THC_SPI_FREQUENCY_2M2	2232143
    #define THC_SPI_FREQUENCY_2M6	2604167
    #define THC_SPI_FREQUENCY_3M1	3125000
    #define THC_SPI_FREQUENCY_3M9	3906250
    #define THC_SPI_FREQUENCY_5M2	5208333

thc_get_spi_freq_div_val() requires spi_freq_val >=3D frequency[i] to select
gear i.  With div8 =3D true, div =3D 7 yields 2232100 Hz, which falls below
THC_SPI_FREQUENCY_2M2 and causes thc_get_spi_freq_div_val() to fail with
THC_SPI_FRQ_RESERVED (-EINVAL in thc_spi_read_config() and
thc_spi_write_config()).  Similarly, div =3D 3 with div8 =3D true yields
5208300 Hz, which misses THC_SPI_FREQUENCY_5M2 and demotes the clock to
THC_SPI_FREQUENCY_3M9.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795794049.gi=
t.emfox@debian.org?part=3D1
