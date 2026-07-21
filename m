Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B96319617;
	Tue, 21 Jul 2026 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621181; cv=none; b=KTV7dCWnlSvqgYe8Y8oSrYpGP6il75yzhNCWIvzUnEE0q1l5KEaiMdSlW9A9hEQ9xvXHejcXqcmfa7loHCC6DWDIh7tjXCGsJwV5EdHrF0XGZaseUTX5SslAzkZjbl/KuAVG/PGcOXLlsSIN6dSX5m7MdakqEL7CaW4BrrlLLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621181; c=relaxed/simple;
	bh=HglUl6wQNbA/i12CNwzn8p2BdPp7nKZk+ejghEL1FDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G2TUGxnOFFe+cBaZ+MkpnijNpHTBwX735VnIkswIUJN73Z6DlVIv4PDdMkEmnkgiB+iXKkZqCVz4ZkdrnFCfCIpx5XxMRwHm0tIMNC1Jyjiuswnq21P/0icGg47pY5hI/wlRSKkwx0UY3QL/jvQDWcH29GbbNTktg09UrsNg6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ6bJ7XP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ6bJ7XP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766BB1F000E9;
	Tue, 21 Jul 2026 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784621179;
	bh=+OsE1EMoC/L7C512tgO1VFZw5a4050B3lakL/O2skBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQ6bJ7XPSx12zJ6OX3EVHcXRUpCwqU8lCLORYEbIbuNSRQQ2ZTk0nvqCD3A4pFQg7
	 LXsxXOpQnihkePTLstcVYUNMsc+pLwpqGLd+i1kkypnbvQdKkenuDvh6X2XFp6GN6B
	 McFLJDexC3GvS4XqF29kRRb/U4s3SRIqpBHvDYupsqQTMldJqM54AUkBtis5YLgNB+
	 0i2xffrBQruJKLhIKbc1J8FxO6NFtJTQ/lVW+lJ+iT5Xj3jhtMpBR93Y/3oomvD8pt
	 642t2YEbQiX3S1wKO6H+6tqA7Y1UMrq9ULIhFFinWwyTuuvi0PYXU8zPUdlVvhanr/
	 X2bQaaRIFZ/pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/9] HID: i2c-hid-of: skip post-power-on delay if
 powered on sufficiently long
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen-Yu Tsai" <wenst@chromium.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260721075226.2347933-5-wenst@chromium.org>
References: <20260721075226.2347933-1-wenst@chromium.org>
 <20260721075226.2347933-5-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:06:19 +0000
Message-Id: <20260721080619.766BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Skipping the post-power-on delay when regulators are already enabl=
ed reduces the reset assertion pulse width to near zero, causing device ini=
tialization failures.
--

--- Patch [4]: [PATCH v3 4/9] HID: i2c-hid-of: skip post-power-on delay if =
powered on sufficiently long ---
commit 77e6d660661b46c12652ca11459dae1f91a79af7
Author: Chen-Yu Tsai <wenst@chromium.org>

HID: i2c-hid-of: skip post-power-on delay if powered on sufficiently long

This commit switches the post-power-on delay to use the new
regulator_bulk_enable_and_wait() API. This avoids unnecessary boot time
delays on devices where the power rail is always-on or left enabled by
the bootloader.

> diff --git a/drivers/hid/i2c-hid/i2c-hid-of.c b/drivers/hid/i2c-hid/i2c-h=
id-of.c
> index 59393d71ddb9d..fdaad451e7102 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of.c

[ ... ]

> @@ -48,16 +49,14 @@ static int i2c_hid_of_power_up(struct i2chid_ops *ops)
>  	struct device *dev =3D &ihid_of->client->dev;
>  	int ret;
> =20
> -	ret =3D regulator_bulk_enable(ARRAY_SIZE(ihid_of->supplies),
> -				    ihid_of->supplies);
> +	ret =3D regulator_bulk_enable_and_wait(ARRAY_SIZE(ihid_of->supplies),
> +					     ihid_of->supplies,
> +					     ihid_of->post_power_delay_ms * USEC_PER_MSEC);
>  	if (ret) {
>  		dev_warn(dev, "Failed to enable supplies: %d\n", ret);
>  		return ret;
>  	}
> =20
> -	if (ihid_of->post_power_delay_ms)
> -		msleep(ihid_of->post_power_delay_ms);
> -
>  	gpiod_set_value_cansleep(ihid_of->reset_gpio, 0);

[Severity: High]
Does skipping this delay cause a regression where the reset assertion pulse=
=20
becomes too short?

If the regulators are already enabled (e.g., from an always-on rail or
bootloader), regulator_bulk_enable_and_wait() will return immediately
without waiting.=20

Because the reset GPIO is asserted during probe just before calling
i2c_hid_of_power_up(), skipping the post-power-on delay here causes the
reset line to be de-asserted almost instantly. This reduces the reset
assertion pulse width to near zero, which might violate the minimum reset
assertion time required by the hardware.

>  	if (ihid_of->post_reset_delay_ms)
>  		msleep(ihid_of->post_reset_delay_ms);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721075226.2347=
933-1-wenst@chromium.org?part=3D4
