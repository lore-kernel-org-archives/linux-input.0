Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7B367B9E;
	Thu,  2 Jul 2026 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032487; cv=none; b=QXIKeUmbwqD2GyFcJ2xWULTg1GoAPR/AxAPhSml0+aCrHCSCDNTl7DJsXo1NsbPB780WQzhWazrvfX/Ybxkn1qAm7RqyjYQWG60v6JU8/fB+pn9A1nB7kogv5J60gAuwLB2LRIP4wD6d3DvJCrV3A48wx8CegZ1jSkWpwebWcbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032487; c=relaxed/simple;
	bh=seL4cgErmtldsklwSUMuFI2PDm5NOpRQNSzBszaqGhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cqjGTrjCGdydYUURMH2+DDWDaVr9HuMomyKkEEUCg85Y2+4D8mB/mz5xWhTi6dXYY1R2znL2KmPxPwbm+BmAo0MuGZ6mRlFti+zHhPOK2JttQuhMV2SQorI99TEvRv5gyG4oNk07yQVp7/fUt40LgtuJSmtYzWgtc5btcpwLTcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEhf/Su+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEhf/Su+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B0D1F000E9;
	Thu,  2 Jul 2026 22:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783032485;
	bh=OPHVyeuMHSW1QWra33Db11ztaNS5rhR9EUrTMQK9QYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEhf/Su++2XR+QSfJXL/HtrG7KKkf1icFM3lqqdVNosqicoX0oQlNa9vgHra73MW0
	 2hcGb6ycSEzvVjy/urYCpdL9jo8qs3u+8rzKLrygZvSH8TPRbevVGkcV2qlBUWRVXc
	 nyTXg60R1miUbWOemy8lFDCXvUBOqdIjx1qRczYcLah7TRVZY442js1myN5103puEj
	 1lQskuygkuJDbVX1TVda6idOKh/WvWFy1cM9Pz/ncwTfqLf8u00821Nc1bosOhE4pq
	 V5BSweXlx2tz5lQS6mgoGk8XJiVYy9RSPyqWVjIoXKjod4/LGg0oMmo/Tuv/LhS/Bu
	 NFwjKOfDIghFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] Input: Add TouchNetix aXiom I2C Touchscreen
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Felsch" <m.felsch@pengutronix.de>
Cc: robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
References: <20260703-v6-10-topic-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de>
 <20260703-v6-10-topic-touchscreen-axiom-v7-4-0d2a550a7ee8@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 22:48:04 +0000
Message-Id: <20260702224804.E0B0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 18 potential issue=
(s) to consider:
- [High] Missing bounds checking during firmware chunk parsing allows malfo=
rmed firmware to trigger integer underflow and out-of-bounds memory accesse=
s.
- [High] Invalid cast of regmap buffer to u16* causes endian-dependent beha=
vior and corrupts register addresses.
- [High] Unbalanced pm_runtime_put in firmware upload cleanup leads to nega=
tive PM usage counts.
- [High] Firmware-controlled allocation size allows out-of-bounds heap read=
 when checking touch slots.
- [High] The driver prevents firmware recovery when the device boots in boo=
tloader mode by improperly failing the probe.
- [High] fwupdate_lock is held across system calls violating kernel mutex s=
emantics, and is double-unlocked on error paths.
- [High] Improper devm teardown order causes Use-After-Free of the input de=
vice by background firmware upload threads.
- [High] Use-after-free of ts->input in the threaded IRQ handler during con=
fig firmware updates and device removal.
- [High] The driver waits on completion primitives for hardware resets and =
saves without reinitializing them, causing future waits to falsely succeed =
immediately.
- [High] The driver passes stack-allocated buffers to I2C transfers, which =
violates DMA requirements and can cause memory corruption.
- [High] NULL pointer dereference in `axiom_remove_axfw_fwl_action` if `dev=
m_add_action_or_reset` fails.
- [Medium] An operator precedence error in subtracting the preamble and pos=
tamble causes the calculated report payload length to be artificially infla=
ted.
- [Medium] Probe error paths leak PM runtime references and fail to disable=
 regulators.
