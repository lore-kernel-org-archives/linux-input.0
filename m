Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795855039;
	b=mPSapBFzTvxXK5Jl/IRRVGZlcyKEBhvPDapt+r7m14hfmgIyB2VuRTxhFyHs5jvXf/1l
	 Og/cDq4sxAfQZ4pfzr7UlAkwNFppViyNFGG29/VklzqjAWcZ7wxaor0XslayTCdggQC2u
	 O1eo1v948IgE9kQo8J0NviloyQatdUH4Jdcpueow73R6QARwnY4B//vo5dUvUfuDcnXnC
	 Py7ee5YdarmwkuajGa0botBc3YO9EYBfC0241xkNP4ALhgOSmR8aBcfAdwFLAsOMq2jvc
	 bOIU8WQYUuOjwmnL5TjZqBDohYXlnH+j5drONlfPbqj9eZUlkcyh8OIBdaZTbK3cyxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795855039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cKBuSnF2sClSB4Z2sW53df2zMXyrHqc53EEhr7ICpao=;
	b=TavbY6QabcfipB+GZa1dNAotgo4T6jhu2/G1oeviJRj5M1BIOHIxUuC7sVhPOB9lJe6A
	 443b+fULmu4HV/hxtpn13yDoVnU32Ym85gXkxZgyASga6af5+bumDZ14nha1UeIdHLiyV
	 ojAgTsEK0emHmHsbxlA5Vu3Lrte9FqtglN+b42o1ke9e2sXMJNyzaCEl4YiExazdn1cBK
	 5XMf/JT01bqJjsBCjHi6TCRBEitAHVk4wa3OA8XpXIlDPWBSsl9Nn6McoGSdC+gXowCQ9
	 ZWkl+T7GHKn9l2o9qv1gTUAE3LI3Vpy+GHBwKc9fSzdjKPsOYMhRBM+BKj8QyUdZzhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ws3z/Xa5";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27E606A31C;
	Sat, 28 Nov 2026 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ws3z/Xa5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE871F00893;
	Sat, 28 Nov 2026 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795855038;
	bh=cKBuSnF2sClSB4Z2sW53df2zMXyrHqc53EEhr7ICpao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ws3z/Xa5Wg6LD5rlRoav4Yc5vZ9PTHxiekT2afPiahPiZSrBqPI1qZupQ+caZTQI9
	 evWE0yODbHmG+nSHbWfgd0sHQoQOY8ONxEEKD6p4+XTtXBlvcloe9psNfHyb4cF0VI
	 m8FvRDSCWYY+I8FL5BtX63gqwfWVrOIOghlZ/b+mY3dAUboiwprp+mbhD03hPZjgHU
	 5yhTInRVaEsRNTjSd7TKUlZybE8ga3QPyajqqiuXMpFqVCfVKIQQAnANA4nNdF2ADH
	 zFEBtuSyniK7r1PXXFXbDd1sj43ntAnQJOWkVZE06YASsjep2BokcPpuzvJ9UFd5/X
	 W3tVcR8OujV8Q==
Message-ID: <sashiko-outbox-238549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261128081835.366128-3-wyibo6109@gmail.com>
References: <20261128081835.366128-1-wyibo6109@gmail.com>
 <20261128081835.366128-3-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 08:37:18 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 11 potential
issues to consider:
- [High] Input: oneplus-pogo-kbd - wake_irq left enabled in
  pogo_detect_work()
- [High] Input: oneplus-pogo-kbd - race on wake_irq_enabled in
  pogo_remove()
- [High] Input: oneplus-pogo-kbd - work cancellation order race in
  pogo_remove()
- [Medium] Input: oneplus-pogo-kbd - unlocked state updates in
  pogo_handle_sync()
- [Medium] Input: oneplus-pogo-kbd - battery status frames hijack
  pogo_set_general()
- [Medium] Input: oneplus-pogo-kbd - data race on kb->resp in
  pogo_xfer()
