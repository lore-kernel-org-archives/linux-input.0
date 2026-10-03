Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A339CD16;
	Sat,  3 Oct 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791050174; cv=none; b=Uli89YWFqNaWG3BWg/k2yELXNw8MFGHgxAoR07uusfl92DPYZp1tUXRPFo4zdsfWgSlX5CWnMiwDo67sLjWkBIuNGZkaQ1JnJaED/yayGcJQbkXGyMbD+/CID5DpubOYbqEiEFZa4bhjI9tknDOFP51Cwqzn0XLTbZCZc2iNzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791050174; c=relaxed/simple;
	bh=T8GsFPQxokMXhyxwh2mYv+BHP2Ts6yRDlU8XYf46jD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F8NkJM9zadegWMq5uvywN5sj5OuFAT/OTtq2UUJWJ9UgSqUuNCtQLfeCGObx3rLMuFipFpEMpadkFPn7JWRBfNVHtsRAGih/+1IVL8m4uTCIcG3bwfetCqieReeCprX/UQL2456DG0+D8PgotSh171C250/bqZ8FFDuwrsjFYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PztOx0s8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PztOx0s8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D11F0089B;
	Sat,  3 Oct 2026 17:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791050172;
	bh=5LBSKdKbKgaOPGYaCo9+mJKq/BquBAVkVidhXQ1PT7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PztOx0s8bhyDGPwv142pVHHiwx5QJYb5aNqUdP9tDAIgi6AErHr/EzqBwO7rAJWb/
	 OpydLKPjbU6JLVXtxRMfkMYPEP0cazp4USYu+D6mBhRFhe87+qFhMzJErEiq0YUPbT
	 3Mi1FQ/yNU7hFsIY2l2ee+vs0322GeCjdHB35CO3GznoGWS6iDPGBL49Ae+UjD8KRT
	 sqwBkGv+EPu6uO0f1ofzVwFBp4dym+n8AacDdb/7rC5G09equ/RChClSMVAPdc23ws
	 ZNxlfd+UPyhO/Budj6U0itDkT9htpKVF2x0YC1V1bHxa+1QFPfHo3DXnSxs8GJhS+B
	 tGkUUqGX4T5Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] HID: himax: Load the firmware from a file
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWljaGHFgiBLb3BlxIc=?= <michal@nozomi.space>
Cc: robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261003142741.48634-5-michal@nozomi.space>
References: <20261003142741.48634-1-michal@nozomi.space>
 <20261003142741.48634-5-michal@nozomi.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 17:56:11 +0000
Message-Id: <20261003175612.176D11F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] hid: himax: out-of-bounds read and heap overflow during firmware p=
arsing
- [High] hid: himax: data race and hardware corruption during concurrent fi=
rmware updates
- [High] hid: himax: use-after-free of HID device due to uncoordinated asyn=
chronous initialization
- [High] hid: himax: double-free and use-after-free of HID device on concur=
rent resume and initialization
- [High] hid: himax: integer underflow in HID report length calculation cau=
ses huge out-of-bounds read
- [High] hid: himax: null pointer dereference in threaded IRQ during device=
 removal
- [High] hid: himax: unaligned memory access via direct pointer casting
- [Medium] hid: himax: memory leak of zf_info array on error path
- [Medium] hid: himax: out-of-bounds read and info leak via %s formatting
- [Medium] hid: himax: interrupt registered with default level trigger inst=
ead of firmware configuration
- [Low] hid: himax: unreachable cancel_delayed_work_sync and misplaced erro=
r label in chip init
--

commit a448774427152dbb6ec0aa1a91961e9842a21cc0
Author: Allen_Lin <allencl_lin@hotmail.com>
Subject: HID: himax: Load the firmware from a file

The HX83102J is often shipped without a flash. The firmware then has to
be loaded from a file into the SRAM of the IC when the driver probes and
on every resume, as the IC loses it when it is powered down.

> diff --git a/drivers/hid/hid-himax.c b/drivers/hid/hid-himax.c
> --- a/drivers/hid/hid-himax.c
> +++ b/drivers/hid/hid-himax.c

[ ... ]

> +static int himax_mcu_read_FW_ver(struct himax_ts_data *ts)
> +{
[ ... ]
> +	ret =3D himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_CUS_INFO, data, HI=
MAX_TP_INFO_STR_LEN);
> +	if (ret < 0) {
> +		dev_err(ts->dev, "%s: read customer info fail\n", __func__);
> +		return ret;
> +	}
> +	memcpy(ts->ic_data.vendor_cus_info, data, HIMAX_TP_INFO_STR_LEN);
> +	dev_info(ts->dev, "%s: Cusomer ID : %s\n", __func__, ts->ic_data.vendor=
_cus_info);

