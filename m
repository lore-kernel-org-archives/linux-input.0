Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DE72F3C07
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780266868; cv=none; b=B9CDF80KfsAGq6mI9tzgxFFezIFgprrGNd/XEw5miwMok4NSOb+nyP7g4MCgqTPCYFy8zGEV4W3sUuT+0+8WdUrCrlkrexrPH+2KU3Jc+v5ooyQxoXllUG7sJvEHHlbvA/lZZ+anZyBiM4EAyhFelIyvf9vIkDP5SCLMt6VzszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780266868; c=relaxed/simple;
	bh=B3OQnJit2rGTQnmLsJqVASEgfg0hoUxI+Vq3+7+b+NI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ApYGrTX4LU5vqNkA1hTaXjVCexw7/b/ls+r5d6ctNBowMOFUqY06rb3jUlaXfW+G04xpMlbNfgmeTb3reGxj8Y0jTB425qnUUy3K3kmY1M5N6RCAbn8skXeIUCx0XiDYjOE23D2XCh6ARZfWk0CSlYqmzj5WUIvYr3uIxn176Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYHrNtLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYHrNtLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289EA1F00893;
	Sun, 31 May 2026 22:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780266867;
	bh=SL9ad20RMi+SyDuwLv3h+74V79rX3E4QYhSX9fX4qUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aYHrNtLbv0SOQHN3D4iVwrktgFsDII86xjaV3LKA6H1+sksAVb37lyYrzAt1yV6wl
	 p15CrhyLrzJsi5tMQIxwIIo59f7dHq9Nw2DvVW1XatKqpUSJs8Gk7YyaNHJFg61G1A
	 QuMjimw/Obed9qRGbADKDx0CG24XLhe97o+8PGkpUYAF7l+vYCcDt9dwJwcI5jVoGK
	 lIFPufleqeDNlituI3xLQBRSDbLDnjvtCQ/CPsOjzwcri8Xxtk/+jmVKD0sP16cx8L
	 CgMZ3gdepv68r1kSl0O5nMwUsD+suD8WPH/C+BGBWSC45Fl1fXRPfTLaseq7oxGDZ7
	 Y5361y4zgZoyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: steelseries: Add MSI Raider A18 HX A9WJG RGB
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Glushkov" <david.glushkov@sntiq.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260531222123.179923-1-david.glushkov@sntiq.com>
References: <20260531222123.179923-1-david.glushkov@sntiq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 22:34:26 +0000
Message-Id: <20260531223427.289EA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Type confusion and undefined behavior for SRWS1 devices in steelse=
ries_headset_raw_event().
- [High] DMA API violation: devm_kzalloc buffer passed to usb_control_msg()=
 for DMA.
- [Low] Build failure due to missing 'err_close' label on the error path of=
 steelseries_probe().

Pre-existing issues:
- [High] Kernel crash due to uninitialized workqueue object when battery re=
gistration fails.
--

commit a675d7bbdbccedaef6c839f514204764ec470211
Author: David Glushkov <david.glushkov@sntiq.com>

HID: steelseries: Add MSI Raider A18 HX A9WJG RGB support

This commit adds support for MSI Raider A18 HX A9WJG RGB keyboards via the
steelseries driver. It introduces multicolor LED support using a devres
managed buffer and adds device specific quirks mapping.

> diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
> --- a/drivers/hid/hid-steelseries.c
> +++ b/drivers/hid/hid-steelseries.c

[ ... ]

> +static int steelseries_msi_rgb_register(struct steelseries_device *sd)
> +{
> +	struct hid_device *hdev =3D sd->hdev;
> +	struct led_classdev *led_cdev;
> +
> +	sd->rgb_buf =3D devm_kzalloc(&hdev->dev, 524, GFP_KERNEL);

[Severity: High]
Memory allocated with devm allocators includes a devres header, which breaks
cacheline alignment. Does passing this sd->rgb_buf to usb_control_msg() in
steelseries_msi_rgb_set_blocking() cause memory corruption on architectures
with non-coherent DMA?

> +	if (!sd->rgb_buf)
> +		return -ENOMEM;

[ ... ]

> @@ -567,7 +731,17 @@ static int steelseries_probe(struct hid_device *hdev=
, const struct hid_device_id
>  	if (ret)
>  		return ret;
> =20
> -	if (steelseries_headset_battery_register(sd) < 0)
> +	if (sd->quirks & STEELSERIES_MSI_RGB) {
> +		ret =3D steelseries_msi_rgb_register(sd);
> +		if (ret) {
> +			hid_err(hdev, "Failed to register MSI RGB LEDs: %d\n", ret);
> +			goto err_close;

[Severity: Low]
Since there is no err_close label defined in steelseries_probe() or the rest
of the file, does this goto statement cause a build failure?

> +		}
> +		return 0;
> +	}
> +
> +	if (sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9) &&
> +	    steelseries_headset_battery_register(sd) < 0)
>  		hid_err(sd->hdev,
>  			"Failed to register battery for headset\n");

[Severity: High]
This is a pre-existing issue, but if steelseries_headset_battery_register()
fails, the error is logged but probe successfully returns 0. This leaves
sd->battery_work zero-initialized.

Will a subsequent raw input event or device removal cause a kernel panic wh=
en
schedule_delayed_work() or cancel_delayed_work_sync() is called on this
uninitialized structure?

[ ... ]

> @@ -635,7 +812,7 @@ static int steelseries_headset_raw_event(struct hid_d=
evice *hdev,
>  	unsigned long flags;
> =20
>  	/* Not a headset */
> -	if (hdev->product =3D=3D USB_DEVICE_ID_STEELSERIES_SRWS1)
> +	if (!(sd->quirks & (STEELSERIES_ARCTIS_1 | STEELSERIES_ARCTIS_9)))
>  		return 0;

[Severity: High]
For SRWS1 devices, the driver data is a completely different structure, not
a struct steelseries_device. As a result, sd aliases a kernel pointer.

Does reading sd->battery_capacity earlier in the function, and checking
sd->quirks here, lead to type confusion and undefined behavior since it
replaces the safe hdev->product ID check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531222123.1799=
23-1-david.glushkov@sntiq.com?part=3D1
