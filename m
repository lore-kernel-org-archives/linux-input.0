Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455183DA5D9
	for <linux-input@vger.kernel.org>; Fri, 17 Jul 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281057; cv=none; b=tgvLBBfnGmOCvkZwVnlzCb0A0vtrf18rUBnzyGtCmLV5FVcKtzPdPnC98INVfiGw4Kk4hNYYEgyQkBCne1OiPXAf/V8tYJlRaOb+ft1WkK2WA/kM2X68owrxCfe1iRPQsBrGyMf4v7C5dTt4msOZ61Z47CsVfJq7mMQK7/yBdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281057; c=relaxed/simple;
	bh=o/YH+Oaaj9coeIThdaHKR6l56rhPkWlW/uu8j7jE2UY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L0NNAbYo5BLvvdcazm2LogjrMckcEhi1ReUnmNVsGqKIMotakEKRxL+iAccMKcP8Is0NYufeH7E9vL3+T26pYvyIWxlJ7IMPVUc6EuLKv+QmlZ3tUXjfiHT5jNDpI6CtHC/IhMGnCnzJAktb5FSnIVyauq5T1CPNvN/sr0PSsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3srKPVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3srKPVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6751F000E9;
	Fri, 17 Jul 2026 09:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281056;
	bh=O6UZSAUmicP0y3EcGeAFCzglQqIg1Sup4tEwza9w2cY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O3srKPVsbsv7nP4nIfoFZBmbRLCjxubWHc+zPQYr6QF5qhjIa5FywCnx8MZpXAYWS
	 +XIA1LMeb4qruMWbWtK/F9Ih4wpcT7ZDLkVywRVjdZ+fkfOpCfIzJrGLa54C5kke8q
	 /UkHeQtdvh4GbcyA6hr7tVTSylsMzTBNBJ2Bwp6I1EPX56wWelzkNf81YkDRvLMVhR
	 UqYfaoh8Vug+tPmUkYP4TIHtKZffB9UaqYmlTsUwxbbed3Xs+hBGhNVbfUzzreQUSq
	 N0pH6ulZFjahy05pKUYz8VxJF1pUX+PceTEMS5UjVU0LGPact3i/S1d3mIT1QNyTrs
	 T9klNkQfVwl+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate report
 size before copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260717091622.1744196-1-sammiee5311@gmail.com>
References: <20260628133717.941389-1-sammiee5311@gmail.com>
 <20260717091622.1744196-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 09:37:35 +0000
Message-Id: <20260717093735.EA6751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unbounded memcpy in `quickspi_get_report()` causes a heap buff=
er overflow if the device responds with a report larger than the caller-all=
ocated buffer.
- [High] The receive buffer `qsdev->input_buf` can be overflowed during an =
RXDMA interrupt because the message size is bounds-checked against a 4K-ali=
gned limit instead of the actual buffer capacity.
- [High] Unbounded memcpy in `quickspi_handle_input_data()` causes a heap b=
uffer overflow of `qsdev->report_buf` on the receive path.
- [High] Concurrent ioctl requests lead to data corruption in the shared DM=
A buffer `qsdev->report_buf`.
--

--- Patch [1]: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate repo=
rt size before copy ---
commit 13f5051992cd9276077cab1966153d3866079f49
Author: HyeongJun An <sammiee5311@gmail.com>

    HID: intel-thc-hid: intel-quickspi: validate report size before copy
   =20
    write_cmd_to_txdma() builds an output report in qsdev->report_buf, a he=
ap
    buffer allocated in quickspi_alloc_report_buf() to the device-descriptor
    derived max_report_len (a few hundred bytes for a touch controller).  It
    copies the caller-supplied report into that buffer:
   =20
