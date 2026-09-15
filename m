Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1843F4D2
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496342; cv=none; b=FQL9k1vEt/0yiQCqIf949twR+Uy8udk2Bg9J+qXZFQRvsTnSFM59xo1L+QOKp1Hv/2dk0YZPqO/lF4rAB0RwU8HleZnqiJeg22VMaDgbWXgAYAQn0u2IghDT3unTFt5y93VBMxhPK6Vi/H+zQSEAIfujbs/GqfZ3iRZsO6wBP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496342; c=relaxed/simple;
	bh=mom5GC2frxSc3TpT6cJ8U4igG4ygK0MA5o8/0dYiTIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DN9j2KoHsSqB2pW/36KV8e2oAkXZ8Ti9OozSmH15QRs6uJHAG2yNgNISbx8RRB0xQS4COYMnDWAAFZW0oOkH3t6dcJyCr345qTFF4jfljBcG3gXxC8Q0IuPqtIHSK1tyjxeVJiVwYzb0Rg7xPJkBJJjNWl9b/71dJUeY2aj/SJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glIqde1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glIqde1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5393D1F000FF;
	Tue, 15 Sep 2026 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789496341;
	bh=oA0HCz252+SgZ3lvgAj8/15HhkH0aagtM6JaOBL8pZ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=glIqde1gzxD0/WQnLzsHG5abaCTIojmDcvN54H6YYPNYLvRhlhyRZrrzVqIm04S0g
	 tiyX/z0YazYHuj2mD3cjVIIlukbRlIE/heiv/rHuviDdIrUuqoR+pg+/jy7PGjUD9f
	 Z0gFsNRDs1W/GRiUZrFPjOzvuJRM6YjLFJm+KJ+bR3qybIPTQYSco/Nl/rwljRs09f
	 guaPxGfGSMJmXeelW68z5zRS9cA/N9VF/cFPy26403FclKKaLq2cslgDfSb3aL7jnm
	 37a5jbJ4YseI+v/WG2lvATu011rX3yayHyxrsHm8lSDs/EPnOQvhigzkJI6SZvsXcj
	 NR9ZZZHCw8UhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] HID: asus: add support for xgm led
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260915181200.18086-4-denis.benato@linux.dev>
References: <20260915181200.18086-1-denis.benato@linux.dev>
 <20260915181200.18086-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:19:00 +0000
Message-Id: <20260915181901.5393D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: asus: I/O on stopped device in probe error path
--

commit d32c2e222ce9fd06cb5cc60459d66b339dbd284d
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for xgm led

This commit adds an LED class device interface to control the brightness
of the red LEDs on Asus XG mobile stations. It registers the LED using
the managed devm_led_classdev_register API and hooks up a callback to
set the brightness via HID reports.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index e6218abdac49c..825833f6c2c4d 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1545,6 +1616,16 @@ static int asus_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  	if (!drvdata->tp)
>  		asus_initialize_reports(hdev);
> =20
> +	if (asus_has_report_id(hdev, FEATURE_KBD_REPORT_ID) &&
> +	    ((hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2022) ||
> +	     (hdev->product =3D=3D USB_DEVICE_ID_ASUSTEK_XGM_2023))) {
> +		ret =3D asus_xgm_init(hdev, drvdata);
> +		if (ret) {
> +			hid_err(hdev, "Failed to initialize xg mobile: %d\n", ret);
> +			goto err_stop_hw;
> +		}
> +	}
> +

[Severity: High]
Does the err_stop_hw path in asus_probe() need to manually unregister the
xgm_led before stopping the hardware?

If probe fails after asus_xgm_init() successfully registers the LED (for
example, if asus_start_multitouch() fails later in the probe function),
the execution jumps to err_stop_hw:

err_stop_hw:
	if (drvdata->listener.brightness_set)
		asus_hid_unregister_listener(&drvdata->listener);

	asus_worker_stop(drvdata->worker);
	hid_hw_stop(hdev);
	return ret;

Since the LED was registered with devm_led_classdev_register(), devres
will automatically unregister it when asus_probe() returns. However,
unregistering an LED classdev natively turns it off, invoking the
blocking asus_xgm_led_set() callback.

Because hid_hw_stop() has already shut down the hardware in this path,
asus_xgm_led_set() will call hid_hw_raw_request() on a stopped (and
potentially partially freed) HID transport. Depending on the lower-level
driver, this can lead to a use-after-free or a kernel crash.

I see this is handled safely in asus_remove() by explicitly unregistering
the LED before hid_hw_stop() is called. Could we do the same in the probe
error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915181200.1808=
6-1-denis.benato@linux.dev?part=3D3