- [Medium] I2C read errors are swallowed and falsely reported as success in=
 polling functions.
- [Medium] Missing NULL check on `kasprintf` results in a crash or broken s=
ysfs state when registering the firmware upload interfaces.
- [Medium] The driver lacks system sleep power management callbacks, causin=
g the device to remain powered on during system suspend if not acting as a =
panel follower.
- [Medium] Dead code in `axiom_register_input_dev` prevents failing initial=
ization when no touchslots are enabled.
- [Low] Typo in the sysfs `device_state` output violates the documented ABI.
--

commit 7ff2ad22a9b84958a9fb53d181dbd9af7a0e7b00
Author: Marco Felsch <m.felsch@pengutronix.de>

Input: Add TouchNetix aXiom I2C Touchscreen support

This patch adds initial support for the TouchNetix AX54A touchscreen
controller. It handles I2C input events, touch coordinate reporting, and
supports firmware and configuration updates via the fw_upload subsystem.

> diff --git a/drivers/input/touchscreen/touchnetix_axiom.c b/drivers/input=
/touchscreen/touchnetix_axiom.c
> --- /dev/null
> +++ b/drivers/input/touchscreen/touchnetix_axiom.c

[ ... ]

> +static const char *axiom_runmode_to_string(struct axiom_data *ts)
> +{
> +	switch (ts->mode) {
> +	case AXIOM_DISCOVERY_MODE:	return "discovery";
> +	case AXIOM_TCP_MODE:		return "tcp";
> +	case AXIOM_TCP_CFG_UPDATE_MODE:	return "th2cfg-update";
> +	case AXIOM_BLP_MODE:		return "bootlaoder";

[Severity: Low]
Does this output "bootlaoder" instead of the documented "bootloader" state?

This typo might break userspace tools reading the device_state sysfs file.

> +	default:			return "unknown";
> +	}
> +}

[ ... ]

