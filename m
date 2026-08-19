Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E8A24BBF0
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139305; cv=none; b=Id2wUwuMkfz1iJolcepX+JYBVG9yXNqGvDc2HqvityudgUj4p9QBJkYv/VfeEOt0aHYUFT0Gt7a9cp8r1ooSSatN3PRgM4Kx65ieTsq4ToS1rIU3sE/axBxruAvgkSVn+WGYYJ2vK2TGIEmsp8VTH4lJMJl92bFsNpE8I+ncdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139305; c=relaxed/simple;
	bh=vt3v7AJuyGqtNeXAONFOp1xB4z3NhjwshLssVW5WXqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UdyacjJ1uW0ZnqZhY4TptL/EjAnafhSyeq1+b64AjobRtOjRl4Wu5Mdkk9dos/0bt3sJh9RFfH/hmxeVYWW5z9fsZvWd+nD6kVAZ206abrCb+ZKEm+rvHbZOjvfg0Cyauf2BYHkdO6UJ1/cZ8/Ab+e3XsWkG1jtu+r3XINWUtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VioTFT4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VioTFT4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89E61F000E9;
	Wed, 19 Aug 2026 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787139304;
	bh=Bai1fNJI9ODSJJS+39Kz7Aexsd7odi/k0AgxRMy5O1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VioTFT4EourK7pQP0tYRMsbgWonw+iXbIkRnaY1g1F8E+iuRsmuzGBZuvDqG42I6v
	 oSxjdtqhnML5nuAgFdraYjEz/tAzoWUMs+eHm6CgV08jWXWdHOY64EipkPUH4pHQik
	 DZwGBf+Fn6vBoUoiMeWKAWOUQIlNLG3xqwAn9Lvr8MgK6Fx4NLNxWNsIYHpbelUHbf
	 iVjS6nRaUXtM4hK2J6DMmrRZUWc7b1V1d2f5Ea8dzQnQddWkK9St0pltwbNBikJHhv
	 Yio6r9wyG8D63LevpNRubE3kAO/zPcQcnfMYAuPowf+yjgzLg0Zzj6r/LvyyQAv4cD
	 LXBkhooqN9jwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] HID: usbhid: adjust output pipe FIFO size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819111203.2883239-1-dmantipov@yandex.ru>
References: <20260819111203.2883239-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:35:03 +0000
Message-Id: <20260819113503.D89E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of dynamically allocated `raw_report` buffers in the o=
utput and control queues upon device unplug and driver unbind.
--

--- Patch [1]: [PATCH v2 1/2] HID: usbhid: adjust output pipe FIFO size ---
commit bf134e3969fdce1c368463a2ad06d7c96d56d312
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: usbhid: adjust output pipe FIFO size

For an USB-specific HID device, size of output FIFO should
be HID_OUTPUT_FIFO_SIZE rather than HID_CONTROL_FIFO_SIZE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://syzkaller.appspot.com/bug?extid=3De2c057ea576d2644e2be
Fixes: 4916b3a57fc9 ("[PATCH] Generic HID layer - USB API")

> diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
> index 75fe85d3d27a0..c408e694a7b27 100644
> --- a/drivers/hid/usbhid/usbhid.h
> +++ b/drivers/hid/usbhid/usbhid.h
> @@ -74,7 +74,7 @@ struct usbhid_device {
>  	unsigned long last_ctrl;						/* record of last output for timeouts */
> =20
>  	struct urb *urbout;                                             /* Outp=
ut URB */
> -	struct hid_output_fifo out[HID_CONTROL_FIFO_SIZE];              /* Outp=
ut pipe fifo */
> +	struct hid_output_fifo out[HID_OUTPUT_FIFO_SIZE];               /* Outp=
ut pipe fifo */

[Severity: High]
This isn't a bug introduced by this patch, but while adjusting the output
FIFO size, I noticed a pre-existing memory leak related to how these output
and control queues are cleaned up.

In drivers/hid/usbhid/hid-core.c, when a device is physically unplugged,
the URB completion callbacks receive an error and handle it by clearing
the FIFOs.

For example, in hid_irq_out():

    if (unplug) {
        usbhid->outtail =3D usbhid->outhead;
    } else {

And similarly in hid_ctrl():

    if (unplug) {
        usbhid->ctrltail =3D usbhid->ctrlhead;
    } else if (usbhid->ctrlhead !=3D usbhid->ctrltail) {

Does this drop the queued items without calling kfree() on their
dynamically allocated raw_report buffers?

Additionally, during driver unbind, usbhid_stop() handles draining the
control queue and correctly freeing raw_report:

    while (usbhid->ctrltail !=3D usbhid->ctrlhead) {
        if (usbhid->ctrl[usbhid->ctrltail].dir =3D=3D USB_DIR_OUT) {
            kfree(usbhid->ctrl[usbhid->ctrltail].raw_report);
            usbhid->ctrl[usbhid->ctrltail].raw_report =3D NULL;
        }
        ...
    }

However, it completely omits an equivalent cleanup loop for the output
queue (usbhid->out).

Could this repeatedly leak memory if userspace or the input subsystem
queues output reports while device unbinds or disconnects occur?

>  	unsigned char outhead, outtail;                                 /* Outp=
ut pipe fifo head & tail */
>  	char *outbuf;                                                   /* Outp=
ut buffer */
>  	dma_addr_t outbuf_dma;                                          /* Outp=
ut buffer dma */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819111203.2883=
239-1-dmantipov@yandex.ru?part=3D1
