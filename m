Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8E4B3C93
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792329184; cv=none; b=ddaQx6EV2NqKqmim7paY6FNMJyBbWEzmqGgm2+FK0gtMcU3+nELf+XnSg+x3DN7GBKphxckg2ZQz5Z0rmMWOrQz5w0fN7ZXyIQfayVmrzdZ+gKCQKGco1CgL140x7yiIsF6Bow99NkUjf+de2WzTcZ6Gbr9n5qyYmR/BcLH381A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792329184; c=relaxed/simple;
	bh=6V6ts08Su23WRol9BYAXPfKeFdX8PvLWl/LUFWr8sL8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E0W3nEKljEmxchQHFm6x+CEhZ+OVOqEYyuZtSue01G034/sQT3uIpykVtsXtrEdUruWWkTya4K8iOZD5UjUwu1QpaPN5vImvwyGOpuUKfa+CHi7wes4OScY17zA12BcfaDqGdjssIB+NEzOMhbBuQel4IZjN/KRvgEJa7jb81zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLHQey9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLHQey9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A399B1F000C5;
	Sun, 18 Oct 2026 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792329183;
	bh=bfsYzgcjmM8MhUnSy2Zr2bV5qkVzCJ1elbJ2No4Y+PU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FLHQey9nk4hZoNPGig7JCQCosTamKoUAHtLrE5q0uMUfi0lA/b1P2hdTfA3Ot2O3n
	 eYGtQtN5aqX4lQF7VFQq04bQ5NaGbRvWYQbkoImyUb1hIPGLkGGzRNytD0Bd7TZDwU
	 8Dz4NXr3l0xienjKJuLpYP1Ke7PMOMJiXTyOM7YQmzI5ehYNwK5KFUxsrjeMhxd5y2
	 bDi4haeC4xmnPNn/SfDa3rdEQa0AjENxzxfbAm2Jct2PLqs2jpj0lAY4J1SAKqR5kz
	 WQQSqbjNFi4mXXB5HQhHAGRit4whEEU6M1XQdSJ3LyThAAFOA0EGdn+XH+b7cp3WNs
	 fOHINM+vL3Iog==
Message-ID: <sashiko-outbox-176149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/8] HID: topping: transport for the M62's vendor
 controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018124838.129349-2-mikhail.v.gavrilov@gmail.com>
References: <20261018124838.129349-1-mikhail.v.gavrilov@gmail.com>
 <20261018124838.129349-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 13:13:03 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] HID: topping: missing pm_ptr() on topping_driver PM callbacks
--

commit cefe32a6b81c6b7ed6128d273a5c5c6a50f7896a
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

HID: topping: transport for the M62's vendor controls

This commit adds a HID transport driver for the Topping M62 USB audio
interface's vendor control protocol, connecting to snd-usb-audio via the
component framework.

> diff --git a/drivers/hid/hid-topping.c b/drivers/hid/hid-topping.c
> new file mode 100644
> index 0000000000000..a8854b2d15306
> --- /dev/null
> +++ b/drivers/hid/hid-topping.c
> @@ -0,0 +1,498 @@

[ ... ]

> +static struct hid_driver topping_driver =3D {
> +	.name		=3D "topping",
> +	.id_table	=3D topping_devices,
> +	.probe		=3D topping_probe,
> +	.remove		=3D topping_remove,
> +	.raw_event	=3D topping_raw_event,
> +	.suspend	=3D topping_suspend,
> +	.resume		=3D topping_resume,
> +	.reset_resume	=3D topping_resume,
> +};
> +module_hid_driver(topping_driver);

[Severity: Low]
In drivers/hid/hid-core.c, hid_driver_suspend(), hid_driver_resume(), and
hid_driver_reset_resume() are only built when CONFIG_PM is enabled:

drivers/hid/hid-core.c:
#ifdef CONFIG_PM
int hid_driver_suspend(struct hid_device *hdev, pm_message_t state)
{
	if (hdev->driver && hdev->driver->suspend)
		return hdev->driver->suspend(hdev, state);

	return 0;
}

Should .suspend, .resume, and .reset_resume in topping_driver be wrapped
with pm_ptr() so that topping_suspend() and topping_resume() can be
eliminated by the compiler when CONFIG_PM is disabled?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018124838.1293=
49-1-mikhail.v.gavrilov@gmail.com?part=3D1
