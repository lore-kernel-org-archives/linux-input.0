Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726233AD9B;
	Thu, 30 Jul 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443506; cv=none; b=bi6fHozTCxLsIEbw/n880GoQ5rTJxgRd9Pg2IMAZsyx4GW/GmnLMVqWJqPuMpilXRfpNTcEpRL94z1I4NQumkmDYHJCu0qed85QcPcZ54e9Qk/7TJg1Gf8SEgpN3HhKFI4ENffesxgPdb/hDBhlDkcFjMjV1mo6YvaLpWm3NATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443506; c=relaxed/simple;
	bh=X5gL6mZLCz1u8pW6KXrr4ZiC9yZj7JovVsLjdJxK2B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KlLk/Uyet24FD0WzuqikO4UDQUp1RxZJInhDVC2cy6Bzzt1u+0o+oIt6b5MbfPKB6uJxZPW+MaDzRdbpqZTrzai8FBRGj4ErVmhk2S/DnAyex5yw9AjPFcqPc5SvJbakVtR+XmiGsN146u/EbbMXoXai7hKv7c2AvzpmnQBAAEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQeE29MJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQeE29MJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325AB1F000E9;
	Thu, 30 Jul 2026 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785443497;
	bh=jaTU6DziDqEW1aFy3fXYnhBdyoVw+cJHxc+Uf2Xlk6w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQeE29MJN9cAEWq6hP1jxhxdLlSmNc3mI1NMHs3ADhCvQYf325ABEHYx6oRrEdqAW
	 3p+t9k7lJl/qdMWLZWqKb5NJ6TL7ZXX9j4p84P9TcKce3b1bPJav4U0r8pag1h9yLp
	 ixeZKRBV7tXj5jhOxunFmh3ANBfy3RXPcM7xiiPwJnl1vDWNgVLIYHbvsaDZgAQvZf
	 5fBjjFXq4uZTDHnS04WGpwd06nZOf9X/7DY5gjpkC1rhrQBCk95Thcv73+vhGewlZF
	 HkPXxNmmDsA96HVrzdpCTTQmqO0k/vjKYvbwePkLOQks1USFyqr4zSCCJP/0pkqEKu
	 /oXy3n27LV4HA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] Input: zinitix - do not ignore non-moving
 fingers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260731-zinitix-modes-v3-2-2c8de712997a@disroot.org>
References: <20260731-zinitix-modes-v3-0-2c8de712997a@disroot.org>
 <20260731-zinitix-modes-v3-2-2c8de712997a@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 20:31:36 +0000
Message-Id: <20260730203137.325AB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch incorrectly relaxes the validation of touch contacts, tu=
rning an AND condition into an OR condition, which risks processing stale s=
lots as ghost touches.

Pre-existing issues:
- [High] The input device is registered and exposed to the system before it=
s private data is fully initialized, causing it to be opened with uninitial=
ized hardware settings.
--

--- Patch [2]: [PATCH v3 2/5] Input: zinitix - do not ignore non-moving fin=
gers ---
commit 454d687d20badd95d32dd2be0a6d7cb81eb6b592
Author: Kaustabh Chakraborty <kauschluss@disroot.org>

Input: zinitix - do not ignore non-moving fingers

This commit allows the ZT7548 touchscreen driver to report fingers even when
they haven't moved since the last interrupt. It does this by adding
SUB_BIT_EXIST to the valid status bits and relaxing the sub_status check in
the interrupt handler to allow any non-zero sub_status.

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index 3421b8ffb19b2..a0a89d25e25bb 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c
> @@ -406,7 +406,7 @@ static void zinitix_report_finger(struct bt541_ts_dat=
a *bt541, int slot,
>  	u16 x, y;
> =20
>  	if (unlikely(!(p->sub_status &
> -		       (SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {
> +		       (SUB_BIT_EXIST | SUB_BIT_UP | SUB_BIT_DOWN | SUB_BIT_MOVE)))) {

[Severity: High]
Does this modification allow a contact with SUB_BIT_MOVE, SUB_BIT_UP, or
SUB_BIT_DOWN to bypass validation and report coordinates even if the mandat=
ory
SUB_BIT_EXIST valid bit is missing?

If the hardware clears the SUB_BIT_EXIST flag for a removed finger but leav=
es
stale status bits (like SUB_BIT_MOVE) in the I2C memory buffer, will this
cause stale slots to be processed as ghost touches?

>  		dev_dbg(&bt541->client->dev, "unknown finger event %#02x\n",
>  			p->sub_status);
>  		return;

[ ... ]

> @@ -473,7 +473,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, vo=
id *bt541_handler)
>  		const struct point_coord *p =3D &touch_event.point_coord[i];
> =20
>  		/* Only process contacts that are actually reported */
> -		if (p->sub_status & SUB_BIT_EXIST)
> +		if (p->sub_status)

[Severity: High]
Will removing the strict SUB_BIT_EXIST check pass any slot with stale status
bits to the processing logic?

Since the driver now relies entirely on status bits to validate active slot=
s,
a stale slot without SUB_BIT_EXIST but with a non-zero sub_status (like
SUB_BIT_MOVE) will now pass both checks.

>  			zinitix_report_finger(bt541, i, p);
>  	}

[Severity: High]
This is a pre-existing issue, but does the driver register the input device
before fully initializing its private data?

In drivers/input/touchscreen/zinitix.c:zinitix_ts_probe():

	error =3D zinitix_init_input_dev(bt541);
	if (error) {
		...
	}

	error =3D device_property_read_u32(&client->dev, "zinitix,mode",
					 &bt541->zinitix_mode);

If the kernel's kbd_handler synchronously opens the device during registrat=
ion
(due to EV_KEY), zinitix_init_touch() will configure the hardware using the
uninitialized zinitix_mode (0) instead of the parsed mode. Does this lead to
malfunctioning touch reporting for devices declaring linux,keycodes in their
device tree?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-zinitix-mo=
des-v3-0-2c8de712997a@disroot.org?part=3D2
