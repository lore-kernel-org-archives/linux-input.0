Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4CE37F738;
	Sat, 10 Oct 2026 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791643708; cv=none; b=Ns6JXFKpTwHjibGK5EVU5z7SA6YWOfkPYVyamPTq+/J17ACuRIbe57ZW4MirttpSx39Tc0/bhMZxu9whsLgyFNBqenTR5idxSUKGOK1P2PDOoWflpY0M8ltMvpLtTLynyiAXMlL7yg8BFFvoHNUpoFulP4NqVOfwZH5ZopEYsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791643708; c=relaxed/simple;
	bh=9eXAqUdHb5iCwJj/z9DZAOPpshce/oZh24S/ryTsQAs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UHJNKNHZ+njeszCOKV5P7xpu1qqNF+xeGuv97ZhEAKfpzsXKwTPnCS/7hTVAlHIv2b0ns73YBexuytFgMMcrrLC89XBmWIoUUFXGOT3uvRPQO8rmj6IQhfH5b3g6kpCiHFio4PWBnQ2gHrhzoygk8ndgUQUCSShbDPclI4d2aTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy+KvSJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy+KvSJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B544B1F000FF;
	Sat, 10 Oct 2026 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791643707;
	bh=kpBw1ITpbJRICLuBLzE9RSXUVtHvenA1B64+VKkuL4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sy+KvSJeWG28jpegXjlKzYQVfVIp2S6QGu5S7Fb6pnGgbHAgcSBthy1bH+DmUunYZ
	 Kce+dNld104RKpWvJTGwqVAVqeLAQmaZSwXCuBbqMNJN1nCRj6yyncNQfXb+kUSujF
	 6FAF6GE1quv5XuUV04gqYSxCbEjMyly0jxSu4Ui0E229ewKY7NIjqd7ZKNsdxEQp86
	 OC51uHgMLeTOIPOWzPSrq0izapHMjbokThyrBOOSYiVXx2HmsnJGQmjx8pIfzbKKGL
	 4tyR3OrsLB/k6YeyPjNBUzcf8z/zgpNl6Yt5MGEJtHXfDhMHpv2PjqA3s3e0v4zpbW
	 e9egtD4x6G5Cg==
Message-ID: <sashiko-outbox-166671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com
Cc: linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261010143836.173883-3-wyibo6109@gmail.com>
References: <20261009122046.551915-1-wyibo6109@gmail.com>
 <20261010143836.173883-1-wyibo6109@gmail.com>
 <20261010143836.173883-3-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 14:48:26 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] input: UAF due to lockless quitting checks and incorrect work canc=
ellation order
- [Medium] input: Data race on link state variables due to missing state_lo=
ck in RX path
- [Medium] input: Race condition and missing memory barriers in TX/RX compl=
etion logic
--

commit 6e3d28332505730268c90370cf0f07792b89214b
Author: Yibo Wang <wyibo6109@gmail.com>

Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

This adds a serdev driver for the Tinno keyboard MCU used by OnePlus/OPPO P=
ad
smart keyboards. It implements a framed protocol over a half-duplex UART for
input events, heartbeat, and backlight control.

