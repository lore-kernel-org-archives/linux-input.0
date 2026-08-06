Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D04478865
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027536; cv=none; b=Bfy3a/9WsSp7mwW1fjF6flI0vqaA2BObPTTYHOO5jDci2T6S+WarrL/xS7JyHgSWvSzR+cC+IsPWABfPuYi2ajRy2ZUJv2QPJuc2db7oXrhH0Z+RbQKekT+oyzXReby0DxLHfshkFyvSW0u4u3ILw2b3yzT3d2pMiLZAEpCISHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027536; c=relaxed/simple;
	bh=aavTJP9tCC2LcAxgXrErBKZyyHbP4AfD564Qf7Yn6cY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hINEqqA9KNXONolIg5JPIHDg4s5ibqilVT4wKqZVj6ASIpvJkP+QLJ6aofFzKsaKXkPT1UMhq6eAlEz3TcOS4O0h5Vk85Uo9B+Eo0h4iP0GbSayR33xuw07ZX2LieTLSte8aW9HdW3zW36VbX5Uo4hF00zN6Obc2DkIQtQEsxvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noS9VHB0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noS9VHB0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3721B1F000E9;
	Thu,  6 Aug 2026 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786027534;
	bh=YvxHFA6XCT5K0x01aKyJPPcAg26Ot2sj/o9o7hQAZV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noS9VHB0hfz39g6grBpwiwkHzbu06lJuConeIfOhmi86OdzT5+giPcQAAc+UQtt2l
	 OmxAkhx05rcIZnhTuHWsrWtAXkt3gRbf70iBDlCAzPCQkg/Oo3OaZ43vbJbLsODtjo
	 B8jWuoahD26QDN6Uapi2SByufg4RYtBEccDKKYVyYfQmwVDdNyXtDH1bu4HJf2sPkj
	 8jHGN3h8gQ0aBD0IMBwl1PgetjqSjfqyOqyhZJrg3CDMYmOFYReiGgbbhtOge/QzAD
	 Ku1y8f57hPPsjZ9m7NMzZRaG9py5b2VspLngYxdF7RsHenBMpSgE6XaXYmnqDKifuE
	 h1ZPz56mSIcKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: bound GET_REPORT
 response to the caller buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806142321.3383353-1-sammiee5311@gmail.com>
References: <20260806133838.3378362-1-sammiee5311@gmail.com>
 <20260806142321.3383353-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:45:33 +0000
Message-Id: <20260806144534.3721B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Medium] Missing READ_ONCE() in TOCTOU fix allows compiler to reload valu=
e, bypassing the bounds check.

Pre-existing issues:
- [Critical] Missing bounds check on user-supplied `buf_len` in `quickspi_s=
et_report` causes a heap buffer overflow.
- [High] Lack of driver-level serialization allows concurrent IOCTLs and IR=
Qs to corrupt shared DMA buffers.
- [High] Asymmetric teardown in remove function leads to Use-After-Free of =
HID device in IRQ handler.
- [High] Heap buffer overflow in `read_dma_buffer` due to copying 4K-aligne=
d packet sizes into undersized input buffer.
- [Medium] Failing to reset waitqueue completion flags on timeout causes st=
ate machine desynchronization.
--

--- Patch [1]: [PATCH v2] HID: intel-thc-hid: intel-quickspi: bound GET_REP=
ORT response to the caller buffer ---
commit 0324df489da12163fd70da0bf173d44cda181192
Author: HyeongJun An <sammiee5311@gmail.com>

HID: intel-thc-hid: intel-quickspi: bound GET_REPORT response to the caller=
 buffer

This commit fixes an out-of-bounds write where the device-supplied response
is copied into the hidraw buffer without checking the buffer's length. It
updates quickspi_get_report() to take the buffer length and validate the
device's report size against it.

