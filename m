Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C7497B96;
	Thu, 15 Oct 2026 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063149; cv=none; b=UFtcpYqVFAsh564uIBxbU/dcdlf2VA99JwdzR+B5P3PbvrOXVHt5PQ6Xwvxa/+/AocdpO+YjPqKdcdgUy/FQNIy7guyLKsqJ+gHJkxEBCr+S/VAz7j8/7Ss9V3+fJK4fdIXn/XyUTjfNAQz5wYNr35oTkteRSZUfgVSQMV2MkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063149; c=relaxed/simple;
	bh=SHqr+iIlnGtxZydbIeZ2ElJryRCT6QPznEHyFuxBXzQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uSicUJ7jwXGBdP+lW0X8l3YvWGxUKNgP+eHakli+T6tpJ2Zh41IciUH31ezLsNJIsGi/iza/xAIz9DNt+Jrn/COJAUbPHvayVhUZbI4FrSZFTWlk9X7oOiHQ8ZWUp0ICyxEZX3qZrwDUQmD569Pd1XPr24+/UwxoomANX9GyBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6FTXrtL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6FTXrtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A37F1F000C4;
	Thu, 15 Oct 2026 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792063147;
	bh=EUuiQTvZ5m+M7vtYBRhA91jya0KPorh/EdYN3drPH50=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z6FTXrtLUEzweG/26yk3qKPwwqam3QLKRZk3SpoFg+bHXClEJzqwtoG1PHTggHid0
	 0F0Y3Sks8hWWZmdQvnwGHmYtKHCuqlyAN9GDtInC3dZ38FomtCNNHsLPOJN/1oL+NJ
	 Xc6NYBqsxITZCyZSwG7SXPIXwu6f7uJkwHl0+Djhc0Arbm8TK5ucoPzst9iyedoTN6
	 ugGF1oxvEEKZB/A/9bseIICYw8aJsAHC0kxQ589kYhp1HXW1ZdgiggNQgrqehUJl/y
	 IFHdeIk+J/OafUMfMG8JcmYyaoz0xHkFkM9aWXXRBsCd0F4uBlRNXgKX26Bb8yAFwT
	 LjT4fnfglLyag==
Message-ID: <sashiko-outbox-172734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261015110859.203989-3-wyibo6109@gmail.com>
References: <20261014135251.11234-1-wyibo6109@gmail.com>
 <20261015110859.203989-1-wyibo6109@gmail.com>
 <20261015110859.203989-3-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:19:07 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] input: pogo: Use-After-Free in async paths due to lockless TOCTOU =
and broken synchronization
- [Medium] serdev: data race and buffer overwrite in pogo_xfer() due to loc=
kless completion handling
- [Medium] serdev: unprotected link state modifications in RX thread cause =
software/hardware state desync
- [Low] sysfs: custom battery_level attribute bypasses power_supply subsyst=
em UAPI
--

commit f989b7094046c3834660c419541bd497ac8abe36
Author: Yibo Wang <wyibo6109@gmail.com>

Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

This commit adds a clean-room serdev driver for the Tinno keyboard MCU
used by the OnePlus Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro smart keyboards.
It introduces a custom protocol implementation over a half-duplex UART
to support touch, keys, backlight, and power management.

> diff --git a/drivers/input/keyboard/oneplus-pogo-kbd.c b/drivers/input/ke=
yboard/oneplus-pogo-kbd.c
> --- a/drivers/input/keyboard/oneplus-pogo-kbd.c
> +++ b/drivers/input/keyboard/oneplus-pogo-kbd.c
[ ... ]
>  		/*
>  		 * Drop any late echo/reply of the previous attempt: with
>  		 * tx_pending cleared the RX path ignores frames until the
>  		 * transfer below re-arms, so a delayed reply cannot complete
>  		 * the fresh iteration or race the resp buffer.
>  		 */
>  		WRITE_ONCE(kb->tx_pending, false);
>  		reinit_completion(&kb->echo_done);
>  		reinit_completion(&kb->resp_done);
>  		kb->tx_cmd =3D cmd;
>  		WRITE_ONCE(kb->tx_pending, true);

[Severity: Medium]
Is it possible for a delayed response from the previous timeout to trigger a
spurious completion here?

When the retry happens, the same cmd is set. If the RX thread was preempted
just before copying the payload, could it wake up and call
complete(&kb->resp_done) using the stale payload for this new iteration?
Explicit lock synchronization between the timeout path and the RX thread mi=
ght
be needed.

