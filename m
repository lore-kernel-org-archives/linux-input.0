Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE903AC0ED;
	Fri, 11 Sep 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117357; cv=none; b=l9FaXkBFFY386UmLOx0lkiGtoBOWrBXN4+llzN+M7sea+Qh/vK6yyJuQldetQ8YjLLW0usaPdPGtoSVpx1jq2xH8F00U/QBK1tMRMJo7Aky82xnXgy3CsNHN638kaz4CypqUd/ZtZS9MA9KtxamgWq28Ls0E862dc58lKdNiEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117357; c=relaxed/simple;
	bh=GuXDXPyeIo8ZOhS1kE3Y73mChIwub4eYEa/RHyevegs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DDctSgc3V/so2DEiKl80K7bZVXzt29CEww9vz1qQC7ZgFB9ZfO3McJtjIOZCRD7xxQFK5D2RIAaoYoHVZIF5JALhiXKfz3BtNsAb0+pTWjGuKw+CF6Br4jf9niB79waxwbuRHC0vrz+te3lVVA1Azk1cEdBj5TziJa5RvS/Ug/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAgKWgE3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAgKWgE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF5C1F000FF;
	Fri, 11 Sep 2026 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117355;
	bh=1oGPf+94HnZQZlhuN5fUGZEQfw+e20DdX/fTC45xHbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XAgKWgE3Vl+n31nJl6W6Z270ptEL+yGREEGQtdkhDjGVa2anIOPjuLhTwd9EQTx7L
	 mX4G3eFXqBsbb30kTZ+KJZnuHK+RfK6apaCcVwda+MM5kX+qf4rUD1Mt5lJJgok6hO
	 3WqpssgCgRB/aTfXBLM6TSOvQxYovyqypY9dsxACLW0iAXJPeYFjLk/x8Yvap0axbX
	 CjemxVhTBmEB6jN3hxlFkETtmBabPlOpAdh3pDQM3eB5GJ0x9tE/NsKL16xW9LPxON
	 6RVmTvaOoP3HU4bxRUdp5dDVVdTBUXgsuh6rzpc4DgGsYbl3qLsi3WluMbCxQIZdmd
	 nEpsnGP0YvAQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/10] Input: novatek-nt36672a-spi: add driver for
 Novatek NT36672A SPI touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, lee@kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-6-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-6-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:02:32 +0000
Message-Id: <20260911090235.3AF5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Use-after-free vulnerability due to mismatched devm/manual cleanup=
 lifetimes.
- [High] Out-of-bounds memory read during firmware partition parsing and pa=
yload download.
- [Medium] Incomplete implementation of standard touchscreen properties API.
- [Medium] Synchronous request_firmware() in probe causes permanent failure=
 if firmware is not immediately available.
- [Low] Redundant manual configuration violating input subsystem guidelines.
--

commit eca71b1ff2a43ef234d60ca689183c4d75eed0bc
Author: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

    Input: novatek-nt36672a-spi: add driver for Novatek NT36672A SPI touchs=
creen
   =20
    Add support for the Novatek NT36672A TDDI touchscreen controller over S=
PI,
    featuring dynamic firmware download, multi-partition binary parsing, and
    DRM panel follower integration.

> diff --git a/drivers/input/touchscreen/novatek-nt36672a-spi.c b/drivers/i=
nput/touchscreen/novatek-nt36672a-spi.c
> new file mode 100644
> index 0000000000000..03d2042b0bb30
> --- /dev/null
> +++ b/drivers/input/touchscreen/novatek-nt36672a-spi.c

[ ... ]

