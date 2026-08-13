Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8A3D0BED;
	Thu, 13 Aug 2026 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659307; cv=none; b=ZGfLFXyU+rTNzvCd150f2lC05ESzRG7qPuiLLgzAOiEufd01dTf7k2PRFnCk/wwCc4Vb7IrEtkfNJekVu6d0pPkEplRwT/t+wPpjYB106iXIBz5xtw7blzZay6q8JjqSoMWvuY3A+z6Mahox+/Ys3qkt2gYTtdA56j5+clI9RZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659307; c=relaxed/simple;
	bh=FEX26yO6PwOX0SemX369uv/8W7TARAfwOkAALDjzK6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ICMit5DzA1gWmNuWtS3V+4siQANkW0EBCBkdp4XIirwiMy5CuswyO2JlPG75JceRNspWLRu6O/mrON4pyNgiNKFaPgzVL8TTnq7oU3+/yGwAHzh+fNVaw0p2WHkbM9m2CPB31o4drDv3UB8+edWgfWk2AVmBAq4UfOsBCkLXqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lckZuRjs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lckZuRjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1AA1F000E9;
	Thu, 13 Aug 2026 22:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659305;
	bh=TK3vje5CLu5MA1uJT0vmqMO9IkciVSJ4rlFIUhlNWWI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lckZuRjsQY7QBmN4c0DvnlM+bVymfoj4OBmvav96Er7j64yNcjwBu1cce1bqZpgTP
	 rcJIbwZ0zpsBGWjTlAhhiYG7nb1c5pBVgADoYpVloO1qlmO0uqw5x8Cibl9cEj09zW
	 ZVlq5iigHDPOEa2mtDNKyfFHHabgikEVzk5oR/UUHto5XhSBFEyrOCRIRE2bg4aJne
	 Yvi4qP4jHtKdOCAH4c9Ucbe7BWTcN4OFj/57lASqqcy70C0OLUxq38K2ooRKrA5jle
	 aNRrPJTAh2gZktk/cpvK3J4yHBk35Vbo3B47c/hnF4A/OeAe28ztAbxB3YOm54ezF7
	 AnaKfPg6iPI7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH WIP v2 10/11] Input: stmfts - support FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg via B4 Relay" <devnull+david.ixit.cz@kernel.org>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260315-stmfts5-v2-10-70bc83ee9591@ixit.cz>
References: <20260315-stmfts5-v2-10-70bc83ee9591@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:15:04 +0000
Message-Id: <20260813221504.ED1AA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [High] Incorrect bitwise assembly of the Y coordinate for FTS5 touch even=
ts causes severely corrupted Y axis reporting.
- [High] Unconditional per-slot `BTN_TOUCH` reporting incorrectly releases =
global touch state during multi-touch hover.
- [High] Negative coordinate corruption due to uninitialized max bounds.
- [High] Kernel panic due to NULL pointer dereference when the device is in=
stantiated without an OF node.
- [High] I2C command sent to the FTS5 device while it is held in reset.
- [Medium] The FTS5 touch area (major/minor axes) parsing logic extracts bi=
ts from the fixed event ID, corrupting the reported values.
- [Medium] The FTS5 device is left fully powered on and active at the end o=
f probe, causing a power state mismatch.
- [Medium] State variable `sdata->running` is permanently left as `true` if=
 `stmfts5_set_scan_mode` fails.

Pre-existing issues:
- [High] The touchscreen device remains unconfigured and unresponsive after=
 a system suspend/resume cycle if it was left open.
--

--- Patch [10]: [PATCH WIP v2 10/11] Input: stmfts - support FTS5 ---
commit ad13c14f5e550fb31aa12d11e439dd6f055dfeae
Author: Petr Hodina <petr.hodina@protonmail.com>
Subject: Input: stmfts - support FTS5

