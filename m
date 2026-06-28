Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF521B6D08
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654667; cv=none; b=jhKN66LLca/VN1pIOI5O/XfCsj6axWZewC0qptf7R+no2KYtsvQSPLehCjv4u90S2QjbvbJKLUuKmfh+VSR32wKidXAMZ+zyXXSc47kxNFyqhV3c45PVm+JZIhplejjvIAC7m+f+hDY0bz2U76EnwBZLNdPDWujea9Z/nYRfvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654667; c=relaxed/simple;
	bh=tRc5L4wAX03CoAxUJzGkdyBWv/XymjOPCmdmbMVf/Kk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gFhufl4rpjpLycT+GMrmtMN0IezN/GUFiiige9x6B6zZIW/vQ2ddthBDN+SLH821oKSrEn3QWZ0l4NRpaLwzvFo3f3qAOY7Xw4PX3cyUNLU37zgP/P7/zWA2ZjF+GqMCgGEaVQa11MIrpy5JIk673KLmsA+cBKZs3+/BsYWIAnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5kzBAYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5kzBAYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC751F000E9;
	Sun, 28 Jun 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782654665;
	bh=VdGZl1PwCGAXT9FwZnx75JcqYPNL33j5MAIlidM2Glw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5kzBAYz86EB8tusskE7PD3Hphr1L8uiORYVLcw8JXbImo/2bg6/A+zssP7UZXxCc
	 PlGTaD7r3ljeMvhuR6pG3xt0VswIQMneIQoj/ec14Iz+LQyp6mrMiaKqZP06iM3HGj
	 xMKgxyMu5SzIHw0770Xo+wjHzpDainR6E8mF3CctvhiGDscsPgO96BxrmZIU2j2Dw8
	 oUs4xxIac6yv0/W8f90l8GCWnbD0IQrog9Jy6Qg+JsO3Pbw9wN+290/FzywKFEOZbw
	 mYh+A1EcgYd4A/xBmF7s+ISRCNahJuNlcEkig19mgPlM/RQQaqQLtZOulhlPh+LuRB
	 DJQGNcEt3VgIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: validate report
 size before copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628133717.941389-1-sammiee5311@gmail.com>
References: <20260628133717.941389-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 13:51:04 +0000
Message-Id: <20260628135105.3AC751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced bounds check rejects valid, maximum-sized out=
put reports.

Pre-existing issues:
- [Critical] Heap buffer overflow in GET_REPORT requests due to ignored use=
r space length parameter.
- [High] Data races and waitqueue corruption due to concurrent lockless HID=
 requests.
- [High] Heap buffer overflow in incoming report processing due to missing =
buffer bounds check.
- [High] Heap buffer overflow in `read_dma_buffer()` due to 4K max packet s=
ize rounding.
--

commit c642b7d6dc654ce88acbb51328c011ab2d5e04f0
Author: HyeongJun An <sammiee5311@gmail.com>

    HID: intel-thc-hid: intel-quickspi: validate report size before copy

    write_cmd_to_txdma() builds an output report in qsdev->report_buf, a he=
ap
    buffer allocated in quickspi_alloc_report_buf() to the device-descriptor
    derived max_report_len. This patch records the report_buf allocation si=
ze
    and rejects reports that do not fit before copying.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30c..1695efd5961d7 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -559,6 +559,8 @@ static int quickspi_alloc_report_buf(struct quickspi_=
device *qsdev)
>  	if (!qsdev->report_buf)
>  		return -ENOMEM;
> =20
> +	qsdev->report_buf_size =3D max_report_len;
> +

[Severity: High]
Since this size is based on the unadjusted device descriptor maximums, will
this reject valid maximum-sized output reports?

When the driver builds an output report in write_cmd_to_txdma(), it prepends
HIDSPI_OUTPUT_REPORT_HEADER_SIZE. If a maximum-sized report is sent, the
combined size will exceed qsdev->report_buf_size and trigger the new bounds
check.

>  	return 0;
>  }
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
This is a pre-existing issue, but can multiple threads corrupt
qsdev->report_buf by executing this concurrently?

Since HID core does not serialize raw_request, multiple threads performing
concurrent HID ioctls (like HIDIOCGFEATURE and HIDIOCSFEATURE) could enter
write_cmd_to_txdma() simultaneously. Without locking, they would overwrite =
the
shared qsdev->report_buf with their respective headers and payloads.

This concurrent access could also corrupt the shared waitqueue state when
handling the responses:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c:quickspi_handl=
e_input_data() {
    ...
    qsdev->get_report_cmpl =3D true;
    wake_up_interruptible(&qsdev->get_report_cmpl_wq);
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does quickspi_get_report() overflow the
caller's buffer during GET_REPORT requests?

When a user space process issues a GET_REPORT ioctl with a smaller buffer,
hid_hw_raw_request() allocates a kernel buffer matching the requested lengt=
h.
However, quickspi_hid_raw_request() discards this length parameter:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c:quickspi_hid_raw_re=
quest() {
    ...
    ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf);
    ...
}

Then quickspi_get_report() copies the full device-supplied response into th=
is
potentially smaller buffer:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c:quickspi_get_r=
eport() {
    ...
    memcpy(buf, qsdev->report_buf, qsdev->report_len);
    ...
}

[Severity: High]
This is a pre-existing issue, but does quickspi_handle_input_data() lack
bounds checking before copying incoming reports?

When a device responds to a GET_FEATURE or GET_INPUT_REPORT, the function
trusts the incoming input_len:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c:quickspi_handl=
e_input_data() {
    ...
    qsdev->report_len =3D sizeof(body_hdr->content_id) + input_len;
    input_report =3D input_body->content - sizeof(body_hdr->content_id);

    memcpy(qsdev->report_buf, input_report, qsdev->report_len);
    ...
}

If a compromised or malicious SPI device sends an artificially large input_=
len
that fits within the DMA transaction's packet bounds (up to 4K) but exceeds
qsdev->report_buf_size, this memcpy will overflow the strictly allocated
qsdev->report_buf.

[Severity: High]
This is a pre-existing issue, but can the 4K packet size rounding in the DMA
configuration lead to a heap overflow?

dma_set_max_packet_size() rounds up the requested DMA max packet sizes (such
as max_input_len) to a 4K boundary:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:dma_set_max_packet_size=
() {
    ...
    dma_config->max_packet_size =3D ALIGN(size, SZ_4K);
    ...
}

When read_dma_buffer() receives data, it bounds-checks mes_len against this
4K-aligned max_packet_size before copying into the caller's buffer:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:read_dma_buffer() {
    ...
    if (mes_len > read_config->max_packet_size) {
        ...
    }
    ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
    ...
}

If a malicious device returns more data than max_input_len but less than the
4K boundary, the check passes. Since qsdev->input_buf was allocated without
this 4K alignment, the copy will overflow the buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628133717.9413=
89-1-sammiee5311@gmail.com?part=3D1