> +static int nvt_write_sram(struct spi_device *spi, const u8 *fwdata,
> +			  u32 sram_addr, u32 size, u32 bin_addr)
> +{
> +	u32 count, i, len;
> +	int ret =3D 0;
> +	u8 *fwbuf;
> +
> +	fwbuf =3D kmalloc(NVT_TRANSFER_LEN + 2, GFP_KERNEL);
> +	if (!fwbuf)
> +		return -ENOMEM;
> +
> +	count =3D (size + NVT_TRANSFER_LEN - 1) / NVT_TRANSFER_LEN;
> +
> +	for (i =3D 0; i < count; i++) {
> +		len =3D (size < NVT_TRANSFER_LEN) ? size : NVT_TRANSFER_LEN;
> +
> +		ret =3D nvt_set_page(spi, sram_addr);
> +		if (ret)
> +			goto out;
> +
> +		fwbuf[0] =3D sram_addr & 0x7f;
> +		memcpy(fwbuf + 1, &fwdata[bin_addr], len);

[Severity: High]
Does this code perform an out-of-bounds read if the provided firmware file =
is
malformed?

The untrusted bin_addr and size are directly used to index fwdata without
validating that bin_addr + size <=3D fwsize, resulting in arbitrary
out-of-bounds reads during the copy.

[ ... ]

> +static int nvt_parse_and_download(struct novatek_ts_data *ts, const u8 *=
fwdata, size_t fwsize)
> +{
> +	struct spi_device *spi =3D ts->spi;
> +	struct nvt_ts_bin_map bin_map[16];
> +	u8 info_sec_num =3D 0;
> +	u8 ovly_sec_num =3D 0;
> +	u32 partition, list;
> +	u32 header_end, pos;
> +	u8 buf[18];
> +	int ret, retry;
> +
> +	if (fwsize < 0x40)
> +		return -EINVAL;
> +
> +	header_end =3D byte_to_word(&fwdata[0]);
> +	pos =3D 0x30;
> +	while (pos < header_end && info_sec_num < 14) {
> +		info_sec_num++;
> +		pos +=3D 0x10;
> +	}
> +
> +	ovly_sec_num =3D (fwdata[0x28] & 0x10) ? (fwdata[0x28] & 0x0f) : 0;
> +	partition =3D 2 + ovly_sec_num + info_sec_num;
> +	if (partition > 16)
> +		partition =3D 16;
> +
> +	for (list =3D 0; list < partition; list++) {
> +		if (list < 2) {
> +			bin_map[list].bin_addr =3D byte_to_word(&fwdata[0 + list * 12]);
> +			bin_map[list].sram_addr =3D byte_to_word(&fwdata[4 + list * 12]);
> +			bin_map[list].size =3D byte_to_word(&fwdata[8 + list * 12]);
> +			bin_map[list].crc =3D byte_to_word(&fwdata[0x18 + list * 4]);
> +		} else {
> +			pos =3D 0x30 + (0x10 * (list - 2));
> +			bin_map[list].sram_addr =3D byte_to_word(&fwdata[pos]);
> +			bin_map[list].size =3D byte_to_word(&fwdata[pos + 4]);
> +			bin_map[list].bin_addr =3D byte_to_word(&fwdata[pos + 8]);

[Severity: High]
Can this loop read out of bounds?

The parsing loop computes 'pos' dynamically up to 16 partitions without bou=
nds
checking against fwsize. This can reach offsets past the minimum 0x40 bytes
checked earlier.

[ ... ]

> +static int novatek_ts_panel_prepared(struct drm_panel_follower *follower)
> +{
> +	struct novatek_ts_data *ts =3D container_of(follower, struct novatek_ts=
_data, panel_follower);
> +
> +	if (ts->fw_wq) {
> +		cancel_delayed_work_sync(&ts->fw_reload_work);
> +		queue_delayed_work(ts->fw_wq, &ts->fw_reload_work, msecs_to_jiffies(15=
00));

[Severity: High]
Could this result in a use-after-free if triggered after the driver is
unbound?

If a panel prepare event fires after novatek_ts_remove() destroys the
workqueue but before devres removes the panel follower, this will invoke
queue_delayed_work() on the already-freed ts->fw_wq pointer.

[ ... ]

> +static irqreturn_t novatek_ts_threaded_irq(int irq, void *dev_id)
> +{
> +	struct novatek_ts_data *ts =3D dev_id;
> +	u8 point_data[NVT_POINT_DATA_LEN + 2] =3D {0};
> +	bool slot_pressed[NVT_MAX_TOUCHES] =3D {false};
> +	int finger_cnt =3D 0;
> +	int ret, i;
> +
> +	mutex_lock(&ts->lock);
> +
> +	nvt_set_page(ts->spi, EVENT_BUF_ADDR);
> +
> +	point_data[0] =3D 0x00;
> +	ret =3D nvt_spi_read(ts->spi, point_data, NVT_POINT_DATA_LEN + 1);
> +	if (ret < 0) {
> +		dev_err_ratelimited(&ts->spi->dev, "failed to read touch points: %d\n"=
, ret);
> +		mutex_unlock(&ts->lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	for (i =3D 0; i < NVT_MAX_TOUCHES; i++) {
> +		int pos =3D 1 + 6 * i;
> +		u8 raw0 =3D point_data[pos];
> +		u8 input_id =3D raw0 >> 3;
> +		u8 status =3D raw0 & 0x07;
> +
> +		if (input_id < 1 || input_id > NVT_MAX_TOUCHES)
> +			continue;
> +
> +		if (status =3D=3D 0x01 || status =3D=3D 0x02) { /* 1: down, 2: move */
> +			u32 x =3D ((u32)point_data[pos + 1] << 4) | ((u32)point_data[pos + 3]=
 >> 4);
> +			u32 y =3D ((u32)point_data[pos + 2] << 4) | ((u32)point_data[pos + 3]=
 & 0x0f);
> +			u32 w =3D point_data[pos + 4] ? point_data[pos + 4] : 1;
> +			u32 p =3D point_data[pos + 5] ? point_data[pos + 5] : 1;
> +
> +			if (x <=3D ts->abs_x_max && y <=3D ts->abs_y_max) {
> +				int slot =3D input_id - 1;
> +
> +				slot_pressed[slot] =3D true;
> +				finger_cnt++;
> +
> +				input_mt_slot(ts->input_dev, slot);
> +				input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
> +				input_report_abs(ts->input_dev, ABS_MT_POSITION_X, x);
> +				input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, y);

[Severity: Medium]
Should this use touchscreen_report_pos() instead of reporting the coordinat=
es
raw?

The driver defines a touchscreen_properties struct but bypasses orientation
and scaling adjustments by not using the standard reporting helper here.

[ ... ]

> +static int novatek_ts_init_input(struct novatek_ts_data *ts)
> +{
> +	struct spi_device *spi =3D ts->spi;
> +	struct input_dev *input;
> +	int ret;
> +
> +	input =3D devm_input_allocate_device(&spi->dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input->name =3D "Novatek NT36672A Touchscreen";
> +	input->id.bustype =3D BUS_SPI;
> +	input->dev.parent =3D &spi->dev;
> +
> +	__set_bit(EV_SYN, input->evbit);
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(EV_ABS, input->evbit);
> +	__set_bit(INPUT_PROP_DIRECT, input->propbit);
> +
> +	input_set_capability(input, EV_KEY, BTN_TOUCH);

[Severity: Low]
Are these manual configurations redundant?

According to the input subsystem guidelines, devm_input_allocate_device()
automatically sets the device parent. Additionally, the core automatically
manages EV_SYN, and input_mt_init_slots() with INPUT_MT_DIRECT automatically
adds EV_KEY, BTN_TOUCH, and INPUT_PROP_DIRECT.

> +	input_set_abs_params(input, ABS_MT_POSITION_X, 0, ts->abs_x_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ts->abs_y_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +
> +	ret =3D input_mt_init_slots(input, NVT_MAX_TOUCHES,
> +				  INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);

[Severity: Medium]
Is there a missing call to touchscreen_parse_properties() here?

Without it, the driver ignores standard properties like touchscreen-inverte=
d-x,
leading to incorrect coordinate reporting on devices that rely on them.

[ ... ]

> +static int novatek_ts_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct novatek_ts_data *ts;
> +	int ret;
> +
> +	ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->spi =3D spi;
> +	mutex_init(&ts->lock);
> +
> +	ts->fw_wq =3D create_singlethread_workqueue("novatek_ts_fw");
> +	if (!ts->fw_wq)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(&ts->fw_reload_work, novatek_ts_fw_work);
> +
> +	ret =3D device_property_read_string(dev, "firmware-name", &ts->fw_name);
> +	if (ret)
> +		ts->fw_name =3D NVT_DEFAULT_FW_NAME;
> +
> +	spi->mode =3D SPI_MODE_0;
> +	spi->bits_per_word =3D 8;
> +	if (!spi->max_speed_hz)
> +		spi->max_speed_hz =3D 4000000;
> +
> +	ret =3D spi_setup(spi);
> +	if (ret)
> +		goto err_destroy_wq;
> +
> +	spi_set_drvdata(spi, ts);
> +
> +	ts->abs_x_max =3D 1080;
> +	ts->abs_y_max =3D 2340;
> +
> +	ret =3D novatek_ts_load_firmware(ts);
> +	if (ret) {
> +		dev_err(dev, "failed to download firmware during probe: %d\n", ret);
> +		goto err_destroy_wq;
> +	}

[Severity: Medium]
Will this synchronous request_firmware() call cause a permanent probe failu=
re if
the firmware is not immediately available at boot?

If the firmware is on a filesystem that hasn't mounted yet, returning an er=
ror
here prevents the device from ever initializing properly, even though the
driver implements a background firmware loader.

[ ... ]

> +	if (drm_is_panel_follower(dev)) {
> +		ts->panel_follower.funcs =3D &novatek_ts_panel_follower_funcs;
> +		ret =3D devm_drm_panel_add_follower(dev, &ts->panel_follower);

[Severity: High]
Does this create a lifetime mismatch with the manually destroyed workqueue?

The panel follower relies on devm for cleanup, extending its lifetime beyond
the explicitly freed workqueue in novatek_ts_remove().

[ ... ]

> +static void novatek_ts_remove(struct spi_device *spi)
> +{
> +	struct novatek_ts_data *ts =3D spi_get_drvdata(spi);
> +
> +	cancel_delayed_work_sync(&ts->fw_reload_work);
> +	destroy_workqueue(ts->fw_wq);
> +}

[Severity: High]
Is it safe to destroy the workqueue manually here before the panel follower
is removed by devm?

This manual destruction happens before devm automatically unregisters the D=
RM
panel follower, leaving a window where panel events can trigger workqueue
access on the freed pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D6