[Severity: Medium]
Could this print out-of-bounds memory into the kernel log? The firmware data
copied into the fixed-size vendor_cus_info array may not be null-terminated.
Should a precision specifier like %.*s be used here to bound the string
formatting to HIMAX_TP_INFO_STR_LEN?

[ ... ]

> +static bool himax_bin_desc_data_get(struct himax_ts_data *ts, u32 addr, =
u8 *descript_buf)
> +{
[ ... ]
> +		} else { /* 3. get data */
> +			map_data.buf =3D &descript_buf[i];
> +			map_code =3D le32_to_cpup(map_data.word);

[Severity: High]
Does this pointer cast cause an unaligned access regression? Using a union =
to
cast an unaligned byte pointer from the firmware image to a 32-bit integer
pointer might cause a fault on architectures requiring strict alignment. Wo=
uld
it be safer to use get_unaligned_le32() here?

[ ... ]

> +static bool himax_mcu_bin_desc_get(unsigned char *fw, struct himax_ts_da=
ta *ts, u32 max_sz)
> +{
[ ... ]
> +	/* Check bin is with description table or not */
> +	if (!(memcmp(fw, header, header_sz) =3D=3D 0 && fw[header_id_loc] =3D=
=3D header_id)) {
> +		dev_err(ts->dev, "%s: No description table\n", __func__);
> +		return false;
> +	}

[Severity: High]
Is there a risk of an out-of-bounds read here if the firmware file is short=
er
than expected? The code accesses fw[14] (header_id_loc) and calls memcmp
without verifying if fw->size is at least large enough to contain the heade=
r.

[ ... ]

> +static int himax_mcu_tp_info_check(struct himax_ts_data *ts)
> +{
[ ... ]
> +	ret =3D himax_mcu_register_read(ts, HIMAX_DSRAM_ADDR_X_Y_RES, data, 4);
> +	if (ret < 0) {
> +		dev_err(ts->dev, "%s: read x/y resolution fail\n", __func__);
> +		return ret;
> +	}
> +	y_res =3D be16_to_cpup((u16 *)&data[0]);
> +	x_res =3D be16_to_cpup((u16 *)&data[2]);

[Severity: High]
Can this cause an alignment fault on architectures with strict alignment
requirements? Casting a byte array directly to a 16-bit pointer and
dereferencing it performs an unaligned access. Should this use
get_unaligned_be16() instead?

[ ... ]

> +static int himax_zf_part_info(const struct firmware *fw, struct himax_ts=
_data *ts)
> +{
[ ... ]
> +	if (i_min < 0 || i_max < 0) {
> +		dev_err(ts->dev, "%s: DSRAM address invalid!\n", __func__);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Does this error path leak the dynamically allocated info array? It appears
the function returns directly without calling kfree(info).

> +
> +	/* 3. prepare data to update */
> +	sram_min =3D info[i_min].cfg_addr;
> +
> +	cfg_sz =3D (dsram_max - dsram_base) + info[i_max].write_size;

[Severity: High]
Could this configuration size calculation bypass the bounds check and lead =
to
a heap buffer overflow later? By assuming the highest address block (i_max)
also holds the end boundary, this might undercalculate the true required
buffer size if a lower-addressed partition has a very large payload.

> +	/* Wrtie size must be multiple of 4 */
> +	if (cfg_sz % 4 !=3D 0)
> +		cfg_sz =3D cfg_sz + 4 - (cfg_sz % 4);
[ ... ]
> +	memset(ts->zf_update_cfg_buffer, 0x00,
> +	       ts->chip_max_dsram_size * sizeof(u8));
> +
> +	/* Collect all partition in FW for DSRAM in a cfg buffer */
> +	for (i =3D 1; i < pnum; i++)
> +		memcpy(&ts->zf_update_cfg_buffer[info[i].cfg_addr - dsram_base],
> +		       &fw->data[info[i].fw_addr], info[i].write_size);

[Severity: High]
Does this memcpy risk overflowing the allocated zf_update_cfg_buffer or
reading out-of-bounds from the firmware file? If the firmware provides
malformed partition offsets or lengths, this could lead to memory corruptio=
n.

[ ... ]

> +static int himax_zf_reload_from_file(char *file_name, struct himax_ts_da=
ta *ts)
> +{
[ ... ]
> +	if (!mutex_trylock(&ts->zf_update_lock)) {
> +		dev_warn(ts->dev, "%s: Other thread is updating now!\n", __func__);
> +		return 0;
> +	}

[Severity: High]
Does returning 0 here falsely report success to the resume path if another
thread is already updating the firmware? Furthermore, since
himax_initial_work() initiates the initial firmware update without holding
the zf_update_lock, could both threads race and concurrently update the
firmware, leading to hardware corruption regressions?

[ ... ]

> +static int himax_hid_probe(struct himax_ts_data *ts)
> +{
[ ... ]
> +	hid =3D ts->hid;
> +	if (hid) {
> +		hid_destroy_device(hid);
> +		hid =3D NULL;
> +	}

[Severity: High]
Is it safe to destroy and recreate the HID device here without locking
against concurrent callers? Both himax_initial_work() and
himax_chip_resume() call himax_hid_probe(). If a system suspend and resume
occur while the asynchronous initial update is running, they might invoke
hid_destroy_device() simultaneously on the same device, leading to a
double-free or use-after-free regression.

[ ... ]

> +static void himax_hid_remove(struct himax_ts_data *ts)
> +{
> +	if (ts && ts->hid)
> +		hid_destroy_device(ts->hid);
> +	else
> +		return;
> +
> +	ts->hid =3D NULL;
> +}

[Severity: High]
Does this removal logic leave the ts->hid_probed flag set to true while
ts->hid is set to NULL? The caller himax_spi_drv_remove() uses
disable_irq_nosync(), which does not wait for active threaded handlers to
finish. If a concurrent himax_ts_operation() executes, it will see
ts->hid_probed as true and attempt to call hid_input_report() with a NULL
ts->hid pointer, which could crash the system.

[ ... ]

> +static int himax_ts_operation(struct himax_ts_data *ts)
> +{
[ ... ]
> +	if (ts->hid_probed) {
> +		offset =3D ts->hid_desc.max_input_length;
> +		if (ts->ic_data.stylus_function) {
> +			ret +=3D himax_hid_report(ts,
> +						ts->xfer_buf + offset + HIMAX_HID_REPORT_HDR_SZ,
> +						ts->hid_desc.max_input_length -
> +						HIMAX_HID_REPORT_HDR_SZ);

[Severity: High]
Can this subtraction underflow if the firmware provides a max_input_length
of 0 or 1? Since HIMAX_HID_REPORT_HDR_SZ is 2, an underflow would result in
a huge unsigned length being passed to the HID report, potentially causing a
massive out-of-bounds memory read.

[ ... ]

> +static void himax_initial_work(struct work_struct *work)
> +{
[ ... ]
> +	if (himax_update_fw(ts)) {
> +		dev_err(ts->dev, "%s: Update FW fail\n", __func__);
> +		goto err_update_fw_failed;
> +	}

[Severity: High]
Should this firmware update be protected by the ts->zf_update_lock? The
resume path uses a trylock on zf_update_lock, but the initial asynchronous
worker calls this without holding the lock. This could allow concurrent
hardware updates if a suspend and resume happens immediately after boot.

[ ... ]

> +static int himax_chip_init(struct himax_ts_data *ts)
> +{
[ ... ]
> +	if (himax_ts_register_interrupt(ts)) {
> +		dev_err(ts->dev, "%s: register interrupt failed\n", __func__);
> +		return -EIO;
> +	}

[Severity: Medium]
Will the interrupt be registered with the wrong trigger type here?
himax_ts_register_interrupt() is called during driver probe and uses
ts->ic_data.interrupt_is_edge. Since the ts structure is zero-allocated, it
defaults to level triggering. However, the true firmware configuration is r=
ead
asynchronously later in himax_initial_work() via himax_mcu_tp_info_check(),
which is too late to affect the interrupt registration.

[ ... ]

> +	ts->initialized =3D true;
> +
> +	return 0;
> +	cancel_delayed_work_sync(&ts->initial_work);
> +err_update_cfg_buf_alloc_failed:
> +
> +	return ret;
> +}

[Severity: Low]
Is the code following the return statement unreachable? The unconditional
return makes the cancellation of the delayed work dead code. Additionally,
the err_update_cfg_buf_alloc_failed label is placed after the return,
meaning the failure path will also exit with 0 instead of propagating the
allocation error.

[ ... ]

>  static void himax_spi_drv_remove(struct spi_device *spi)
>  {
[ ... ]
> +	if (ts->probe_finish) {
> +		if (ts->ic_boot_done) {
> +			himax_int_enable(ts, false);
> +
> +			if (ts->hid_probed)
> +				himax_hid_remove(ts);
> +		}
> +		himax_chip_deinit(ts);
> +		himax_platform_deinit(ts);
> +	}
>  }

[Severity: High]
Could this sequence lead to a use-after-free regression of the HID device?
The check for ic_boot_done happens before himax_chip_deinit() cancels the
delayed initialization work. If the delayed work is currently executing,
ic_boot_done is false, so himax_hid_remove() is skipped. The work could
then finish and register the HID device right after the SPI driver has been
unbound and the ts structure freed, leaving an active HID device with a
dangling pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003142741.4863=
4-1-michal@nozomi.space?part=3D4