- [Medium] Input: oneplus-pogo-kbd: missing ABS_MT_TOOL_TYPE in
  pogo_register_inputs()
- [Medium] Input: oneplus-pogo-kbd: stuck keys and touches on replug in
  pogo_plug_work()
- [Low] Input: oneplus-pogo-kbd - 2-byte truncation of max-length
  replies in resp
- [Low] Input: oneplus-pogo-kbd - Kconfig selects non-existent INPUT_MT
  symbol
- [Low] Input: oneplus-pogo-kbd: unhandled GPIO error in
  pogo_detect_work()
--

commit 1c97b620e512d00923891630f226277057c54866
Author: Yibo Wang <wyibo6109@gmail.com>

Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

This commit adds a serdev input and LED class driver for the Tinno keyboard
MCU used by OnePlus and OPPO Pad magnetic pogo-pin keyboards.

> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kcon=
fig
> index 07790614e27fc..3cf1928f85057 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -757,4 +757,17 @@ config KEYBOARD_CYPRESS_SF
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cypress-sf.
> =20
> +config KEYBOARD_ONEPLUS_POGO
> +	tristate "OnePlus/OPPO Pad pogo-pin keyboard"
> +	depends on SERIAL_DEV_BUS && GPIOLIB
> +	depends on LEDS_CLASS
> +	select INPUT_MT

[Severity: Low]
Does INPUT_MT exist as a Kconfig symbol?  input-mt.o is built into
input-core.o unconditionally under CONFIG_INPUT, so selecting INPUT_MT here
is a no-op that triggers a Kconfig warning on an undefined symbol.

[ ... ]

> diff --git a/drivers/input/keyboard/oneplus-pogo-kbd.c b/drivers/input/ke=
yboard/oneplus-pogo-kbd.c
> new file mode 100644
> index 0000000000000..e7ead8e7ca4fb
> --- /dev/null
> +++ b/drivers/input/keyboard/oneplus-pogo-kbd.c

[ ... ]

> +	/* host -> keyboard transfers */
> +	struct mutex io_lock;
> +	struct mutex state_lock;
> +	struct completion echo_done;
> +	struct completion resp_done;
> +	u8 tx_cmd;
> +	bool tx_pending;
> +	bool quitting;
> +	u8 resp[OWB_MAX_PAYLOAD];
> +	unsigned int resp_len;

[Severity: Low]
Should resp be sized to OWB_MAX_PAYLOAD + 2?  pogo_handle_frame() copies the
2-byte cmd and len header together with the payload (len + 2 bytes) into
kb->resp and clamps resp_len to sizeof(kb->resp), which truncates the last 2
bytes of a maximum-length reply.

[ ... ]

> +static int pogo_xfer(struct pogo_kbd *kb, u8 cmd, const u8 *payload, u8 =
len,
> +		     u8 *resp, unsigned int resp_size)
> +{
> +	u8 frame[OWB_TX_BUF_LEN];
> +	unsigned int frame_len;
> +	int attempt, ret =3D -ETIMEDOUT;
> +
> +	if (len > OWB_MAX_PAYLOAD)
> +		return -EINVAL;
> +
> +	frame_len =3D owb_build_frame(frame, cmd, payload, len);
> +	print_hex_dump_debug("pogo tx: ", DUMP_PREFIX_NONE, 32, 1, frame, frame=
_len, false);
> +
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
> +
> +		gpiod_set_value_cansleep(kb->tx_en_gpio, 1);
> +		usleep_range(POGO_TX_GATE_ON_US, POGO_TX_GATE_ON_US + 50);
> +
> +		ret =3D serdev_device_write(kb->serdev, frame, frame_len,
> +					  msecs_to_jiffies(POGO_RESP_TIMEOUT_MS));
> +		if (ret >=3D 0)
> +			serdev_device_wait_until_sent(kb->serdev,
> +						      msecs_to_jiffies(20));
> +
> +		/*
> +		 * Release the wire as soon as the last bit is out: the MCU
> +		 * answers within a few hundred microseconds and would collide
> +		 * with our idle-high TX driver otherwise.  The echo is only
> +		 * checked afterwards, it is already queued in the tty buffer.
> +		 */
> +		usleep_range(POGO_TX_GATE_OFF_US, POGO_TX_GATE_OFF_US + 50);
> +		gpiod_set_value_cansleep(kb->tx_en_gpio, 0);
> +
> +		echoed =3D wait_for_completion_timeout(&kb->echo_done,
> +				msecs_to_jiffies(POGO_ECHO_TIMEOUT_MS)) !=3D 0;
> +
> +		if (ret < 0) {
> +			dev_warn(kb->dev, "cmd 0x%02x write failed: %d\n", cmd, ret);
> +			continue;
> +		}
> +		if (!echoed) {
> +			dev_dbg(kb->dev, "cmd 0x%02x: no echo\n", cmd);
> +			ret =3D -EIO;
> +			continue;
> +		}
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
> +			ret =3D n;
> +			break;
> +		}

