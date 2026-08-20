Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6141A4F7
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225247; cv=none; b=JYxvga/0wX+PtHYwboxM+OCtyTTqeN/loqvkMovJ6Eh4nEik92gaCrjLC8GijCCz1gpfcfau4Nriae0AnRzl9pqKmG8khQl5kPdC/bzlEu5CTy7VsVM1sFje59FCnmK5lM5bfK5YBInLVnSmZwWy32C8zwoqPuAnVy+9KwlZdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225247; c=relaxed/simple;
	bh=CqOT5Wn4QJg7oeqx8rXLrXQ+RwvlOZHwxusVcYIF8yA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P6ijwfa4J33WB87F5Ct5x/kKKDLJB65o4qwcECOkH1Y8hkapQBNEZ6ThnAEyyRb5I7mAeHfLs2oh5nYxvOugZlN3HMpe0gH1UL+osf0H/w2JGQBJYHKMkWCXAfHov74rjP9IOLudQhIse5Ap4Z6XmrhxN6PauL4j2A5E0pzylCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlT9lOsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlT9lOsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F21F00A3A;
	Thu, 20 Aug 2026 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787225245;
	bh=6tsDTBT+2VgC58Hcw1k+Cm/DTRMZJFaozB0t7qFJ0oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FlT9lOsAJWpOmmmjjkEJj8Ytjr5sBTSK2EgX7ijLcK9TkP8FJSSwWA49tqheBqM4n
	 XZfG8VOKpJ1IvGIPdBoawIZBiYw8EdsylgKMB/DpnWUf+T2x9IloUNdIHlZkPpSff8
	 XI6EmwaMjMZcWtdq8uHWK607mfOkH1aGA7/LvCB2nqJlNT1l5gafgW85xnriw4hbHy
	 imvnUDH3wWxb/y/+SnGGjpVyeN8Zs8t6YZvuWSW6QeIemhLR+u8vHc5zrWU4pLY4GX
	 PcuWWn1LYG9oeaa3ojzNm1m2ZPrYkB+V3djsrXCRU/h9qyjNa6f7uky5ICIskcsHyQ
	 fvHKZiXXpxXPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the GET
 REPORT response to report_buf
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260820111558.475304-3-sammiee5311@gmail.com>
References: <20260820111558.475304-1-sammiee5311@gmail.com>
 <20260820111558.475304-3-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 11:27:25 +0000
Message-Id: <20260820112725.966F21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] State machine desynchronization in raw request handlers due to unr=
eset completion flags.
- [High] Missing locking in raw request handlers allows concurrent requests=
 to corrupt the shared command and response buffers.
- [High] Use-After-Free: DMA buffers are freed during driver remove() witho=
ut synchronizing with the threaded IRQ handler.
- [Medium] Subsystem API Violation: The transport driver uses hid_input_rep=
ort() instead of hid_safe_input_report().
- [Medium] Signal interruptions are incorrectly treated as timeouts in raw =
requests, breaking signal handling.
--

--- Patch [2]: [PATCH 2/2] HID: intel-thc-hid: intel-quickspi: bound the GE=
T REPORT response to report_buf ---
commit c4e25ca5cbdc0b92b00b6a64c016c4b8ee39d40d
Author: HyeongJun An <sammiee5311@gmail.com>

HID: intel-thc-hid: intel-quickspi: bound the GET REPORT response to report=
_buf

This patch bounds the GET_FEATURE and GET_INPUT_REPORT response copy lengths
to qsdev->report_buf_size. It drops responses that exceed this size to prev=
ent
overflowing the buffer with responses bounded only by the DMA packet size.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c=
 b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index 847c5ec55569a..7d34cc22a11a8 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
[ ... ]
> @@ -210,10 +211,17 @@ void quickspi_handle_input_data(struct quickspi_dev=
ice *qsdev, u32 buf_len)
> =20
>  	case GET_FEATURE_RESPONSE:
>  	case GET_INPUT_REPORT_RESPONSE:
> -		qsdev->report_len =3D sizeof(body_hdr->content_id) + input_len;
> +		report_len =3D sizeof(body_hdr->content_id) + input_len;
> +		if (report_len > qsdev->report_buf_size) {
> +			dev_err_once(qsdev->dev, "Get report response too big: %u\n",
> +				     report_len);
> +			return;
> +		}
> +
> +		qsdev->report_len =3D report_len;
>  		input_report =3D input_body->content - sizeof(body_hdr->content_id);
> =20
> -		memcpy(qsdev->report_buf, input_report, qsdev->report_len);
> +		memcpy(qsdev->report_buf, input_report, report_len);

