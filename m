Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7C2E7375
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062516; cv=none; b=uWndF3g1lLd7oUTIrpkVUrE8L1wCYX00sd+YT3Fsg8CWWHzYGBUziMhreUGPrMqt8VPIsfgZXJsfrutDGQ4vcL3AAD7rk+EfKJNR4CjRsiHjoMEd8DJwsNEkLisD7GYqGn2gQy/InCiUTxPM+8lWnR8B0fDphDTSw+lup6nEJXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062516; c=relaxed/simple;
	bh=4RIMZMeI1R1H632NpMoFwgKnPdrB7sZNAuPeQnccpKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FKuFHZ/GOKdfdvAxsISOG2BSR/9zbhaQ4zV/2LMpiyVEDUjb7OQgbY7Of4GxzLSXfOwNXOAxMwL9KxvWorSpMVkNb3Sr9uGXcvle4nPDMMF4rnf3k00xP10HNRUHPXPQ3YJnaBDpReeV4oMQXSGVCA0PMY1wZfxsCIhApKC16XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmibt2YM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmibt2YM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506C21F000E9;
	Tue, 18 Aug 2026 14:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787062514;
	bh=l1+2NumH2hvv8diyAQd4BOIrNemAw2FnBMFvvnyxlVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jmibt2YMUKvGu9InUQWaduGOQeAbCU3/6DPNbyib58s92kzCl9XSAxfamLbtNWPt4
	 c59YbICnx3pQouHSMxHU0rcM7fNqUsSL0szkv1x2uWbGOr7IsejiTkIIuhhrHfVGGs
	 MQJ5yz7x9e0Yhy8jjAtvjNh6BJvXqWDDLwzwtgwW8wy9sXQt07ETJ+2mhBW5xRWVHL
	 tO02WCLQWUiqNr4Ej/V5/ER/v5j4m8tjBU1ughMCkc1tOKNjOoE3+EfnyMZ0tCt+Do
	 HpWmCv1SnyZ/02ElqZmtfAT9H1iLu7OO3jc6CHrgkgheT2ptldnGnpFKggUbAaCWNX
	 lujP5v/DDEinA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: reject oversized QuickSPI
 GET_REPORT responses
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260818140245.1903804-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260818140245.1903804-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:15:13 +0000
Message-Id: <20260818141514.506C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on user-supplied buffer length in `quickspi_s=
et_report` leads to a heap buffer overflow in `write_cmd_to_txdma`.
- [High] Preexisting heap buffer overflows in the QuickSPI DMA input report=
ing paths due to 4KB-aligned boundary checks and unaligned allocations.
- [High] Concurrent `raw_request` calls are not serialized, leading to data=
 races and corruption on the shared `qsdev->report_buf`.
- [High] Incomplete fix in `quickspi_get_report` protects the user buffer b=
ut fails to prevent an out-of-bounds read from the kernel heap.
--

--- Patch [1]: [PATCH] HID: intel-thc-hid: reject oversized QuickSPI GET_RE=
PORT responses ---
commit 95a4cfcd8aa1ba2ab8a0e552fbf091c155176036
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

HID: intel-thc-hid: reject oversized QuickSPI GET_REPORT responses

Thread the HID core caller length into quickspi_get_report() and reject
responses that exceed the caller-provided buffer before the final copy.
Snapshot the completed response length once so the bound check, copy, and
returned byte count all use the same value.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protoc=
ol implementation")
Assisted-by: Codex:gpt-5
Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

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
This isn't a bug introduced by this patch, but are concurrent raw_request
calls serialized here?

It looks like multiple threads could invoke quickspi_hid_raw_request()
simultaneously from userspace. Without a driver-level mutex, could
concurrent threads write outgoing commands directly into the single shared
qsdev->report_buf in write_cmd_to_txdma()?

>  		break;
>  	case HID_REQ_SET_REPORT:
>  		ret =3D quickspi_set_report(qsdev, rtype, reportnum, buf, len);

[Severity: High]
This is a pre-existing issue, but does this pass an unvalidated user length
through to quickspi_set_report()?

If userspace issues a SET_REPORT request with a payload up to 4096 bytes, l=
en
is passed to write_cmd_to_txdma() without being validated against the
allocation size of the internal buffer. Could this unconditionally execute:

memcpy(write_buf->content, report_buf, report_buf_len);

into qsdev->report_buf and overflow the kernel heap?

>  		break;
>  	default:

[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c=
 b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index cb19057f1191b..acc9d67c53ca0 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c

[ ... ]

> @@ -371,10 +373,17 @@ int quickspi_get_report(struct quickspi_device *qsd=
ev,
>  		return -ETIMEDOUT;
>  	}
>  	qsdev->get_report_cmpl =3D false;
> +	report_len =3D READ_ONCE(qsdev->report_len);
> +
> +	if (report_len > buf_len) {
> +		dev_err_once(qsdev->dev, "Get report response too large: %u vs %zu\n",
> +			     report_len, buf_len);
> +		return -EINVAL;
> +	}
> =20
> -	memcpy(buf, qsdev->report_buf, qsdev->report_len);
> +	memcpy(buf, qsdev->report_buf, report_len);

[Severity: High]
This is a pre-existing issue, but does this check prevent out-of-bounds rea=
ds
from qsdev->report_buf?

While the new bounds check prevents overflowing the destination buf, it
doesn't seem to verify if report_len exceeds the allocation size of the sou=
rce
buffer qsdev->report_buf.

Since report_len is derived from an incoming hardware packet, if userspace
requests a large buffer length, could this memcpy read past the end of
qsdev->report_buf and leak adjacent kernel heap memory to userspace?

[Severity: High]
This isn't a bug introduced by this patch, but how is the capacity of
qsdev->report_buf validated against hardware DMA limits during allocation a=
nd
reporting?

It appears qsdev->input_buf and qsdev->report_buf are allocated to a precise
descriptor size in quickspi_alloc_report_buf(). However, the DMA limits are
aligned to 4KB in read_dma_buffer():

if (mes_len > read_config->max_packet_size) { ... }
ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);

If a device sends a packet larger than the descriptor size but smaller than
the 4KB-aligned max packet size, could this unconditionally copy the payload
into qsdev->report_buf and overflow the heap?

> -	return qsdev->report_len;
> +	return report_len;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818140245.1903=
804-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1
