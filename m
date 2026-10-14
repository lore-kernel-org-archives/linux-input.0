Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4235326B5;
	Wed, 14 Oct 2026 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986627; cv=none; b=tCUliTsidJAggnOwwIwuljMhTuDZZ5OKnxrDit21BWE7y5/DtPBanZj1NWSTkJN6TvSYjvkuqlelj/DCrkx1U/lWgcFzlIjWdc37d5hvwO4nYMNY3Fiu4GwEY6RJWq7xtnmAt2gYUyaUzRk4u2ZI39wcL84G2MGGnlwNs5lGWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986627; c=relaxed/simple;
	bh=QXboNzLTxr3eBXF9UQJDEX3cXMIc5L36e1L2g+PHYp8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pokTIHMxfBEm5XF6qlCtaAbgVIdobLf5WLTFtCnrd4amB7X5J8N9FpD4JUksjjm6jPw/KGJFnm2Jhtje+TgmKlbr8df7FaWkQHZIxrjDlhgCgPojXLkRasj5iMK6SNareCiIpo1dlnnm35U6r3vHKDEDQ+694xwTK69kamLvLME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXGrzPxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXGrzPxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08F51F00A2F;
	Wed, 14 Oct 2026 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791986621;
	bh=mQBE2FT0ku1TFYAqWdNwA6z/reMUrV8Ne9aQWDEfQ9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AXGrzPxeDwZ5DsK10+ILVTEai/qj5/uZxdwJga45L5AyuHqKA8FbCndjXmadwLb1g
	 pS14rZoMCpEto/NWgukdF0ATU/3/bHXWNL8urfexQsDez6k8UKR2AFfHd6sEAVWLfZ
	 N38RUt2j1P+MTvaAVOnZonPCRT1Ddzaznks22zCN3n7RKNElAa4j6I1KyT79fF/1nj
	 U353D91HklhfBbeO+EsTUzPCjwbAMw2HYjjf2vNyf8T8QjrU2zkWA8X2xXHJb3Ltw0
	 3D7+4CXaevTvZHiBhHCb9n9yUIoyic85EnCjZAQ6NxXxy445I2zMp2Zd+F4rYEgF6T
	 EYpHbvI14d1/A==
Message-ID: <sashiko-outbox-171400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261014135251.11234-3-wyibo6109@gmail.com>
References: <20261010143836.173883-1-wyibo6109@gmail.com>
 <20261014135251.11234-1-wyibo6109@gmail.com>
 <20261014135251.11234-3-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:03:40 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] input: incorrect work cancellation order and UART teardown sequenc=
e cause UAF
- [High] input: early return in pogo_wake_irq_enable bypasses teardown sync=
hronization causing UAF
- [Medium] input: data race on link state variables kb->connected and kb->h=
b_seen
- [Medium] input: spontaneous battery status frames break protocol by masqu=
erading as command replies
- [Low] input: lockless tx_pending synchronization allows late echoes to fa=
lsely complete retries
--

commit a6ba6892df355bac066ccad7a6e524f24c69aa8a
Author: Yibo Wang <wyibo6109@gmail.com>

    Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

This commit adds a serdev driver for the Tinno keyboard MCU used by
OnePlus and OPPO smart keyboards. The MCU communicates over a half-duplex
UART using a framed protocol. It supports touchpad, function keys, and
backlight control.

