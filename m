Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40D34F259
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 21:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510986; cv=none; b=ri0ZTkDiHYrv3T1UTH0oyZK93Z5ZBgCnbDb1v2stSbSXsT0yayeew9y8r7Ve3AhCw6MOTh2cewRcUVww61ppdfRnWExFmFFEbyX4nQ7XFbTjVLXGZozIUY/TsOg/++jLnDKIcgPUF1Bvend8v0nRHTirixCny8Y379y8fB3K6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510986; c=relaxed/simple;
	bh=leYVR+V11rByOqXIPq6QHGpxCcohyIh0zYGtKZBTUUY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZWx+JUveR70YVXged7DZ0vuA9HhWTnpFspjIwAaOCXyaSyC3hI5BUxhH2aO9AVTm8lQj6NTkMuZrNkYXIIN17e60BO+ozMyaPJLaHpMpcpTr/LmQs5CtK412/hrssDj8EjzGYAz8TeQaZb5k+b9H3tmK2r8NDnfYSG0xH4ooXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKU2VWKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKU2VWKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B0A1F000E9;
	Fri, 26 Jun 2026 21:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782510985;
	bh=xul7AZKPdv9mcoxDMs2UzxetaKBydt/kcG5RWIgEnj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QKU2VWKf+hZlcuawgDWrqQGkJEDfh6UMF+50TUluee51F7u+ZeNA7/8sF0HN7VRuf
	 dedv3GsZqFg7Zs6dMaamNwGXJKooXDMc8SJdxbZMZr0YmtROy/UhVzJieKm2e3cgCH
	 hIi5/IdPnyyYhrBAJaCnYuR5Cru4ggEB1ojsb/H+K0FALzewoEd+3wsFHNUmCCYQI1
	 9d4wmQcKs/RCXJin5epBW/Jl11sGQqNJN4VsZ3SzPpc9QyyuWgER5LYFBNxhTWB9ew
	 9Mzzcit3/UpnDUv40oDCcnPTeIL71PIfzJSfYl3lHBterS8DLdZ73GvqRYh7lKPriK
	 kEh3mJHTj7Rtg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] Input: ilitek_ts: add stylus input support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kristian Mide" <kristian@mide.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260626214248.5563-2-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
 <20260626214248.5563-2-kristian@mide.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 21:56:24 +0000
Message-Id: <20260626215624.B7B0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Lazy initialization of the pen input device from within the IRQ ha=
ndler causes a devres LIFO ordering inversion, leading to a memory leak and=
 Use-After-Free during device unbind.
- [High] The pen input device axis limits are not synced with Device Tree p=
roperties, leading to mismatched axis boundaries and massive coordinate und=
erflow values.
- [Low] Direct bit manipulation is used instead of the preferred `input_set=
_capability()` helper.

Pre-existing issues:
- [High] I2C transfers are performed using buffers allocated on the stack, =
which is unsafe for DMA.
--

commit 0912736a7a818d72cc6868aba6ad50c6f06afd78
Author: Kristian Mide <kristian@mide.dk>

Input: ilitek_ts: add stylus input support

Add a separate stylus input device for report ID 0x0c packets,
with pressure, hover, and side-button support. The pen device is
created lazily on first pen report so touchscreen-only hardware does
not expose stylus capabilities up front.

> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/to=
uchscreen/ilitek_ts_i2c.c
> index 3de0fbf8da386..f0721af02adf2 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c

[ ... ]

> @@ -164,6 +237,9 @@ static int ilitek_process_and_report_v6(struct ilitek=
_ts_data *ts)
>  		return error;
>  	}
> =20
> +	if (buf[0] =3D=3D ILITEK_PEN_I2C_REPORT_ID)
> +		return ilitek_process_pen_report(ts, buf);

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but since buf is passed here, is it safe to allocate buf as a
512-byte array on the stack in ilitek_process_and_report_v6() and pass it to
I2C transfer functions?

When CONFIG_VMAP_STACK is enabled, stack addresses cannot be safely mapped
for DMA. If the underlying I2C host controller uses DMA, could attempting
to map this stack buffer lead to memory corruption or kernel panics?

