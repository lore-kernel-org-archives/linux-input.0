Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9723C4B9A;
	Thu,  2 Jul 2026 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032196; cv=none; b=n41p/I3tE/iesoJN7SCxcaX6Rj2WlflpHzUYrnxIRtDbfuOnoMiZGPan+BXWSh9InNXhbmrrF1DDlgIw3YNOwqjmZcpe+0WQTwNMDTs+pffa/ir7QFRdX/fHPGsBsHbZclEvbhgDOQITAV11raki7cw1sPYvr7hB8Wdcr6/tmCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032196; c=relaxed/simple;
	bh=W7SWCGEvjiiSW4IOeYSTmz8jIFpEtDjwN6Req2SGZ/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OjrpRTavuLlz7u5P0ySURs0f/rtmPWficq4qPriFjZCol+Dkbutl/7h2Lw0jxACndT4x1WYq5MJxOvx4t4QSw9rccjTbgYMfp0YXpnUt8AGQ+pqShHVgPKPByu8TisFh+A/PVvUo5TKDmA3jF/fXozwANsE1Wd6/FDe9z1owCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZWbAcQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZWbAcQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BD91F000E9;
	Thu,  2 Jul 2026 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783032191;
	bh=ZEPmC4wQuzZ4bfte0udlxpjiCX3GWg4BdPm1kTHlBbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DZWbAcQHRd4y8ZDbgxaFn5cSWOGyttVjxIZnbG2n9x10qxLdCCET941j5HWbx9ArF
	 rn0GvF9X0BKNZnHqwbfrE5Z+9LfcLhJXm66jiFvIcDMoh54mfX+MEkchvK9gS1HhnR
	 8IX5c2lLRGCK180D6ai+BIhtIN0abdDqRj6BAHGsJo3cShQJfR8c2b5ysPuJ2/IUEU
	 TrOQtds/paXvbrWGe8qvTM+0O+GofGrTjGA1lksGMzCOFuScvuE0Q7eGKd7skIvGt7
	 X3hVCKLyBkms3oIloTSagk9cv7Rv8jNLVZEok6bj8ZNbbkzUk27xpQR1PHeZw8NUzg
	 XlGytkZUAG+pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Felsch" <m.felsch@pengutronix.de>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v6-4-1aa50ba3bc5a@pengutronix.de>
References: <20260703-v6-10-topic-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v6-4-1aa50ba3bc5a@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:43:10 +0000
Message-Id: <20260702224311.75BD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [High] Custom regmap callbacks interpret 16-bit register addresses with i=
ncorrect endianness, leading to I2C transfer failures on little-endian host=
s and corrupted addresses on big-endian hosts.
- [High] The firmware upload cleanup handler double-unlocks `fwupdate_lock`=
 and permanently underflows the PM runtime usage counter.
- [High] Missing bounds checks when parsing firmware chunks lead to out-of-=
bounds memory reads and integer underflows.
- [High] Insufficient startup delay due to using a millisecond macro with `=
fsleep()`, causing a 1000x shorter sleep than intended.
- [High] Manual unregistration of the input device in `remove()` races with=
 devres-managed IRQs and sysfs interfaces, leading to Use-After-Free.
- [High] The TH2CFG firmware update path replaces the input device dynamica=
lly without disabling the IRQ, causing a Use-After-Free race with active in=
terrupt handlers.
- [High] Missing `reinit_completion()` allows late interrupts to cause spur=
ious wakeups in subsequent operations.
- [Medium] Probe error paths leak the PM runtime usage counter and leave ha=
rdware regulators permanently enabled.
- [Medium] The allocated input device is leaked if requesting the threaded =
IRQ fails.
- [Medium] Arithmetic error calculating the payload length due to subtracti=
on of preamble and postamble bytes without parentheses.
- [Medium] Unreachable error handling when the device reports 0 touch slots=
 during initial probe leads to a logic flaw and dead code.
