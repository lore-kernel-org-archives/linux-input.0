Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572C468C2C;
	Fri,  9 Oct 2026 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548686; cv=none; b=csTRJ9AElOoEglypNOprK3PmBp8jLCrqtZJ+dKO3UY68AKcGilaKW9LomgCa8pgT0oy4KTSzQ6ORNgUHbkzaJMbShvyg85qd/AIxtt/xlyBLp3zgkU2DxNFOTZG8RV/ebsU2R8m4ls4tcRlZ5kRgjb3rskE70UTRfDrVUFF6fI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548686; c=relaxed/simple;
	bh=3Zw35r4K9LVHNRHDezY8A90tYkmVlFWWVFXqgdJSKsQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=P1E7o6GqQVWm0PqBbiFGV1nnPPP5jvjvs0UjUJuMKzZ5mREdlNLzBqVrOvGaNxoEQA93cvBk1ka7/JUeeA9QIMfslZ491GSdglnvVOUeETJLwhfJyZCBCe5CDroiKsb/2gYF4akGpwi/aDs5Cf5yEadffI+fD9GQBY9AC4ZzAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0PeDuH1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0PeDuH1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DBC1F000FF;
	Fri,  9 Oct 2026 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791548678;
	bh=6xK93ThS1pvc+cHk8A0twTBxTI5RD6Xpj6qM6Y/oskU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0PeDuH1pcDv031b8zBHl/FGEVIH4aaTslNNfduNQeI4P2vp4pn4TpalCRNICV6GQ
	 9MK6Vdzem5vqqOBzc0+P/35yecQagCNbefsG3m/5zh3fG+502IBvExB0yR0g38O5Ra
	 CCn9txJ6chpimH9PLn9GKVKj+Ektyq7eO832+XNQ87s94V5nALn2BVFR3XY0RsSm9K
	 eS0Lk2yC5Qchfylt6JUpBQyRaoEqW9ssc09m/AB0AmR7D+kD1vqAxRJcEvC9fb5swv
	 tG3ku9CYTzUCuwpRM0AU3GEPtHNGz8cExVD0gUyPWAhooxEI1f0vPlMfC15OAXeLRH
	 H+8PbxSoUtRZA==
Message-ID: <sashiko-outbox-165533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yibo Wang" <wyibo6109@gmail.com>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261009121143.550498-3-2024312277@stu.hit.edu.cn>
References: <20261009121143.550498-1-2024312277@stu.hit.edu.cn>
 <20261009121143.550498-3-2024312277@stu.hit.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:24:37 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] input: Use-After-Free in workqueues due to incorrect teardown sequ=
ence
- [High] input: Resource leak and UAF due to race between plug_work and pow=
er_off
- [Medium] input: Data race and corruption on kb->resp buffer in UART RX pa=
th
- [Medium] input: Data race on wake_irq_enabled state causing permanent IRQ=
 disablement
- [Medium] input: Missing Kconfig dependencies for INPUT_MT and LEDS_CLASS
- [Low] input: Success logging in probe path violates subsystem guidelines
--

commit 3f827ef8e9c7e47ecd0b1c17c9418abab787c03c
Author: Yibo Wang <wyibo6109@gmail.com>

Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver
   =20
Clean-room serdev driver for the Tinno keyboard MCU used by the OnePlus
Pad 3 Pro / Pad 4 and OPPO Pad 5 Pro smart keyboards, replacing the
vendor platform driver that depends on a downstream msm_geni_serial
callback and a user-space held tty fd.

> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kcon=
fig
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -768,4 +768,15 @@ config KEYBOARD_CYPRESS_SF
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cypress-sf.
> =20
> +config KEYBOARD_ONEPLUS_POGO
> +	tristate "OnePlus/OPPO Pad pogo-pin keyboard"
> +	depends on SERIAL_DEV_BUS && GPIOLIB

[Severity: Medium]
Should this Kconfig entry select CONFIG_INPUT_MT and depend on
CONFIG_LEDS_CLASS?

The driver explicitly calls input_mt_init_slots() and
devm_led_classdev_register_ext(). If CONFIG_INPUT_MT is disabled, the kernel
will fail to link. If CONFIG_LEDS_CLASS is configured as a module and this
driver is built-in, it will cause a linker error or silently drop
functionality. Standard kernel practices require this Kconfig to select
CONFIG_INPUT_MT and depend on CONFIG_LEDS_CLASS.

> diff --git a/drivers/input/keyboard/oneplus-pogo-kbd.c b/drivers/input/ke=
yboard/oneplus-pogo-kbd.c
> --- /dev/null
> +++ b/drivers/input/keyboard/oneplus-pogo-kbd.c
[ ... ]
> +static int pogo_xfer(struct pogo_kbd *kb, u8 cmd, const u8 *payload, u8 =
len,
> +		     u8 *resp, unsigned int resp_size)
> +{
[ ... ]
> +		if (wait_for_completion_timeout(&kb->resp_done,
> +				msecs_to_jiffies(POGO_RESP_TIMEOUT_MS))) {
> +			unsigned int n =3D min(kb->resp_len, resp_size);
> +
> +			memcpy(resp, kb->resp, n);
> +			ret =3D n;
> +			break;
> +		}
> +		dev_dbg(kb->dev, "cmd 0x%02x: no reply\n", cmd);
> +		ret =3D -ETIMEDOUT;
> +	}
> +	WRITE_ONCE(kb->tx_pending, false);
> +	mutex_unlock(&kb->io_lock);
> +
> +	return ret;
> +}