> diff --git a/drivers/input/keyboard/oneplus-pogo-kbd.c b/drivers/input/ke=
yboard/oneplus-pogo-kbd.c
> index 0000000000000..298f0eff52116
> --- /dev/null
> +++ b/drivers/input/keyboard/oneplus-pogo-kbd.c
[ ... ]
> +static int pogo_xfer(struct pogo_kbd *kb, u8 cmd, const u8 *payload, u8 =
len,
> +		     u8 *resp, unsigned int resp_size)
> +{
[ ... ]
> +	mutex_lock(&kb->io_lock);
> +	for (attempt =3D 0; attempt < POGO_XFER_RETRIES; attempt++) {
> +		bool echoed;
> +
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

[Severity: Medium]
Since WRITE_ONCE does not emit a hardware memory barrier, could the CPU reo=
rder
these stores on weakly-ordered architectures?

This might allow the RX thread to see tx_pending =3D=3D true while still re=
ading
the old tx_cmd, opening a race condition.

[ ... ]
> +static void pogo_handle_sync(struct pogo_kbd *kb, const u8 *p, unsigned =
int len)
> +{
> +	bool replug =3D false;
> +
> +	if (len < 2)
> +		return;
> +
> +	if (p[0] =3D=3D OWB_SYNC_PLUG_IN && p[1] =3D=3D 0x02 && len >=3D 9) {
> +		kb->brand =3D p[2];
> +		memcpy(kb->mac, &p[3], POGO_MAC_LEN);
> +		/*
> +		 * The MCU repeats this frame until the host has talked to it;
> +		 * only a plug-in frame after regular heartbeats is a re-plug.
> +		 */
> +		replug =3D kb->connected && kb->hb_seen;
> +	} else if (p[0] =3D=3D OWB_SYNC_HEARTBEAT && p[1] =3D=3D 0x02 && len >=
=3D 10) {
> +		kb->brand =3D p[3];
> +		memcpy(kb->mac, &p[4], POGO_MAC_LEN);
> +		kb->hb_seen =3D true;
> +	}
> +
> +	if (!kb->connected || replug) {
> +		kb->connected =3D true;
> +		kb->hb_seen =3D false;
> +		kb->retry_ms =3D POGO_RETRY_MIN_MS;

[Severity: Medium]
Are these link state variables modified without holding kb->state_lock here?

Because pogo_handle_sync() runs in the RX worker context, it can execute
concurrently with workqueues running pogo_power_off() or pogo_power_on().
This data race could corrupt the driver's state machine logic.

> +		if (!READ_ONCE(kb->quitting))
> +			schedule_work(&kb->plug_work);

[Severity: High]
Does this lockless quitting check allow a use-after-free?

If the RX thread evaluates !READ_ONCE(kb->quitting) as true but is preempted
before calling schedule_work(), pogo_remove() might finish cancelling plug_=
work
and return.

The RX thread would then resume and queue plug_work after it has been
cancelled, leading to a use-after-free when devres frees kb.

> +	}
> +}
> +
> +static void pogo_handle_frame(struct pogo_kbd *kb, const u8 *f, unsigned=
 int n)
> +{
[ ... ]
> +	switch (cmd) {
> +	case OWB_CMD_KEYS:
[ ... ]
> +	case OWB_CMD_SYNC_UPLOAD:
> +		pogo_handle_sync(kb, payload, len);
> +		break;
> +	default:
> +		if (cmd =3D=3D OWB_CMD_GENERAL_ACK && len >=3D 4 &&
> +		    payload[0] =3D=3D OWB_GEN_BATTERY_STATUS)
> +			kb->battery_level =3D payload[2];
> +
> +		if (READ_ONCE(kb->tx_pending) && cmd =3D=3D kb->tx_cmd + 1) {

[Severity: Medium]
Is there a missing acquire barrier (smp_load_acquire) when reading tx_pendi=
ng
and tx_cmd here?

Furthermore, since the RX thread's check is not protected by a lock, it cou=
ld
be preempted between evaluating tx_pending and reading tx_cmd, which might
result in erroneously completing a new transfer using an old response.

> +			/* reply layout for callers: cmd, len, payload */
> +			kb->resp_len =3D min_t(unsigned int, len + 2, sizeof(kb->resp));
> +			memcpy(kb->resp, &f[3], kb->resp_len);
> +			complete(&kb->resp_done);
> +		} else {
> +			dev_dbg(kb->dev, "unhandled frame cmd 0x%02x len %u\n",
> +				cmd, len);
> +		}
> +		break;
> +	}
> +}
[ ... ]
> +static void pogo_hb_work(struct work_struct *work)
> +{
[ ... ]
> +	/* re-arm: retry while the wake line still reports a keyboard */
> +	if (!READ_ONCE(kb->quitting))
> +		schedule_delayed_work(&kb->detect_work,
> +				      msecs_to_jiffies(kb->retry_ms));

[Severity: High]
Could hb_work queue detect_work after it has been cancelled?

Since pogo_remove() cancels detect_work before hb_work, if hb_work executes
concurrently with teardown, this lockless check allows schedule_delayed_wor=
k()
to run after cancel_delayed_work_sync(&kb->detect_work) has completed.

This leaves detect_work permanently queued, leading to another use-after-fr=
ee
when kb is freed.

> +	kb->retry_ms =3D min(kb->retry_ms * 2, POGO_RETRY_MAX_MS);
> +}
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
Does this cancellation order correctly prevent works from being queued?

As noted above, cancelling detect_work before hb_work permits hb_work to
re-queue detect_work during teardown.

Additionally, the RX path's lockless check against kb->quitting means plug_=
work
can be queued after cancel_work_sync() completes, due to delayed devres ser=
dev
closure.

> +
> +	/* unregisters the input devices, the last possible led_work queuer */
> +	pogo_power_off(kb);
> +
> +	/* flush a led_work queued before the inputs went away */
> +	cancel_work_sync(&kb->led_work);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010143836.1738=
83-1-wyibo6109@gmail.com?part=3D2
