Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573482;
	b=pKa8rPQGwvyrOFQncVlajBMsTrvkpcDoaqlhohoB0pFX/BXrVAt+LwdgDFZF+B96feAe
	 hf/nrLVPknSyinfZa5Gf+wAMtBRXbVBFnuellhIOBESGyYo7xr/egapyQZDehR96ZEik/
	 DCMLbQ3lYXHKUERcz8uKn4v7ZLuWAPrmScfaw+vVltvirUEULHnUeu4c7PNnM8d0mauIT
	 uTozOKwFuID5to9glzXXnGMGasx/WUvGt9FgvvIMaUB47UB9xIBVtg2HwVEB1Fcn/QLLm
	 ZmFlKQjYxzGfbJiLf4oODN9A+Z7rUD5ETRjgd30sYxc5uuAdjXRhqu6HVWU5POTBNRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XDipyrD8oa+BKvtLgwZus4IEY5ayteCDOYTttC5h54U=;
	b=IXJP+M2czmlDMI+2tz46BNwMH0j41AT6mtSVVmo3wfQz7yo0TcBnkxmItP6jptJhJlIJ
	 pgjj0rlyI8lmxaav9zzFZpwo/E9SMJzXp0w0x+DSaNg9erriNgk2XLg2y7z3SJU97wLHs
	 gz6WM70FDc4f5yxq13XtVeIcjcqixAhphvC4tQDy7QJLLJZcD2Wzk25jVF5mT8TaG6cHf
	 UINvGqxv3t+M1fgwDhMRW0iUXII+dAUzxbheyFqItX1fPhlUlBkBLy6n2kqkfkghzBwpH
	 g3Fz7byQY3Ow/huOhgEqozD1Peazw0EqJYg9Ex/b0TEpEjY0tC/rymAfcThgy6MSRbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKPeYqWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93B606A326;
	Wed, 25 Nov 2026 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKPeYqWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6161F000D8;
	Wed, 25 Nov 2026 02:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573481;
	bh=XDipyrD8oa+BKvtLgwZus4IEY5ayteCDOYTttC5h54U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKPeYqWZN/vW7MsM9SwvNpX5qe6N/TfWKYi4RV4P+BGG+JEoF7g/uDPniaH/AgI6s
	 vB86rS7V81mX9HTva2GfNmAE4s/pbWcGcRuUFbZqvsWam0ErYaPYmz28yyjs5Zw49g
	 pjpXmY4Cek59WRFoknUDrjWrgTIzCyyOZokbZGUJQuKsffVbM97AVJFEvFIbcLGlm5
	 vDk/dXwaTHA6RqPV7TCTwc3bh79ozbIZmnad2mmZbBMT8f+KdN/Q5FHriR/AmNRfJO
	 rdv16+0Uj76198SmqlkwwyHDRUSJ5N31mPYb1YsBTVGhiuU93MIz0jE+TPPpDfjPb0
	 ToDUT/FETcrQg==
Message-ID: <sashiko-outbox-232407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] Input: add Jadard JD9365TX in-cell touchscreen
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_03FEA6A02E8E137CCC5AC97E6F118A3CC10A@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_03FEA6A02E8E137CCC5AC97E6F118A3CC10A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:24:40 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] Input: jadard_jd9365tx: broken slot check in
  jd_report_touches()
- [High] Input: jadard_jd9365tx: deferred init in jd_poll() and no reset
  recovery
- [Medium] Input: jadard_jd9365tx: uninitialized stack read in
  jd_report_touches()
- [Medium] Input: jadard_jd9365tx: missing reset-gpios handling in
  jadard_tp_probe()
- [Low] Input: jadard_jd9365tx: signed shift overflow in
  jd_resolve_coord_addr()
- [Low] Input: jadard_jd9365tx: duplicate OF-only size parsing in
  jadard_tp_probe()
- [Low] Input: jadard_jd9365tx: redundant capabilities, BTN_TOUCH, and
  parent setup
- [Low] Input: jadard_jd9365tx: positional initializer in jadard_tp_id
  table
- [Low] Input: jadard_jd9365tx: empty commit message body for new driver
--

commit 7d4899901ebf2b5cd58796c8a16ba3f15ed92ab7
Author: Hefei <3066883572@qq.com>

> Input: add Jadard JD9365TX in-cell touchscreen driver
>
> Signed-off-by: Hefei <3066883572@qq.com>

[Severity: Low]
This commit adds a new touchscreen driver with an empty commit message
body.  Please add a description of the Jadard JD9365TX hardware and explain
why the driver uses I2C polling and defers hardware initialization.

> diff --git a/drivers/input/touchscreen/jadard_jd9365tx.c b/drivers/input/=
touchscreen/jadard_jd9365tx.c
> new file mode 100644
> index 0000000000000..2030157c3a5b8
> --- /dev/null
> +++ b/drivers/input/touchscreen/jadard_jd9365tx.c
> @@ -0,0 +1,373 @@

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
Can shifting buf[JD_ESRAM_COORD_IDX * 8 + 3] and
buf[JD_ESRAM_COORD_IDX * 8 + 7] left by 24 bits overflow a 32-bit signed
int?  In C, u8 values are promoted to signed int before << 24, which
triggers undefined behavior under UBSAN when bit 7 of the high byte is set.
Using get_unaligned_le32() avoids this.

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
Can jd_report_touches() read uninitialized stack memory from buf[] when
jd_resolve_coord_addr() accepts a section length smaller than 53 bytes?

