Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B01265CC2
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025491; cv=none; b=NM/8c1aIuFDhIXEx/CylSQ8xWt9+J62eMaAKzA9Z2zzU65Oib23bZYl6BSnVDUo2EgWVYljXcDnq0zT8/SO3CmBq3pZCKN3+0XNZn7zb6o5ob+Z7q/pHWIDwdB4Hv0dnAbu6eUljBx/krWB5PYfRXv1vZkvaQ9YVSD/BCncTW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025491; c=relaxed/simple;
	bh=WAsiLfVIMNX6G8BOKe/Tv7Br0H5Ac9rBtSCfJNhdHNY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UYaT7ftcYagoUhZ2oTnpmPnrTCoqc1hOtT2jtVtXO8sCvlIRLjRVdsxhqzpFeQYJkC5nH20rOtkvKediTEP/rfT2e+ninCtd4hxp5GUkMi8I82AGSdIr29BzeJqYirOtYBx2kPLA3E/Z833XUuhPlzkiqp12oRIMkZkMK/goSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTDEOmnp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTDEOmnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B48C1F00A3A;
	Thu,  6 Aug 2026 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786025489;
	bh=ZW5cNd+/UND3tB3LNX21kUAnNJZZ1m7U7NVphMuTsB0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VTDEOmnpWCv6ZF+C7UUhGQmMZJHyuzuzk44ksKYenl3vF+RvgzjOf9dTJ4X6Oh2ad
	 LHv3fQbbCOK5Tp4a8Sf2INpfdhuUf3OKKjgrkR8IqhyhAp3Opp2cF63RbPzzeW6qTh
	 +1Ohuz96nMnuXr4ksnVukGQDJzNHv7vX+JQmIZgHRdmE0sNuULO9U5m1nxXDP8KN+4
	 y6RTfhsffxirJ7HC+HfrIzhyymaDXdWWTQsmmlmFotpdNtvm4VOZ98FrycLf5ZEjtW
	 yB+o7tyX93Nm2NKSZqYrtgQZa3naU+rPNaiWlLMmKEnGvo8HtilBXK+MxBP5Jm8mCo
	 paFja/s2wfZxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
 response to the caller buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806133838.3378362-1-sammiee5311@gmail.com>
References: <20260806133838.3378362-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:11:28 +0000
Message-Id: <20260806141129.9B48C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] The newly added bounds check for `qsdev->report_len` against `buf_=
len` is vulnerable to a Time-of-Check to Time-of-Use (TOCTOU) race conditio=
n.

Pre-existing issues:
- [Critical] Heap buffer overflow in `write_cmd_to_txdma` due to unbounded =
userspace input (host to device).
- [High] Missing synchronization around shared DMA buffers leads to data co=
rruption across concurrent HID raw requests.
- [High] Completion flags for report requests are not cleared before sendin=
g commands, leading to stale responses.
- [High] Malicious device input can overflow `qsdev->report_buf` due to mis=
matched maximum bounds (device to host).
- [High] Tearing down DMA before disabling interrupts allows the IRQ thread=
 to access freed scatter-gather lists.
- [High] Missing `dma_sync_sg_for_device` and `dma_sync_sg_for_cpu` calls w=
hen accessing long-lived DMA mapped scatterlists.
--

--- Patch [1]: [PATCH] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT=
 response to the caller buffer ---
commit ec62591c11a2dc3339b24ad3e40072aee89c7d83
Author: HyeongJun An <sammiee5311@gmail.com>

HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller=
 buffer

This patch adds a bounds check to quickspi_get_report() to ensure the
device-supplied qsdev->report_len does not exceed the caller-provided
buf_len. It aims to prevent buffer overflows when copying the response to
the caller's buffer.

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

[Severity: High]
This is a pre-existing issue, but does this code lack synchronization
around shared DMA buffers?=20

Multiple userspace threads can concurrently issue requests through
quickspi_hid_raw_request() lacking any mutual exclusion before touching sha=
red
device buffers. Both GET and SET report paths modify and read the same
qsdev->report_buf locklessly (e.g., via write_cmd_to_txdma()), and the IRQ
handler also writes to this buffer.=20

