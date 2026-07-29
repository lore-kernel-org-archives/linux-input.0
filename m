Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396EB1C3BF7
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785291085; cv=none; b=cIUNQ/7ULtqGoKBVl9i3xWpCaD4LEgAwMBI20XXkX6gSsuGby3lIdCnlgJe/YQ804ExZ0+EFRfDIXXK4WZjISwtAB1iFNYkpLOKLKqdy9XU8rBOQfoa2dRTWUNlaWqaD/Rs/wlMzN53iAst4IXaHDUARw/qPoZqMI7ccWkRxljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785291085; c=relaxed/simple;
	bh=kt8PIbzq6G/C6eqnGNriB54MYbzhBTMyswNC2j42rZ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BrkbwViRqgE+jWYUKolWwjNTg0FPpmsxlLRCiX0jrtehMczgfuvrOwONzr0YyWUO+A8oC4HktiZtK1LaOX8rL4GovnSGhyqk5byJxtPCzlcEw/Wu1eMHzbXBd+k4yjyc5VC+d2MwMs3Hh70KCL1miKC5n7CU5gI1G6aPcvnpPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDtjMfXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDtjMfXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC851F000E9;
	Wed, 29 Jul 2026 02:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785291084;
	bh=6h5USIzMp3a1Fv2F1uB5N1shb05Ih24Hd4QOUSAzRKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CDtjMfXfFBCYaGbG/OcDEiggaCWwbKcWGIoAsJvGEGeGl67YlGOWXJGav+MfBxTHw
	 EOHH7mW7Mv+xSk0YNZmetIniaEaZ7nyzq663+piKvTrdBIrkjFwR5fEdjosD7qGKLa
	 HfVqUlayUCkurlNJzSTlVCh3oPyV5WvwUnBHL8tfuX5aFLfxgiMlwCqY3jimZoX+Pj
	 1o6UDYoOKA1pwYfwUNTMgRKFkQpX3uI1dJMwaAnbNXu0lGuQfvE7ceOURlPqsBEXZS
	 S+v9Oqa9/tpkU4mvUpcjjnTpm3lVW1Vqs29pI9A716gYhjLV5CtomVSe9hCSXfvtAg
	 SBf46GRs+0w4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/11] HID: steam: Improve logging and other cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260729015243.1170573-10-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
 <20260729015243.1170573-10-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 02:11:23 +0000
Message-Id: <20260729021123.DEC851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in `steam_register()` fails to remove the device fr=
om the global `steam_devices` list, leading to a Use-After-Free when probe =
fails.
--

--- Patch [9]: [PATCH v4 09/11] HID: steam: Improve logging and other clean=
up ---
commit e2534775e852c76ea14b6b8605e36139ce7654b1
Author: Vicki Pfau <vi@endrift.com>

    HID: steam: Improve logging and other cleanup
   =20
    Adds more logging as appropriate, reindents an enum to match surrounding
    style, as well as cleaning up some places where we can use guard() inst=
ead
    of doing locking and unlocking manually.

> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 5ab4396a241e0..3738a4de3bffb 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c

[ ... ]

> @@ -1838,6 +1847,7 @@ static void steam_do_deck_input_event(struct steam_=
device *steam,
>  		steam->did_mode_switch =3D false;
>  		cancel_delayed_work(&steam->mode_switch);
>  	} else if (!steam->client_opened && start_pressed && !steam->did_mode_s=
witch) {
> +		hid_dbg(steam->hdev, "%s: doing mode switch\n", __func__);
>  		steam->did_mode_switch =3D true;
>  		schedule_delayed_work(&steam->mode_switch, 45 * HZ / 100);
>  	}

[Severity: High]
This is a pre-existing issue, but the error path in steam_register() fails =
to
remove the device from the global steam_devices list, which could lead to a
use-after-free when probe fails.

If steam_register() fails during steam_probe() for a wired device (e.g., if
steam_sensors_register() returns an error), the steam object is added to the
global steam_devices list but is not removed on the error path:

drivers/hid/hid-steam.c:steam_register() {
    ...
steam_register_sensors_fail:
	steam_input_unregister(steam);
steam_register_input_fail:
	return ret;
}

steam_probe() then returns the error, jumping to the err_hw_stop label and
bypassing steam_unregister(), which would have removed it from the list:

drivers/hid/hid-steam.c:steam_probe() {
    ...
		ret =3D steam_register(steam);
		if (ret) {
			hid_err(hdev, "%s:steam_register failed with error %d\n", __func__, ret);
			goto err_hw_stop;
		}
    ...
}

Because the steam object was allocated with devm_kzalloc(), the kernel frees
it upon probe failure, leaving a dangling pointer in the steam_devices list.

Can this memory corruption be triggered by plugging in a second Steam
Controller, or by writing to the lizard_mode sysfs parameter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729015243.1170=
573-1-vi@endrift.com?part=3D9
