Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC4525A69;
	Fri, 16 Oct 2026 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169402; cv=none; b=QmY1rroi9vNEuZMaBfCTnAHV0wTMBEnGE9YIrO/3W+kse68T1qMmQEmZb3ymkgT5MBSTRy+VmzTCASBDlUFZ1FbALzDW0zxoklJAoV57GFBr2KeTC9spNtuRBQjoDDrql1vhFLnIBSfnLuC2dKKJKAakv8+HnkJlqZze9DpsoyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169402; c=relaxed/simple;
	bh=UImA8cYpBLvNiZlZAZgCL2GsX+CMC3XG8WnHT0qvxzU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dvcdnaWdIfZ81Lp6g3Kk/a3YmnXi757bZmpyuKYiD3aB8wNL2owHP+HQzSPnV5E23Q7Xl22iOyovXI6UG/8yUPXAFgRpkmUngNOCkQzhusCIr47ReMwv5TaxvnBbkbRNjInvRVJ0Tvs/a0pOsoROU97tUPt/WuN6//I5t8/OMqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd24Oa3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd24Oa3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDFB1F000C8;
	Fri, 16 Oct 2026 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792169399;
	bh=esfa2CJ+kq/M1Ei3Ia0U0h1TOpo9U/op3o7pm8PndAg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bd24Oa3x0AfpwQkItbVvmWmO53ozQ81BZIt5CYEwNSzc40YhLZMF3jgLksyXyvdlM
	 zAvFtPc5c+FElkZGhyI7T+UUmI/JvCq35dFlSWQd4NDKsWUIUIxRgBY64CVzFXbMYp
	 GlP38NIFJrqriFphdT+ljghd2Wr3Qvzt9JCAFrgx3UfjlOeS8k/08nrrZ+oHJs3KvX
	 4NRGNG0jCP+OS56xXNEObXcqR+xjTeMirHftT2riFCvFOMX2hd0VCRPRFwaH5O4mmv
	 LKu2U5jnvZzz9bk+ekT+1Lm4xJ48UM+Xv8u//G5HYBQmopuA6nkjt6IPmRheTRzVMu
	 LjGF3GduAcdng==
Message-ID: <sashiko-outbox-174666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016163859.1070138-3-wyibo6109@gmail.com>
References: <20261016163859.1070138-1-wyibo6109@gmail.com>
 <20261016163859.1070138-3-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 16:49:58 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] input: use-after-free in work queues due to lockless removal races
- [Medium] input: silent truncation of maximum-length responses in kb->resp
- [Medium] input: oneplus-pogo: data race on kb->resp buffer in pogo_xfer
- [Medium] input: oneplus-pogo-kbd: Data race on kb->connected state variab=
les
--

commit 55459b7da977a6dfb82c08f24907cc60a6e32cd0
Author: Yibo Wang <wyibo6109@gmail.com>

Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

Clean-room serdev driver for the Tinno keyboard MCU used by the OnePlus
Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro smart keyboards, replacing the
vendor platform driver that depends on a downstream msm_geni_serial
callback and a user-space held tty fd.

