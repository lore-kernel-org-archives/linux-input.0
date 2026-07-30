Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353423559E1;
	Thu, 30 Jul 2026 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441696; cv=none; b=nSeJBFtzTQYaquIlZb1HlE5AdKxGcJlEJhHew1NrxExA63PapLDBPmHlvu36LqqpLT42HxA/Kcc+t8Ei+i7qxKSh1uXw5McFdyPiBuzcEqEcZIc0K7RJZl6xueJXGgpNYq9oNtiIrNfTQ/p9KPu+91ehVNI1vsox9ylRXCX5d54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441696; c=relaxed/simple;
	bh=f93fCmGWnoImWam34URDWG7c4IawJDr+vx1wKcDQFck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rt9KGXRspt74nAGPowRh8cBG2BRVNTVJWPHumsLomX3IvCkLUi9F2PHQKfSiqemDNo7gb6SvXwCR2HpSWx7gShRfJsfC+Jd3BiuFvhr2UG0GLAF+qEWQ5syghFZa9/zRDnF90E59qnu4dUl8n/bc8TnSeFoSLHiX92YfKJcoZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bxxaa28i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bxxaa28i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FE11F000E9;
	Thu, 30 Jul 2026 20:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785441693;
	bh=xT2kJDI1dEXQ1gjwiVa98E3BtDlc/4uaOMCTO+rHOs8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bxxaa28iZJrZxg4GjFKKxSyTnJPM6FegR9ztfRJmwt5S4GnaGVtiG2/xQ57RCb+Kd
	 uOu03recDFJ5yBgMu/TAmX7WAcRt57UhpVEjrHUK0NlOt61XeBJeGnhQQA28BBOY9G
	 FKBZ8y6I190BKe3B/K/qcdNnZSSXvW3N2d/c0LPwJxfOWyN4P5TNe+Gc/aLLkg+CgN
	 c+TBVuVbZyqFgnQmRKAR+uMojYRUePM9su+2KBwSX+jCOwRCBvmC8hxgMjrY4J9Cny
	 cu3/m/7guEzRMMKmKVLuFDtz/zlUzVnQmR17ZQlQUmVkRsmVzW3flo7x1kR1Tr/M8/
	 BTPH7nJZ3fXXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] arm64: dts: exynos7870-j6lte: set mode 0 as
 default for zinitix touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260731-zinitix-modes-v2-5-ffe2ec9a9031@disroot.org>
References: <20260731-zinitix-modes-v2-0-ffe2ec9a9031@disroot.org>
 <20260731-zinitix-modes-v2-5-ffe2ec9a9031@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:01:32 +0000
Message-Id: <20260730200132.B2FE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] NULL pointer dereference in IRQ handler due to race condition with=
 input device registration.
- [Medium] Commit message and code logic mismatch regarding finger event fi=
ltering.
--

--- Patch [5]: [PATCH v2 5/5] arm64: dts: exynos7870-j6lte: set mode 0 as d=
efault for zinitix touchscreen ---
commit 8857c310eb5f5f4f8a5e742e862931240c3227fa
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

arm64: dts: exynos7870-j6lte: set mode 0 as default for zinitix touchscreen

This commit sets the default mode for the ZT7548 touchscreen chip to 0 in t=
he
Galaxy J6 device tree. It ensures that fake aftermarket digitizers, which o=
nly
implement mode 0, function correctly since the downstream kernel driver also
utilizes mode 0.

> arm64: dts: exynos7870-j6lte: set mode 0 as default for zinitix touchscre=
en

[Severity: Medium]
Is there a mismatch between the commit message and code logic regarding fin=
ger
event filtering?

The commit "Input: zinitix - do not ignore non-moving fingers" states in its
message: "...under the following condition: if (p->sub_status & SUB_BIT_EXI=
ST)
zinitix_report_finger(bt541, i, p); This implies and ensures that every val=
id
finger must have the SUB_BIT_EXIST flag."

However, the condition simply checks if (p->sub_status):

drivers/input/touchscreen/zinitix.c:zinitix_ts_irq_handler() {
    ...
		/* Only process contacts that are actually reported */
		if (p->sub_status)
			zinitix_report_finger(bt541, i, p);
    ...
}

Does this regression allow events without SUB_BIT_EXIST to bypass the filte=
r,
invalidating the stated premise?

> diff --git a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts b/arch/arm64=
/boot/dts/exynos/exynos7870-j6lte.dts
> index de30d0970336f..bd8f798c9810b 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
> @@ -424,6 +424,8 @@ touchscreen@20 {
>  		touchscreen-size-y =3D <1480>;
> =20
>  		vdd-supply =3D <&vdd_ldo34>;
> +
> +		zinitix,mode =3D <0>;

[Severity: High]
Could setting the mode here introduce a regression where a NULL pointer
dereference occurs in the IRQ handler due to a race condition with input
device registration?

Looking at drivers/input/touchscreen/zinitix.c:zinitix_ts_probe(), it calls
zinitix_init_input_dev() which registers the input device:

drivers/input/touchscreen/zinitix.c:zinitix_init_input_dev() {
    ...
	error =3D input_register_device(input_dev);
    ...
}

This immediately exposes the evdev node to userspace. If userspace (e.g., u=
dev)
opens the device instantly, zinitix_input_open() invokes zinitix_start(),
which enables the hardware IRQ.

If an interrupt fires at this exact moment, zinitix_ts_irq_handler() runs a=
nd
dereferences the callback:

drivers/input/touchscreen/zinitix.c:zinitix_ts_irq_handler() {
    ...
	error =3D bt541->read_point_status(bt541, &touch_event);
    ...
}

However, the probe thread has not yet assigned this function pointer, becau=
se
it happens later via the mode switch:

drivers/input/touchscreen/zinitix.c:zinitix_ts_probe() {
    ...
	switch (bt541->zinitix_mode) {
	case 0:
		bt541->read_point_status =3D zinitix_read_point_status_mode0;
    ...
}

Since the function pointer is uninitialized when the IRQ fires, would this
regression cause a kernel panic?

>  	};
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v2-0-ffe2ec9a9031@disroot.org?part=3D5
