Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573305;
	b=Y1TX/Z5sk1w8sZej5CG8Q6M+WU6I8gu8613dk9qxxecAsnNuf9Oqji9YZgUZRkMfFWB8
	 5LvCZPhqrxwifB614+VAwBQg1t9QvKtOKZmvJrV9KIf/61k/ndYd2ZwHQvFWuZ3SQQnFZ
	 SMnhyUnuT7QWN6VqdK7WnycxbOYB+O7LKpqcGhLBIECk2QliE3Ut/hxuNp+mm/cTva0oR
	 hAKJHkXFTLOQjTwrStaKpV36j4A7I8v41Z6/yZWOpPfjAcAPXqxVkiV7QXZgH3WQDqEYh
	 LvtUNIsVN6qJzK3Xfv5iS5ZtiKM1yTiaeRn7ac/2uYkLVvPgiPyEAcqW3GgPfL28t+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573305;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T2COakVKMfgrteIQGy9WhpJzbN6q/Tnr0GgzM4kHGCs=;
	b=Yr/aJU2bY7fhV4EHfhkEPcZPQVspEQslR7C2VBlfvuJggr6wEj9U5O/MHFtGJqQg5uTR
	 pCJRRJmYpI+SLX50Shk/y2QVTOkLYGJPnv4DdNiw68XcRaR9fdHD6Id692iJs0xexmJjJ
	 PaD5NTfAtd1rEwbMbB6LO46Evf1yzFOUEBV8fBSDhPMcvP6e7LStuM1vpS0UO1G5wUdq4
	 buGFxJQbzxjcamHqQSykZOBlnONggYy2d5RJMsti/T44MmYg963XSjjAlB0ZueHwk6fH/
	 87VXItsatvc0SLya2yZgFNIVQOLciyRXGMxZVjr/6YOJARKxeGXmh4Dn0AZbtBCzYFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg1pMxsx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC09606A31E;
	Wed, 25 Nov 2026 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg1pMxsx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1FD1F000C0;
	Wed, 25 Nov 2026 02:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573304;
	bh=T2COakVKMfgrteIQGy9WhpJzbN6q/Tnr0GgzM4kHGCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bg1pMxsxW2t2fLyMpK7Xr/eFLF3avUpvQQXXCH7Hq5/79WDc8E+wT+VUzrwA50yx2
	 cvIDsItFfUeqSapaSSSySnPP0MKlENr/Wqwh3pAZ7ygyAFFoxYZU03D02EKanlIDn5
	 Ec5gtXZ7K9hWx2XwYWGwXco5nRRHVh2kCF1C1tivmE4GtANk45CLQjUDDqg4V/45Y0
	 tFDfTZ5dIfASz7NQg88BX/gQgOq64snapLYLBwzrr+Mf4t0OHpLJ3IXorHTa/SyLgG
	 VgsFy5n2BT4/m5WoySJ7q0NtjVu0aA1pgmLRa2gzGaDio9WRrzGp8tfH68+3bpnenk
	 o3K+qQrYpG9Yg==
Message-ID: <sashiko-outbox-232404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] Input: add Jadard JD9365TX in-cell touchscreen
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_0E08C29B27905F3154DF71AA0F7F2BA5EF07@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_0E08C29B27905F3154DF71AA0F7F2BA5EF07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:21:44 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] Input: jadard_jd9365tx: deferred jd_hw_init() in jd_poll()
  breaks lifecycle
- [High] Input: jadard_jd9365tx: broken MT slot gating in
  jd_report_touches()
- [Medium] Input: jadard_jd9365tx: uninitialized stack read in
  jd_report_touches()
- [Medium] Input: jadard_jd9365tx: missing reset-gpios handling in
  jadard_tp_probe()
- [Low] Input: jadard_jd9365tx: signed shift overflow in
  jd_resolve_coord_addr()
- [Low] Input: jadard_jd9365tx: duplicate OF-only size parsing in
  jadard_tp_probe()
- [Low] Input: jadard_jd9365tx: Input and I2C subsystem convention
  violations