Could this lead to data corruption across concurrent HID raw requests?

>  		break;
>  	case HID_REQ_SET_REPORT:
>  		ret =3D quickspi_set_report(qsdev, rtype, reportnum, buf, len);

[Severity: Critical]
This is a pre-existing issue, but can unbounded userspace input cause a heap
buffer overflow here?=20

The user-controlled len is passed to write_cmd_to_txdma(), which executes:

if (report_buf && report_buf_len > 0)
    memcpy(write_buf->content, report_buf, report_buf_len);

This memcpy lacks bounds checking against the allocated size of
qsdev->report_buf, which could allow a local user writing to the hidraw
device to overwrite adjacent heap objects.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c=
 b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index cb19057f1191b..9c4fce09729d3 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
[ ... ]
> @@ -372,6 +373,12 @@ int quickspi_get_report(struct quickspi_device *qsde=
v,
>  	}
>  	qsdev->get_report_cmpl =3D false;

[Severity: High]
This is a pre-existing issue, but are the completion flags managed correctly
when timeouts occur?=20

If wait_event_interruptible_timeout() times out, it returns early and does =
not
reset qsdev->get_report_cmpl =3D false.=20

If a delayed interrupt then sets this flag, the next call to
quickspi_get_report() will send a command and immediately pass the wait_eve=
nt,
consuming stale or uninitialized response data.

> =20
> +	if (qsdev->report_len > buf_len) {

[Severity: High]
Is there a Time-of-Check to Time-of-Use (TOCTOU) race condition here?=20

The qsdev->report_len variable is evaluated in this condition and then
evaluated again in the memcpy below. Because there is no locking, a
concurrent update from quickspi_handle_input_data() could change
qsdev->report_len between the check and the use, leading to a buffer overfl=
ow
in the caller's buffer.

> +		dev_err_once(qsdev->dev, "Get report response too big, %u vs %u\n",
> +			     qsdev->report_len, buf_len);
> +		return -EINVAL;
> +	}
> +
>  	memcpy(buf, qsdev->report_buf, qsdev->report_len);
> =20
>  	return qsdev->report_len;
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h=
 b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
> index 775e29c1ed136..8a2338bee8085 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.h
> @@ -12,7 +12,7 @@ struct quickspi_device;
> =20
>  void quickspi_handle_input_data(struct quickspi_device *qsdev, u32 buf_l=
en);

[Severity: High]
This is a pre-existing issue, but could malicious device input overflow
qsdev->report_buf here?=20

In quickspi_handle_input_data(), the incoming data is validated against the
size of qsdev->input_buf, but then copied into qsdev->report_buf:

memcpy(qsdev->report_buf, input_report, qsdev->report_len);

Since qsdev->input_buf can be larger than qsdev->report_buf based on varying
device descriptor fields, could a device send a packet that passes the
input_buf bounds check but overflows report_buf?


[Severity: High]
This is a pre-existing issue, but does quickspi_remove() in pci-quickspi.c
tear down DMA resources before disabling interrupts?

quickspi_remove() {
    ...
    quickspi_dma_deinit();
    quickspi_dev_deinit();
}

The driver destroys DMA structures and SG lists before calling
quickspi_dev_deinit() to quiesce hardware interrupts. If a device interrupt
fires in this window, could the IRQ thread access freed scatter-gather
lists?


[Severity: High]
This is a pre-existing issue, but is the driver missing required DMA API sy=
nc
calls in intel-thc-dma.c?=20

The driver modifies and reads CPU virtual addresses of SG lists using
sg_copy_from_buffer() (in write_dma_buffer()) and sg_copy_to_buffer() (in
thc_swdma_read()).=20

Are calls to dma_sync_sg_for_device() and dma_sync_sg_for_cpu() required he=
re
to prevent silent I/O corruption on systems with SWIOTLB or non-coherent DMA
architectures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806133838.3378=
362-1-sammiee5311@gmail.com?part=3D1