Introduce basic FTS5 support including SLPI and AP mode handling.
Currently handles full power AP mode for devices like Pixel 3 (blueline).

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c
> @@ -204,6 +245,157 @@ static void stmfts_report_contact_release(struct st=
mfts_data *sdata,
> [ ... ]
> +static void stmfts5_report_contact_event(struct stmfts_data *sdata,
> +					 const u8 event[])
> +{
> [ ... ]
> +	/* Parse coordinates with better precision */
> +	x =3D (((int)event[3] & STMFTS_MASK_X_MSB) << 8) | event[2];
> +	y =3D ((int)event[4] << 4) | ((event[3] & STMFTS_MASK_Y_LSB) >> 4);

[Severity: High]
Is this Y coordinate assembly correct? The block comment states event[3]
contains the Y MSB in the high 4 bits, and event[4] contains the Y LSB.
By left-shifting event[4] and right-shifting event[3], could this
completely scramble the Y axis mapping?

> +
> +	/* Parse pressure - ensure non-zero for active touch */
> +	area =3D event[5];
> [ ... ]
> +	/* Parse touch area with improved bit extraction */
> +	maj =3D (((event[0] & 0x0C) << 2) | ((event[6] & 0xF0) >> 4));
> +	min =3D (((event[7] & 0xC0) >> 2) | (event[6] & 0x0F));

[Severity: Medium]
Does this parsing logic for the touch area extract from the correct bits?
Since event[0] is the event ID byte (e.g., 0x13 or 0x23), bits 2 and 3
are always 0. Furthermore, extracting the major axis from the high 4 bits
of event[6] contradicts the documented format where event[6] contains the
major axis in the low 4 bits.

> [ ... ]
> +	/* Boundary check - some devices report max value, adjust */
> +	if (x >=3D sdata->prop.max_x)
> +		x =3D sdata->prop.max_x - 1;
> +	if (y >=3D sdata->prop.max_y)
> +		y =3D sdata->prop.max_y - 1;

[Severity: High]
Could this force valid touch coordinates to -1? If the platform does not
specify touchscreen boundaries in the Device Tree,
touchscreen_parse_properties() leaves max_x and max_y as 0. Without a call
to input_set_abs_params() to establish default maximums, this check would
evaluate as x >=3D 0 and set the coordinate to -1.

> +
> +	input_mt_slot(sdata->input, touch_id);
> +	input_report_key(sdata->input, BTN_TOUCH, touch_condition);

[Severity: High]
Can this unconditional per-slot BTN_TOUCH reporting cause active touches
to be abruptly dropped? BTN_TOUCH is a global property. If one finger is
actively touching the screen (touch_condition =3D true) and a second finger
triggers a hover event (touch_condition =3D false) in the same packet,
processing the hover slot will emit BTN_TOUCH, 0, releasing the global
touch state.

> +	input_mt_report_slot_state(sdata->input, tool, true);
> @@ -372,6 +620,28 @@ static int stmfts_input_open(struct input_dev *dev)
> [ ... ]
> +static int stmfts5_input_open(struct input_dev *dev)
> +{
> [ ... ]
> +	mutex_lock(&sdata->mutex);
> +	sdata->running =3D true;
> +	mutex_unlock(&sdata->mutex);
> +
> +	err =3D stmfts5_set_scan_mode(sdata, 0xff);
> +	if (err) {
> +		pm_runtime_put_sync(&sdata->client->dev);
> +		return err;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Should the error path reset the sdata->running flag back to false? If
stmfts5_set_scan_mode() fails, the function returns an error without
clearing this flag, permanently desynchronizing the driver's internal
state tracking.

> @@ -615,6 +902,41 @@ static int stmfts_power_on(struct stmfts_data *sdata)
> [ ... ]
> +static int stmfts5_power_on(struct stmfts_data *sdata)
> +{
> [ ... ]
> +	enable_irq(sdata->client->irq);
> +
> +	return 0;

[Severity: Medium]
Is the FTS5 device left fully active while the PM core tracks it as
suspended? At the end of the probe function, pm_runtime_enable()
initializes the PM runtime state to RPM_SUSPENDED. Unlike
stmfts_power_on() which explicitly puts the hardware to sleep before
returning, this function enables interrupts and returns without sending
a sleep command, causing a power state mismatch.

> [ ... ]
>  static void stmfts_power_off(void *data)
>  {
> [ ... ]
>  	if (sdata->reset_gpio)
>  		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
> =20
> +	if (sdata->is_fts5) {
> +		i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);

[Severity: High]
Will this I2C command succeed while the device is held in hardware reset?
The reset line is asserted immediately prior to this block. Because the
chip is held in reset, its I2C interface is disabled and the transfer is
likely to time out or return a NACK.

> +		msleep(20);
> +	}
> @@ -657,6 +984,7 @@ static int stmfts_probe(struct i2c_client *client)
> [ ... ]
> +	sdata->ops =3D of_device_get_match_data(dev);
> [ ... ]
> -	sdata->input->open =3D stmfts_input_open;
> -	sdata->input->close =3D stmfts_input_close;
> +	sdata->input->open =3D sdata->ops->input_open;

[Severity: High]
Can this cause a NULL pointer dereference during device probe? If the
driver is bound to a device without a Device Tree node (e.g., via I2C
sysfs legacy matching), of_device_get_match_data() returns NULL. The
code then immediately dereferences this pointer to assign the callbacks.

> @@ -810,7 +1231,7 @@ static int stmfts_resume(struct device *dev)
>  {
>  	struct stmfts_data *sdata =3D dev_get_drvdata(dev);
> =20
> -	return stmfts_power_on(sdata);
> +	return sdata->ops->power_on(sdata);

[Severity: High]
This is a pre-existing issue, but does this leave the touchscreen device
unconfigured and unresponsive after a system suspend/resume cycle if it
was left open?

If the device is open when the system enters suspend, the PM core
considers its runtime state to be RPM_ACTIVE across the cycle. On resume,
power_on() is called. For FTS4, this puts the device into STMFTS_SLEEP_IN,
and for FTS5, it does not re-enable interrupts or set the scan mode.
Because the PM core tracks it as already RPM_ACTIVE,
stmfts_runtime_resume() is never called to restore functionality, leaving
the hardware physically powered but logically unconfigured.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260315-stmfts5-v2=
-0-70bc83ee9591@ixit.cz?part=3D10