- [Low] Input: jadard_jd9365tx: missing commit description and invalid
  trailer
--

commit 14bb2db3ff6aa2fe722f173dd49badfb3b138498
Author: Hefei <3066883572@qq.com>

> Input: add Jadard JD9365TX in-cell touchscreen driver
>
> Signed-off-by: Hefei <3066883572@qq.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

[Severity: Low]
This commit adds a new touchscreen driver without a changelog body
describing the hardware, communication protocol, or polling design, and it
carries a non-standard Co-authored-by trailer for an AI tool without a
corresponding human DCO sign-off.

> diff --git a/drivers/input/touchscreen/jadard_jd9365tx.c b/drivers/input/=
touchscreen/jadard_jd9365tx.c
> new file mode 100644
> index 0000000000000..2030157c3a5b8
> --- /dev/null
> +++ b/drivers/input/touchscreen/jadard_jd9365tx.c

[ ... ]

> +static int jd_resolve_coord_addr(struct jadard_tp *ts)
> +{
> +	u32 esram_num_addr =3D JD_ERAM_BASE + 4 + JD_MAX_DSRAM_NUM * 8;
> +	u32 esram_sec_addr =3D esram_num_addr + 4;
> +	u8 buf[JD_ESRAM_SECTION_NUM * 8];
> +	u32 addr, len;
> +	int ret;
> +
> +	ret =3D jd_read_reg(ts->client, esram_sec_addr, buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	addr =3D buf[JD_ESRAM_COORD_IDX * 8 + 0] |
> +	       (buf[JD_ESRAM_COORD_IDX * 8 + 1] << 8) |
> +	       (buf[JD_ESRAM_COORD_IDX * 8 + 2] << 16) |
> +	       (buf[JD_ESRAM_COORD_IDX * 8 + 3] << 24);
> +	len =3D buf[JD_ESRAM_COORD_IDX * 8 + 4] |
> +	      (buf[JD_ESRAM_COORD_IDX * 8 + 5] << 8) |
> +	      (buf[JD_ESRAM_COORD_IDX * 8 + 6] << 16) |
> +	      (buf[JD_ESRAM_COORD_IDX * 8 + 7] << 24);

[Severity: Low]
Can the `<< 24` shifts on `buf[...]` overflow a 32-bit signed int?

Each `u8` element is promoted to signed `int` before shifting, so bit 7
being set triggers signed integer overflow under CONFIG_UBSAN.  Using
get_unaligned_le32() avoids both manual byte assembly and the signed shift.

> +
> +	if (addr < JD_ERAM_BASE || addr >=3D JD_ERAM_BASE + 0x1000 ||
> +	    len =3D=3D 0 || len > JD_TOUCH_DATA_SIZE)
> +		return -EINVAL;
> +
> +	ts->coord_addr =3D addr;
> +	ts->touch_data_size =3D (u16)len;
> +	return 0;
> +}

[Severity: Medium]
Can setting `ts->touch_data_size` to a value smaller than 53 cause
jd_report_touches() to read uninitialized stack memory from `buf`?

jd_poll() allocates `u8 buf[JD_TOUCH_DATA_SIZE]` on the stack without
initializing it and reads only `ts->touch_data_size` bytes from I2C.
However, jd_report_touches() unconditionally loops over all 10 slots
(`ts->max_points`) and reads 5 bytes per slot starting at
`JD_TOUCH_COORD_INFO_ADDR` (offsets 3 through 52).  If the ESRAM section
table reports `len < 53`, jd_report_touches() parses uninitialized stack
bytes and reports them to userspace as touch coordinates and touch major
values.

[ ... ]

> +static void jd_report_touches(struct jadard_tp *ts, const u8 *buf)
> +{
> +	u8 finger_num =3D buf[JD_FINGER_NUM_ADDR];
> +	unsigned int i;
> +	bool any =3D false;
> +
> +	if (finger_num > ts->max_points)
> +		finger_num =3D ts->max_points;
> +
> +	for (i =3D 0; i < ts->max_points; i++) {
> +		const u8 *c =3D buf + JD_TOUCH_COORD_INFO_ADDR +
> +			      i * JD_FINGER_DATA_SIZE;
> +		u16 x =3D (c[0] << 8) | c[1];
> +		u16 y =3D (c[2] << 8) | c[3];
> +		u8 w =3D c[4];
> +		bool down =3D false;
> +
> +		if (i < finger_num &&
> +		    x <=3D ts->abs_x_max && y <=3D ts->abs_y_max &&
> +		    x !=3D 0xFFFF && y !=3D 0xFFFF)
> +			down =3D true;

[Severity: High]
Does gating `down` on `i < finger_num` drop active touches in higher-number=
ed
MT slots when an earlier slot is released?

Each index `i` maps directly to MT slot `i`, while `finger_num` is the total
count of active contacts.  If two fingers are down in slots 0 and 1 and
finger 0 lifts, `finger_num` becomes 1 while slot 1 (`i =3D=3D 1`) still ho=
lds
the remaining finger's coordinates; `i < finger_num` (`1 < 1`) then evaluat=
es
to false and releases slot 1 as well.

Also, when `buf[JD_FINGER_NUM_ADDR] > ts->max_points` (such as 0xFF when the
report buffer is not ready), clamping `finger_num` to `ts->max_points`
processes the frame as up to 10 touches instead of discarding the invalid
frame.

[ ... ]

> +static void jd_poll(struct input_dev *input)
> +{
> +	struct jadard_tp *ts =3D input_get_drvdata(input);
> +	u8 buf[JD_TOUCH_DATA_SIZE];
> +	int ret;
> +
> +	if (!ts->ready) {
> +		ret =3D jd_hw_init(ts);
> +		if (ret)
> +			return;
> +		ts->ready =3D true;
> +	}

[Severity: High]
Does deferring jd_hw_init() from jadard_tp_probe() to jd_poll() break device
probing, polling, and power-cycle recovery?

Because jadard_tp_probe() never communicates with the controller, probe
succeeds and leaves `vdd` and `iovcc` enabled even when the device is absent
or has an unsupported chip ID (`-ENODEV`).  When the input device is opened,
jd_hw_init() -> jd_section_ready() can stall input_open_device() (under
`input->mutex`) and `system_freezable_wq` for up to 50 iterations of
`msleep(2)` plus I2C reads, and any failure causes jd_poll() to retry
jd_hw_init() on every 8-16 ms poll tick indefinitely.  Furthermore, once
`ts->ready` is set, it is never cleared across a DSI panel reset or system
suspend/resume, so the controller is never returned to the 0xF2 backdoor mo=
de
required for subsequent 0xF3 register reads.

[ ... ]

> +static int jadard_tp_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct jadard_tp *ts;
> +	struct input_dev *input;
> +	u32 val;
> +	int ret;
> +
> +	ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client =3D client;
> +	ts->max_points =3D JD_MAX_POINTS;
> +	ts->abs_x_max =3D 719;
> +	ts->abs_y_max =3D 1279;
> +	ts->poll_interval_ms =3D JD_DEFAULT_POLL_MS;
> +	ts->touch_data_size =3D JD_TOUCH_DATA_SIZE;
> +
> +	ts->vdd =3D devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(ts->vdd))
> +		return PTR_ERR(ts->vdd);
> +
> +	ts->iovcc =3D devm_regulator_get(dev, "iovcc");
> +	if (IS_ERR(ts->iovcc))
> +		return PTR_ERR(ts->iovcc);
> +
> +	ret =3D regulator_enable(ts->vdd);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regulator_enable(ts->iovcc);
> +	if (ret) {
> +		regulator_disable(ts->vdd);
> +		return ret;
> +	}

[Severity: Medium]
Should jadard_tp_probe() request and deassert the optional `reset-gpios`
after enabling the regulators?

The `jadard,jd9365tx` Devicetree binding defines `reset-gpios`, so boards
wiring that reset line can leave the controller held in reset and
unresponsive on I2C if probe never acquires and deasserts it.

> +
> +	ret =3D devm_add_action_or_reset(dev, jadard_tp_disable_regulators, ts);
> +	if (ret)
> +		return ret;
> +
> +	if (!device_property_read_u32(dev, "poll-interval", &val) &&
> +	    val >=3D 8 && val <=3D 100)
> +		ts->poll_interval_ms =3D val;
> +
> +	if (!of_property_read_u32(dev->of_node, "touchscreen-size-x", &val) && =
val)
> +		ts->abs_x_max =3D val - 1;
> +
> +	if (!of_property_read_u32(dev->of_node, "touchscreen-size-y", &val) && =
val)
> +		ts->abs_y_max =3D val - 1;

[Severity: Low]
Why parse `touchscreen-size-x` and `touchscreen-size-y` manually with
of_property_read_u32() when touchscreen_parse_properties() is called below?

touchscreen_parse_properties() already reads these properties via the
generic device property API and stores the pre-swap axis maxima in
`ts->prop.max_x` and `ts->prop.max_y`.  On non-OF property providers where
`dev->of_node` is NULL, `ts->abs_x_max` and `ts->abs_y_max` stay at 719 and
1279, causing jd_report_touches() to drop valid coordinates above 719x1279.

> +
> +	input =3D devm_input_allocate_device(dev);
> +	if (!input)
> +		return -ENOMEM;
> +
> +	input->name =3D "Jadard JD9365TX Touchscreen";
> +	input->id.bustype =3D BUS_I2C;
> +	input->dev.parent =3D dev;
> +
> +	__set_bit(EV_ABS, input->evbit);
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(BTN_TOUCH, input->keybit);
> +
> +	input_set_abs_params(input, ABS_MT_POSITION_X, 0, ts->abs_x_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ts->abs_y_max, 0, 0);
> +	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> +
> +	touchscreen_parse_properties(input, true, &ts->prop);
> +
> +	ret =3D input_mt_init_slots(input, ts->max_points, INPUT_MT_DIRECT);
> +	if (ret)
> +		return ret;
> +
> +	input_set_drvdata(input, ts);
> +	ts->input =3D input;
> +	i2c_set_clientdata(client, ts);
> +
> +	ret =3D input_setup_polling(input, jd_poll);
> +	if (ret)
> +		return ret;
> +
> +	input_set_poll_interval(input, ts->poll_interval_ms);
> +
> +	return input_register_device(input);
> +}
> +
> +static const struct of_device_id jadard_tp_of_match[] =3D {
> +	{ .compatible =3D "jadard,jd9365tx" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, jadard_tp_of_match);
> +
> +static const struct i2c_device_id jadard_tp_id[] =3D {
> +	{ "jd9365tx", 0 },
> +	{ }
> +};

[Severity: Low]
This isn't a bug, but several places in the driver depart from Input and I2C
subsystem conventions:

- devm_input_allocate_device() already sets `input->dev.parent =3D dev`, so
  the manual assignment in jadard_tp_probe() is redundant.
- The `__set_bit()` calls for `EV_ABS`, `EV_KEY`, and `BTN_TOUCH` in
  jadard_tp_probe() are redundant because input_set_abs_params() sets
  `EV_ABS` and `input_mt_init_slots(..., INPUT_MT_DIRECT)` sets `EV_KEY` and
  `BTN_TOUCH`.
- Calling `input_report_key(ts->input, BTN_TOUCH, any)` in
  jd_report_touches() is redundant because input_mt_sync_frame() already
  reports `BTN_TOUCH` via pointer emulation.
- `jadard_tp_id[]` should use a named initializer (`{ .name =3D "jd9365tx" =
}`)
  rather than `{ "jd9365tx", 0 }`.
- `vdd` and `iovcc` can be managed with devm_regulator_bulk_get_enable()
  instead of open-coding devm_regulator_get(), regulator_enable(), and
  jadard_tp_disable_regulators().
- In Input drivers, error-only variables are conventionally named `error`
  (or `err`), and functions with multiple failure points check the result of
  the final call (`error =3D input_register_device(input); if (error) return
  error; return 0;`).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D5