- [Medium] Dead code pointer check `if (!entry)` is used instead of checkin=
g if the usage entry is populated.
- [Medium] Insufficient bounds checking on device-supplied usage size leads=
 to a heap out-of-bounds read in `axiom_u42_get_touchslots`.
--

A review of this patch has revealed the following issues:

commit ee908a9756d78a49fffc38a01178c9ab48ed3f33
Author: Marco Felsch <m.felsch@pengutronix.de>

Input: Add TouchNetix aXiom I2C Touchscreen support

This adds the initial support for the TouchNetix AX54A touchcontroller
which is part of TouchNetix's aXiom touchscreen controller family.

> diff --git a/drivers/input/touchscreen/touchnetix_axiom.c b/drivers/input=
/touchscreen/touchnetix_axiom.c
> --- a/drivers/input/touchscreen/touchnetix_axiom.c
> +++ b/drivers/input/touchscreen/touchnetix_axiom.c

[ ... ]

> @@ -854,16 +854,16 @@ static int axiom_u02_save_config(struct axiom_data =
*ts)
>  	msg.parameters[2] =3D cpu_to_le16(AXIOM_U02_REV1_PARAM2_SAVEVLTLCFG2NVM=
);
> =20
>  	error =3D axiom_u02_send_msg(ts, &msg, false);
>  	if (error)
>  		return error;
> =20
>  	/* Downstream axcfg.py waits for 2sec without checking U01 response */
>  	if (!axiom_wait_for_completion_timeout(ts, &ts->nvm_write,
>  					       msecs_to_jiffies(2 * MSEC_PER_SEC))) {

[Severity: High]
Does this code risk consuming a stale completion signal? The completion=20
variable ts->nvm_write doesn't appear to be reinitialized. If a previous
operation timed out but completed late, could wait_for_completion_timeout()
return immediately here without actually waiting? We might need a call to
reinit_completion() before starting the wait.

> @@ -876,16 +876,16 @@ static int axiom_u02_swreset(struct axiom_data *ts)
>  	error =3D axiom_u02_send_msg(ts, &msg, false);
>  	if (error)
>  		return error;
> =20
>  	/*
>  	 * Downstream axcfg.py waits for 1sec without checking U01 HELLO. Tests
>  	 * showed that waiting for the HELLO message isn't enough therefore we
>  	 * need to add the additional fsleep(1sec).
>  	 * Touchnetix said that the boot can take up to 2sec if all self tests
>  	 * are enabled, so wait 2sec for the HELLO message.
>  	 */
>  	if (!axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
>  					       msecs_to_jiffies(2 * MSEC_PER_SEC))) {

[Severity: High]
Could we hit the same stale completion issue here for ts->boot_complete? A
late interrupt from a previous operation might cause this to return early
if reinit_completion() is missing.

[ ... ]

> @@ -998,16 +998,16 @@ static int axiom_regmap_read(void *context, const v=
oid *reg_buf, size_t reg_size
> =20
>  	if (val_size > AXIOM_MAX_XFERLEN) {
>  		dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
>  			val_size, AXIOM_MAX_XFERLEN);
>  		return -EINVAL;
>  	}
> =20
>  	addr =3D *((u16 *)reg_buf);
>  	hdr.target_address =3D cpu_to_le16(addr);

[Severity: High]
Will this address casting work correctly on big-endian hosts? Since I2C
regmap sends the buffer in big-endian format by default, casting the byte
buffer directly to u16 will swap the bytes on little-endian systems. Then,
when calling cpu_to_le16(addr), a big-endian system will swap the big-endian
bytes to little-endian, completely breaking the hardware communication.
Does this code need to read the address using get_unaligned_be16() instead?

> @@ -1035,16 +1035,16 @@ static int axiom_regmap_write(void *context, cons=
t void *data, size_t count)
>  	val_size =3D count - sizeof(addr);
>  	if (val_size > AXIOM_MAX_XFERLEN) {
>  		dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
>  			val_size, AXIOM_MAX_XFERLEN);
>  		return -EINVAL;
>  	}
> =20
>  	addr =3D *((u16 *)data);
>  	hdr.target_address =3D cpu_to_le16(addr);