> +
>  	if (buf[0] !=3D ILITEK_TP_I2C_REPORT_ID) {
>  		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
>  		return -EINVAL;

[ ... ]

> @@ -459,6 +535,60 @@ static int ilitek_read_tp_info(struct ilitek_ts_data=
 *ts, bool boot)
>  	return 0;
>  }
> =20
> +static int ilitek_pen_input_dev_init(struct device *dev, struct ilitek_t=
s_data *ts)
> +{
> +	struct input_dev *pen_input;
> +	int error;
> +
> +	if (ts->pen_input_dev)
> +		return 0;
> +
> +	/* No explicit pen capability probe is known; create on first pen repor=
t. */
> +
> +	pen_input =3D input_allocate_device();
> +	if (!pen_input)
> +		return -ENOMEM;
> +
> +	ts->pen_input_dev =3D pen_input;
> +	pen_input->dev.parent =3D dev;
> +	pen_input->name =3D "ilitek_ts_pen";
> +	pen_input->id.bustype =3D BUS_I2C;
> +
> +	__set_bit(INPUT_PROP_DIRECT, pen_input->propbit);
> +	__set_bit(EV_KEY, pen_input->evbit);
> +	__set_bit(EV_ABS, pen_input->evbit);
> +	__set_bit(BTN_TOUCH, pen_input->keybit);
> +	__set_bit(BTN_TOOL_PEN, pen_input->keybit);
> +	__set_bit(BTN_STYLUS, pen_input->keybit);
> +	__set_bit(BTN_STYLUS2, pen_input->keybit);

[Severity: Low]
This isn't a bug, but could we use the input_set_capability() helper here
instead of direct bit manipulation?

> +
> +	input_set_abs_params(pen_input, ABS_X,
> +			     ts->screen_min_x, ts->screen_max_x, 0, 0);
> +	input_set_abs_params(pen_input, ABS_Y,
> +			     ts->screen_min_y, ts->screen_max_y, 0, 0);

[Severity: High]
Should the touchscreen properties (DT properties) be applied to these
absolute parameters?

The touchscreen_report_pos() function called during event processing will
apply inversion and swapping based on Device Tree properties to the
coordinates.

If the limits advertised here are strictly from the raw hardware bounds and
are unaware of those DT properties, could this cause the device to report
out-of-bounds coordinates or result in unsigned underflows when an axis is
inverted?

> +	input_set_abs_params(pen_input, ABS_PRESSURE, 0,
> +			     ILITEK_PEN_PRESSURE_MAX, 0, 0);
> +	input_set_abs_params(pen_input, ABS_DISTANCE, 0,
> +			     ILITEK_PEN_DISTANCE_MAX, 0, 0);
> +	input_abs_set_res(pen_input, ABS_X, ILITEK_PEN_RESOLUTION);
> +	input_abs_set_res(pen_input, ABS_Y, ILITEK_PEN_RESOLUTION);
> +
> +	error =3D input_register_device(pen_input);
> +	if (error)
> +		goto err_free_pen_input;
> +
> +	error =3D devm_add_action_or_reset(dev, ilitek_unregister_pen_input, ts=
);

[Severity: High]
Since this function is called lazily from the threaded IRQ handler after
probe has completed, does adding a devm action here break the LIFO teardown
ordering?

During device unbind, devres will release resources in LIFO order. This
action would run first and set ts->pen_input_dev =3D NULL, but the IRQ
handler would still be active.

If a hardware interrupt fires during unbind after this has been
unregistered, would the IRQ handler observe the NULL pointer, allocate a
new pen device, and add a new devres action that devres_release_all()
will never process, resulting in a memory leak and a potential
use-after-free?

> +	if (error)
> +		return error;
> +
> +	return 0;
> +
> +err_free_pen_input:
> +	ts->pen_input_dev =3D NULL;
> +	input_free_device(pen_input);
> +	return error;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626214248.5563=
-1-kristian@mide.dk?part=3D1