Link: https://lore.kernel.org/all/20260806133838.3378362-1-sammiee5311@gmai=
l.com/

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c b/driv=
ers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
index 91d5807b4a830..a60a0a7f16aad 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c
[ ... ]
@@ -61,7 +61,7 @@ static int quickspi_hid_raw_request(struct hid_device *hi=
d,
=20
 	switch (reqtype) {
 	case HID_REQ_GET_REPORT:
-		ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf);
+		ret =3D quickspi_get_report(qsdev, rtype, reportnum, buf, len);
 		break;
 	case HID_REQ_SET_REPORT:
 		ret =3D quickspi_set_report(qsdev, rtype, reportnum, buf, len);

[Severity: Critical]
This is a pre-existing issue, but are we missing a bounds check on the
user-supplied len in quickspi_set_report()?

When len (which can be up to HID_MAX_BUFFER_SIZE) is passed down to
write_cmd_to_txdma() in drivers/hid/intel-thc-hid/intel-quickspi/quickspi-p=
rotocol.c:

quickspi_set_report()
   ret =3D write_cmd_to_txdma(qsdev, rep_type, report_id, buf + 1, buf_len =
- 1);

Could this unconditionally copy a large user input into the driver's intern=
al
buffer, causing a heap buffer overflow?

>  		break;
[ ... ]
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b=
/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index cb19057f1191b..10b06dea39612 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
[ ... ]
@@ -372,9 +374,16 @@ int quickspi_get_report(struct quickspi_device *qsdev,
 	}

[Severity: Medium]
This is a pre-existing issue, but could this timeout error path leave the
completion flag in a desynchronized state?

If wait_event_interruptible_timeout() returns -ETIMEDOUT but the device
later responds, a delayed interrupt could set qsdev->get_report_cmpl to tru=
e.
Would the next IOCTL then bypass the wait queue and consume a stale respons=
e?

>  	qsdev->get_report_cmpl =3D false;
> =20
> -	memcpy(buf, qsdev->report_buf, qsdev->report_len);
> +	report_len =3D qsdev->report_len;
> +	if (report_len > buf_len) {
> +		dev_err_once(qsdev->dev, "Get report response too big, %u vs %u\n",
> +			     report_len, buf_len);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(buf, qsdev->report_buf, report_len);

[Severity: Medium]
Is it possible for the compiler to optimize away the local report_len varia=
ble
and reload qsdev->report_len directly from memory during the memcpy() call?

If an interrupt updates qsdev->report_len to a larger size after the bounds
check but before the copy, could it bypass the check and overflow the calle=
r's
buffer? Should this use READ_ONCE() to prevent reloading?

> -	return qsdev->report_len;
> +	return report_len;
>  }

[Severity: High]
This is a pre-existing issue, but is there a lack of driver-level serializa=
tion
that allows concurrent IOCTLs and IRQs to corrupt shared DMA buffers?

User space threads concurrently calling HIDIOCGFEATURE or HIDIOCSFEATURE via
hidraw only acquire a shared read lock (minors_rwsem). Both
quickspi_get_report() and quickspi_set_report() call write_cmd_to_txdma(),
which writes directly into the shared buffer locklessly:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c:write_cmd_to_t=
xdma() {
    ...
    if (report_buf)
        memcpy(write_buf->report_bdy, report_buf, report_buf_len);
    ...
}

Furthermore, the threaded IRQ handler concurrently writes device responses =
into
the exact same buffer:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c:quickspi_handl=
e_input_data() {
    ...
    memcpy(qsdev->report_buf, input_report, qsdev->report_len);
    ...
}

Can multiple threads and IRQs entering these paths simultaneously cause data
corruption or information leaks?

[Severity: High]
This is a pre-existing issue, but could the asymmetric teardown in
quickspi_remove() lead to a Use-After-Free of the HID device?

quickspi_remove() destroys and frees the hid_dev before hardware interrupts
are disabled:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_remove() {
    ...
    quickspi_hid_remove(qsdev);
    quickspi_dma_deinit(qsdev);

    pm_runtime_get_noresume(qsdev->dev);

    quickspi_dev_deinit(qsdev);
    ...
}

If the device is unbound via sysfs while hardware is actively sending
interrupts, could an interrupt fire in this window and cause
quickspi_handle_input_data() to invoke quickspi_hid_send_report(),
accessing the already freed qsdev->hid_dev?

[Severity: High]
This is a pre-existing issue, but is there a heap buffer overflow risk in
read_dma_buffer() due to copying 4K-aligned packet sizes into an undersized
input buffer?

The input_buf is allocated to the exact max_input_len:

drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c:quickspi_alloc_repo=
rt_buf() {
    ...
    qsdev->input_buf =3D devm_kzalloc(qsdev->dev, max_input_len, GFP_KERNEL=
);
    ...
}

However, the bounds check in read_dma_buffer() uses the 4K-aligned
max_packet_size:

drivers/hid/intel-thc-hid/intel-thc/intel-thc-dma.c:read_dma_buffer() {
    ...
    if (mes_len > read_config->max_packet_size) {
        ...
    }
    ret =3D sg_copy_to_buffer(sg, nent, read_buff, mes_len);
    ...
}

If a malfunctioning or malicious hardware device sends a packet larger than
max_input_len but within the 4K alignment, will it bypass the bounds check
and overflow the smaller heap allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806142321.3383=
353-1-sammiee5311@gmail.com?part=3D1