[Severity: Medium]
Is there a data race on kb->resp when timeouts occur?

If wait_for_completion_timeout() times out, it proceeds to the next loop
iteration and calls reinit_completion(&kb->resp_done) without setting
kb->tx_pending =3D false.

If a delayed reply from the previous attempt arrives concurrently, the
serdev RX callback pogo_handle_frame() sees kb->tx_pending =3D=3D true and
writes the payload into kb->resp locklessly:

    if (READ_ONCE(kb->tx_pending) && cmd =3D=3D kb->tx_cmd + 1) {
        kb->resp_len =3D min_t(unsigned int, len + 2, sizeof(kb->resp));
        memcpy(kb->resp, &f[3], kb->resp_len);

This can overwrite kb->resp while pogo_xfer() is concurrently reading from
it, or it can spuriously complete the new iteration before the packet is
even sent.

[ ... ]
> +static void pogo_wake_irq_enable(struct pogo_kbd *kb, bool enable)
> +{
> +	if (enable =3D=3D kb->wake_irq_enabled)
> +		return;
> +	if (enable)
> +		enable_irq(kb->wake_irq);
> +	else
> +		disable_irq(kb->wake_irq);
> +	kb->wake_irq_enabled =3D enable;
> +}

[Severity: Medium]
Does updating the state after enabling the IRQ cause a race condition?

If the wake line is already asserted, the IRQ can fire immediately on anoth=
er
CPU as soon as enable_irq() executes. The ISR pogo_wake_isr() would then ru=
n,
call disable_irq_nosync(), and assign kb->wake_irq_enabled =3D false.

When the original CPU resumes, it unconditionally assigns
kb->wake_irq_enabled =3D true, overwriting the ISR's state update. The
software state now claims the IRQ is enabled, while the hardware IRQ is
actually disabled.

Subsequent calls to pogo_wake_irq_enable() will return early without enabli=
ng
the IRQ, leaving the keyboard permanently asleep.

[ ... ]
> +static void pogo_power_off(struct pogo_kbd *kb)
> +{
> +	dev_dbg(kb->dev, "power off\n");
> +	kb->powered =3D false;
> +	gpiod_set_value_cansleep(kb->power_gpio, 0);
> +	if (kb->connected) {
> +		kb->connected =3D false;
> +		pogo_unregister_inputs(kb);
> +		dev_info(kb->dev, "keyboard detached\n");
> +	}
> +}

[Severity: High]
Can a race between pogo_plug_work() and pogo_power_off() leak input devices?

In pogo_plug_work(), device registration proceeds outside the lock:

    if (!kb->kbd) {
        ret =3D pogo_register_inputs(kb);

Concurrently, pogo_hb_work() can call pogo_power_off(), which sets
kb->connected =3D false and calls pogo_unregister_inputs(). Since plug_work
has not yet assigned kb->kbd under the lock, pogo_unregister_inputs() does
nothing.

After plug_work completes registration and assigns kb->kbd, if the driver
is unbound, pogo_remove() calls pogo_power_off(). Because kb->connected is
already false, it skips unregistering the devices.

This leaks the input devices, and their private data pointers retain the
freed kb struct, causing a use-after-free when accessed by userspace.

[ ... ]
> +static int pogo_probe(struct serdev_device *serdev)
> +{
[ ... ]
> +	/* evaluate the current attach state; enables the irq when idle */
> +	schedule_delayed_work(&kb->detect_work,
> +			      msecs_to_jiffies(POGO_DETECT_DEBOUNCE_MS));
> +
> +	dev_info(dev, "pogo keyboard link ready (wake irq %d)\n", kb->wake_irq);
> +	return 0;
> +}

[Severity: Low]
Should this success message be removed to match subsystem guidelines?

The driver prints an explicit success log message upon normal completion of
the probe sequence. The LED and Input maintainer guidelines request that
drivers only log errors or warnings.

[ ... ]
> +static void pogo_remove(struct serdev_device *serdev)
> +{
> +	struct pogo_kbd *kb =3D serdev_device_get_drvdata(serdev);
> +
> +	pogo_wake_irq_enable(kb, false);
> +	cancel_delayed_work_sync(&kb->detect_work);
> +	cancel_delayed_work_sync(&kb->hb_work);
> +	cancel_work_sync(&kb->plug_work);
> +	cancel_work_sync(&kb->led_work);
> +	pogo_power_off(kb);
> +}

[Severity: High]
Could this teardown sequence leave a window for use-after-free bugs?

First, cancel_work_sync(&kb->led_work) is called before pogo_power_off(kb)
unregisters the input devices. Userspace can trigger pogo_kbd_event() via
sysfs/evdev and queue led_work after the cancellation.

Second, the serdev port is managed via devm_serdev_device_open(), so it
remains open until devres cleanup runs after pogo_remove() returns. An
incoming UART frame could trigger pogo_receive_buf() and queue plug_work
on the freed memory.

Third, detect_work and hb_work can schedule each other. Sequentially
cancelling them without a state flag (e.g., kb->quitting =3D true) allows
hb_work to queue detect_work immediately after detect_work is cancelled.

Also, if pogo_probe() fails after opening the serdev, plug_work is never
cancelled before devres cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121143.5504=
98-1-2024312277@stu.hit.edu.cn?part=3D2
