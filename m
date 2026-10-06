Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7623393E
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791268203; cv=none; b=ZF6qZUvkQ9z3qCgWZvoTJcuhhwzyTVMOB4eUC5szQo2pBciVGhXb9bOSFzkdRIpjnmqYIA5fsEV1CeWBvRcCIPP8bFzcOWP9ek9Gk3pxkpAz0ZdO8XJ7k1Vt9rrd7b/Y0jlRrQXur6DvGEwOhxR4NYIqYMaOmSDICQc2n9B2mfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791268203; c=relaxed/simple;
	bh=9UMPj3TGQc/Ba6tFKMAZO6iqkBGHNbibAAOuIHn/F38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LpdTsJNfTd+7zPqafJYPRcte0WWRC1Qr4BjnSeca1vShqs94nVDpkpe5tWP/3d1CprgGK+c3ofurN/1ygqUigKndvAJZVw0hWx9sA8WkDZqA8bvapczLqJpmE+KZFpz7j+k2AAFim+2hOsVzjOI0ko4558FenWx3EL5D29BRdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gA+UPw/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gA+UPw/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE2C1F00893;
	Tue,  6 Oct 2026 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791268202;
	bh=zVlFSd1qeCnsHa7bR60Jhh4jO+ABLI+7lM5wqTUxafg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gA+UPw/NR0bN2q8nRDV8Eq5KpSsVSp1mMOpbR7/FhWFIhTVvFHSXCS2T0G0+dfGOO
	 43vAxMvzW/GZF4KdoJZqN5ake4orLKwtu1DOWUY8s/x8DsCQEuR+oatwWCgduL89mJ
	 PqZ8DRAlFGk8PUpz8xPHA506zROenh8ZEqs53H1PFh6gBZshY8HKe9OINtWDIFkcnU
	 60+nJZaPMfUhayfDCnfsiKbdBoKYeRUVBwjPNVpuQGQ5rtZHcWYewX/xllzwP2DqYK
	 B0z7PC1APusj7hIPpXMhiLSXAWSU/yZjVJcczzQFktUj7mlLVR9WP2B5vTbTjf0fqT
	 FI9+sJfMXl7qQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 2/4] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261006061619.2005967-3-vi@endrift.com>
References: <20261006061619.2005967-1-vi@endrift.com>
 <20261006061619.2005967-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 06:30:01 +0000
Message-Id: <20261006063001.EEE2C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: nintendo: Use-after-free of ns2 in rumble_work due to missing=
 sync cancel
- [High] hid: nintendo: Workqueue list corruption due to rumble_work re-ini=
tialization
--

commit a197b51ef6afbdd0338765f77b38c7488b6d41fe
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add rumble support for Switch 2 controllers

This commit adds basic rumble support for Switch 2 controllers,
simulating standard force feedback using the HD Rumble actuators.
It introduces a delayed work item to manage rumble state updates.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index c31ded267be76..c49ca95753206 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -3374,6 +3550,26 @@ static int switch2_init_input(struct switch2_contr=
oller *ns2)
>  		return -EINVAL;
>  	}
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	ns2->rumble_buffer =3D devm_kzalloc(&input->dev, 64, GFP_KERNEL);
> +	if (!ns2->rumble_buffer) {
> +		input_free_device(input);
> +		return -ENOMEM;
> +	}
> +	ret =3D devm_delayed_work_autocancel(&input->dev, &ns2->rumble_work, sw=
itch2_rumble_work);

[Severity: High]
Can this lead to a use-after-free of the ns2 structure?

The devm_delayed_work_autocancel() helper binds the work cancellation to
the input device's devres group. If a userspace process holds the input
device open when the physical device is unplugged, the devres execution is
delayed until the file descriptor is closed. However, the driver's remove
function frees the ns2 controller structure synchronously via kref_put()
without waiting for the devres cleanup. If the delayed work is pending,
it will execute and access the freed ns2 structure in switch2_rumble_work().

[Severity: High]
Does this code corrupt the workqueue list if initialization is retried?

In switch2_init_input(), the input device is registered and exposed to
userspace. If a subsequent initialization step fails, such as the LED
registration, the error path unregisters the device. If userspace opens
the device and triggers a rumble effect before unregistration completes,
ns2->rumble_work is queued.

The state machine then retries switch2_init_controller(), which calls
switch2_init_input() again. This allocates a new input device and calls
devm_delayed_work_autocancel() on the exact same &ns2->rumble_work. This
unconditionally calls INIT_DELAYED_WORK() on an already-queued work item,
which overwrites its list pointers and corrupts the workqueue list.

> +	if (ret < 0) {
> +		input_free_device(input);
> +		return ret;
> +	}
> +
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +	ret =3D input_ff_create_memless(input, NULL, switch2_play_effect);
> +	if (ret) {
> +		input_free_device(input);
> +		return ret;
> +	}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006061619.2005=
967-1-vi@endrift.com?part=3D2