[Severity: Medium]
Can pogo_handle_frame() race with pogo_xfer() on kb->resp and kb->resp_len?

CPU0                                    CPU1 (serdev RX)
pogo_xfer()
  /* attempt 0 times out on resp_done */
  /* attempt 1 */
  WRITE_ONCE(kb->tx_pending, false)
  reinit_completion(&kb->resp_done)
  WRITE_ONCE(kb->tx_pending, true)
  /* late reply from attempt 0 arrives */
                                        pogo_handle_frame()
                                          kb->resp_len =3D ...
                                          memcpy(kb->resp, ...)
                                          complete(&kb->resp_done)
  wait_for_completion_timeout(&kb->resp_done)
  n =3D min(kb->resp_len, resp_size)
                                        /* reply to attempt 1 arrives */
                                        pogo_handle_frame()
                                          if (READ_ONCE(kb->tx_pending))
                                            kb->resp_len =3D ...
                                            memcpy(kb->resp, ...) <-- data =
race
  WRITE_ONCE(kb->tx_pending, false)
  memcpy(resp, kb->resp, n) <-- torn read

Because no lock serializes pogo_handle_frame() with pogo_xfer() and
pogo_handle_frame() does not clear kb->tx_pending, a second matching frame
can overwrite kb->resp and kb->resp_len while pogo_xfer() is reading them.
Also, re-arming kb->tx_pending before writing the retry frame allows a late
echo or reply from the previous attempt to complete echo_done or resp_done
during the 450 us TX gate delay or UART write.

[ ... ]

> +	input_set_abs_params(tp, ABS_MT_POSITION_X, 0, kb->hw->tp_max_x, 0, 0);
> +	input_set_abs_params(tp, ABS_MT_POSITION_Y, 0, kb->hw->tp_max_y, 0, 0);
> +	input_abs_set_res(tp, ABS_MT_POSITION_X, kb->hw->tp_res_x);
> +	input_abs_set_res(tp, ABS_MT_POSITION_Y, kb->hw->tp_res_y);
> +	ret =3D input_mt_init_slots(tp, POGO_TOUCH_FINGERS,
> +				  INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED);

[Severity: Medium]
Does pogo_register_inputs() need to register ABS_MT_TOOL_TYPE on tp?

pogo_report_touchpad() decodes MT_TOOL_PALM vs MT_TOOL_FINGER and passes it
to input_mt_report_slot_state(), which emits EV_ABS / ABS_MT_TOOL_TYPE.
Because input_set_abs_params(tp, ABS_MT_TOOL_TYPE, 0, MT_TOOL_PALM, 0, 0) is
not called here, ABS_MT_TOOL_TYPE is not set in tp->absbit and the input
core drops all tool type events, disabling palm rejection.

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
> +		if (!READ_ONCE(kb->quitting))
> +			schedule_work(&kb->plug_work);
> +	}
> +}

[Severity: Medium]
Can a queued sync frame arriving during pogo_power_off() leave kb->connected
stuck at true while the keyboard is powered off?

