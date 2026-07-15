Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3361B808
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 01:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077694; cv=none; b=XJEyGzgsL8dhblmbxnBGPkOmedZt09A2Tk8wXf/9ZDoLCjmhsDSJxNLzc/fB/20Ktlb0L2ER2Keaf8CBR95RTK4Hh01P10R61nhFI4ygZ97esEstvhWDnIyVMTMsRrEyFwqkanUGZ3qAli12kYZo3fk4IaUaIB0jldhbF/O7oEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077694; c=relaxed/simple;
	bh=DrXKFNGquHzhJthGaVkxjOPkgpO0o+yV6UsbqDjEVl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nrj/ERqiKLJU/j/Khb8xqA5ZJDMEQAlhLtT1Zbz/mQo5yrAUar9mOCp0tZw3GpQNkpFvQuuCPqCAyLVnkjXG3M5F2UJYScphC8S5NZvFBSDL2k7VY8/67xahzY5+x3QSaA1n4rYNa8JHHxsNVYLNzcB2vUrBIOAiQmgVCGa9WnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLiGqe9i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLiGqe9i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A881F000E9;
	Wed, 15 Jul 2026 01:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784077689;
	bh=/trqzlEyKjrB4zXRmI+Zzcu/I0bM+O4wZoE7qct3g4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DLiGqe9iN5wc6+yT1PQ6h+2kMNk1rbDRo9oG4N+6RysYy9S32DcjDp4uchcEJA+ca
	 9gvKT1JT9Y7A+d9PMPedSEqXxXMmJ2WoecfQN9m4VEUdY/QIoA7CdCKhqeY67GxQD3
	 B34xytFxsONSuA5rWbvK60xs8544vgVxejvytRKLLjOh3uLg+eNP82kzNo/cVGnBmv
	 4XN0Wub3dSctY7ifL4Cuh0Nz44mFMT2F+33E1pfgFG7NBscRauu2C4v2SkuUQ3w4Ly
	 /NfZChMPpPIjGY0bLJaIofTgdjXPhx9fwMpS/iMK1Z6Wf41XPEFBD8DAZfvn06LuuI
	 PE/TfyN5QVwQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: add driver for Gigabyte Aero vendor-specific
 brightness keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Uddhav Swami" <uddhavswami@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715004457.100650-1-uddhavswami@gmail.com>
References: <20260715004457.100650-1-uddhavswami@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:08:08 +0000
Message-Id: <20260715010809.35A881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Dangling pointer in `drvdata->input` leads to Use-After-Free if `h=
idinput_connect()` fails during device probe.
--

--- Patch [1]: [PATCH] HID: add driver for Gigabyte Aero vendor-specific br=
ightness keys ---
commit 1b9632575a5f9cf3b6d4d94e30945e582cc34a94
Author: Uddhav Swami <uddhavswami@gmail.com>

    HID: add driver for Gigabyte Aero vendor-specific brightness keys

This commit adds a minimal HID driver that intercepts vendor-defined HID
reports for the Gigabyte Aero 15 XB keyboard. It maps values 0x7D and 0x7E
to KEY_BRIGHTNESSDOWN and KEY_BRIGHTNESSUP respectively.

> diff --git a/drivers/hid/hid-gigabyte.c b/drivers/hid/hid-gigabyte.c
> new file mode 100644
> index 0000000000000..1c242734aed3f
> --- /dev/null
> +++ b/drivers/hid/hid-gigabyte.c
> @@ -0,0 +1,127 @@

[ ... ]

> +static int gigabyte_aero_input_configured(struct hid_device *hdev,
> +					  struct hid_input *hi)
> +{
> +	struct gigabyte_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct input_dev *input =3D hi->input;
> +
> +	input_set_capability(input, EV_KEY, KEY_BRIGHTNESSUP);
> +	input_set_capability(input, EV_KEY, KEY_BRIGHTNESSDOWN);
> +
> +	drvdata->input =3D input;

[Severity: High]
Can drvdata->input become a dangling pointer here if input registration fai=
ls?

If hidinput_connect() fails later during the probe sequence (for example, if
input_register_device() fails), hidinput_disconnect() will be called and it
frees the input_dev.

However, because this driver implements a .raw_event callback, hid_connect()
will still return success. This allows hid_hw_start() to return 0 and the
probe to complete successfully.

If that happens, drvdata->input is left pointing to the freed input_dev,
which will trigger a use-after-free in gigabyte_aero_raw_event() when a
brightness key is pressed:

	case GIGABYTE_AERO_BRIGHTNESS_DOWN:
		input_report_key(drvdata->input, KEY_BRIGHTNESSDOWN, 1);

Could we avoid this by checking if (hdev->claimed & HID_CLAIMED_INPUT) is
set after hid_hw_start() completes in gigabyte_aero_probe()?

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715004457.1006=
50-1-uddhavswami@gmail.com?part=3D1
