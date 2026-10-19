Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792422299;
	b=ojXTj/TuiR3KNql5iVZxzF2vNjA/aeuA90cInvK9HfyrjIshx4P+Tbapq8k4GweS8z5M
	 Z95o6CdfulAEDfll3xVwXaYmzPzLmurv4Wcc0mgkcXZjLi+RnmlecdDLlMsC9oehAs4BP
	 xTvJY5lBGmgPtwuVS1noi4OKwr3XooiWvHuA16c88XDbo7i316K7typC0XqVIB/2bKkYo
	 b7FwoAy/H7syUSerN6sV4hbe/Lm3TUl8FIgEWVaZBoZAm/e9FQJR5jpVzQcsBJBjGk32v
	 fvERkY9Kk83rSytos9BzDZpdFAxVUp+uj4BjMarp4z2MMRhSAG3NN2SpuuCUM5PW30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422299;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ad6v0L0F27TU6Te9QyxMaMLCYtKuYDKg5ncBirPOnb0=;
	b=3GEaOSv6XGc68kkiVPFYe94NRxQAJEoLp8XrTV4c5jASL9e/ogWKMMsjmqm3CPw7NamR
	 j84r+vteVeTCcsU62OwUtdmA0M31ANAvd8/UjMK8AaZPf9ANW9IfVa5InRy2SlDfLYJZJ
	 oj3BRejSDESvhxUZ4ztIelcFuD9iJojRyHMG7+Zf/dDiKJo9N2PGABy/iudwVDGyndMV1
	 jMkE0a8LFwH1PuM0J/cTgQvNwpyiz9lr6Z9NdeL15LJ0hIy/x1KHHzZExgrGvpAwl68zE
	 ryMpdWZsnEWKGC+JRqglyeFXhJfLBeNb7gMRZkWlhH4tV90d4lm58WPjl8WTV4MZ8Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8lnMjer;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1124607F4B5
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M8lnMjer
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CD71F000C4;
	Mon, 19 Oct 2026 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422298;
	bh=ad6v0L0F27TU6Te9QyxMaMLCYtKuYDKg5ncBirPOnb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M8lnMjer8Tp8eCRqE4qVTgSX2feLugmU8bDU2qzFdjUSMAdRBoVdNhHR9OuWs2Doa
	 CZxmcYJZ+56sjKoSuhFG40SN2zeBGrOlaEU1J5/xSiarK+XGST+rEyWoml/wmxdKm/
	 7f/urVmDv+mVM4b7e+CQkhE+t1F+RmLX5Y2vdmT2IYX6nf3Sf/7JE7CANnBAHlKpiW
	 DtqDK9dTDNuTGHaIUwKr87TsJL4a3PNf3ctadVrELNpHKoNpXA3iLpGwPdx/y3jiAX
	 Kadrh1Q1Hm8drYNQ2mPuBYr3ZHZ8HvU5tYdO/dMuVxgS5fMWAvUYYRg3JNrMT0nZpL
	 3eequlLk5ooiw==
Message-ID: <sashiko-outbox-177602@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] HID: Intel-thc-hid: Intel-quickspi: Fix
 buffer overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261019135441.1420968-326-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-326-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:04:57 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] HID: quickspi: quickspi_alloc_report_buf() under-sizes input_buf f=
or RXDMA
- [Medium] HID: intel-quickspi: quickspi_dma_init() omits header and rep_de=
sc_len in DMA sizes
--

commit 525db4dc56bd312030200280ce09472abe29a406
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quickspi: Fix buffer overflow

