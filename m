Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D3399892
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089681; cv=none; b=i+xk/U8G8GwtY5BTICVXOaPpNhc0lNGO3vHOMnyQuPFIm7P2jkUHdv9D3AFVg0wlRBGIVMrzMtZxE8vwg4oN/Ljh6dRJSoZjd7ooGPZxLYx+TXK1a80Qd0LWhkPvFEpHysiAaWADpK4zlJa/VL4sN8u6VCsgFRliGRnaB4FlJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089681; c=relaxed/simple;
	bh=k6Dw/xEURbGsGFL9V6ztgKqFJc/o2wof3wqU9QD5TPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O0cmM2R5tFSYSkIOjcjayqKU0txjZTKbMYhY5p9Cly9TnHMWv+zOMha5nWkjpYxakiKAqyaQ9i9dORZpLaMBSEHt96qtIOH7T6kDENHDsuTJvpvbvU65Flk8PNFOP0XKgvL49qAthPeOaZyUwBbcNnoQETaZTiCVtyzlhEY53KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1ZJk1BP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1ZJk1BP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8C71F000E9;
	Wed, 15 Jul 2026 04:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784089680;
	bh=FDXRSY0/DGd21gSFveF0ee34gV5Ne1Hk++4QyQFdfrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d1ZJk1BPZy7MKFJhPrz4tTxSHkbziJ3YF5jJfF7vSSBrzWAgOIGlp5hFx+iDmLcZu
	 CFxG8sZANDjhUncfWMONsx8HJigwKe7OuYOjmYUfRtJH47Xl58+X0esV1byukWhf9a
	 x/OW1WdfM8tbzB/bxvwcogl4ZnYi3M/2FQtcCUrjg1bacKpHASsbWS16ulHxRyvt0Y
	 dfu4jmzQAUhCsvLLzWox1YvN2ooPHntmMa0EhiY0y7bb47Vxht32+ni+7fYO/tu2N2
	 aCom0e2Plg0nWrl88YprVz+jQjh9lM0eLmK7BBqFRVFIieLpsRU27WS+oEYs/wsPBu
	 4DSUVB/tsJHMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: add driver for Gigabyte Aero vendor-specific
 brightness keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Uddhav Swami" <uddhavswami@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260715041556.112673-1-uddhavswami@gmail.com>
References: <20260715004457.100650-1-uddhavswami@gmail.com>
 <20260715041556.112673-1-uddhavswami@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 04:27:59 +0000
Message-Id: <20260715042759.DF8C71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional capability mapping forces the registration of all =
hid_inputs and unpredictably overwrites drvdata->input.
- [Low] Uses 'ret' instead of 'error' or 'err' for error variable.
--

--- Patch [1]: [PATCH v2] HID: add driver for Gigabyte Aero vendor-specific=
 brightness keys ---
commit a88dff22dbe03f72cc6b7e002b5c019c9cd1010f
Author: Uddhav Swami <uddhavswami@gmail.com>

HID: add driver for Gigabyte Aero vendor-specific brightness keys

This patch intercepts vendor-defined HID reports for brightness keys on
Gigabyte Aero laptops and maps them to standard KEY_BRIGHTNESSUP and
KEY_BRIGHTNESSDOWN input events.

> diff --git a/drivers/hid/hid-gigabyte.c b/drivers/hid/hid-gigabyte.c
> new file mode 100644
> index 0000000000000..3f0c9a1b6bc1d
> --- /dev/null
> +++ b/drivers/hid/hid-gigabyte.c

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

[Severity: Medium]
Does this code accidentally force the registration of all hid_inputs?

Since capabilities are applied unconditionally to every hid_input applicati=
on
exposed by the device, it appears this defeats the HID core's
hidinput_has_been_populated() check. This could result in dummy input devic=
es
being registered for collections that have no mapped usages and would
otherwise be cleaned up.

Also, because drvdata->input is unconditionally overwritten on every callba=
ck
during device probe, will brightness events be unpredictably routed to
whichever hid_input happened to be parsed last by the HID core?

> +
> +	return 0;
> +}
> +
> +static int gigabyte_aero_probe(struct hid_device *hdev,
> +			       const struct hid_device_id *id)
> +{
> +	struct gigabyte_drvdata *drvdata;
> +	int ret;

[Severity: Low]
This isn't a bug, but could we use a different variable name here?

The input subsystem maintainer preferences suggest using 'error' or 'err' f=
or
variables that hold only negative error codes and 0 for success, rather than
'ret'.

> +
> +	drvdata =3D devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715041556.1126=
73-1-uddhavswami@gmail.com?part=3D1
