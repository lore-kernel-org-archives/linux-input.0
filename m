Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56983355057;
	Thu, 30 Jul 2026 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441574; cv=none; b=WIEkUdX76Dp0qCgMJJsI8tfA0mxpvClVHvr4mWZ962Wad1HUpC4Qn1Bl/K4GVbgs9r2V0iBBUKwmSwPc/fRCLV+pychK/d6ATd2fj8Zqv8GD/r/LhBZL0KqMq0X+6aeI51+/rZFV5EjqXJWH4koctcN87i2PNU3qtAZs9OzfVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441574; c=relaxed/simple;
	bh=tpzejd0SPnpC8FgCH3J5WeGfBvoRb/qDQolqraS2sko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oPULND+pKyQJejjwXO3U96pMjqLsZmFyP7VOkrzXF7uveQG3QRmiu5sdfOcL71onVGh2OKQUkuvOqUWDcfoq0MxQot9yvvD6Waa3AWAGWc4vWDCm1+Wf8V28cOYYKhfDBkeu4QInnomyx8hklN6dhQYHrNbirqckv2g0owOhV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfdm0utS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfdm0utS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5861F000E9;
	Thu, 30 Jul 2026 19:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785441569;
	bh=ma5Sy60TxgYX/x/NMieoAc85I5ieEw80K2T4n7zPQmA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nfdm0utSUFGsKXR4y9XRW37fr4WQgRTRhAU3O/KOmkG3g/fOlBB+GpSDnM1uEhawG
	 mufNj7yMDT4XCnrNHEC6C2fiU6lcl9mvYqaaCFz3oNCXYTmx2VAOJXNR3wsWKaUHO8
	 f1qWrKuH78djHH1XOJIijxH8RdXPoScOt6dJMuGf+gLu4j0w+HFIc9LCu97D+frakO
	 QDtkZBwN9BhF6f9aY/h6mzd0ywQaR4+OQp45x4wX98SW5TyFWJv+VNiPRATRxAVIxS
	 9Ps2nFSAPGJbtSz3tBvZ9P8H04UYm0XAE0iXSkZy/cTYBVhRX86oAOKGqMH6bEynS3
	 +j4/fhGiRuMzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] Input: zinitix - check all available fingers for
 every touch event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260731-zinitix-modes-v2-1-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
 <20260731-zinitix-modes-v2-1-ffe2ec9a9031@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 19:59:28 +0000
Message-Id: <20260730195928.9F5861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditionally iterating over all slots reverts a previous bugfix=
 and reintroduces phantom touches on BT404 controllers.

Pre-existing issues:
- [High] I2C message buffers are allocated on the stack, violating DMA API =
rules.
- [High] Input device is registered before all driver private data is fully=
 initialized, allowing a Use-After-Free if probe fails.
--

--- Patch [1]: [PATCH v2 1/5] Input: zinitix - check all available fingers =
for every touch event ---
commit 035227fe3b93a4e9baec0dee6f309a653f790ded
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

Input: zinitix - check all available fingers for every touch event

This commit modifies the Zinitix touchscreen driver to unconditionally
iterate over all possible fingers during a touch event, removing the
use of the finger_mask field.

Link: https://android.googlesource.com/kernel/bcm/+/23d376ef33aa4c500a5ea24=
a290f029d5f8e2de3/drivers/input/touchscreen/zinitix_touch.c#1942 [1]

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index 0c36765bd79f8..3421b8ffb19b2 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -445,7 +445,6 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  	struct bt541_ts_data *bt541 =3D bt541_handler;
>  	struct i2c_client *client =3D bt541->client;
>  	struct touch_event touch_event;

[Severity: High]
This is a pre-existing issue, but does passing this stack-allocated variable
to the I2C read functions violate DMA API rules?

During a touch event, zinitix_ts_irq_handler() passes the stack-allocated
touch_event down to zinitix_read_data(), which eventually reaches
i2c_master_recv(). If the I2C master driver uses DMA, mapping this stack
memory could lead to memory corruption or a kernel panic on architectures
with VMAP_STACK and DMA API debugging enabled.

[ ... ]
> @@ -470,8 +469,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  		zinitix_report_keys(bt541, le16_to_cpu(icon_events));
>  	}
> =20
> -	finger_mask =3D touch_event.finger_mask;
> -	for_each_set_bit(i, &finger_mask, MAX_SUPPORTED_FINGER_NUM) {
> +	for (i =3D 0; i < MAX_SUPPORTED_FINGER_NUM; i++) {
>  		const struct point_coord *p =3D &touch_event.point_coord[i];
> =20
>  		/* Only process contacts that are actually reported */

[Severity: High]
Could unconditionally iterating over all slots revert a previous bugfix for
BT404 controllers?

When a touch occurs on a BT404 controller, the firmware incorrectly leaves
SUB_BIT_EXIST set for shadow fingers. By dropping the finger_mask filter
here, it looks like zinitix_report_finger() will be called for those
shadow fingers, potentially causing multiple phantom inputs for every
physical touch.


[Severity: High]
This is a pre-existing issue, but looking at zinitix_ts_probe(), is there a
use-after-free window if probe fails?

The zinitix,mode property is parsed and validated after the input device is
already registered by zinitix_init_input_dev():

zinitix_ts_probe() {
        ...
        error =3D zinitix_init_input_dev(bt541);
        if (error) { ... }

        error =3D device_property_read_u32(&client->dev, "zinitix,mode",
                                         &bt541->zinitix_mode);
        if (error < 0) { ... }
        ...
}

If parsing fails, probe returns an error and devres frees the bt541
structure. If userspace opens the device during this window, the input_dev
survives the probe failure. When userspace subsequently closes it, wouldn't
zinitix_input_close() dereference the freed bt541 pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v2-0-ffe2ec9a9031@disroot.org?part=3D1