This commit expands the allocation of qsdev->input_buf in
quickspi_alloc_report_buf() using HIDSPI_INPUT_BODY_SIZE() so that it accou=
nts
for the 4-byte HID-over-SPI input body header in addition to the maximum
payload length.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 1c96d1d85845c..48387a7341604 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -549,7 +549,8 @@ static int quickspi_alloc_report_buf(struct quickspi_=
device *qsdev)
>  	max_input_len =3D max(le16_to_cpu(qsdev->dev_desc.rep_desc_len),
>  			    le16_to_cpu(qsdev->dev_desc.max_input_len));
> =20
> -	qsdev->input_buf =3D devm_kzalloc(qsdev->dev, max_input_len, GFP_KERNEL=
);
> +	qsdev->input_buf =3D devm_kzalloc(qsdev->dev,
> +					HIDSPI_INPUT_BODY_SIZE(max_input_len), GFP_KERNEL);

[Severity: High]
Can qsdev->input_buf still be overflowed during RXDMA reads in
thc_rxdma_read() -> read_dma_buffer()?

In quickspi_irq_thread_handler(), qsdev->input_buf is passed to
thc_rxdma_read() before quickspi_handle_input_data() validates the packet:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_irq_thread=
_handler() {
	...
	ret =3D thc_rxdma_read(qsdev->thc_hw, THC_RXDMA2, qsdev->input_buf,
			     &input_len, &read_finished);
	if (ret) {
		err_recover =3D 1;
		goto end;
	}

	quickspi_handle_input_data(qsdev, input_len);
	...
}

However, dma_set_max_packet_size() rounds read_config->max_packet_size up to
SZ_4K, and read_dma_buffer() only checks mes_len against
read_config->max_packet_size before copying into read_buff (qsdev->input_bu=
f):

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:read_dma_buffer() {
	...
	prd_tbl =3D &read_config->prd_tbls[prd_table_index];
	mes_len =3D calc_message_len(prd_tbl, &nent);
	if (mes_len > read_config->max_packet_size) {
		dev_err(dev->dev,
			"Message length %zu is bigger than buffer length %lu\n",
			mes_len, read_config->max_packet_size);
		return -EMSGSIZE;
	}

	sg =3D read_config->sgls[prd_table_index];
	ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
	...
}

Because the HIDSPI input report header encodes input_report_len in 4-byte
units (HIDSPI_INPUT_HEADER_REPORT_LEN with THC_UNIT_MICROFRAME_SIZE =3D 2),=
 even
a compliant device sending a report descriptor or maximum-sized input report
whose length is not a multiple of 4 bytes produces a 4-byte-aligned DMA
transfer that exceeds HIDSPI_INPUT_BODY_SIZE(max_input_len) by 1 to 3 bytes.
Furthermore, any incoming SPI frame with mes_len between
HIDSPI_INPUT_BODY_SIZE(max_input_len) and read_config->max_packet_size will=
 be
copied past the end of qsdev->input_buf before quickspi_handle_input_data()
runs.

[Severity: Medium]
Also, should quickspi_dma_init() be updated to match the buffer sizes compu=
ted
here in quickspi_alloc_report_buf()?

Right now, quickspi_dma_init() passes the raw max_input_len and max_output_=
len
from dev_desc to thc_dma_set_max_packet_sizes():

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_dma_init()=
 {
	...
	ret =3D thc_dma_set_max_packet_sizes(qsdev->thc_hw, 0,
					   le16_to_cpu(qsdev->dev_desc.max_input_len),
					   le16_to_cpu(qsdev->dev_desc.max_output_len),
					   0);
	...
}

Since QuickSPI receives both report descriptor responses and input reports
over THC_RXDMA2, if HIDSPI_INPUT_BODY_SIZE(max(rep_desc_len, max_input_len))
exceeds ALIGN(max_input_len, SZ_4K) (for example, when max_input_len is at =
or
within 3 bytes of a 4K boundary so adding the 4-byte header crosses into the
next 4K page, or when rep_desc_len + 4 > ALIGN(max_input_len, SZ_4K)), won't
the RXDMA2 scatterlist and max_packet_size be too small for the transfer?
Similarly, THC_TXDMA omits HIDSPI_OUTPUT_REPORT_HEADER_SIZE and max_input_l=
en
(used for SET_FEATURE reports in qsdev->report_buf).

>  	if (!qsdev->input_buf)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-326-sashal@kernel.org?part=3D1