> +static int axiom_u02_wait_idle(struct axiom_data *ts)
> +{
> +	unsigned int reg;
> +	int error, ret;
> +	u16 cmd;
> +
> +	if (!axiom_driver_supports_usage(ts, AXIOM_U02))
> +		return -EINVAL;
> +
> +	reg =3D axiom_usage_baseaddr(ts, AXIOM_U02);
> +	reg +=3D AXIOM_U02_REV1_COMMAND_REG;
> +
> +	/*
> +	 * Missing regmap_raw_read_poll_timeout for now. RESP_SUCCESS means that
> +	 * the last command successfully completed and the device is idle.
> +	 */
> +	error =3D read_poll_timeout(regmap_raw_read, ret,
> +				  ret || cmd =3D=3D AXIOM_U02_REV1_RESP_SUCCESS,
> +				  10 * USEC_PER_MSEC, 1 * USEC_PER_SEC, false,
> +				  ts->regmap, reg, &cmd, 2);

[Severity: Medium]
Can this swallow I2C read errors?

If regmap_raw_read fails, ret will be non-zero (an error code). The
condition evaluates to true, ending the poll successfully. The function
then incorrectly assumes commands completed successfully and returns 0.

> +	if (error) {
> +		dev_err(ts->dev, "Poll u02 timedout with: %#x\n", cmd);
> +		return error;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static int axiom_u02_swreset(struct axiom_data *ts)
> +{
> +	struct axiom_u02_rev1_system_manager_msg msg =3D {
> +		.command =3D cpu_to_le16(AXIOM_U02_REV1_CMD_SOFTRESET),
> +	};
> +	int error;
> +
> +	if (!axiom_driver_supports_usage(ts, AXIOM_U02))
> +		return -EINVAL;
> +
> +	error =3D axiom_u02_send_msg(ts, &msg, false);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * Downstream axcfg.py waits for 1sec without checking U01 HELLO. Tests
> +	 * showed that waiting for the HELLO message isn't enough therefore we
> +	 * need to add the additional fsleep(1sec).
> +	 * Touchnetix said that the boot can take up to 2sec if all self tests
> +	 * are enabled, so wait 2sec for the HELLO message.
> +	 */
> +	if (!axiom_wait_for_completion_timeout(ts, &ts->boot_complete,
> +					       msecs_to_jiffies(2 * MSEC_PER_SEC))) {

[Severity: High]
Is reinit_completion needed here before waiting?

Since boot_complete and nvm_write are signaled via complete, future calls
to axiom_wait_for_completion_timeout will return immediately because
reinit_completion is never called to reset their internal state. This might
cause premature hardware communication.

> +		dev_err(ts->dev, "Error swreset timedout\n");
> +		error =3D -ETIMEDOUT;
> +	}
> +
> +	fsleep(USEC_PER_SEC);
> +
> +	return error;
> +}

[ ... ]

> +static bool axiom_u42_get_touchslots(struct axiom_data *ts)
> +{
> +	unsigned int bufsize;
> +	unsigned int reg;
> +	int error, i;
> +
> +	bufsize =3D axiom_usage_size(ts, AXIOM_U42);
> +	u8 *buf __free(kfree) =3D kzalloc(bufsize, GFP_KERNEL);
> +	if (!buf)
> +		return false;
> +
> +	reg =3D axiom_usage_baseaddr(ts, AXIOM_U42);
> +	error =3D regmap_raw_read(ts->regmap, reg, buf, bufsize);
> +	if (error) {
> +		dev_warn(ts->dev, "Failed to read u42\n");
> +		return false;
> +	}
> +
> +	ts->enabled_slots =3D 0;
> +	ts->num_slots =3D 0;
> +
> +	for (i =3D 0; i < AXIOM_MAX_TOUCHSLOTS; i++) {
> +		if (axiom_u42_touch_enabled(ts, buf, i)) {

[Severity: High]
Could this lead to an out-of-bounds heap read?

The bufsize is determined by the device via axiom_usage_size. If a
compromised or malfunctioning device reports a size smaller than 18 bytes,
the loop still iterates up to 10 slots checking fixed offsets up to index
17 in axiom_u42_touch_enabled, reading past the allocated buffer.

> +			ts->enabled_slots |=3D BIT(i);
> +			ts->num_slots++;
> +		}
> +	}
> +
> +	return true;
> +}

[ ... ]

> +static int axiom_u34_rev1_process_report(struct axiom_data *ts,
> +					 const u8 *_buf, size_t bufsize)
> +{
> +	unsigned int reg =3D axiom_usage_baseaddr(ts, AXIOM_U34);
> +	struct regmap *regmap =3D ts->regmap;
> +	u8 buf[AXIOM_PAGE_BYTE_LEN] =3D { };

[Severity: High]
Can this cause memory corruption on architectures lacking hardware cache
coherence?

The 256-byte buf array is allocated on the stack and passed to
regmap_raw_read, which eventually reaches the I2C core. Stack memory is
generally not DMA-safe, violating I2C transfer requirements.

> +	struct device *dev =3D ts->dev;
> +	unsigned char report_usage;
> +	u16 crc_report, crc_calc;
> +	unsigned int len;
> +	u8 *payload;
> +	int error;
> +
> +	error =3D regmap_raw_read(regmap, reg, buf, ts->max_report_byte_len);
> +	if (error)
> +		return error;

[ ... ]

> +	report_usage =3D buf[1];
> +	payload =3D &buf[AXIOM_U34_REV1_PREAMBLE_BYTES];
> +	len -=3D AXIOM_U34_REV1_PREAMBLE_BYTES - AXIOM_U34_REV1_POSTAMBLE_BYTES;

[Severity: Medium]
Could this calculation artificially inflate the payload length?

Mathematically, subtracting without parentheses evaluates like this:
len -=3D (2 - 4), which results in len +=3D 2.
Should this have parentheses around the values being subtracted?

> +
> +	switch (report_usage) {
> +	case AXIOM_U01:
> +	case AXIOM_U41:

[ ... ]

> +static int axiom_u41_rev2_process_report(struct axiom_data *ts,
> +					 const u8 *buf, size_t bufsize)
> +{
> +	struct input_dev *input =3D ts->input;
> +	unsigned char id;
> +	u16 targets;
> +
> +	/*
> +	 * The input registration can be postponed but the touchscreen FW is
> +	 * sending u41 reports regardless.
> +	 */
> +	if (!input)
> +		return 0;

[Severity: High]
Could this lead to a use-after-free if the input device is unregistered?

During config firmware updates (axiom_cfg_fw_write) and module removal,
the input device is freed. If the threaded IRQ handler runs concurrently
and reads ts->input before it is nulled out, it might access a freed pointer
when calling input_mt_slot and touchscreen_report_pos.

> +
> +	targets =3D get_unaligned_le16(&buf[AXIOM_U41_REV2_TARGETSTATUS_REG]);

[ ... ]

> +static int axiom_regmap_read(void *context, const void *reg_buf, size_t =
reg_size,
> +			     void *val_buf, size_t val_size)
> +{
> +	struct device *dev =3D context;
> +	struct i2c_client *i2c =3D to_i2c_client(dev);
> +	struct axiom_data *ts =3D i2c_get_clientdata(i2c);
> +	struct axiom_cmd_header hdr;
> +	struct i2c_msg xfer[2];
> +	u16 xferlen, addr;
> +	int ret;
> +
> +	if (val_size > AXIOM_MAX_XFERLEN) {
> +		dev_err(ts->dev, "Exceed max xferlen: %zu > %u\n",
> +			val_size, AXIOM_MAX_XFERLEN);
> +		return -EINVAL;
> +	}
> +
> +	addr =3D *((u16 *)reg_buf);
> +	hdr.target_address =3D cpu_to_le16(addr);

[Severity: High]
Does this cast cause endianness issues on big-endian architectures?

Casting a byte buffer directly to a u16 pointer evaluates differently
depending on the host byte order. When cpu_to_le16 is applied afterwards,
the register address sent to the device will be corrupted on big-endian
systems. The same pattern is present in axiom_regmap_write.

> +	xferlen =3D FIELD_PREP(AXIOM_CMD_HDR_DIR_MASK, AXIOM_CMD_HDR_READ) |
> +		  FIELD_PREP(AXIOM_CMD_HDR_LEN_MASK, val_size);
> +	hdr.xferlen =3D cpu_to_le16(xferlen);
> +
> +	if (!axiom_usage_supported(ts, addr))
> +		return -EINVAL;
> +
> +	xfer[0].addr =3D i2c->addr;
> +	xfer[0].flags =3D 0;
> +	xfer[0].len =3D sizeof(hdr);
> +	xfer[0].buf =3D (u8 *)&hdr;

[Severity: High]
Could passing the stack-allocated hdr struct to i2c_transfer cause issues
with DMA mapping?

The I2C core expects buffers that are DMA-safe, but stack variables might
violate this on non-coherent architectures. A similar stack-buffer is passed
in axiom_regmap_write.

> +
> +	xfer[1].addr =3D i2c->addr;
> +	xfer[1].flags =3D I2C_M_RD;
> +	xfer[1].len =3D val_size;
> +	xfer[1].buf =3D val_buf;

[ ... ]

> +static enum fw_upload_err axiom_axfw_fw_prepare(struct fw_upload *fw_upl=
oad,
> +						const u8 *data, u32 size)
> +{
> +	struct axiom_data *ts =3D fw_upload->dd_handle;
> +	struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
> +	enum fw_upload_err ret;
> +
> +	scoped_guard(mutex, &afw->lock) {
> +		afw->cancel =3D false;
> +	}
> +
> +	mutex_lock(&ts->fwupdate_lock);
> +
> +	ret =3D __axiom_axfw_fw_prepare(ts, afw, data, size);
> +
> +	/*
> +	 * In FW_UPLOAD_ERR_NONE case the complete handler will release the
> +	 * lock.
> +	 */
> +	if (ret !=3D FW_UPLOAD_ERR_NONE)
> +		mutex_unlock(&ts->fwupdate_lock);

[Severity: High]
Can this lead to a double-unlock of fwupdate_lock?

If __axiom_axfw_fw_prepare returns an error, this code unlocks the mutex.
However, the firmware upload core will subsequently call the cleanup
callback axiom_axfw_fw_cleanup, which unconditionally unlocks the mutex
again. The same issue exists in axiom_cfg_fw_prepare.

> +
> +	return ret;
> +}

[ ... ]

> +static enum fw_upload_err axiom_axfw_fw_write(struct fw_upload *fw_uploa=
d,
> +					      const u8 *data, u32 offset,
> +					      u32 size, u32 *written)
> +{
> +	struct axiom_data *ts =3D fw_upload->dd_handle;
> +	struct axiom_firmware *afw =3D &ts->fw[AXIOM_FW_AXFW];
> +	struct device *dev =3D ts->dev;
> +	int error;
> +
> +	/*
> +	 * According Touchnetix the IRQ pin gets reconfigured in bootloader
> +	 * mode. Which can cause spurious IRQs. Therefore the IRQ should be
> +	 * disabled on the host.
> +	 *
> +	 * See the cleanup routine for the balanced enable.
> +	 */
> +	if (axiom_get_runmode(ts) !=3D AXIOM_BLP_MODE)
> +		axiom_disable_irq(ts);
> +
> +	/* Done before cancel check due to cleanup based put */
> +	error =3D pm_runtime_resume_and_get(ts->dev);
> +	if (error)
> +		return FW_UPLOAD_ERR_HW_ERROR;

[Severity: High]
Does this error path lead to an unbalanced PM runtime usage count?

If pm_runtime_resume_and_get fails, it returns an error and no reference
is acquired. The firmware upload core will then call axiom_axfw_fw_cleanup,
which unconditionally calls pm_runtime_put_sync_autosuspend, potentially
causing a refcount underflow.

> +
> +	scoped_guard(mutex, &afw->lock) {
> +		if (afw->cancel)
> +			return FW_UPLOAD_ERR_CANCELED;
> +	}

[ ... ]

> +	while (size) {
> +		u16 chunk_len, len;
> +
> +		chunk_len =3D get_unaligned_be16(&data[6]);
> +		len =3D chunk_len + sizeof(struct axiom_fw_axfw_chunk_hdr);
> +
> +		/*
> +		 * The bootlaoder FW can handle the complete chunk incl. the
> +		 * header.
> +		 */
> +		error =3D axiom_blp_write_chunk(ts, data, len);
> +		if (error) {
> +			/*
> +			 * Tests showed that the bootloader mode must be exited
> +			 * if an invalid chunk was received by the bootloader fw
> +			 * since all following attempts to download valid chunks
> +			 * will fail. Try do so via axiom_blp_reset() but tests
> +			 * also showed that this may fail too. So inform the
> +			 * user and hope that the full power-cycle helps. To get
> +			 * the device back into a working mode where the device
> +			 * accepts data again.
> +			 */
> +			if (axiom_blp_reset(ts))
> +				dev_warn(dev, "Couldn't recover device, device requires power-cycle\=
n");
> +			return axiom_unlock_input_return_hw_error(ts);
> +		}
> +
> +		size -=3D len;
> +		*written +=3D len;
> +		data +=3D len;

[Severity: High]
Is there a bounds checking issue here that could lead to integer underflow?

The length is calculated and subtracted from size without checking if len
is actually less than or equal to size. If a malformed firmware chunk
reports a large chunk_len, size will wrap around, causing out-of-bounds
accesses on the next iteration. This also occurs in axiom_cfg_fw_write
and __axiom_cfg_fw_prepare.

> +	}

[ ... ]

> +static int axiom_register_fwl(struct axiom_data *ts)
> +{
> +	struct device *dev =3D ts->dev;
> +	struct fw_upload *fwl;
> +	char *fw_name;
> +	int error;
> +
> +	if (!IS_ENABLED(CONFIG_FW_UPLOAD)) {
> +		dev_dbg(dev, "axfw and th2cfgbin update disabled\n");
> +		return 0;
> +	}
> +
> +	mutex_init(&ts->fw[AXIOM_FW_AXFW].lock);
> +	fw_name =3D kasprintf(GFP_KERNEL, "i2c:%s.axfw", dev_name(dev));
> +	fwl =3D firmware_upload_register(THIS_MODULE, ts->dev, fw_name,
> +				       &axiom_axfw_fw_upload_ops, ts);

[Severity: Medium]
Should there be a NULL pointer check for fw_name?

If kasprintf fails under memory pressure, it returns NULL, which is then
passed directly to firmware_upload_register.

> +	kfree(fw_name);
> +	if (IS_ERR(fwl))
> +		return dev_err_probe(dev, PTR_ERR(fwl),
> +				     "Failed to register firmware upload\n");
> +
> +	error =3D devm_add_action_or_reset(dev, axiom_remove_axfw_fwl_action, t=
s);
> +	if (error)
> +		return error;
> +
> +	ts->fw[AXIOM_FW_AXFW].fwl =3D fwl;

[Severity: High]
Could this cause a NULL pointer dereference if devm_add_action_or_reset fai=
ls?

If it fails, devm_add_action_or_reset executes axiom_remove_axfw_fwl_action
immediately. However, ts->fw[AXIOM_FW_AXFW].fwl is currently NULL because
it hasn't been assigned yet, causing firmware_upload_unregister to crash.

> +
> +	mutex_init(&ts->fw[AXIOM_FW_CFG].lock);

[ ... ]

> +static int axiom_register_input_dev(struct axiom_data *ts,
> +				    bool update_in_process)
> +{
> +	struct device *dev =3D ts->dev;
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct input_dev *input;
> +	int error;

[ ... ]

> +	axiom_get_touchslots(ts);
> +	if (!ts->num_slots && update_in_process) {
> +		input_free_device(input);
> +		/*
> +		 * Skip input device registration but don't throw an error to
> +		 * not abort the update since some FW updates require a
> +		 * following CFG update to re-initialize the touchslot handling.
> +		 */
> +		if (update_in_process) {
> +			dev_info(dev, "No touchslots found after FW or CFG update, skip regis=
tering input device\n");
> +			return 0;
> +		}
> +
> +		dev_err(dev, "Error firmware has no touchslots enabled\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
Is the -EINVAL error path dead code?

The outer if-statement requires update_in_process to be true. The inner
if-statement also checks if update_in_process is true and returns 0.
The code will never reach the dev_err and -EINVAL return.

> +
> +	error =3D input_mt_init_slots(input, ts->num_slots, INPUT_MT_DIRECT);

[ ... ]

> +static int axiom_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct axiom_data *ts;
> +	int error;

[ ... ]

> +	pm_runtime_set_autosuspend_delay(dev, 10 * MSEC_PER_SEC);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
> +	error =3D devm_pm_runtime_enable(dev);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed to enable pm-runtime\n");
> +
> +	error =3D axiom_register_panel_follower(ts);
> +	if (error)
> +		return dev_err_probe(dev, error, "Failed to register panel follower\n"=
);

[Severity: Medium]
Do these error returns leak the PM runtime reference and leave the power
supplies enabled?

If devm_pm_runtime_enable or axiom_register_panel_follower fail, the
function returns directly without dropping the reference acquired by
pm_runtime_get_noresume or disabling the regulators.

> +
> +	error =3D axiom_u31_device_discover(ts);
> +	/*
> +	 * Register the device to allow FW updates in case that the current FW
> +	 * doesn't support the required driver usages or if the device is in
> +	 * bootloader mode.
> +	 *
> +	 * The U02 usage has to be supported, since this is the usage which is
> +	 * used to put the device into bootloader mode!
> +	 *
> +	 * TODO: Add support for the emergency bootloader mode enter sequence.
> +	 * The emergency enter is done by toggling the nRESET pin 5-times in a
> +	 * row.
> +	 */
> +	if (error) {
> +		if (IS_ENABLED(CONFIG_FW_UPLOAD) &&
> +		    axiom_driver_supports_usage(ts, AXIOM_U02) &&
> +		    (axiom_get_runmode(ts) =3D=3D AXIOM_DISCOVERY_MODE ||
> +		     axiom_get_runmode(ts) =3D=3D AXIOM_BLP_MODE)) {
> +			dev_warn(dev, "Device discovery failed, wait for user fw update\n");
> +			pm_runtime_mark_last_busy(dev);
> +			pm_runtime_put_sync_autosuspend(dev);
> +			return 0;
> +		}
> +		pm_runtime_put_sync(dev);
> +		return dev_err_probe(dev, error, "Device discovery failed\n");
> +	}

[Severity: High]
Does this logic prevent firmware recovery when the device boots in bootload=
er
mode?

When starting in BLP mode, axiom_u31_device_discover returns -EACCES
without populating the usage table. The recovery check here evaluates
axiom_driver_supports_usage(ts, AXIOM_U02), which returns false because the
usage table is empty. This aborts the probe instead of enabling the upload
interface.

> +
> +	error =3D axiom_register_input_dev(ts, false);

[ ... ]

> +static void axiom_i2c_remove(struct i2c_client *client)
> +{
> +	struct axiom_data *ts =3D i2c_get_clientdata(client);
> +
> +	axiom_unregister_input_dev(ts);
> +}

[Severity: High]
Could this lead to a use-after-free during unbind?

The firmware upload cleanup actions are registered via devres, meaning they
execute after axiom_i2c_remove. However, axiom_i2c_remove explicitly frees
the input device. If a background firmware upload thread is active, it will
access the freed input device.

> +
> +static int axiom_runtime_suspend(struct device *dev)
> +{
> +	struct axiom_data *ts =3D dev_get_drvdata(dev);
> +
> +	axiom_disable_irq(ts);
> +	axiom_power_down_device(ts);
> +
> +	return 0;
> +}
> +
> +static int axiom_runtime_resume(struct device *dev)
> +{
> +	struct axiom_data *ts =3D dev_get_drvdata(dev);
> +	int error;
> +
> +	error =3D axiom_power_up_device(ts);
> +	if (error)
> +		return error;
> +
> +	axiom_enable_irq(ts);
> +
> +	return 0;
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(axiom_pm_ops, axiom_runtime_suspend,
> +				 axiom_runtime_resume, NULL);

[Severity: Medium]
Should this include system sleep power management callbacks?

DEFINE_RUNTIME_DEV_PM_OPS is used, but without SYSTEM_SLEEP_PM_OPS. If the
touchscreen is held open by userspace during a system suspend (S3), the
device will remain in RPM_ACTIVE and stay powered on.

> +
> +static const struct i2c_device_id axiom_i2c_id_table[] =3D {
> +	{ "ax54a" },
> +	{ },
> +};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-v6-10-topi=
c-touchscreen-axiom-v7-0-0d2a550a7ee8@pengutronix.de?part=3D4