CPU0 (hb_work)                          CPU1 (serdev RX)
pogo_power_off()
  mutex_lock(&kb->state_lock)
  kb->connected =3D false
  kb->powered =3D false
  mutex_unlock(&kb->state_lock)
                                        pogo_handle_sync()
                                          if (!kb->connected)
                                            kb->connected =3D true
                                            schedule_work(&kb->plug_work)
pogo_plug_work()
  if (!kb->powered)
    return;  <-- kb->connected remains true while powered off

pogo_handle_sync() mutates kb->connected and kb->hb_seen without holding
kb->state_lock or checking kb->powered, so sysfs connected_show() stays 1
and pogo_backlight_set() / pogo_led_work() issue timing-out UART transfers
to an unpowered device.

In addition, if a 0x2F frame does not match either the OWB_SYNC_PLUG_IN or
OWB_SYNC_HEARTBEAT branch, pogo_handle_sync() falls through and marks
kb->connected =3D true with uninitialized brand and MAC.  Finally, neither
pogo_power_off() nor pogo_power_on() resets kb->in_frame or kb->sync_cnt, so
powering off mid-frame corrupts the first frame after re-attach.

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

[Severity: Medium]
Should unsolicited OWB_GEN_BATTERY_STATUS frames break out of the switch
instead of falling through to the command reply completion?

When pogo_set_general() sends OWB_CMD_GENERAL (0x3A), kb->tx_cmd + 1 is
OWB_CMD_GENERAL_ACK (0x3B).  If the MCU pushes an unsolicited 0x3B / 0x0E
battery status frame while pogo_set_general() is waiting for its 0x3B ACK,
falling through copies the battery frame into kb->resp and completes
kb->resp_done, causing pogo_set_general() to see resp[2] !=3D sub and abort
with -EPROTO.

[ ... ]

> +static void pogo_detect_work(struct work_struct *work)
> +{
> +	struct pogo_kbd *kb =3D container_of(work, struct pogo_kbd,
> +					   detect_work.work);
> +
> +	int i;
> +
> +	if (READ_ONCE(kb->quitting) || kb->powered)
> +		return;
> +
> +	/* the unpowered keyboard holds the wire low; require a stable level */
> +	for (i =3D 0; i < POGO_DETECT_SAMPLES; i++) {
> +		if (!gpiod_get_value_cansleep(kb->wake_gpio))
> +			break;
> +		msleep(POGO_DETECT_SAMPLE_MS);
> +	}
> +	if (i =3D=3D POGO_DETECT_SAMPLES) {
> +		pogo_power_on(kb);
> +		return;
> +	}
> +
> +	kb->retry_ms =3D POGO_RETRY_MIN_MS;
> +	pogo_wake_irq_enable(kb, true);
> +	/* the edge may have happened before the irq was armed */
> +	if (!READ_ONCE(kb->quitting) && gpiod_get_value_cansleep(kb->wake_gpio))
> +		mod_delayed_work(system_dfl_wq, &kb->detect_work,
> +				 msecs_to_jiffies(POGO_DETECT_DEBOUNCE_MS));
> +}

[Severity: High]
Does the reschedule path after pogo_wake_irq_enable(kb, true) leave wake_irq
enabled when the keyboard powers on?

If the initial sampling loop exits early because the attach edge arrives
just before the loop finishes, pogo_detect_work() enables wake_irq, sees
wake_gpio active, and reschedules detect_work without disabling wake_irq.
Because the attached keyboard holds wake_gpio steadily active, no new
falling edge fires pogo_wake_isr(), and the next run of pogo_detect_work()
reaches i =3D=3D POGO_DETECT_SAMPLES and calls pogo_power_on() with wake_irq
still enabled on the shared 921600-baud UART wire.

[Severity: Low]
Also in pogo_detect_work(), gpiod_get_value_cansleep() can return a negative
errno, which both boolean checks treat as an active wake line and use to
power on the keyboard or reschedule detect_work.

[ ... ]