[Severity: High]
This is a pre-existing issue, but missing locking in the raw request handle=
rs=20
appears to allow concurrent requests to corrupt qsdev->report_buf.

The HID core does not serialize raw_request callbacks. If multiple threads=
=20
concurrently call quickspi_hid_raw_request(), they will both execute=20
write_cmd_to_txdma().=20

This function writes the outgoing command into a single, unprotected shared=
=20
buffer qsdev->report_buf:

quickspi_hid_raw_request() -> write_cmd_to_txdma() {
    ...
    write_buf =3D (struct output_report *)qsdev->report_buf;
    ...
    memcpy(write_buf->content, report_buf, report_buf_len);
}

Concurrently, the IRQ handler quickspi_handle_input_data() also writes the=
=20
incoming response directly into the exact same qsdev->report_buf here.

Without a mutex protecting the request-response cycle and this buffer, coul=
d=20
concurrent requests overwrite each other's outgoing commands, and could=20
incoming responses overwrite commands being constructed?


[Severity: High]
This is a pre-existing issue, but can the state machine become desynchroniz=
ed=20
if a raw request times out?

If quickspi_get_report() times out, it returns -ETIMEDOUT without resetting=
=20
the completion flag qsdev->get_report_cmpl:

quickspi_get_report() {
    ...
    ret =3D wait_event_interruptible_timeout(qsdev->get_report_cmpl_wq,
                                           qsdev->get_report_cmpl,
                                           QUICKSPI_ACK_WAIT_TIMEOUT * HZ);
    ...
}

If the hardware eventually sends a delayed response, the IRQ handler will=20
set the flag to true. When a subsequent raw request is issued, it will writ=
e=20
the new command, but wait_event_interruptible_timeout() will return=20
immediately because the flag is already true.

Would this cause the driver to return stale data from the previous request=
=20
and lose synchronization with the device?=20

The set_report_cmpl flag appears to suffer from the exact same=20
desynchronization flaw in quickspi_set_report().


[Severity: Medium]
This is a pre-existing issue, but are signal interruptions incorrectly trea=
ted=20
as timeouts in raw requests?

In quickspi_get_report() and quickspi_set_report(), the driver uses=20
wait_event_interruptible_timeout(). If the wait is interrupted by a signal,=
=20
the function returns a negative error code (such as -ERESTARTSYS).

The driver checks for ret <=3D 0 and unconditionally returns -ETIMEDOUT:

quickspi_get_report() {
    ...
    if (ret <=3D 0 || !qsdev->get_report_cmpl) {
        dev_err_once(qsdev->dev, "Wait Get Report Response timeout, ret:%d\=
n", ret);
        return -ETIMEDOUT;
    }
    ...
}

Does this swallow the actual signal error code, preventing userspace from=20
correctly handling signals and breaking the syscall restart mechanism?


[Severity: Medium]
This is a pre-existing issue, but should the transport driver use=20
hid_safe_input_report() instead of hid_input_report() here?

According to the HID subsystem documentation, transport drivers must prefer=
=20
hid_safe_input_report() over hid_input_report() when feeding data from=20
hardware interrupts to the HID core.=20

This allows the core to perform strict boundary checks against the maximum=
=20
allocated buffer size, preventing out-of-bounds reads if a device supplies=
=20
a malicious report descriptor.

quickspi_hid_send_report() {
    ...
    ret =3D hid_input_report(qsdev->hid_dev, HID_INPUT_REPORT, data, data_l=
en, 1);
    ...
}

Does using hid_input_report() expose the HID core to potential out-of-bound=
s=20
reads?


[Severity: High]
This is a pre-existing issue, but could DMA buffers be freed during driver=
=20
remove() without synchronizing with the threaded IRQ handler?

During driver removal, quickspi_remove() disables hardware interrupts and=20
then calls quickspi_dma_deinit() which releases the DMA buffers:

quickspi_remove() {
    ...
    quickspi_dev_deinit(qsdev);
    quickspi_dma_deinit(qsdev);
    ...
}

However, it does not seem to synchronize with the devm-managed threaded IRQ=
=20
handler (quickspi_irq_thread_handler), which might already be executing on=
=20
another CPU.=20

The threaded handler calls thc_rxdma_read(), which reads from the DMA=20
buffers:

quickspi_irq_thread_handler() {
    ...
    ret =3D thc_rxdma_read(qsdev->thc_hw, THC_RXDMA2, qsdev->input_buf,
                         &input_len, &read_finished);
    ...
}

If thc_dma_release() frees these buffers while the threaded handler is=20
concurrently executing, could this result in a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820111558.4753=
04-1-sammiee5311@gmail.com?part=3D2