[ ... ]
>  static void pogo_handle_sync(struct pogo_kbd *kb, const u8 *p, unsigned =
int len)
>  {
[ ... ]
>  	if (!kb->connected || replug) {
>  		kb->connected =3D true;
>  		kb->hb_seen =3D false;
>  		kb->retry_ms =3D POGO_RETRY_MIN_MS;

[Severity: Medium]
Does this locklessly update the link state variables while they are also
managed by pogo_power_off() under state_lock?

If a delayed heartbeat frame is processed exactly as pogo_hb_work() determi=
nes
a timeout and calls pogo_power_off(), could pogo_power_off() clear the state
just before this unsynchronized block unconditionally sets kb->connected =
=3D true
again?

>  		if (!READ_ONCE(kb->quitting))
>  			schedule_work(&kb->plug_work);
>  	}

[Severity: High]
Can this lockless check of kb->quitting lead to a use-after-free during dri=
ver
removal?

The serdev RX path is devres-managed and can run concurrently with
pogo_remove(). If the RX thread evaluates quitting as false just before
pogo_remove() sets it to true, it could queue plug_work after
cancel_work_sync(&kb->plug_work) has already finished, causing the work to =
run
on freed memory.

[ ... ]
>  static void pogo_handle_frame(struct pogo_kbd *kb, const u8 *f, unsigned=
 int n)
>  {
[ ... ]
>  		if (READ_ONCE(kb->tx_pending) && cmd =3D=3D kb->tx_cmd + 1) {
>  			/* reply layout for callers: cmd, len, payload */
>  			kb->resp_len =3D min_t(unsigned int, len + 2, sizeof(kb->resp));
>  			memcpy(kb->resp, &f[3], kb->resp_len);
>  			complete(&kb->resp_done);
>  		}

[Severity: Medium]
Since the check for tx_pending and tx_cmd is lockless, could the RX thread =
be
preempted right after this condition evaluates to true?

If pogo_xfer() times out, resets tx_pending, and starts a retry with the sa=
me
command, the stalled RX thread could resume, overwrite kb->resp with the old
payload, and signal completion for the new transfer.

[ ... ]
>  static void pogo_wake_irq_enable(struct pogo_kbd *kb, bool enable)
>  {
>  	if (enable =3D=3D kb->wake_irq_enabled)
>  		return;

[Severity: High]
Could this optimization skip synchronizing with a running ISR?

If pogo_wake_isr() sets kb->wake_irq_enabled =3D false, this check will ret=
urn
immediately without calling disable_irq(). During pogo_remove(), this allows
the teardown to proceed without waiting for the ISR, which might then queue
detect_work after it has been cancelled.

[ ... ]
>  static void pogo_power_off(struct pogo_kbd *kb)
>  {
>  	bool was_connected;
> =20
>  	mutex_lock(&kb->state_lock);
>  	was_connected =3D kb->connected;
>  	kb->connected =3D false;
>  	kb->powered =3D false;
>  	mutex_unlock(&kb->state_lock);

[Severity: Medium]
As mentioned above, if this safe transition runs concurrently with a delayed
frame processed by pogo_handle_sync(), could the hardware state become
desynchronized?

The software might incorrectly reflect a connected device while the hardware
is unpowered, causing subsequent sysfs accesses (like setting the backlight)
to time out waiting for the MCU.

[ ... ]
>  static ssize_t battery_level_show(struct device *dev,
>  				  struct device_attribute *attr, char *buf)
>  {
>  	struct pogo_kbd *kb =3D dev_get_drvdata(dev);
> =20
>  	if (!kb->connected)
>  		return -ENODEV;
>  	/* only keyboards with a battery push 0x0E status frames */
>  	if (kb->battery_level < 0)
>  		return -ENODATA;
>  	return sysfs_emit(buf, "%d\n", kb->battery_level);
>  }
>  static DEVICE_ATTR_RO(battery_level);

[Severity: Low]
Does exposing battery_level as a custom sysfs attribute bypass the standard
power_supply subsystem?

Standard Linux userspace battery monitors (like UPower) only scan for devic=
es
registered under the standard power_supply class. Would it be better to
register a POWER_SUPPLY_TYPE_BATTERY device using the power supply API so
desktop environments can seamlessly read the keyboard's battery status?

[ ... ]
>  static void pogo_remove(struct serdev_device *serdev)
>  {
>  	struct pogo_kbd *kb =3D serdev_device_get_drvdata(serdev);
> =20
>  	/*
>  	 * Stop the world first: with quitting set, the RX path and the
>  	 * works stop queueing each other, so the cancels below cannot be
>  	 * undone again.  The wake IRQ is disabled (and any in-flight ISR
>  	 * finished) before detect_work is cancelled.
>  	 */
>  	WRITE_ONCE(kb->quitting, true);
>  	pogo_wake_irq_enable(kb, false);
>  	cancel_delayed_work_sync(&kb->detect_work);
>  	cancel_delayed_work_sync(&kb->hb_work);
>  	cancel_work_sync(&kb->plug_work);

[Severity: High]
Are these sequential cancellations safe against background works queuing ea=
ch
other?

Since detect_work is cancelled before hb_work, if hb_work evaluates !quitti=
ng
right before it is set to true here, it could queue detect_work again after
cancel_delayed_work_sync(&kb->detect_work) has already completed. This would
leave a timer active on the device structure after it is freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015110859.2039=
89-1-wyibo6109@gmail.com?part=3D2