> +static void pogo_plug_work(struct work_struct *work)
> +{
> +	struct pogo_kbd *kb =3D container_of(work, struct pogo_kbd, plug_work);
> +	int ret;
> +
> +	if (READ_ONCE(kb->quitting) || !kb->powered || !kb->connected)
> +		return;
> +
> +	if (!kb->kbd) {
> +		ret =3D pogo_register_inputs(kb);

[Severity: Medium]
When a re-plug sync frame arrives while kb->kbd is already registered,
should pogo_plug_work() release active keys and touchpad contacts?

If the MCU resets or the pogo pins bounce briefly and send a new
OWB_SYNC_PLUG_IN frame before the 500 ms heartbeat timeout expires,
pogo_plug_work() skips pogo_register_inputs() and keeps the existing input
devices without calling pogo_release_all(kb), leaving any key or touch held
across the reset stuck down.

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
Can pogo_wake_isr() race with pogo_remove() on kb->wake_irq_enabled and
re-queue detect_work after cancel_delayed_work_sync()?

CPU0                                    CPU1 (<hardirq>)
                                        pogo_wake_isr()
                                          disable_irq_nosync(irq)
                                          kb->wake_irq_enabled =3D false
                                          if (!READ_ONCE(kb->quitting))
pogo_remove()
  WRITE_ONCE(kb->quitting, true)
  pogo_wake_irq_enable(kb, false)
    if (enable =3D=3D kb->wake_irq_enabled)
      return; /* skips disable_irq() */
  cancel_delayed_work_sync(&kb->detect_work)
                                            mod_delayed_work(..., &kb->dete=
ct_work, ...)
  /* devres frees kb */
                                        pogo_detect_work() <-- use-after-fr=
ee

Because pogo_wake_isr() clears kb->wake_irq_enabled without locking before
checking kb->quitting, pogo_wake_irq_enable(kb, false) sees
kb->wake_irq_enabled =3D=3D false and returns without calling disable_irq()=
 or
synchronize_irq().  Conversely, if pogo_wake_irq_enable(kb, false) passes
its check just as pogo_wake_isr() fires, both disable_irq_nosync() and
disable_irq() run and increment the IRQ disable depth to 2.

In addition, if pogo_detect_work() is already inside its 120 ms sampling
loop when pogo_remove() runs, pogo_wake_irq_enable(kb, false) runs before
cancel_delayed_work_sync(&kb->detect_work), and pogo_detect_work() does not
re-check kb->quitting after the loop before calling pogo_power_on() or
pogo_wake_irq_enable(kb, true).

[Severity: High]
Can pogo_hb_work() or pogo_receive_buf() also re-queue work after the
cancel_*_work_sync() calls in pogo_remove() and pogo_probe()'s err_shutdown
path?

CPU0                                    CPU1 (kworker)
                                        pogo_hb_work()
                                          pogo_power_off(kb)
                                          if (!READ_ONCE(kb->quitting))
pogo_remove()
  WRITE_ONCE(kb->quitting, true)
  ...
  cancel_delayed_work_sync(&kb->detect_work)
                                            schedule_delayed_work(&kb->dete=
ct_work, ...)
  cancel_delayed_work_sync(&kb->hb_work)
  /* devres frees kb */
                                        pogo_detect_work() <-- use-after-fr=
ee

pogo_hb_work() schedules kb->detect_work, so cancelling detect_work before
hb_work allows an in-flight pogo_hb_work() that just passed its quitting
check to re-arm detect_work.  Similarly, because serdev is opened via
devm_serdev_device_open() and stays open until devres teardown runs after
pogo_remove() returns, an in-flight pogo_receive_buf() -> pogo_handle_sync()
that just passed its quitting check can call schedule_work(&kb->plug_work)
after cancel_work_sync(&kb->plug_work) completes; using
disable_delayed_work_sync() and disable_work_sync() would prevent
post-cancel queueing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261128081835.3661=
28-1-wyibo6109@gmail.com?part=3D2