[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..da5ecfcd0fbf8 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -555,7 +555,14 @@ static int quickspi_alloc_report_buf(struct quickspi=
_device *qsdev)
>  	max_report_len =3D max(le16_to_cpu(qsdev->dev_desc.max_output_len),
>  			     le16_to_cpu(qsdev->dev_desc.max_input_len));
> =20
> -	qsdev->report_buf =3D devm_kzalloc(qsdev->dev, max_report_len, GFP_KERN=
EL);
> +	/*
> +	 * write_cmd_to_txdma() writes the output report header ahead of the
> +	 * content in this buffer, so it has to hold both.
> +	 */
> +	qsdev->report_buf_size =3D HIDSPI_OUTPUT_REPORT_SIZE(max_report_len);
> +
> +	qsdev->report_buf =3D devm_kzalloc(qsdev->dev, qsdev->report_buf_size,
> +					 GFP_KERNEL);

[Severity: High]
This is a pre-existing issue, but does the allocation for qsdev->input_buf
earlier in quickspi_alloc_report_buf() need to be 4K-aligned to prevent a h=
eap
overflow during an RX DMA interrupt?

In thc_rxdma_read(), read_dma_buffer() bounds-checks the message length
against read_config->max_packet_size, which is 4K-aligned via
thc_dma_set_max_packet_sizes().

If a hardware device sends a DMA packet larger than max_input_len but
smaller than or equal to ALIGN(max_input_len, SZ_4K), it would pass the
bounds check in read_dma_buffer():

intel-thc/intel-thc-dma.c:read_dma_buffer() {
    ...
    if (mes_len > read_config->max_packet_size) {
    ...
}

and copy up to 4096 bytes into qsdev->input_buf, which was allocated strict=
ly
to the unaligned max_input_len.

>  	if (!qsdev->report_buf)
>  		return -ENOMEM;
> =20

[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c=
 b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index cb19057f1191b..db6054843e777 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -30,6 +30,9 @@ static int write_cmd_to_txdma(struct quickspi_device *q=
sdev,
> =20
>  	write_buf =3D (struct output_report *)qsdev->report_buf;
> =20
> +	if (HIDSPI_OUTPUT_REPORT_SIZE(report_buf_len) > qsdev->report_buf_size)
> +		return -EINVAL;
> +
>  	write_buf->output_hdr.report_type =3D report_type;
>  	write_buf->output_hdr.content_len =3D cpu_to_le16(report_buf_len);
>  	write_buf->output_hdr.content_id =3D report_id;
> =20
>  	if (report_buf && report_buf_len > 0)
>  		memcpy(write_buf->content, report_buf, report_buf_len);

[Severity: High]
This is a pre-existing issue, but can concurrent ioctl requests cause data
corruption in the shared DMA buffer qsdev->report_buf?

Multiple userspace processes can concurrently call HIDIOCSFEATURE or
HIDIOCGFEATURE. The HID core routines hold a read-lock, allowing parallel
execution in the driver callbacks.

Does write_cmd_to_txdma() modify qsdev->report_buf and trigger DMA writes
without mutual exclusion against concurrent TX or RX requests like
quickspi_handle_input_data()?

quickspi-protocol.c:quickspi_handle_input_data() {
    ...
    memcpy(qsdev->report_buf, input_report, qsdev->report_len);
    ...
}


[Severity: High]
This is a pre-existing issue, but can the receive path also overflow
qsdev->report_buf?

While this patch secures the output path, quickspi_handle_input_data()
parses input_len from the payload and executes an unbounded memcpy:

quickspi-protocol.c:quickspi_handle_input_data() {
    ...
    memcpy(qsdev->report_buf, input_report, qsdev->report_len);
    ...
}

If a compromised device sends a GET_FEATURE_RESPONSE with a length exceeding
qsdev->report_buf_size, will this cause a heap buffer overflow?


[Severity: Critical]
This isn't a bug introduced by this patch, but is there an unbounded memcpy
in quickspi_get_report() that could cause a heap buffer overflow?

When a userspace process calls ioctl(HIDIOCGFEATURE) with a length parameter
smaller than the actual hardware report size, quickspi_hid_raw_request()
discards the bounds-checking len parameter:

quickspi-hid.c:quickspi_hid_raw_request() {
    ...
    ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf);
    ...
}

Then quickspi_get_report() copies qsdev->report_len bytes into the
caller's buffer without validating against the buffer's true capacity:

quickspi-protocol.c:quickspi_get_report() {
    ...
    memcpy(buf, qsdev->report_buf, qsdev->report_len);
    ...
}

Could this lead to memory corruption if the device responds with a report
larger than the caller-allocated buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717091622.1744=
196-1-sammiee5311@gmail.com?part=3D1
