Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BE78F2F
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803064; cv=none; b=nbZ9xQGVDcDSA2zYM6KQqVCU2jWGAh7h+xCoM97HnJsYlI6jR6BS7eT7biaSYKoE+hfSGRSct7V4VF1W6LrescKtIr2Hc7lQNGOnnFUYcHr7Zm6nzJgaLzPptgkXLBAhh6NrVCLKtGm/3XY/zydcPQRSKZQqyUrWiE+OGqhfW1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803064; c=relaxed/simple;
	bh=yRbD8kdfgcbSuhAs8QNzn/gohbi3IZN2C1Q1XQgwSvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZJE2u/O3Az6XbglmfzP7+4xPg+w33OMVzKk5kwVf4TgelWggK7XA7BAnPIDkSy7yOe+BpICcsy2cHWqD8JuZ+Z1ENumK8svyxiZrt7RxM07PEFFtsPbh/xT931qiFbbNOwKQC867YCSzMZ9BYEwivwkc0lnhR9XvBsurMluYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWbxvVv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWbxvVv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459181F000E9;
	Tue, 30 Jun 2026 07:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782803063;
	bh=CVXNyAJYHT9mzhyOJln3JIOoWkMLFybcRsWzjYn1M78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWbxvVv/d68t8T4tP/1LF4wjFYcw/9O4evl/fYRyhf4hFPztsYGPVdjdTRGG52b/V
	 JGNf+oOc+Sqe2Usi3dFsBzG6+2m2fijReoE94O6i+ACebnp3ECyWqh3nYOI3km/sV8
	 B0qNGcmCZ4bDjt/nTIvyj0Ljq4phPceLTse731Vf8TQAk5Qgpul4cbqe7BNBxJgD4T
	 tohiISTFWJ4fMt6AwB7SdAhQeHaOIS63CJBGLlUz3zzA5yqyjFX4e25hYflNTkcfaB
	 PKz/dgorpT2tIrc5uuvR7tr5naQUsl1hMqDNYF13CInk3rIqm+Tztd+8i4Rr9cS6y2
	 MRBGWpzqvsJAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: usbtouchscreen - validate Nexio reply length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <2026063007023179.2-ccfa108-0009-Input-usbtouchscreen---vali-pengpeng@iscas.ac.cn>
References: <2026063007023179.2-ccfa108-0009-Input-usbtouchscreen---vali-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:04:21 +0000
Message-Id: <20260630070422.459181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing `usb_kill_urb()` in `usbtouch_disconnect` for devices =
with `irq_always` leads to a Use-After-Free.
- [High] Missing URB restart in `usbtouch_reset_resume` for `irq_always` de=
vices.
- [High] Heap out-of-bounds read in `usbtouch_process_multi()` when handlin=
g fragmented packets from a malicious device.
- [Medium] The driver unconditionally submits a shared ACK URB in the inter=
rupt handler without checking if it is already active, leading to a WARN lo=
g-spam Denial of Service.
--

commit 5d3372d0fad0625b140375a0207438f22cdad247
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

Input: usbtouchscreen - validate Nexio reply length

This commit updates nexio_init() to require at least two bytes of reply=20
data before checking the embedded reply length at buf[1]. This prevents=20
reading uninitialized or out-of-bounds data when actual_len is 1.

> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/t=
ouchscreen/usbtouchscreen.c
> index 0bbacb517c286..0e07bcce5f96b 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -1011,7 +1011,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
>  		ret =3D usb_bulk_msg(dev, usb_rcvbulkpipe(dev, input_ep),
>  				   buf, NEXIO_BUFSIZE, &actual_len,
>  				   NEXIO_TIMEOUT);
> -		if (ret < 0 || actual_len < 1 || buf[1] !=3D actual_len)
> +		if (ret < 0 || actual_len < 2 || buf[1] !=3D actual_len)
>  			continue;
>  		switch (buf[0]) {
>  		case 0x83:	/* firmware version */

[Severity: High]
This isn't a bug introduced by this patch, but is it possible that the
polling URB will never be restarted for irq_always devices after a reset?

In usbtouch_reset_resume():

	if (usbtouch->is_open)
		return usb_submit_urb(usbtouch->irq, GFP_NOIO);

Unlike usbtouch_resume(), this misses the || usbtouch->type->irq_always
condition. If an irq_always device goes through a reset-resume cycle while
not actively opened by userspace, does this permanently break the hardware
polling contract and freeze the device until it is explicitly reopened?

[Severity: Critical]
This is a pre-existing issue, but does usbtouch_disconnect() have a
use-after-free risk for irq_always devices?

usbtouch_disconnect() calls:

	usb_free_urb(usbtouch->irq);
	if (usbtouch->type->exit)
		usbtouch->type->exit(usbtouch);
	usbtouch_free_buffers(interface_to_usbdev(intf), usbtouch);
	kfree(usbtouch);

Since usbtouch_close() omits calling usb_kill_urb() for irq_always devices,
and usb_free_urb() only decrements the reference count without cancelling
the in-flight URB, the URB remains active.=20

When usbtouch_disconnect() returns, usb_disable_interface() will forcibly
cancel active URBs, triggering the completion handler usbtouch_irq():

	struct usbtouch_usb *usbtouch =3D urb->context;
	struct device *dev =3D &usbtouch->interface->dev;

Won't this completion handler access the already-freed usbtouch context
upon normal device unbind or unplug?

[Severity: High]
This isn't a bug introduced by this patch, but does usbtouch_process_multi()
properly validate bounds against the actual packet length?

	tmp =3D pkt_len - usbtouch->buf_len;
	if (usbtouch->buf_len + tmp >=3D usbtouch->type->rept_size)
		goto out_flush_buf;
	memcpy(usbtouch->buffer + usbtouch->buf_len, pkt, tmp);

If a device advertises a small wMaxPacketSize, the usbtouch->data buffer
is allocated small. When calculating tmp to read from the current URB
payload pkt, it doesn't verify that the received data length is at least
tmp.=20

If tmp is greater than the received length, will this memcpy() read past
the end of the newly received data and out of the bounds of the small heap
allocation?

[Severity: Medium]
This is a pre-existing issue, but can the unconditional submission of
the ACK URB lead to a log-spam denial of service?

In nexio_read_data():

	/* send ACK */
	ret =3D usb_submit_urb(priv->ack, GFP_ATOMIC);
	if (ret)
		dev_warn(dev, "Failed to submit ACK URB: %d\n", ret);

If a device sends rapid touch packets via the bulk IN endpoint faster
than they can be acknowledged, the driver will attempt to submit the
already-active ACK URB.=20

Since the USB core rejects resubmitting an active URB and emits a kernel
warning, could a malicious or buggy device spam IN packets to trigger a
continuous stream of kernel WARN stack traces?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026063007023179.2-=
ccfa108-0009-Input-usbtouchscreen---vali-pengpeng@iscas.ac.cn?part=3D1