jd_resolve_coord_addr() accepts any len from 1 to JD_TOUCH_DATA_SIZE (78),
and jd_poll() declares u8 buf[JD_TOUCH_DATA_SIZE] uninitialized on the
stack before reading ts->touch_data_size bytes into it.  However,
jd_report_touches() unconditionally reads JD_TOUCH_COORD_INFO_ADDR +
ts->max_points * JD_FINGER_DATA_SIZE (53) bytes from buf[], reporting
uninitialized stack bytes as touch coordinates whenever len < 53.  The
bounds check also does not verify that addr + len stays within
JD_ERAM_BASE + 0x1000.

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
Does gating down on i < finger_num drop active contacts whenever a
lower-numbered slot lifts before a higher-numbered slot?

The packet uses fixed slots where inactive slots carry 0xFFFF/0xFFFF and
finger_num is the total active contact count.  If fingers are down in slots
0 and 1 (finger_num =3D=3D 2) and finger 0 lifts while finger 1 stays on the
screen, finger_num becomes 1 while slot 1 retains its coordinates; on the
next poll, slot 1 (i =3D=3D 1) fails i < finger_num and is reported as
released.  In addition, clamping finger_num > ts->max_points to
ts->max_points instead of discarding the packet treats an invalid 0xFF
header byte as 10 active fingers.

> +
> +		input_mt_slot(ts->input, i);
> +		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, down);
> +
> +		if (down) {
> +			touchscreen_report_pos(ts->input, &ts->prop, x, y, true);
> +			input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, w);
> +			any =3D true;
> +		}
> +	}
> +
> +	input_mt_sync_frame(ts->input);
> +	input_report_key(ts->input, BTN_TOUCH, any);
> +	input_sync(ts->input);
> +}
> +
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
> +
> +	ret =3D jd_read_reg(ts->client, ts->coord_addr, buf, ts->touch_data_siz=
e);
> +	if (!ret)
> +		jd_report_touches(ts, buf);
> +}

[Severity: High]
Does deferring jd_hw_init() to jd_poll() break probe detection, block the
poller workqueue, and leave the touchscreen unable to recover after panel
or system resets?

Because jadard_tp_probe() registers the input device without checking
hardware presence, an absent device or chip ID mismatch (-ENODEV) still
binds, keeps vdd and iovcc enabled, and retries jd_hw_init() every 16 ms
while the device is open.  Inside jd_hw_init(), jd_section_ready() loops up
to 50 times calling msleep(2) and jd_read_reg(), blocking
input_open_device() (under input->mutex) or system_freezable_wq for
hundreds of milliseconds.  Once ts->ready is set to true, it is never
cleared on read failures or across suspend/resume, so any reset or power
cycle of the shared JD9365TX controller drops the 0xF2 I2C backdoor mode
and causes subsequent touch reads to fail permanently.

> +
> +static void jadard_tp_disable_regulators(void *data)
> +{
> +	struct jadard_tp *ts =3D data;
> +
> +	regulator_disable(ts->iovcc);
> +	regulator_disable(ts->vdd);
> +}
> +
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
Does jadard_tp_probe() leave the controller held in reset on boards that
wire reset-gpios to the touchscreen node?  The jadard,jd9365tx DT binding
defines reset-gpios, but jadard_tp_probe() never requests or deasserts it
after enabling vdd and iovcc.

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
Why parse touchscreen-size-x and touchscreen-size-y manually with
of_property_read_u32() into ts->abs_x_max and ts->abs_y_max when
touchscreen_parse_properties() is called right below?
touchscreen_parse_properties() already parses these via the generic device
property API and stores the pre-swap axis maxima in ts->prop.max_x and
ts->prop.max_y; if properties come from non-OF firmware nodes or
touchscreen-min-x/y is used, ts->abs_x_max and ts->abs_y_max stay at
719x1279 and jd_report_touches() drops coordinates above those defaults.

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

[Severity: Low]
This isn't a bug, but several parts of jadard_tp_probe() and
jd_report_touches() duplicate work already done by the input and regulator
helpers:
- devm_input_allocate_device(dev) already sets input->dev.parent =3D dev.
- input_set_abs_params() and input_mt_init_slots(..., INPUT_MT_DIRECT)
  already set EV_ABS, EV_KEY, and BTN_TOUCH, so the raw __set_bit() calls
  are redundant.
- input_mt_sync_frame() with INPUT_MT_DIRECT already reports BTN_TOUCH via
  pointer emulation, so input_report_key(ts->input, BTN_TOUCH, any) in
  jd_report_touches() is redundant.
- vdd and iovcc can be managed with devm_regulator_bulk_get_enable()
  instead of manual regulator_enable() calls and
  jadard_tp_disable_regulators().
- Per input subsystem style, please name the error status variable error
  and check the return value of input_register_device() before explicitly
  returning 0.

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
This isn't a bug, but new struct i2c_device_id entries should use named
initializers ({ .name =3D "jd9365tx" }).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A3BF23A8B6E=
3691F0D567ADF8B84194F4408@qq.com?part=3D5
