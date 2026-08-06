Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA42279DCC
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019821; cv=none; b=R1m8ZtMmAs6GrSA0Tk/XreqL0M/yzkwmhu14SqBBOoJeU8qEFr/OjPDywaOkTGOYQmyo1mMMEX3qfDf+Heb//nMBZRwRJjAJJ2dzCwRlwOGi4BrweeAdwgVtbe3Qwxa51C8dMZ6yWslxuQwX3xWGDZA0d5M6yE5cB6H3xfJ0lTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019821; c=relaxed/simple;
	bh=2tGDgPc+Olsv8qbD9EEztucQKzzT4gk0RtmCeOzrJTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ll7weaLO+ZRE/gZbnN8uqByIsD947dE8jfUeO6JrtkDJSOR2Bm/7XuvPEbUYjJayZQgYuVZzZ+3a7HS5q2hAiU0T+xslwFDe4atwjJR0+gsIiFfOAqFPWaSmUA29muN3wDE6kXR6Hpbd18Vp+qYwl2LlWsDFc4Z91aN/5yIV24s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guGH3YMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guGH3YMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5320C1F000E9;
	Thu,  6 Aug 2026 12:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019820;
	bh=l7a/9q25FfLKFCZnarGxYPnRQ+XSpL+BFPOOD2BV1a0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guGH3YMxoQA4PY5l2dw8ntzp2lsp8HfSo8I0KhAoH4hj72Ig8HYPbBTLfkurftc5J
	 HQclAltSq3xZ4M7PBlzT3in59Y4WcRK54GdIuaO68sZ1ILGXwR7pv1TO3TAvmAKhMa
	 PO0j1rBvxz8Iv7SOX6TmrbazJVB7mGNs6lH1U5kfzVYgb9/OMeRE6Zi/J6G6KATkU4
	 9CqQ8I+rhxI7jxHaiQPC7D64Z2aMJ0b6EWclIgN5e9I6IglEhGfhJSz9oRaC1cp8A4
	 2K1Qg28HxAPMiaJ8mvPk4UBJ/kitZP814A2a05U9LmRBpjXNjMqYCE+pjrtUyW9PZQ
	 wgrTF81lOqYbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/13] iio: humidity: hid-sensor-humidity: convert
 probe and teardown to devm-managed resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Chitroda" <sanjayembeddedse@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-6-f1f92c1d830f@gmail.com>
References: <20260806-28-apr-iio-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com>
 <20260806-28-apr-iio-redundant-argument-v5-temp-v5-6-f1f92c1d830f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:36:59 +0000
Message-Id: <20260806123700.5320C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Shared global `humidity_callbacks` structure causes `.pdev` pointe=
r overwrite, leading to state corruption and use-after-free when multiple h=
umidity sensors are present.
--

--- Patch [6]: [PATCH v5 06/13] iio: humidity: hid-sensor-humidity: convert=
 probe and teardown to devm-managed resources ---
commit 56374932f747b4eb1a636c154cf264875bcdacc6
Author: Sanjay Chitroda <sanjayembeddedse@gmail.com>

iio: humidity: hid-sensor-humidity: convert probe and teardown to devm-mana=
ged resources

This commit converts the HID IIO driver resource management to use
devm-managed helpers. This ties the lifetime of all resources to the
device, simplifies error handling in the probe path, and removes the
explicit remove callback entirely.

> diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/hum=
idity/hid-sensor-humidity.c
> --- a/drivers/iio/humidity/hid-sensor-humidity.c
> +++ b/drivers/iio/humidity/hid-sensor-humidity.c
[ ... ]
> @@ -233,42 +234,20 @@ static int hid_humidity_probe(struct platform_devic=
e *pdev)
>  	platform_set_drvdata(pdev, indio_dev);
> =20
>  	humidity_callbacks.pdev =3D pdev;
> -	ret =3D sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
> -					   &humidity_callbacks);
> +	ret =3D devm_sensor_hub_register_callback(dev, hsdev, HID_USAGE_SENSOR_=
HUMIDITY,
> +						&humidity_callbacks);

[Severity: High]
This is a pre-existing issue, but does assigning pdev to the shared global
humidity_callbacks structure risk state corruption and a use-after-free?

If multiple humidity sensors are probed, the last probed device overwrites
this global pointer. If that last device is later removed, the global pdev
pointer will point to freed memory.

When an event later arrives for the remaining active device,
humidity_proc_event() will dereference the freed pdev:

static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
                               u32 usage_id, void *pdev)
{
        struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
        ...
}

Should humidity_callbacks be dynamically allocated per-device or stored
within the device's private data rather than shared globally?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-28-apr-iio=
-redundant-argument-v5-temp-v5-0-f1f92c1d830f@gmail.com?part=3D6
