Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EA43A4F4B;
	Thu, 30 Jul 2026 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441529; cv=none; b=tUN1ozbSF9ZIpkRDSK2/IcqR2FzcAVPBrkCLbpWUc12cJfo1MiGLFW0STPz5l58wRlhcv2DuW7IcE6nlfFFL7Km96Uq5xDyp80jtxUNOINJFeDTIcg4orgRWCOxIMzkB729kHzzX2R7P8rlkaSmOdrRdIhGA+Sn/TYJtpKfFg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441529; c=relaxed/simple;
	bh=bwvJi+/kxyzyKOK+FPYXYX/3g+fO9detu8iEE5YbZVM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AL12Z8MboWm9Aj/DLPMCSo+CHrufGYGCy1SE9K3EO6m6avOufKXldmmGd035qz8m6ozWZKQqPzX8EYH5fG/cn2aMx3e1Z0WSJT/n3wxoG/Dm1M15hhiWUEyEucen1HdC1Hm/PwmGBFHkreXBONFQfumpLKuKbU7YUKlHu0Kq/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI9dwUYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI9dwUYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4AA1F00A3D;
	Thu, 30 Jul 2026 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785441527;
	bh=4peZCgdfFKryA1yePthkbERPFAx+fTU7HT6qAHWd6sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lI9dwUYPXZ9StzXSeddpo6nFGzb4ULNwH9fJETCibezcKHxaeG7JXEOrlbZwETG/m
	 6OTEUJzFgJ/gQz4g3nQh6LQPSbAl0F8KNj1a+2EwTPLbH2NkXm3Flujovabtz/9nAo
	 BS2jXdxyATpR08cxqq9r2XOQwNWGQi8hkSMaly9V3Pv81LQx2DGEzunAb0/Sz7pQ9v
	 ysidZQV1cG6k+WquAz4E+Eck+Y/taQa0y40NeF63Dgr81Fy5C7MXNiOGDvNJ7yKj4L
	 eoU0K/c/1VjXQFyxQEz5XzcIdVhSjcEaVJ31gWqfD0vXb/KYctYnuQZKyapIED4wUT
	 TBJ2DEm91dJvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] Input: zinitix - do not ignore non-moving
 fingers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260731-zinitix-modes-v2-2-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
 <20260731-zinitix-modes-v2-2-ffe2ec9a9031@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 19:58:46 +0000
Message-Id: <20260730195847.2B4AA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Device properties are read and validated after the input device ha=
s been registered, creating a race condition with userspace.
- [High] The driver allocates I2C transfer buffers on the stack, which viol=
ates DMA mapping rules and can cause memory corruption or panics.
--

--- Patch [2]: [PATCH v2 2/5] Input: zinitix - do not ignore non-moving fin=
gers ---
commit 79b05b71b81ce17697cba617a5a5c777d1fe07a7
Author: Kaustabh Chakraborty <kauschluss@disroot.org>
Subject: Input: zinitix - do not ignore non-moving fingers

This commit fixes an issue where multitouch does not work reliably on the
ZT7548 touchscreen by no longer ignoring fingers that lack movement flags.
It ensures contacts with the SUB_BIT_EXIST flag are correctly processed in
zinitix_report_finger().

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index 3421b8ffb19b2..a0a89d25e25bb 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
[ ... ]
> @@ -473,7 +473,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  		const struct point_coord *p =3D &touch_event.point_coord[i];
> =20
>  		/* Only process contacts that are actually reported */
> -		if (p->sub_status & SUB_BIT_EXIST)
> +		if (p->sub_status)
>  			zinitix_report_finger(bt541, i, p);
>  	}
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does the interrupt handler
allocate I2C transfer buffers on the stack, potentially violating DMA
mapping constraints?

In zinitix_ts_irq_handler(), touch_event is declared on the stack and passed
directly down to the I2C subsystem:

drivers/input/touchscreen/zinitix.c:zinitix_ts_irq_handler() {
	struct touch_event touch_event;
	...
	error =3D zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
				  &touch_event, sizeof(struct touch_event));

The helpers zinitix_read_data() and zinitix_write_u16() also allocate buffe=
rs
on the stack before passing them to i2c_master_send():

drivers/input/touchscreen/zinitix.c:zinitix_read_data() {
	__le16 reg_le =3D cpu_to_le16(reg);
	...
	ret =3D i2c_master_send(client, (u8 *)&reg_le, sizeof(reg_le));

Could this cause memory corruption or silent DMA failures if the underlying
I2C adapter attempts to DMA-map these stack pointers?


[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
with userspace during the driver's probe?

The driver initializes and registers the input device, exposing it to
userspace, before finishing its property validation:

drivers/input/touchscreen/zinitix.c:zinitix_ts_probe() {
	...
	error =3D zinitix_init_input_dev(bt541);
	// device is now registered and visible to userspace
	...
	error =3D device_property_read_u32(&client->dev, "zinitix,mode",
					 &bt541->zinitix_mode);
	...
	if (bt541->zinitix_mode !=3D 2) {
		dev_err(&client->dev,
			"Malformed zinitix,mode property, must be 2 ...\n",
			bt541->zinitix_mode);
		return -EINVAL;
	}

If userspace opens the device right after registration, zinitix_start()
could run with an uninitialized bt541->zinitix_mode, writing garbage to the
hardware.

Furthermore, if the probe fails due to a malformed mode property, the
already-exposed device will be abruptly destroyed while potentially in use.

Could the device properties be read and validated before calling
input_register_device() to ensure safe initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v2-0-ffe2ec9a9031@disroot.org?part=3D2
