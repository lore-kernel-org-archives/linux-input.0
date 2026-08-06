Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3A1E5B68
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030832; cv=none; b=s3I5JsXRTEPseyn06evRk7DYGb1rRsJWhjRL6w2fGGugmUFo+0sWd2Vw0UbJREwjuDRU/J/8dLzy0JsS8xntC5DREH40FG81FN6Z0XaQMjUmZIpvmi6VUvMqDPqsqtO0DotpbmZOTH3nATxW8wMk/OFgdrkWy3Bd8yHRcHrwfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030832; c=relaxed/simple;
	bh=/v9Qw3zHzOAX/0/4g/JCAhwrP512xweqOlF6PYzeTTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WPK7hwIGsUVql8oIL3uCjkb/r7wwF2t1NszhWGTbOggy2TzlcacV33MZ76N0aCUjbAScnccrySQO/5c9739D3HRbtHCIc2i3nXzAz3k/fTobsemM5e1HVR7vuBw1ysF20jHPb/gSAHVBVCLiw7t43eXPKjYQQFBN5sIafHbJcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs/1EU6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs/1EU6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0807A1F000E9;
	Thu,  6 Aug 2026 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030831;
	bh=YDJ32EbVUg6v779ia6ucXWJf9dkaDwZNG1TyOciLS9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vs/1EU6vzEdvQNy2vlqPX5HEIDfSInByHLq192ZYYbnZed02dfN4u5+9EdmweJ53J
	 +xV8U3VS64t+/Jrrm3LbjpR6AbcfgcX6KOkslR0V7kCm+J2aKkRKkGcJLpY3Sezb6k
	 dFM1fj8SmhEdEoRJv4qSUfP5LZH/wj8HFrwy5ceXct07pnb/xhTChYeE/5VX8y2Etp
	 3VEIskB7jTkmEYz+Q+iCKhooWCNcq1v+V+sq3GAhCWnZZTEB+NekdGbgrTX+tRlBlo
	 x2s+UIBpquOw6WXPOU3BwG+fZAQ/bFITxQgfnL8LVuzsQTbPV/PhWbXu286PWlQVIf
	 4lgaZU1ZVklpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
 response to the caller buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806145619.3386809-1-sammiee5311@gmail.com>
References: <20260806142321.3383353-1-sammiee5311@gmail.com>
 <20260806145619.3386809-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 15:40:30 +0000
Message-Id: <20260806154031.0807A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow in `read_dma_buffer()` and `quickspi_hand=
le_input_data()` due to mismatched bounds checking against the 4KB DMA limi=
t.
- [Critical] Heap buffer overflow in `quickspi_set_report()` due to missing=
 bounds check against the allocated size of `qsdev->report_buf`.
- [High] Data race and buffer corruption due to missing serialization acros=
s request and response handlers.
- [High] Use-After-Free in the IRQ thread handler against `qsdev->hid_dev` =
during device removal.
- [High] Missing CPU/Device synchronization for streaming DMA buffers.
- [Medium] State desynchronization in `quickspi_get_report()` and `quickspi=
_set_report()` due to stale completion flags.
--

--- Patch [1]: [PATCH v3] HID: intel-thc-hid: intel-quickspi: bound GET_REP=
ORT response to the caller buffer ---
commit a1a09cc358271f5bac5710688c074796a3f0d94b
Author: HyeongJun An <sammiee5311@gmail.com>

HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller=
 buffer

This patch adds bounds checking in quickspi_get_report() to prevent the
device-supplied response length from overflowing the caller-provided buffer.
It ensures that the copied response length does not exceed the size request=
ed
by the caller, mitigating potential memory corruption.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> index 91d5807b4a830..a60a0a7f16aad 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
> @@ -61,7 +61,7 @@ static int quickspi_hid_raw_request(struct hid_device *=
hid,
> =20
>  	switch (reqtype) {
>  	case HID_REQ_GET_REPORT:
> -		ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf);
> +		ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf, len);
>  		break;
>  	case HID_REQ_SET_REPORT:
>  		ret =3D quickspi_set_report(qsdev, rtype, reportnum, buf, len);

[Severity: Critical]
This is a pre-existing issue, but could this lead to a heap buffer overflow?

Userspace can invoke the HIDIOCSFEATURE or HIDIOCSOUTPUT ioctl via hidraw
with a payload up to HID_MAX_BUFFER_SIZE (8192 bytes). quickspi_set_report()
receives this user-controlled buf_len and passes it down:

quickspi-protocol.c:quickspi_set_report() {
    ...
    ret =3D write_cmd_to_txdma(qsdev, rep_type, report_id, buf + 1, buf_len=
 - 1);
}

write_cmd_to_txdma() then performs a memcpy directly into qsdev->report_buf:

quickspi-protocol.c:write_cmd_to_txdma() {
    ...
    if (report_buf && report_buf_len > 0)
        memcpy(write_buf->content, report_buf, report_buf_len);
}

Does the driver ever verify that the user-supplied length fits within the
dynamically allocated capacity of qsdev->report_buf before copying?

>  		break;

