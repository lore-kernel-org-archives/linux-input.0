Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276C29994B;
	Thu, 23 Jul 2026 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784835160; cv=none; b=jUtfbyIU03ldxpcCRv2ck6mw/JvoErMIyg0zm41S4jMCS3hwpdJL2IWcAhftmNQVF6PqjKOmlWMsokFML3pmpsWY0xSr6XzUlSTR0qRCYDNgivB9LSCXQNeZhlY8ui4/x7FwqtrmAktbJp8Osomw4+ygaRw0fYwTmPUwRjzm83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784835160; c=relaxed/simple;
	bh=pw7hXCGOJgzJy9+oaO6bIye049xwPpWOj5eEECoqpZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p6tWyuV3AuqJEUK8RTRqjuSdnwWcFSO0jd7FJw5Pv8q+xFFq5qpbBH40237WXpx8ylR3tU1Ra1o71bj9ro5FZO34hEE/F6cElXJAvEg1JKZCskbMcEB3mbR0lcI0mtIUeawHns4ZlqYKtXNt/R0gkQsU5970mtFB4lA3vLpbYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkN6Cbuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkN6Cbuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351781F000E9;
	Thu, 23 Jul 2026 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784835155;
	bh=9OkuSCyeDz7nXg9dn35OcN9fAqYdEXbUkChLHjMBYrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GkN6Cbuf5v2sdfmdivxWznyX9T2agtGAn2qcePO/HybP4bLzBG0MxivuAnm+2xuYT
	 cX9KO3SZN+mL+LPXwHg35iAQfVQYeYG5+Vb7kYZulmN7EwuVpR2W5DxF98rIXg6jD/
	 JvY6dDZqetWiyL9lP2z1ZT1hCS51L7cf3olGKhuDnIjRlugu3i0qV4UX8ji9KdmIig
	 Sb6iIGKdn0RFbkO/vOkNzdE/G/Wohx/muhORh6Q63JanM4I1iLZkWa1hZ0q3gYcA08
	 6pBVVOMDMD7MwZcvcG4Fs1KtI1iN23aEuRHA0RGVJA4Q9RU10qV7VErOPr7TNu1Co6
	 BOZHvxKOMpJFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] Input: zinitix - do not ignore non-moving fingers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260724-zinitix-modes-v1-2-f6df7d86a878@disroot.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
 <20260724-zinitix-modes-v1-2-f6df7d86a878@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 19:32:34 +0000
Message-Id: <20260723193235.351781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Low] The validation check in `zinitix_report_finger()` is mathematically=
 impossible to trigger, turning the validation block into dead code and byp=
assing all event validation.

Pre-existing issues:
- [High] The input device is registered before all driver private data is f=
ully initialized, exposing incomplete state to userspace and violating subs=
ystem rules.
- [High] Regulators enabled in `zinitix_start()` are not disabled on initia=
lization failure paths, leading to a leaked reference count.
- [High] I2C transfers are performed using stack-allocated buffers, which v=
iolates kernel safety guidelines for DMA-mapped memory.
--

--- Patch [2]: [PATCH 2/5] Input: zinitix - do not ignore non-moving finger=
s ---
commit 014178afb268830e3c3cda63dc0ca293fa9a9335
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

Input: zinitix - do not ignore non-moving fingers

This commit addresses an issue with the ZT7548 touchscreen where non-moving
fingers are ignored. It updates the validation mask in zinitix_report_finge=
r()
to include the SUB_BIT_EXIST flag. This ensures fingers that haven't moved
since the last interrupt are properly recognized.

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index 3421b8ffb19b2..fdcb80f52c917 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -406,7 +406,7 @@ static void zinitix_report_finger(struct bt541_ts_dat=
a *bt541, int slot,
>  	u16 x, y;
> =20
>  	if (unlikely(!(p->sub_status &
> -		       (SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {
> +		       (SUB_BIT_EXIST | SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {
[Severity: Low]
Is this validation check mathematically impossible to trigger now?

The caller zinitix_ts_irq_handler() already verifies if SUB_BIT_EXIST is se=
t:

zinitix_ts_irq_handler() {
    ...
    if (p->sub_status & SUB_BIT_EXIST)
        zinitix_report_finger(bt541, i, p);
    ...
}

Since SUB_BIT_EXIST is strictly guaranteed to be present when this function
is called, the bitwise AND always evaluates to a non-zero value.

This means the negated condition will always evaluate to false, rendering
the entire event validation block and its debug log dead code.

>  		dev_dbg(&bt541->client->dev, "unknown finger event %#02x\n",
>  			p->sub_status);
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but does the input device
registration happen before all driver private data is fully initialized?

In zinitix_ts_probe():
    ...
    error =3D zinitix_init_input_dev(bt541);
    ...
    error =3D device_property_read_u32(&client->dev, "zinitix,mode",
                                     &bt541->zinitix_mode);
    ...

If a userspace process opens the input device immediately upon registration
in zinitix_init_input_dev(), the driver could configure the hardware using
an uninitialized bt541->zinitix_mode.

Could this place the touchscreen into an unsupported mode?

[Severity: High]
This is a pre-existing issue, but are the regulators enabled in
zinitix_start() correctly disabled on initialization failure paths?

zinitix_start() {
    ...
    error =3D regulator_bulk_enable(ARRAY_SIZE(bt541->supplies),
                                  bt541->supplies);
    ...
    error =3D zinitix_send_power_on_sequence(bt541);
    if (error) {
        dev_err(&bt541->client->dev,
                "Error while sending power-on sequence: %d\n", error);
        return error;
    }
    ...
}

If zinitix_send_power_on_sequence() or zinitix_init_touch() fail, the
function returns without disabling the regulators.

Since the input subsystem considers the device closed on open failure, it
will not call zinitix_input_close().

Could repeated open attempts leak the regulator references?

[Severity: High]
This is a pre-existing issue, but do the I2C transfers use stack-allocated
buffers?

zinitix_write_cmd() {
    __le16 reg_le =3D cpu_to_le16(reg);
    int ret;

    ret =3D i2c_master_send(client, (u8 *)&reg_le, sizeof(reg_le));
    ...
}

zinitix_ts_irq_handler() {
    struct touch_event touch_event;
    ...
    error =3D zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
                              &touch_event, sizeof(struct touch_event));
    ...
}

Passing stack-allocated buffers to I2C transfer functions can lead to
memory corruption or DMA API warnings if the underlying I2C controller
driver attempts to use DMA.

Are these buffers safe given that stack memory is not guaranteed to be
DMA-coherent?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-zinitix-mo=
des-v1-0-f6df7d86a878@disroot.org?part=3D2
