Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353239;
	b=IV/tGwQ4uSGzvwF272pQc9bisjtd7TdBXUvqYABJEqwUNDPZGKFh6W32g4TFAANP0ERU
	 Ut9KWW+yIay/2fOn1Bz9WcdXJaTUYIoulFx9y/zsxJZ97ry7FyI/ndmE+eP8OybPzG0JF
	 POGjzb0VOzhTYfXd1ibSWI0NSIkBo5WmaC34YksQLQnqgpRinU/Fp96A29eooX4xSm2FV
	 8mcTI98kj16tlDR61cYd8bpB9D+0A14WRD4ueSH6DnQvfXgAEy9mX0sTXAvY06gEgFlPk
	 KA4k/xeyddF2W6Z6cgFTfp2OLT0MY3eN/hl7mxJrB2O8jR2oG50m7OZbPAtOInygWSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P6CN+SBL+Q77XRqAOzhYlATAlo+wGAE4QhBFJzAmDtI=;
	b=PLW7DmfxSCiqmQhzODfST9jHXT7H5NeNzwlLuO0aZBd6PAkzMOi1HrxubMDRcomGeuS6
	 JG8/PKv6+u0fij0IpF0tiUzx9f52ijSH5nSWQzmMhDzTMY/P+WVWoLld8BZwA+gJGZZu8
	 4wvQABk4s2mxcMbJ3TBx/59cEtH1P2BaJ/pRDXw07k2KhyUa6flvddRV4om62H4BLNKmV
	 7XL3WGVaErwYL0r75BIwjv42yavjP7R9cASef5U+5uVMtWEQlTC5d8b/jZs8Sz+ugMeBf
	 POD1YlCw9SSqOJUHgdcpn3XZ4noSY/SZRfWP285I1MTa4kFsx1nqaeWXy5JNV1gUL8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=km2+3nKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF470606A321
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=km2+3nKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586691F0093C;
	Tue, 10 Nov 2026 23:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353238;
	bh=P6CN+SBL+Q77XRqAOzhYlATAlo+wGAE4QhBFJzAmDtI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=km2+3nKOTXo5d2S4RqVcqXQEKKh2UVRKXIRiOmHo3/Y/8TK5SRaNmVHO3MqAgzNA7
	 L/1TfWcozcdCTPGGcxGoqlT9jxFbpDWHB+Y5Kv9i3kc+cgYFcLIhw0h0tXdhwJt6fH
	 dVmnwTsO1BFThO3XZ90I/tJ1WuFcWs/WUdLGYe0aK1gj82WcIS4fnmhEnN0OuDnHNs
	 GSVd2epQ+U0LapSARGYo8x7KApGaZbIOfvshcjD2Rh1UBMX+clwVhLMOj5L7O2nDm8
	 LfXnnb8lHh25Y0GSdvXfTTv4/S9IjKclo2eyhClaiY/U95qrsFHt6lyhQVn40/sMT4
	 JQnoGGs+wy32g==
Message-ID: <sashiko-outbox-207904@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: corsair: cancel LED work again after unregistering
 the LED
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Claesson" <andreas@aclaesson.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-hid-corsair-k90-uaf-v1-1-0621c2c5c451@aclaesson.com>
References: <20261109-hid-corsair-k90-uaf-v1-1-0621c2c5c451@aclaesson.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 23:27:17 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] HID: corsair: use-after-free in k90_init_macro_functions()
  error path [1]
--

commit 3a201ad222c1beccee0e1120afae987d661371db
Author: Andreas Claesson <andreas@aclaesson.com>

HID: corsair: cancel LED work again after unregistering the LED

This commit adds a second cancel_work_sync() call after
led_classdev_unregister() in k90_cleanup_backlight() and
k90_cleanup_macro_functions() to cancel work re-queued when
led_classdev_unregister() turns the LED off.

> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 278c6efb565df..75c862f5f783f 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c

[ ... ]

> @@ -542,6 +544,8 @@ static void k90_cleanup_macro_functions(struct hid_de=
vice *dev)
>  		k90->record_led.removed =3D true;
>  		cancel_work_sync(&k90->record_led.work);
>  		led_classdev_unregister(&k90->record_led.cdev);
> +		/* unregister turns the LED off, which re-queues the work */
> +		cancel_work_sync(&k90->record_led.work);
>  		kfree(k90->record_led.cdev.name);
> =20
>  		kfree(k90);

[Severity: Medium]
This problem wasn't introduced by this patch, but can the fail_sysfs error
path in k90_init_macro_functions() still cause a use-after-free on
led->cdev.dev [1]?

drivers/hid/hid-corsair.c:k90_init_macro_functions() {
    ...
fail_sysfs:
	k90->record_led.removed =3D true;
	led_classdev_unregister(&k90->record_led.cdev);
	cancel_work_sync(&k90->record_led.work);
    ...
}

When sysfs_create_group() fails after led_classdev_register() has exposed
the record LED, fail_sysfs calls led_classdev_unregister() without calling
cancel_work_sync() first:

CPU0                              CPU1
k90_init_macro_functions()
  led_classdev_register(...)
                                  k90_brightness_set()
                                    schedule_work(&led->work)
                                  k90_record_led_work()
                                    if (led->removed)
  sysfs_create_group(...)
  k90->record_led.removed =3D true;
  led_classdev_unregister(...)
                                    led->cdev.dev->parent
                                      <-- use-after-free
  cancel_work_sync(...)

Calling cancel_work_sync(&k90->record_led.work) before
led_classdev_unregister() in fail_sysfs as well would match
k90_cleanup_macro_functions().

[1] https://sashiko.dev/#/bug/linux-2f786541-d064-428e-a1ab-d203d4112002

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-hid-corsai=
r-k90-uaf-v1-1-0621c2c5c451@aclaesson.com?part=3D1
