Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8444CB8A8
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535513; cv=none; b=DzmVz7Uu8nWG7nFLZx3CugiUodWlro3POE5Vm4ho1MJ4OW8mSwYzxVMwDsqpY6LmZvq4tSY3pg1C/rBcdKvbno06lNHqxpPDaa8pPjakxb8wPaWHD16AYiZ+X5/e4i1wWX3j5RojbFxuSjJP4OCjRZpjVFu/OE4AHyBeg6u39Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535513; c=relaxed/simple;
	bh=EX1lLxiIl3/7KUaEf5HdgM1pfJKFMDGaXGTSoQlIECw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qaJrJdYxa3R2UjwkUd39mwRvmIQdp/jpVd7dEiYBDDdrerLgLesKtcdRHmULkwi+q3j1XuPEqOqz06uNp1+JPPXHiJBfP5TPpB2RoMwyQRPKU9KG0g0+V1oULQB5NbAuMBGVYMFEMy2W0g6FZqnnaVjA3+Ymvdnqn/HcXCHisWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnyCw7sD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnyCw7sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638011F00A3D;
	Fri,  4 Sep 2026 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788535511;
	bh=U2Q/lm3iGj/pYvBhBrK10Dt40xX3hP4fe2q3C++APgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnyCw7sDkjw2gcZYdjIZj58yt5oJU4C18FlSYFjm0XM0L8aHOIRB6W6MjCPHFhkIx
	 vWGPhbix3fAiLRLKQf1Xs+c0A8qqF8ij0aXovsHTdU4ao31qwYDOepqojRsI6bx8du
	 OMGDA7dp9v6YS7m782Z98dFgLH5qCK0oXLN6PkQzmbr6rbYWBUlEgh9PNJaYB44DTC
	 1jJU9c4Ky5uODgSmmKOiJxucojhUjRwDBrRBFc8CM9ael08tLJmxkMKJENpH0okDFu
	 mylqhr0klvq7QA5fYCWuoA5wqKD0AqV48m8pvR9sb2iKkbNAN0rqjpAvmCVlzcHZV3
	 oNgJh+Cefzelg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/13] HID: asus: add joysticks inner and outer range
 configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260904145845.184887-7-denis.benato@linux.dev>
References: <20260904145845.184887-1-denis.benato@linux.dev>
 <20260904145845.184887-7-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 15:25:10 +0000
Message-Id: <20260904152511.638011F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `cfg` parameter in `ally_set_joystick_thresholds` is passed but=
 never used within the function.
--

commit 221ad3b5bb99d01e136cae46aadc818940877d10
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add joysticks inner and outer range configuration

This commit adds sysfs attributes to configure the inner and outer ranges
(deadzones and sensitivity) for the joysticks on ROG Ally devices.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 659956ebaefca..8b9ab5f7931c0 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> +static int ally_set_joystick_thresholds(struct ally_handheld *ally,
> +					struct hid_device *hdev, struct ally_config *cfg,
> +					u8 left_it, u8 left_ot, u8 right_it, u8 right_ot)
> +{
> +	const u8 payload[] =3D { left_it, left_ot, right_it, right_ot };

[Severity: Low]
Is it necessary to pass the cfg parameter to this function?

Looking at the body of ally_set_joystick_thresholds() in
drivers/hid/hid-asus.c, the struct ally_config pointer cfg is passed but
never referenced. Could this parameter be removed to clean up the function
signature?

> +	int ret;
> +
> +	u8 *buf __free(kfree) =3D ally_alloc_cmd(CMD_SET_JOYSTICK_DEADZONE, pay=
load, sizeof(payload));
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret =3D ally_gamepad_send_packet(ally, hdev, buf, ROG_ALLY_REPORT_SIZE);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904145845.1848=
87-1-denis.benato@linux.dev?part=3D6