--- a/drivers/input/keyboard/oneplus-pogo-kbd.c
+++ b/drivers/input/keyboard/oneplus-pogo-kbd.c
[ ... ]
> +static int pogo_xfer(struct pogo_kbd *kb, u8 cmd, const u8 *payload, u8 =
len,
> +		     u8 *resp, unsigned int resp_size)
> +{
[ ... ]
> +		/*
> +		 * Drop any late echo/reply of the previous attempt: with
> +		 * tx_pending cleared the RX path ignores frames until the
> +		 * transfer below re-arms, so a delayed reply cannot complete
> +		 * the fresh iteration or race the resp buffer.
> +		 */
> +		WRITE_ONCE(kb->tx_pending, false);
> +		reinit_completion(&kb->echo_done);
> +		reinit_completion(&kb->resp_done);
> +		kb->tx_cmd =3D cmd;
> +		WRITE_ONCE(kb->tx_pending, true);

[Severity: Low]
Does this lockless synchronization for tx_pending allow late echoes to fals=
ely
complete retries?

If the UART RX path (pogo_handle_frame) observes tx_pending =3D=3D true and
matches the command, but then stalls just before calling
complete(&kb->echo_done), pogo_xfer() could time out and start a new retry.
When the RX thread resumes and calls complete(), it would satisfy the new
retry's completion with the old echo, potentially masking a real transmissi=
on
failure.

[ ... ]
> +static void pogo_handle_sync(struct pogo_kbd *kb, const u8 *p, unsigned =
int len)
> +{
[ ... ]
> +	if (!kb->connected || replug) {
> +		kb->connected =3D true;
> +		kb->hb_seen =3D false;

[Severity: Medium]
Could this modify the link state variables concurrently with pogo_power_off=
()?

Since pogo_power_off() modifies kb->connected and kb->powered while holding
kb->state_lock, but pogo_handle_sync() updates kb->connected and kb->hb_seen
here locklessly, the RX thread might clobber the teardown state. This could
leave kb->connected =3D true after the hardware is unpowered, bypassing che=
cks
in sysfs interfaces and potentially backfeeding power through the UART pins.

> +		kb->retry_ms =3D POGO_RETRY_MIN_MS;
> +		if (!READ_ONCE(kb->quitting))
> +			schedule_work(&kb->plug_work);
> +	}
> +}
> +
> +static void pogo_handle_frame(struct pogo_kbd *kb, const u8 *f, unsigned=
 int n)
> +{
[ ... ]
> +	default:
> +		if (cmd =3D=3D OWB_CMD_GENERAL_ACK && len >=3D 4 &&
> +		    payload[0] =3D=3D OWB_GEN_BATTERY_STATUS)
> +			kb->battery_level =3D payload[2];
> +
> +		if (READ_ONCE(kb->tx_pending) && cmd =3D=3D kb->tx_cmd + 1) {

[Severity: Medium]
Should there be an 'else' block for the battery status check?

The MCU can spontaneously transmit battery status frames (cmd 0x3B,
payload[0] 0x0E). If the host is currently waiting for a general command
reply (kb->tx_cmd =3D=3D 0x3A), the condition cmd =3D=3D kb->tx_cmd + 1 wil=
l match.
This causes the battery frame to be falsely accepted as the command reply,
which could cause pogo_set_general() to fail with -EPROTO and drop the real
reply that arrives later.

> +			/* reply layout for callers: cmd, len, payload */
> +			kb->resp_len =3D min_t(unsigned int, len + 2, sizeof(kb->resp));
> +			memcpy(kb->resp, &f[3], kb->resp_len);
> +			complete(&kb->resp_done);
> +		} else {
[ ... ]
> +static void pogo_wake_irq_enable(struct pogo_kbd *kb, bool enable)
> +{
> +	if (enable =3D=3D kb->wake_irq_enabled)
> +		return;

[Severity: High]
Does this early return bypass the synchronization barrier during teardown?

In pogo_wake_isr(), the hardware interrupt calls disable_irq_nosync() and s=
ets
kb->wake_irq_enabled =3D false. If pogo_remove() calls pogo_wake_irq_enable=
(kb, false)
while the ISR is executing after the flag has been updated, this early retu=
rn
will skip the disable_irq() call entirely.

This allows pogo_remove() to proceed with teardown and free the memory whil=
e the
ISR is still running and about to queue detect_work, leading to a use-after=
-free.

> +	if (enable) {
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
Could the cancellation order and serdev teardown sequence cause a use-after=
-free?

Because detect_work is cancelled before hb_work, if hb_work is running
concurrently, it can re-queue detect_work after it has been cancelled. The
lockless check !READ_ONCE(kb->quitting) allows a thread to read false, stal=
l,
and queue the work after these cancellations are finished.

Additionally, since the serdev port remains open during pogo_remove() (it c=
loses
later via devres), the UART RX callback can still execute, evaluate the loc=
kless
quitting flag as false, and queue plug_work after cancel_work_sync(&kb->plu=
g_work)
has already returned.=20

This sequence can leave works queued while devres frees the kb memory.

> +
> +	/* unregisters the input devices, the last possible led_work queuer */
> +	pogo_power_off(kb);
> +
> +	/* flush a led_work queued before the inputs went away */
> +	cancel_work_sync(&kb->led_work);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014135251.1123=
4-1-wyibo6109@gmail.com?part=3D2
