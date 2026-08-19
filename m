Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E972437474
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131797; cv=none; b=XOn+C00Z+ptUIvURiePQR1O9nN+5sRYsUfVocZxevL4Kgq/K7S66D7Mej4JBFZFPv2v0MsHhMiodzDEJE8Rf6/iB2fGPkGFEOsfBMDJ2VWLXAJum09+GjKBHyMqbq7ndmmckZ3WUseGwBxO+8tAfkPAtNQVL2Q0QNd9QHN6vuUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131797; c=relaxed/simple;
	bh=EhivRo/NdpR24xtx4Rzs9EdpxR5V9qrJZ8z13MLufpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NlEiKWrDYjmRI71vA1tKbw0p40h6JwSnHZnL6hdug1STPy6w8+iBuwckw6CiijJL7t9RiEhnxe3RPmtod6EDFtP7LDrlp7UEGEw7qPTwG5VcjR+1RzkJMlHeXbtEE7RM0n7RcyoY0iTID/vIj/iwUxG1qkuPrH/GJLDvOa8ByTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab10oL77; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab10oL77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E15F1F000E9;
	Wed, 19 Aug 2026 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131790;
	bh=clBGFgmop+LovhQKQr4zPZMTmWI/Njr/7AxA2k7ljvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ab10oL77EhWpbk24YCPA9DmO0KrJ35CMTobkXKEQL1S/AKqtQ5ztUWI5Mn4G+eP9I
	 SC3x+6AI1LbgbxGfPkQdaQm264pb92g0pNLLVKqiV3lCMgVDDhbYDT/SNoYDYi1isi
	 P29EEzfH8JaS4Otql6B9sm1bWc8nMlcTqzlG2gQYBOCddVBzh5SzUtKeCKsfhwMFa0
	 tNyY1p6LjHxOfvBXEmYZzu0+QZLypqP7U51z1DZRS8BLyDBA/xh76sUikDEfYx7Pto
	 eBfzrJ8qVPVXYoBzefl0+ZaFBifOo6VSqzKcaJNdHH6pNsVe+fxj5OSTOLVyslIPSC
	 uDoJqZbyG6Ynw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: usbhid: free unsent raw output reports in
 usbhid_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260819090937.2856848-1-dmantipov@yandex.ru>
References: <20260819090937.2856848-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:29:49 +0000
Message-Id: <20260819092950.1E15F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Advancing `outtail` to `outhead` in `usbhid_stop()` before kil=
ling the active URB causes a queue underflow in `hid_irq_out()`, leading to=
 a NULL pointer dereference.
- [Low] The output queue cleanup loop incorrectly uses `HID_CONTROL_FIFO_SI=
ZE` instead of `HID_OUTPUT_FIFO_SIZE` to wrap the `outtail` index.

Pre-existing issues:
- [High] The patch fails to resolve the `raw_report` memory leak when a dev=
ice is unexpectedly removed, contradicting the commit message's primary cla=
im.
--

--- Patch [1]: [PATCH] HID: usbhid: free unsent raw output reports in usbhi=
d_stop() ---
commit 2636e8bec5c393ff996cba8abd150f864da2447f
Author: Dmitry Antipov <dmantipov@yandex.ru>
HID: usbhid: free unsent raw output reports in usbhid_stop()

This commit attempts to fix memory leaks of unsent raw output reports
when a HID device is stalled or unexpectedly removed. It adds a loop
in usbhid_stop() to free the raw_report buffers and advance the outtail
index.

Link: https://syzkaller.appspot.com/bug?extid=3De2c057ea576d2644e2be

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 96b0181cf8194..599a7566b825a 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
[ ... ]
> @@ -1253,6 +1253,14 @@ static void usbhid_stop(struct hid_device *hid)
>  		usbhid->ctrltail =3D (usbhid->ctrltail + 1) &
>  			(HID_CONTROL_FIFO_SIZE - 1);
>  	}
> +
> +	while (usbhid->outtail !=3D usbhid->outhead) {

[Severity: High]
This isn't a bug introduced by this patch, but does this actually fix the l=
eak
when the device is unexpectedly removed?

If the device is unplugged while an output report is in flight, the URB
completion handler hid_irq_out() runs with status -ESHUTDOWN and sets
unplug =3D 1. It then does this:

drivers/hid/usbhid/hid-core.c:hid_irq_out() {
    ...
    if (unplug) {
        usbhid->outtail =3D usbhid->outhead;
    }
    ...
}

This discards the pending queue entries before they are freed. Later, when
usbhid_stop() runs, usbhid->outtail already equals usbhid->outhead, so this
new while loop will be skipped entirely.

> +		kfree(usbhid->out[usbhid->outtail].raw_report);
> +		usbhid->out[usbhid->outtail].raw_report =3D NULL;
> +
> +		usbhid->outtail =3D (usbhid->outtail + 1) &
> +			(HID_CONTROL_FIFO_SIZE - 1);

[Severity: Low]
Does this use the wrong bitmask size?

The output queue size is defined by HID_OUTPUT_FIFO_SIZE, but this wraps
using HID_CONTROL_FIFO_SIZE - 1.

While the array in usbhid_device is sized using HID_CONTROL_FIFO_SIZE and
won't cause memory corruption, it forces outtail to traverse up to 192 unus=
ed
queue slots before wrapping.

> +	}
>  	spin_unlock_irq(&usbhid->lock);
> =20
>  	usb_kill_urb(usbhid->urbin);
>  	usb_kill_urb(usbhid->urbout);

[Severity: Critical]
Can clearing the queue here lead to a NULL pointer dereference in the URB
completion handler?

If an output URB is active during unbind, the new loop above advances outta=
il
until it equals outhead. Then the lock is dropped and usb_kill_urb() cancels
the in-flight URB.

The cancellation synchronously invokes hid_irq_out() with status -ENOENT:

drivers/hid/usbhid/hid-core.c:hid_irq_out() {
    ...
    } else {
        usbhid->outtail =3D (usbhid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE -=
 1);

        if (usbhid->outhead !=3D usbhid->outtail &&
                hid_submit_out(hid) =3D=3D 0) {
    ...
}

Because outtail already equals outhead from the loop in usbhid_stop(),
incrementing outtail here pushes it past outhead. The check
(usbhid->outhead !=3D usbhid->outtail) then evaluates to true, tricking the
driver into calling hid_submit_out() on an empty slot. This accesses a
zero-initialized slot and dereferences a NULL report pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819090937.2856=
848-1-dmantipov@yandex.ru?part=3D1
