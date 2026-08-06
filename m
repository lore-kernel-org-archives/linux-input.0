Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58A2E6CC0
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983880; cv=none; b=YU5N6Xk1skEKyXQZbUeQVFb6Kwz+2sFV4qDsmnvm6DWH8W9bWXiz2NnFhiY412QhdFI6KYkzdG39/nKDA+2+uGrchfe3pMkQng9Sc7TgsUiC4Ru6y3nEUUrfl6IaB5fB72wjLeW2SuaHTsrPWtECu/mvlwQcF5Q5wDzvmDc+n7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983880; c=relaxed/simple;
	bh=HmJ7n6QvhGZNMq3+4/a/KK3+t28YuQ9dhTfJw0TunGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TrJ4GzSB48kvHsIdVWlK1/8wfzFI4IJwjIXgzLRE0kHO0AaAogcC0RBBsU+LpdSBpB/q3Z3gfDRwuNX7X8xlZojOEc0kRZZaD69sGIG1XLfWJn9DMC2FxYAeDdziQIp0ZpVR2euh2rxYXrV8YQz+DYBfdDXOsZrFdzGqR1PozOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIJQYS1P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIJQYS1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4821D1F000E9;
	Thu,  6 Aug 2026 02:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785983878;
	bh=A3XN0hFI+k4cp8AtK/QRE+gt+E9BMc+V4YXcHx+NJlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iIJQYS1PLTtl7Jo4n+yii4Tg1d5p8g+DGWARg080OPCX8Yt4XlI0cZ1GLu0nXDF/Z
	 S4XveeyguvkAY7IYLiCZtu7Ycd1DWJ0JGmzs/8ANW3in2TBIPTSWmysAOQb2wZCBX3
	 iGLRP3UVdgbhrIx9SoIU/7fAmu2uSaOLcQTCwKQCmYxB7WCde2uDjDpBe4vXXIJG97
	 9o1nD2FO0PadHZEQQ24LNExHZBW+nOjzMBCOEt7t0coQAqVaM7fT0KaBQi8IecZNwc
	 Uf36uJ9Q8SrpmorDFpi9aYV0fhP2RM2NF9C5Cx8T3TRJPBn8oYiGK8mZXSREutWFTr
	 PDLpCDuzqxj8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] HID: steam: Fix wording of connect/disconnect
 logs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806022653.93939-4-vi@endrift.com>
References: <20260806022653.93939-1-vi@endrift.com>
 <20260806022653.93939-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 02:37:57 +0000
Message-Id: <20260806023758.4821D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Device sending an empty serial number causes silent resource leaks=
 upon disconnection.
- [Medium] Registration failure leaves `steam->serial_no` populated, perman=
ently breaking subsequent connections.
--

--- Patch [3]: [PATCH v2 3/6] HID: steam: Fix wording of connect/disconnect=
 logs ---
commit 1846261fd57667e998e1416cd9dcdbedc57da4e8
Author: Vicki Pfau <vi@endrift.com>

HID: steam: Fix wording of connect/disconnect logs

This commit updates the connect and disconnect log messages to properly
identify the device as a Deck or a Controller depending on the device quirk=
s.
It aligns these messages with other special-cased strings in the driver.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 6476fbdc58886..38c00dab0b067 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -1394,7 +1394,8 @@ static int steam_register(struct steam_device *stea=
m)
>  			"%s:steam_get_attributes failed with error %d\n",
>  			__func__, ret);
> =20
> -	hid_info(steam->hdev, "Steam Controller '%s' connected",
> +	hid_info(steam->hdev, "Steam %s '%s' connected",
> +			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
>  			steam->serial_no);

[Severity: Medium]
This is a pre-existing issue, but can a registration failure permanently
break subsequent connections for this device?

If steam_register() fails later in the function (for example, if
steam_input_register() fails), the error path:

steam_register_sensors_fail:
	steam_input_unregister(steam);
steam_register_input_fail:
	steam_battery_unregister(steam);
	mutex_unlock(&steam->report_mutex);
	return ret;

cleans up resources but does not clear steam->serial_no.

On the next connection attempt, steam_register() will see steam->serial_no[=
0]
is populated and immediately return 0 without setting up any input devices,
leaving the device permanently broken until replugged.

> =20
>  	/* ignore battery errors, we can live without it */
> @@ -1427,7 +1428,8 @@ static void steam_unregister(struct steam_device *s=
team)
>  	if (!steam->serial_no[0])
>  		return;

[Severity: High]
This is a pre-existing issue, but does this early return lead to a silent
resource leak if the device sends an empty serial number?

If steam_get_serial() successfully reads a valid HID reply but the string
payload is empty, it populates steam->serial_no with an empty string using
strscpy() and returns success, bypassing the fallback serial generation.

Later, on disconnection, steam_unregister() will hit this early return and
skip unregistering the input devices, sensors, and power supplies.

> =20
> -	hid_info(steam->hdev, "Steam Controller '%s' disconnected",
> +	hid_info(steam->hdev, "Steam %s '%s' disconnected",
> +			steam->quirks & STEAM_QUIRK_DECK ? "Deck" : "Controller",
>  			steam->serial_no);
>  	steam_battery_unregister(steam);
>  	steam_sensors_unregister(steam);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806022653.9393=
9-1-vi@endrift.com?part=3D3