> diff --git a/drivers/input/keyboard/oneplus-pogo-kbd.c b/drivers/input/ke=
yboard/oneplus-pogo-kbd.c
> new file mode 100644
> index 0000000000000..afe87d9616174
> --- /dev/null
> +++ b/drivers/input/keyboard/oneplus-pogo-kbd.c
[ ... ]
> +static int pogo_xfer(struct pogo_kbd *kb, u8 cmd, const u8 *payload, u8 =
len,
> +		     u8 *resp, unsigned int resp_size)
> +{
[ ... ]
> +		if (!resp) {
> +			ret =3D 0;
> +			break;
> +		}
> +		if (wait_for_completion_timeout(&kb->resp_done,
> +				msecs_to_jiffies(POGO_RESP_TIMEOUT_MS))) {
> +			unsigned int n =3D min(kb->resp_len, resp_size);
> +
> +			/* stop the RX path before copying the reply out */
> +			WRITE_ONCE(kb->tx_pending, false);
> +			memcpy(resp, kb->resp, n);

[Severity: Medium]
Can this lead to a data race on the kb->resp buffer?

If a delayed reply from a previous attempt completes kb->resp_done early,
pogo_xfer() wakes up, sets tx_pending to false, and starts reading
kb->resp. Concurrently, the RX thread in pogo_handle_frame() may receive
the reply for the current attempt, evaluate tx_pending as true, and
overwrite kb->resp via memcpy() while pogo_xfer() is reading it.

This torn read could cause spurious -EPROTO initialization failures.

[ ... ]
> +static void pogo_handle_sync(struct pogo_kbd *kb, const u8 *p, unsigned =
int len)
> +{
> +	bool replug =3D false;
[ ... ]
> +	if (!kb->connected || replug) {
> +		kb->connected =3D true;
> +		kb->hb_seen =3D false;
> +		kb->retry_ms =3D POGO_RETRY_MIN_MS;
> +		if (!READ_ONCE(kb->quitting))
> +			schedule_work(&kb->plug_work);
> +	}

[Severity: Medium]
Is it safe to modify kb->connected here without holding kb->state_lock?

In pogo_power_off(), kb->connected and kb->powered are cleared under
kb->state_lock. If pogo_power_off() races with this RX path, this lockless
modification can leave the driver permanently desynchronized.

If pogo_power_off() sets powered =3D false and connected =3D false, and a d=
elayed
UART sync frame is processed here concurrently, this path will locklessly s=
et
connected =3D true. The subsequent schedule_work(&kb->plug_work) will exit
early because powered is false, leaving connected =3D true while powered is=
 false.

[ ... ]
> +static void pogo_handle_frame(struct pogo_kbd *kb, const u8 *f, unsigned=
 int n)
> +{
[ ... ]
> +		if (READ_ONCE(kb->tx_pending) && cmd =3D=3D kb->tx_cmd + 1) {
> +			/* reply layout for callers: cmd, len, payload */
> +			kb->resp_len =3D min_t(unsigned int, len + 2, sizeof(kb->resp));
> +			memcpy(kb->resp, &f[3], kb->resp_len);

[Severity: Medium]
Does this truncate maximum-length responses?

The kb->resp buffer is sized to OWB_MAX_PAYLOAD (128 bytes). By adding 2 to
len (for cmd and len), a maximum payload of 128 bytes yields len + 2 =3D 13=
0.
The min_t() will cap this at sizeof(kb->resp) (128), which silently truncat=
es
the last 2 bytes of the payload.

[ ... ]
> +static void pogo_remove(struct serdev_device *serdev)
> +{
> +	struct pogo_kbd *kb =3D serdev_device_get_drvdata(serdev);
> +
> +	/*
> +	 * Stop the world first: with quitting set, the RX path and the
> +	 * works stop queueing each other, so the cancels below cannot be
> +	 * undone again.  The wake IRQ is disabled (and any in-flight ISR
> +	 * finished) before detect_work is cancelled.
> +	 */
> +	WRITE_ONCE(kb->quitting, true);
> +	pogo_wake_irq_enable(kb, false);
> +	cancel_delayed_work_sync(&kb->detect_work);
> +	cancel_delayed_work_sync(&kb->hb_work);
> +	cancel_work_sync(&kb->plug_work);

[Severity: High]
Can this teardown sequence lead to a use-after-free of the work queues?

If pogo_wake_isr() is currently executing and has already called
disable_irq_nosync(), kb->wake_irq_enabled will be false.

When pogo_remove() calls pogo_wake_irq_enable(kb, false), it will hit
the early return:

    if (enable =3D=3D kb->wake_irq_enabled)
        return;

This bypasses the disable_irq() synchronization barrier. Because
pogo_wake_isr() checks kb->quitting without a lock, the ISR could observe
quitting =3D=3D false before pogo_remove() sets it, but queue the delayed
work after pogo_remove() has already completed the cancellations, resulting
in a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016163859.1070=
138-1-wyibo6109@gmail.com?part=3D2