[Severity: High]
Does this have the same endianness issue as axiom_regmap_read()?

[ ... ]

> @@ -1078,16 +1078,16 @@ static bool axiom_u42_get_touchslots(struct axiom=
_data *ts)
> =20
>  	reg =3D axiom_usage_baseaddr(ts, AXIOM_U42);
>  	error =3D regmap_raw_read(ts->regmap, reg, buf, bufsize);
>  	if (error) {
>  		dev_warn(ts->dev, "Failed to read u42\n");
>  		return false;
>  	}
> =20
>  	ts->enabled_slots =3D 0;
>  	ts->num_slots =3D 0;
> =20
>  	for (i =3D 0; i < AXIOM_MAX_TOUCHSLOTS; i++) {
>  		if (axiom_u42_touch_enabled(ts, buf, i)) {

[Severity: Medium]
Could this loop read out of bounds? The buf buffer is sized based on bufsize
which is supplied by the device. If the device advertises a U42 usage size
smaller than the maximum required index (e.g., 4 bytes), iterating 10 times
and indexing into buf might result in a heap out-of-bounds read. Do we need
to verify that bufsize is large enough for all max touch slots?

[ ... ]

> @@ -1117,16 +1117,16 @@ static int axiom_process_report(struct axiom_data=
 *ts, unsigned char usage_num,
>  				const u8 *buf, size_t buflen)
>  {
>  	struct axiom_usage_table_entry *entry =3D &ts->usage_table[usage_num];
> =20
>  	/* Skip processing if not in TCP mode */
>  	if ((axiom_get_runmode(ts) !=3D AXIOM_TCP_MODE) &&
>  	    (axiom_get_runmode(ts) !=3D AXIOM_TCP_CFG_UPDATE_MODE))
>  		return 0;
> =20
>  	/* May happen if an unsupported usage was requested */
>  	if (!entry) {
>  		dev_info(ts->dev, "Unsupported usage U%x request\n", usage_num);
>  		return 0;
>  	}

[Severity: Medium]
Is this pointer check effective? Since entry is initialized using the addre=
ss
of an element in the array (&ts->usage_table[usage_num]), it will never
be NULL. Should this check !entry->populated instead?

[ ... ]

> @@ -1158,16 +1158,16 @@ static int axiom_u34_rev1_process_report(struct a=
xiom_data *ts,
>  	 * The CRC16 value can be queried at the last two bytes of the report.
>  	 * The value itself is covering the complete report excluding the CRC16
>  	 * value at the end.
>  	 */
>  	crc_report =3D get_unaligned_le16(&buf[len - 2]);
>  	crc_calc =3D crc16(0, buf, (len - 2));
> =20
>  	if (crc_calc !=3D crc_report) {
>  		dev_err_ratelimited(dev, "CRC16 mismatch!\n");
>  		return -EINVAL;
>  	}
> =20
>  	report_usage =3D buf[1];
>  	payload =3D &buf[AXIOM_U34_REV1_PREAMBLE_BYTES];
>  	len -=3D AXIOM_U34_REV1_PREAMBLE_BYTES - AXIOM_U34_REV1_POSTAMBLE_BYTES;

[Severity: Medium]
Does this calculation result in an incorrect length? Due to C operator
precedence, len -=3D A - B calculates len -=3D (A - B). This evaluates to
len -=3D (2 - 4), effectively adding 2 to the length instead of subtracting=
 6.
Would len -=3D (AXIOM_U34_REV1_PREAMBLE_BYTES + AXIOM_U34_REV1_POSTAMBLE_BY=
TES)
be the intended math here?

[ ... ]

> @@ -1838,16 +1838,16 @@ static enum fw_upload_err axiom_axfw_fw_prepare(s=
truct fw_upload *fw_upload,
>  						const u8 *data, u32 size)
>  {
>  	struct axiom_data *ts =3D fw_upload->dd_handle;
>  	struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
>  	enum fw_upload_err ret;
> =20
>  	scoped_guard(mutex, &afw->lock) {
>  		afw->cancel =3D false;
>  	}
> =20
>  	mutex_lock(&ts->fwupdate_lock);
> =20
>  	ret =3D __axiom_axfw_fw_prepare(ts, afw, data, size);
> =20
>  	/*
>  	 * In FW_UPLOAD_ERR_NONE case the complete handler will release the
>  	 * lock.
>  	 */
>  	if (ret !=3D FW_UPLOAD_ERR_NONE)
>  		mutex_unlock(&ts->fwupdate_lock);

[Severity: High]
Does this code risk a double-unlock of ts->fwupdate_lock? The firmware
upload core unconditionally calls the cleanup callback when prepare fails.
Since axiom_axfw_fw_cleanup() also unconditionally unlocks the mutex,
unlocking it here on the error path will cause a double-unlock panic.

[ ... ]

> @@ -1934,16 +1934,16 @@ static enum fw_upload_err axiom_axfw_fw_write(str=
uct fw_upload *fw_upload,
>  		error =3D axiom_enter_bootloader_mode(ts);
>  		if (error)
>  			return axiom_unlock_input_return_hw_error(ts);
>  	}
> =20
>  	while (size) {
>  		u16 chunk_len, len;
> =20
>  		chunk_len =3D get_unaligned_be16(&data[6]);
>  		len =3D chunk_len + sizeof(struct axiom_fw_axfw_chunk_hdr);
> =20
>  		/*
>  		 * The bootlaoder FW can handle the complete chunk incl. the
>  		 * header.
>  		 */
>  		error =3D axiom_blp_write_chunk(ts, data, len);
>  		if (error) {
>  			/*
>  			 * Tests showed that the bootloader mode must be exited
>  			 * if an invalid chunk was received by the bootloader fw
>  			 * since all following attempts to download valid chunks
>  			 * will fail. Try do so via axiom_blp_reset() but tests
>  			 * also showed that this may fail too. So inform the
>  			 * user and hope that the full power-cycle helps. To get
>  			 * the device back into a working mode where the device
>  			 * accepts data again.
>  			 */
>  			if (axiom_blp_reset(ts))
>  				dev_warn(dev, "Couldn't recover device, device requires power-cycle\=
n");
>  			return axiom_unlock_input_return_hw_error(ts);
>  		}
> =20
>  		size -=3D len;

[Severity: High]
Could this loop read out of bounds on the kernel heap? The chunk_len is
extracted directly from the untrusted firmware data, but there is no check
to ensure that size is large enough to contain the full chunk. If the
firmware is malformed such that len > size, size will underflow to a huge
value causing an infinite out of bounds read.

[ ... ]

> @@ -2022,16 +2022,16 @@ static void axiom_axfw_fw_handle_irq(struct axiom=
_data *ts)
>  	 * because the probe() aborted due to firmware incompatibilities. Skip
>  	 * the enable step if the IRQ is not disabled to not mess with the
>  	 * refcount.
>  	 */
>  	if (irqd_irq_disabled(data) &&
>  	    axiom_get_runmode(ts) !=3D AXIOM_BLP_MODE)
>  		axiom_enable_irq(ts);
>  }
> =20
>  static void axiom_axfw_fw_cleanup(struct fw_upload *fw_upload)
>  {
>  	struct axiom_data *ts =3D fw_upload->dd_handle;
> =20
>  	mutex_unlock(&ts->fwupdate_lock);
>  	axiom_axfw_fw_handle_irq(ts);
>  	pm_runtime_mark_last_busy(ts->dev);
>  	pm_runtime_put_sync_autosuspend(ts->dev);
>  }

[Severity: High]
Does this pm_runtime_put_sync_autosuspend() call risk an underflow? If the
firmware upload fails during the prepare callback, the core will call this
cleanup function. Since the pm_runtime_resume_and_get() is only called later
inside the write callback, dropping the reference unconditionally here will
permanently underflow the PM runtime usage counter.

[ ... ]

> @@ -2171,16 +2171,16 @@ static enum fw_upload_err __axiom_cfg_fw_prepare(=
struct axiom_data *ts,
>  	/* Skip to the first fw chunk */
>  	data +=3D sizeof(struct axiom_fw_cfg_hdr);
>  	size -=3D sizeof(struct axiom_fw_cfg_hdr);
> =20
>  	/*
>  	 * Search for u33 which contains the CRC information and perform only
>  	 * the runtime-crc check.
>  	 */
>  	while (size) {
>  		unsigned int chunk_len;
> =20
>  		chunk_len =3D axiom_cfg_fw_prepare_chunk(&chunk, data);
>  		if (chunk.usage_num =3D=3D AXIOM_U33)
>  			break;
> =20
>  		data +=3D chunk_len;
>  		size -=3D chunk_len;

[Severity: High]
Is it possible for this loop to underflow the size variable if the chunk
is malformed? There doesn't appear to be a check verifying that size is
greater than or equal to chunk_len before subtracting it.

[ ... ]

> @@ -2435,16 +2435,16 @@ static enum fw_upload_err axiom_cfg_fw_write(stru=
ct fw_upload *fw_upload,
> =20
>  	/*
>  	 * (Re)start the device with the new config. Start the device AE
>  	 * either via u02 SW_RESET or u02 CMD_START, the behavior is the same
>  	 * according Touchnetix.
>  	 */
>  	error =3D axiom_u02_swreset(ts);
>  	if (error) {
>  		dev_err(dev, "Soft reset failed\n");
>  		goto err_unlock;
>  	}
> =20
>  	error =3D axiom_u33_read(ts, &ts->crc[AXIOM_CRC_CUR]);
>  	if (error)
>  		goto err_unlock;
> =20
>  	if (axiom_verify_crcs(ts))
>  		goto err_unlock;
> =20
>  	/* Unlock before the input device gets unregistered */
>  	axiom_unlock_input_device(ts);
> =20
>  	error =3D axiom_update_input_dev(ts);

[Severity: High]
Could this dynamic input device replacement lead to a Use-After-Free? The
driver softly resets the device and calls axiom_update_input_dev(ts) which
frees the old ts->input and allocates a new one. Unlike the AXFW update,
axiom_disable_irq(ts) is never called here. A soft-reset triggers an immedi=
ate
interrupt, which would cause axiom_u41_rev2_process_report() to execute and
access ts->input without locks while it is being freed.

[ ... ]

> @@ -2776,16 +2776,16 @@ static int axiom_register_input_dev(struct axiom_=
data *ts,
>  	input_set_abs_params(input, ABS_MT_POSITION_X, 0, AXIOM_MAX_XY, 0, 0);
>  	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, AXIOM_MAX_XY, 0, 0);
>  	input_set_abs_params(input, ABS_MT_DISTANCE, 0, 127, 0, 0);
>  	if (ts->cds_enabled)
>  		input_set_abs_params(input, ABS_MT_PRESSURE, 0, 127, 0, 0);
> =20
>  	touchscreen_parse_properties(input, true, &ts->prop);
> =20
>  	axiom_get_touchslots(ts);
>  	if (!ts->num_slots && update_in_process) {
>  		input_free_device(input);
>  		/*
>  		 * Skip input device registration but don't throw an error to
>  		 * not abort the update since some FW updates require a
>  		 * following CFG update to re-initialize the touchslot handling.
>  		 */
>  		if (update_in_process) {

[Severity: Medium]
Will this error path ever execute during the initial probe? When called from
probe, update_in_process is false, making the condition evaluate to false
even if ts->num_slots is 0. This skips the error block, calls
input_mt_init_slots (which returns 0 without initializing dev->mt), and
registers a potentially useless input device instead of returning an error.

[ ... ]

> @@ -2831,16 +2831,16 @@ static int axiom_register_input_dev(struct axiom_=
data *ts,
>  	 * to the i2c-dev whereas the input-poller belong to the input-dev. The
>  	 * input-dev can get unregistered during a firmware update to reflect
>  	 * the new firmware state. Therefore the input-poller setup must be done
>  	 * always.
>  	 */
>  	if (client->irq) {
>  		if (!ts->irq_setup_done) {
>  			error =3D devm_request_threaded_irq(dev, client->irq,
>  							  NULL, axiom_irq,
>  							  IRQF_ONESHOT,
>  							  dev_name(dev), ts);
>  			if (error) {
>  				dev_err(dev, "Failed to request IRQ\n");
>  				return error;
>  			}

[Severity: Medium]
Does this error path leak the input device? It returns immediately when
devm_request_threaded_irq() fails, but it appears to miss calling
input_free_device(input) which is done in the other error paths in this
function.

[ ... ]

> @@ -2866,16 +2866,16 @@ static int axiom_power_up_device(struct axiom_dat=
a *ts)
>  	int error;
> =20
>  	error =3D regulator_bulk_enable(ts->num_supplies, ts->supplies);
>  	if (error) {
>  		dev_err(dev, "Failed to enable power supplies\n");
>  		return error;
>  	}
> =20
>  	gpiod_set_value_cansleep(ts->reset_gpio, 1);
>  	fsleep(2000);
>  	gpiod_set_value_cansleep(ts->reset_gpio, 0);
> =20
>  	fsleep(AXIOM_STARTUP_TIME_MS);
> =20
>  	return 0;
>  }

[Severity: High]
Does this use the intended sleep duration? fsleep() takes its argument in
microseconds, but it's passed AXIOM_STARTUP_TIME_MS (which is 110). This wi=
ll
cause the driver to wait for 110 microseconds instead of 110 milliseconds,
which could prevent the touch controller from finishing its boot sequence
before communication is attempted.

[ ... ]

> @@ -2982,16 +2982,16 @@ static int axiom_i2c_probe(struct i2c_client *cli=
ent)
>  	if (error)
>  		return error;
> =20
>  	error =3D axiom_power_up_device(ts);
>  	if (error)
>  		return dev_err_probe(dev, error, "Failed to power-on device\n");
> =20
>  	pm_runtime_set_autosuspend_delay(dev, 10 * MSEC_PER_SEC);
>  	pm_runtime_use_autosuspend(dev);
>  	pm_runtime_set_active(dev);
>  	pm_runtime_get_noresume(dev);
>  	error =3D devm_pm_runtime_enable(dev);
>  	if (error)
>  		return dev_err_probe(dev, error, "Failed to enable pm-runtime\n");
> =20
>  	error =3D axiom_register_panel_follower(ts);
>  	if (error)
>  		return dev_err_probe(dev, error, "Failed to register panel follower\n"=
);

[Severity: Medium]
Do these probe error paths leak the PM runtime usage counter? Returning
directly here skips calling pm_runtime_put_sync() and leaves the hardware
regulators permanently enabled since axiom_power_down_device(ts) isn't call=
ed.

[ ... ]

> @@ -3099,14 +3099,14 @@ static int axiom_i2c_probe(struct i2c_client *cli=
ent)
>  		if (!IS_ENABLED(CONFIG_FW_UPLOAD))
>  			return dev_err_probe(dev, error, "Failed to register input device\n");
> =20
>  		dev_warn(dev, "Failed to register the input device, wait for user fw u=
pdate\n");
>  	}
> =20
>  	return 0;
>  }
> =20
>  static void axiom_i2c_remove(struct i2c_client *client)
>  {
>  	struct axiom_data *ts =3D i2c_get_clientdata(client);
> =20
>  	axiom_unregister_input_dev(ts);
>  }

[Severity: High]
Could manually unregistering the input device here race with devres-managed
resources? The threaded IRQ handler and sysfs firmware upload callbacks are
managed by devm, so they won't be disabled until after remove() finishes. If
an interrupt fires or a sysfs upload starts during unbind, it might access =
the
already-freed input device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-v6-10-topi=
c-touchscreen-axiom-v6-0-1aa50ba3bc5a@pengutronix.de?part=3D4