[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c=
 b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index cb19057f1191b..9dacfdf7aff64 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -372,9 +374,17 @@ int quickspi_get_report(struct quickspi_device *qsde=
v,
>  	}
>  	qsdev->get_report_cmpl =3D false;

[Severity: Medium]
This is a pre-existing issue, but does this leave the completion flag
vulnerable to state desynchronization?

The driver waits for qsdev->get_report_cmpl using
wait_event_interruptible_timeout(). If the wait times out (e.g., due to
device latency or signal interruption), the function returns -ETIMEDOUT but
leaves the completion flag unmodified.

When the delayed response finally arrives, the IRQ handler will set the flag
to true.

Since write_cmd_to_txdma() is called earlier without first explicitly
re-initializing the completion flag to false:

quickspi-protocol.c:quickspi_get_report() {
    ...
    ret =3D write_cmd_to_txdma(qsdev, rep_type, report_id, NULL, 0);
}

Will the next request immediately pass the wait queue condition because the
flag is already true from the delayed response, leading to reading stale
data?

> -	memcpy(buf, qsdev->report_buf, qsdev->report_len);
> +	/* quickspi_handle_input_data() updates this from IRQ context. */
> +	report_len =3D READ_ONCE(qsdev->report_len);
> +	if (report_len > buf_len) {
> +		dev_err_once(qsdev->dev, "Get report response too big, %u vs %u\n",
> +			     report_len, buf_len);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(buf, qsdev->report_buf, report_len);

[Severity: High]
This is a pre-existing issue, but is there a data race and potential buffer
corruption due to missing serialization here?

The HID core does not universally serialize hid_hw_raw_request() calls,
so multiple userspace threads could concurrently invoke quickspi_get_report=
()
and quickspi_set_report().

write_cmd_to_txdma() locklessly writes outgoing commands directly into the
shared qsdev->report_buf:

quickspi-protocol.c:write_cmd_to_txdma() {
    ...
    write_buf =3D (struct output_report *)qsdev->report_buf;
    write_buf->output_hdr.report_type =3D report_type;
}

The threaded IRQ handler quickspi_handle_input_data() also locklessly writes
incoming responses into the exact same qsdev->report_buf:

quickspi-protocol.c:quickspi_handle_input_data() {
    ...
    memcpy(qsdev->report_buf, input_report, qsdev->report_len);
}

If two threads send requests simultaneously, or if an incoming response
arrives while another thread is reading the response here via memcpy(),
could their payloads interleave and corrupt outgoing DMA commands or
incoming responses?

> -	return qsdev->report_len;
> +	return report_len;
>  }

[Severity: Critical]
This is a pre-existing issue, but is there a potential heap buffer overflow
in read_dma_buffer() and quickspi_handle_input_data()?

The driver allocates qsdev->input_buf and qsdev->report_buf based on
max_input_len and max_output_len from the device descriptor (e.g., 512
bytes). However, thc_dma_set_max_packet_sizes() aligns the max packet size
to 4096 bytes.

In read_dma_buffer(), it validates the packet size against this 4096-byte
limit rather than the allocated buffer size:

intel-thc-dma.c:read_dma_buffer() {
    ...
    if (mes_len > read_config->max_packet_size) {
    ...
    ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
}

If a device sends a packet larger than the allocated max_input_len, could
sg_copy_to_buffer() overflow qsdev->input_buf?

Furthermore, quickspi_handle_input_data() performs a memcpy() into
qsdev->report_buf without validating against its allocated size:

quickspi-protocol.c:quickspi_handle_input_data() {
    ...
    memcpy(qsdev->report_buf, input_report, qsdev->report_len);
}

Can this lead to a secondary overflow if the device provides an untrusted
length?

[Severity: High]
This is a pre-existing issue, but is there a potential use-after-free in the
IRQ thread handler during device removal?

During removal, quickspi_remove() destroys the HID device while the threaded
IRQ handler is still registered and active:

pci-quickspi.c:quickspi_remove() {
    ...
    quickspi_hid_remove(qsdev);
    quickspi_dma_deinit(qsdev);
}

Since devres IRQ cleanup runs after remove() returns, and the interrupt is
not explicitly disabled before the HID device is destroyed, could an
interrupt fire concurrently?

If so, quickspi_irq_thread_handler() will run and eventually call
quickspi_hid_send_report(), which dereferences the freed HID device:

quickspi-hid.c:quickspi_hid_send_report() {
    ...
    ret =3D hid_input_report(qsdev->hid_dev, HID_INPUT_REPORT, data, data_l=
en, 1);
}

[Severity: High]
This is a pre-existing issue, but does the DMA code miss CPU/device
synchronization for streaming DMA buffers?

The driver uses dma_map_sg() to map its RX/TX ring buffers. In
read_dma_buffer(), it accesses the buffers via sg_copy_to_buffer() without
calling dma_sync_sg_for_cpu() to explicitly transfer ownership from the
device to the CPU:

intel-thc-dma.c:read_dma_buffer() {
    ...
    ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
}

Similarly, in write_dma_buffer(), it writes data using sg_copy_from_buffer()
but never calls dma_sync_sg_for_device() before starting the DMA:

intel-thc-dma.c:write_dma_buffer() {
    ...
    ret =3D sg_copy_from_buffer(sg, nent, buffer, buf_len);
}

Can this lead to reading stale cache lines or device writing to un-bounced
memory on systems using SWIOTLB or non-coherent architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806145619.3386=
809-1-sammiee5311@gmail.com?part=3D1
