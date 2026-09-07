Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54A456DE2
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788776370; cv=none; b=r5wCftWGwc9v4S8GmN86VSNS4Pvnypz8WZCf0p98f9ufimqESG0UDzIIHpub+9AKAa19GA5rezyCUzGA8kcBhplrtwdow+yGyS9TGREMENOkXClWRmc1s5Uevi1ieSDdkHuUUVziYXp/v5xntwPYBYhdBq3DB+Ta4Js/fuPGyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788776370; c=relaxed/simple;
	bh=HIe6CEW65mLhR7vD3WXC334UpJIXWADFkEqLQeIqh9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WS6vYzXXCtFx3E4cg2xmtH8DrFWA7lQ0xOFfv4+8h2dYd4wvh4tWrV0iStwi7CJxHuV5NZTSc4Qs+yJs7NZuMRnku93wvwhCw3eVqb4SRjUmQwTLKpL4JcICVqaVHHuTj/zRAkWmA5kkU7M0PenZiLxGbCfsutqHmAW6h0Uj9Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbHudQhu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbHudQhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845251F00A3A;
	Mon,  7 Sep 2026 10:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788776368;
	bh=aWq3EzADCAJGy25rrpIez3Pz4VFfbjPYuvU9KhUPRkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbHudQhuvHgpNSfcsNpJYfSpXklYQ1GXgpYwCQuc43uVyEHsuxAxMJMlshBGya5ZW
	 PVh+k1HgwYrgj/23iRAiQ3LW4CdSwhnkEbHK8dxfltW4OT7mLFcQF8qUVUxPMJpAlh
	 tKLM6RfLEIRvaGoNMxJVsKgFSBpNzAQrh2CpqEDywLyXB74MubjwLvU6fQPMOvIC9F
	 Mqr/7KcpShicCaSCMwZhllDCPcRPma7rusQPCFNNADN1v45sx4Le3VI+N8AqpXlPR4
	 CUsiStoBMc5jwAOSXUjjbUpam9SEakRjyIP7sZK3ZhaclOL2CnDBD8On05i1qbv1T7
	 VLHxpvgOEkJug==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v2 2/2] HID: usbhid: free unsent raw output
 reports in usbhid_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260907100645.86990-2-dmantipov@yandex.ru>
References: <20260907100645.86990-1-dmantipov@yandex.ru>
 <20260907100645.86990-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:19:28 +0000
Message-Id: <20260907101928.845251F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Emptying the output queue in `usbhid_stop()` causes the URB comple=
tion handler `hid_irq_out()` to advance `outtail` past `outhead`, leading t=
o a NULL pointer dereference in `hid_submit_out()`.
--

commit fa290a16b56c6527830ed98c05dc263369208959
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: usbhid: free unsent raw output reports in usbhid_stop()

When HID device is stalled or disconnected, there might be an
unsent (i.e. never passed via hid_submit_out()) output reports.
So free their raw buffers in usbhid_stop() to avoid memory leaks.

Closes: https://syzkaller.appspot.com/bug?extid=3De2c057ea576d2644e2be

> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 96b0181cf8194..60662616fd2a0 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1253,6 +1253,14 @@ static void usbhid_stop(struct hid_device *hid)
>  		usbhid->ctrltail =3D (usbhid->ctrltail + 1) &
>  			(HID_CONTROL_FIFO_SIZE - 1);
>  	}
> +
> +	while (usbhid->outtail !=3D usbhid->outhead) {
> +		kfree(usbhid->out[usbhid->outtail].raw_report);
> +		usbhid->out[usbhid->outtail].raw_report =3D NULL;
> +
> +		usbhid->outtail =3D (usbhid->outtail + 1) &
> +			(HID_OUTPUT_FIFO_SIZE - 1);
> +	}

[Severity: High]
Does emptying the output queue here cause a NULL pointer dereference
when usb_kill_urb() subsequently cancels the in-flight URB?

When usb_kill_urb(usbhid->urbout) invokes the hid_irq_out() completion
handler with -ENOENT, unplug is 0. Unlike hid_ctrl(), hid_irq_out()
unconditionally advances outtail without checking if the queue is empty:

drivers/hid/usbhid/hid-core.c:hid_irq_out() {
	...
	if (unplug) {
		usbhid->outtail =3D usbhid->outhead;
	} else {
		usbhid->outtail =3D (usbhid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);

		if (usbhid->outhead !=3D usbhid->outtail &&
				hid_submit_out(hid) =3D=3D 0) {
	...
}

Because this loop in usbhid_stop() already made outtail equal to outhead,
advancing it moves outtail into an uninitialized slot and makes the
outhead !=3D outtail condition true.

This then triggers hid_submit_out(), which dereferences the NULL report
pointer from the uninitialized slot:

drivers/hid/usbhid/hid-core.c:hid_submit_out() {
	...
	report =3D usbhid->out[usbhid->outtail].report;
	...
	usbhid->urbout->transfer_buffer_length =3D hid_report_len(report);
	...
}

Should hid_irq_out() be updated to check if outhead !=3D outtail before
advancing the queue, similar to what hid_ctrl() does?

>  	spin_unlock_irq(&usbhid->lock);
> =20
>  	usb_kill_urb(usbhid->urbin);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907100645.8699=
0-1-dmantipov@yandex.ru?part=3D2
