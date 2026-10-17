Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2437F312
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202874; cv=none; b=NG/dhEht780C8qnMRF13yOTF0DM7Pmk8+r1aNR4KJNUQfJ6u2uj3HkJe2hraEhSuzQ9lYtFrBa8vvA1MB32chohOI0HW/Qu8MD1HPkGrRyJKDEyst+QacsuFKZXhFMWkGnA3caJ9hKIKS9sQ5ET28s/4OiguVBxZkuxC/WJqWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202874; c=relaxed/simple;
	bh=Tjv8fJrKv4/VBZKIW9ki43iHGFVYIwCJo9UWlxbGPRw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dPQmUjWDdJ5VADwPlUBtE9aGReJUEqIPAPXQ48aDi6cWfxTqMj+nkXlmbk4n8fSXhuAihSuhxQL/lyqHsKY0A9uBgzxzLZ3R6+2Bx2PtDT8RrwsxUQhGmcyG62SmTMM6C+pwVS+2bYcmr7vtEqT+NZscbamznm8+IGddi82Cehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBQQMmR1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBQQMmR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F38D1F000C4;
	Sat, 17 Oct 2026 02:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202870;
	bh=v+UIe9YYn8+/UeyW8PqSdszSMv/xpFILTREuzy3diLI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MBQQMmR152DAhzBb7wofY4SUCWqAl1hDj3JBVyGO4gARCYvWSHiYmxE/mEo6uOrun
	 f8H0j3qE2qFtzghm57G0zonLyDz+gLDsqEuIDc1h3BOePmaDtY9SL0kT/RO+/RZGDL
	 ZABkZgAJEWY484TiGd3H4RWjwSn40TjuhQnIVPhY356O9YIcgLAXyQgMhJwpweSqv1
	 hIQl6HlysQWIfXKlONqqo35lEgmX2C14Je0zzJX5N2CGp3gf5ExW8i1CtVG0Wp7RQ9
	 NOy1FBUh2Fb+GxJ9/PC4MxMQDjkncSn1ZjqMGRF0C/uHv9ZuQtiHvHQ7hzl1yBvZxh
	 A5NOfBbe1bgbQ==
Message-ID: <sashiko-outbox-175191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] HID: hid-lenovo-go-s: Move attribute init to
 after device query
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017013956.2440130-8-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
 <20261017013956.2440130-8-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:07:50 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: hid-lenovo-go-s: stale setup_attempts in cfg_setup() preven=
ts retries
--

commit 64ba4976aa238a6736cd4179f4b0b3a285680c68
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-lenovo-go-s: Move attribute init to after device query

This commit moves sysfs attribute and multicolor LED registration from
hid_gos_cfg_probe() to cfg_setup() so that attributes are only registered
after the MCU has been queried. It also adds retry logic to reschedule
cfg_setup() up to 5 times if cfg_query_device() fails.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 14aeddd65704b..cefb243800b65 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
> @@ -42,6 +42,7 @@ static struct hid_gos_cfg {
>  	bool gp_registered;
>  	bool rgb_registered;
>  	int cmd_status;
> +	int setup_attempts;
>  	u8 gp_auto_sleep_time;
>  	u8 gp_dpad_mode;
>  	u8 gp_mode;
> @@ -1453,57 +1454,127 @@ static struct led_classdev_mc gos_cdev_rgb =3D {

[ ... ]

> +static void cfg_setup(struct work_struct *work)
> +{
> +	bool gp_registered =3D false;
> +	bool rgb_registered =3D false;
> +	int ret;
> +
> +	ret =3D cfg_query_device();
>  	if (ret) {
> -		dev_err(&drvdata.hdev->dev,
> -			"Failed to retrieve OS Mode: %i\n", ret);
> +		/* The MCU may not be ready yet. Retry a bounded number of
> +		 * times before giving up.
> +		 */
> +		drvdata.setup_attempts++;
> +		if (drvdata.setup_attempts >=3D 5) {
> +			dev_err(&drvdata.hdev->dev,
> +				"Giving up on device setup after %d attempts\n",
> +				drvdata.setup_attempts);
> +			return;
> +		}
> +
> +		schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies(50));
>  		return;
>  	}
> =20
> -	/* Pairs with smp_load_acquire in attribute show/store functions */
> -	smp_store_release(&drvdata.gp_registered, true);
> -	/* Pairs with smp_load_acquire in attribute show/store functions */
> -	smp_store_release(&drvdata.rgb_registered, true);
> +	drvdata.setup_attempts =3D 0;

[Severity: Medium]
What happens on a subsequent setup run if cfg_query_device() fails 5 times
and cfg_setup() gives up, or if hid_gos_cfg_suspend() cancels gos_cfg_setup
after one or more failed attempts?

Since drvdata.setup_attempts is only reset to 0 when cfg_query_device()
succeeds, giving up leaves drvdata.setup_attempts at 5, and a suspend
cancellation leaves it at a non-zero count:

drivers/hid/hid-lenovo-go-s.c:hid_gos_cfg_suspend() {
	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
	return 0;
}

When hid_gos_cfg_reset_resume() later runs and sees that registration did
not complete, it schedules gos_cfg_setup again without resetting
drvdata.setup_attempts:

drivers/hid/hid-lenovo-go-s.c:hid_gos_cfg_reset_resume() {
	...
	if (!gp_registered || !rgb_registered) {
		ret =3D schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies(2)=
);
		...
	}
}

The same applies if the driver is unbound and rebound in hid_gos_cfg_probe()
while drvdata is static.

If the first query on that new run fails because the MCU is not immediately
ready, drvdata.setup_attempts++ increments the stale value (for example from
5 to 6) and cfg_setup() immediately gives up on the first attempt without
retrying. Should drvdata.setup_attempts be reset when giving up or when
scheduling a fresh setup sequence in hid_gos_cfg_probe() and
hid_gos_cfg_reset_resume()?

[ ... ]

> +}
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017013956.2440=
130-1-derekjohn.clark@gmail.com?part=3D7
