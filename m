Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936918E02A
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139269; cv=none; b=aD5l7jfrq3EPFSC6a7AH+wADVJ638eV+PGJ+/EuUf8N7TBISsPoPkoLpRYq5thXTHbaTfPXn6GlIzi+8YHCB/TLqeWTFEO1D6riWA4X9KswBkN8SUCWVSyNL61QR3sHPMqD8E1Uxq8/5jxAu59/Bkx0BhOa/uEsMF4RHUR1S7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139269; c=relaxed/simple;
	bh=/i9G+A0jOBH5AAZG85fwm+75PLJ2usin7AyAPH7DmIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pfdvpWhCRKqKr5sf55yf8urQULmYSxN8PKwHbRFyIzWYGA6WRNcMd22hjK5wW7DFWZ8Li8dquTfLE3MO5YlLI/cbU+jHe9rlip3wNUe69qd7dTWwQUBkD5hTkDeWNXteJ6NdBvgg4Mjye+1lCjWCA1o6oGn1OHoYh49kjGqif9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtyLx+/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtyLx+/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1301F000E9;
	Wed, 19 Aug 2026 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787139268;
	bh=+APU7Wz6g8ltmkQaTw3TBobhgI9wUIejsbP5AmNuRiM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JtyLx+/Fw9GW1R0B0hRySFZ7IdlWa8tqTZlKu6uQLDqvc9mxJdtPi2j0jtxHkqW0R
	 viMre5zimdXcaPC9bzCpPMpd2w/UDFJoYPHN7I8D4ORgqWMddc6/fjYMusnH7EYj14
	 kq3sE8IDjkXweRxEZN8XqmHbLpQaO/hSA9nZpI1j+EPeKgk4QzKhOqhXPpphy/nWs7
	 ITZUUa9AvF9k/JEUaFjkvKvsrRM4JGpR2y8N0hxnkIYONhPfsUJVUJgNVbIy/gOWLo
	 +sRIX2HLy2FmoZ29y2opfgd16obHQ7zqgKPRi6Z/jgMbCNpI+VrMP2Hj8dSDGu+vrm
	 z2RiBdKG7Najg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] HID: usbhid: free unsent raw output reports in
 usbhid_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260819111203.2883239-2-dmantipov@yandex.ru>
References: <20260819111203.2883239-1-dmantipov@yandex.ru>
 <20260819111203.2883239-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:34:27 +0000
Message-Id: <20260819113428.1E1301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Emptying the `out` queue in `usbhid_stop` without updating the cor=
responding `hid_irq_out` completion handler causes an out-of-bounds queue a=
ccess, leading to a NULL pointer dereference and kernel panic.
--

--- Patch [2]: [PATCH v2 2/2] HID: usbhid: free unsent raw output reports i=
n usbhid_stop() ---
commit 026e2d1c35a0ae9588e9e7e4b956512ff4689607
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: usbhid: free unsent raw output reports in usbhid_stop()

When a HID device is stalled or disconnected, there might be unsent
output reports. This patch frees their raw buffers in usbhid_stop()
to avoid memory leaks.

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
Could emptying the out queue here cause a NULL pointer dereference if an
output URB is currently in-flight?

If an in-flight URB is canceled by the subsequent usb_kill_urb() call, it
will synchronously trigger the completion handler hid_irq_out() with status
-ENOENT.

Unlike hid_ctrl(), hid_irq_out() unconditionally increments outtail:

drivers/hid/usbhid/hid-core.c:hid_irq_out() {
    ...
    } else {
        usbhid->outtail =3D (usbhid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE -=
 1);

        if (usbhid->outhead !=3D usbhid->outtail &&
                hid_submit_out(hid) =3D=3D 0) {
    ...
}

If usbhid_stop() has already made outtail equal to outhead, this increment
pushes outtail out of bounds. The outhead !=3D outtail check will then pass,
and it will call hid_submit_out() which will dereference a NULL report:

drivers/hid/usbhid/hid-core.c:hid_submit_out() {
    ...
    report =3D usbhid->out[usbhid->outtail].report;
    usbhid->urbout->transfer_buffer_length =3D hid_report_len(report);
    ...
}

>  	spin_unlock_irq(&usbhid->lock);
> =20
>  	usb_kill_urb(usbhid->urbin);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819111203.2883=
239-1-dmantipov@yandex.ru?part=3D2
