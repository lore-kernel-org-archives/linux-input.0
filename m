Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35CB46EF8B;
	Thu, 23 Jul 2026 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806863; cv=none; b=tDbPn3SBOM50WEpkplIw23ZVjpA1hqQqtIXg4WuB1KxT76mLkhjz34k/oEm0srcD1h1WRQNdYjlGB2ogyM5mgvnTXhnjwTElhNSCGiaNGBjVEL8XtTRia4iXmk8XrmmhdHuU3WyJG0Y9yXW+Ln/NumxqTZdvIUkL/mJ0/1g1rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806863; c=relaxed/simple;
	bh=ycmcnDA9W9u3n1nLO3cbrVbrs+s56pP9IGoWgaetcPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LmiS56/4S6I0WGnN/ngv9FfJYc4xN20b2fqK28jvIHuMAS1kvss9btPrC12R5zGe3GcnmKGKGz80JFJg1Epmw6r5INfBmEau1ymL+j3xs82WJB9CQVgTmPXervmQafZj6OLPvpowsN2BqdrHacMnltBhv6nNXCetTGqI7zzRQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BG5wCGK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BG5wCGK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D641F000E9;
	Thu, 23 Jul 2026 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806861;
	bh=yJZ2Lmj9oIHWTkKAy8s6Pxlio/eIYtSaDw/CPceSmZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BG5wCGK5OY1GPzgEyrDEUP3FWyvSv5WbmQV9lkDdovOK6Wio+eND+sR0+mWvLdUlf
	 9+F3BSxav3lhN4V5oADqbCoVNf7Sh+zx1woLFewSBecsnlhHpzq8iQEi8Zhu2pLL1J
	 wyyMBSTjHJ7FcsVg5siQZ9q99KCG1FWyitdzBg9En8TnHkFjbt6fxRobt7twUcRjsf
	 GapkkP63gcio7PO8E/8DMssdmIAMR2fDojPKjLOlQycVrY6UDFQAzfkDgJK2nliNDg
	 ehTY9LCSQZQ4twJQucmSrCOlaYBxM1SfhqZtfus1TARDGMI6VFl473ZW3/dorc00z3
	 zEjLq9OMyhmUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] Input: edt-ft5x06 - ignore contacts with an
 out-of-range slot id
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandre Hamamdjian" <azkali.limited@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260723-b4-ft5426-v1-1-d4b4e32be042@gmail.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
 <20260723-b4-ft5426-v1-1-d4b4e32be042@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:40:59 +0000
Message-Id: <20260723114100.D6D641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbalanced `disable_irq()` calls when suspending and resuming in f=
actory mode lead to a permanently disabled touchscreen.
- [High] Stack-allocated buffers are passed to `regmap_bulk_read()` and `i2=
c_transfer()`, which can cause memory corruption or panics if the underlyin=
g I2C host controller driver uses DMA.
--

--- Patch [1]: [PATCH 1/4] Input: edt-ft5x06 - ignore contacts with an out-=
of-range slot id ---
commit 9dab47af56724a9e66ce05f01c0e4d726933073c
Author: Alexandre Hamamdjian <azkali.limited@gmail.com>

Input: edt-ft5x06 - ignore contacts with an out-of-range slot id

The per-contact slot id is taken from the top nibble of the third
report byte, so it can be any value from 0 to 15. The driver only
allocates max_support_points MT slots (2 to 10 depending on the
variant), so a report that carries an id at or above that count - be it
a genuinely higher-numbered contact or a corrupted byte - is outside the
range the input core was told about.

input_mt_slot() silently ignores an ABS_MT_SLOT beyond num_slots and
leaves the current slot unchanged, so the following
input_mt_report_slot_state()/touchscreen_report_pos() pair is applied to
whichever slot happened to be selected last, reporting the contact at the
wrong position. Skip such entries instead.

> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index d3b1177185a3b..d6c3d033b83df 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -331,6 +331,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *d=
ev_id)
>  			swap(x, y);
> =20
>  		id =3D (buf[2] >> 4) & 0x0f;
> +		if (id >=3D tsdata->max_support_points)
> +			continue;
> =20
>  		input_mt_slot(tsdata->input, id);
>  		if (input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER,

[Severity: High]
This isn't a bug introduced by this patch, but I noticed that stack-allocat=
ed
buffers are being passed to regmap_bulk_read() in this same function:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_isr() {
    ...
	u8 rdbuf[63];
    ...
	error =3D regmap_bulk_read(tsdata->regmap, tsdata->tdata_cmd, rdbuf,
				 tsdata->tdata_len);
    ...
}

Can this lead to memory corruption or kernel panics if the underlying I2C h=
ost
controller uses DMA without bounce buffering and CONFIG_VMAP_STACK is enabl=
ed?

I see similar stack allocations passed to i2c_transfer() elsewhere in the
driver:

drivers/input/touchscreen/edt-ft5x06.c:edt_M06_i2c_read() {
    ...
	u8 wbuf[4], rbuf[3];
    ...
	xfer[1].buf =3D reg_read ? rbuf : val_buf;
	ret =3D i2c_transfer(i2c->adapter, xfer, 2);
    ...
}

drivers/input/touchscreen/edt-ft5x06.c:edt_M06_i2c_write() {
    ...
	u8 wbuf[4];
    ...
	xfer.buf =3D wbuf;
	ret =3D i2c_transfer(i2c->adapter, &xfer, 1);
    ...
}

Should these buffers be heap-allocated to avoid violating the kernel DMA AP=
I?

[Severity: High]
This is a pre-existing issue, but there appears to be a regression with
unbalanced disable_irq() calls that could leave the touchscreen permanently
disabled.

When entering factory mode, disable_irq() increments the disable depth:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_factory_mode() {
    ...
	disable_irq(client->irq);
    ...
}

If the system then suspends, edt_ft5x06_ts_suspend() unconditionally disabl=
es
the IRQ again, incrementing the depth a second time:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_suspend() {
    ...
	disable_irq(tsdata->client->irq);
    ...
}

During resume, edt_ft5x06_ts_resume() calls enable_irq() once, but then
detects tsdata->factory_mode is true and calls edt_ft5x06_factory_mode()
again, which disables the IRQ a second time:

drivers/input/touchscreen/edt-ft5x06.c:edt_ft5x06_ts_resume() {
    ...
		enable_irq(tsdata->client->irq);

		if (tsdata->factory_mode)
			ret =3D edt_ft5x06_factory_mode(tsdata);
    ...
}

When the user later switches back to work mode, edt_ft5x06_work_mode() only
calls enable_irq() once. Does this leave the IRQ disable depth at 1, keeping
the touchscreen completely dead until the module is reloaded or the system =
is
rebooted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-b4-ft5426-=
v1-0-d4b4e32be042@gmail.com?part=3D1
