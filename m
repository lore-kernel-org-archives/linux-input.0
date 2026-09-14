Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF43B0AED
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428612; cv=none; b=oZ4Kzu6vvkQsL/gQ7yMDBjkEvhQ1YKDhEE8Sw1tttpv9c6SJkaSQZfw7djSkiWfNg0wdzLT9YhYJ7p7FBhLjYxb/F20FsvlDsaUCnyGEcAL1lrDJv79sfJbq2ggU/lahq2fuRpin/UKqwowg7mAjMoJTLb0RZlG9iRzSUL3ySQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428612; c=relaxed/simple;
	bh=4Vy3637FCfbUu+g+w9XYMiTJXS5MKoH0FvQ60q8bZsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YdZlZ0oGOooZ/AHVWzsWhlcZse3A73lJ0JVO1E9F7AqWRVUOhiugZxByQf51+0e4oNHuUUgjfy0i7oqGLt+krn/KfvAmd38QukvtXk/nGFG4muL7jvvk7O3sIZblYZa10Mc6e+2tY+v/8TewejtXFRmWQpElQMoY+0SlPLy5Lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/CKgikB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/CKgikB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C81F000FF;
	Mon, 14 Sep 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428610;
	bh=0P+2UDjTIaH5M8xUnn0zse3u0TmLDj4e4LDzescRrfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T/CKgikBLfpaRtR9vhqHhnZmpObkIZbUUESZ7tL/NNVGg4qZUMHhkWCGqjANoPmGd
	 MM1JDRDFD3/CFkcew/f9PpWUEUvyhtXTHfYIXpxk3Hmn1vw1emUDs8MvgPcjiaiHVh
	 sEraERB8N994ixgK4HgLDOs41TZHzIUQluI7CcTIwTgExqKyE0zgH6JjNC15t9u2xS
	 S1ykuiNfCPQzWxX7Fm16/gcgwe3P2TTymI8eC9ig2Ys9eCM60fF9ItpXAMFnwNMKwX
	 NXRAAglktZKE6Uy5QXWL1L49EDROBTHtXik9mowY+JfcFH/eWC5kACc8y2zGzjV2lz
	 NbId59WEZM5mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] HID: hid-lenovo-go-s: Move attribute init to
 after device query
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260914225303.868569-8-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
 <20260914225303.868569-8-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 23:30:10 +0000
Message-Id: <20260914233010.8D7C81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hid: hid-lenovo-go-s: double register of LED device corrupts leds_=
list
- [High] hid: hid-lenovo-go-s: permanently disabled workqueue breaks resume
- [Medium] sysfs: hid-lenovo-go-s: attributes return -ENODEV immediately af=
ter creation
--

commit 71c67b9719643790013b558cabadd6b89996f3ca
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-lenovo-go-s: Move attribute init to after device query

Currently this driver registers attributes before the MCU is ready to
accept commands, which can lead to attribute access that blocks the MCU
in some rare cases. Move attribute construction to gos_cfg_setup, after
the device has been queried.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 6d98fff6d987e..f1a0bcfcdb71a 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c
[ ... ]
> @@ -1497,10 +1498,53 @@ static void cfg_setup(struct work_struct *work)
>  		return;
>  	}
> =20
> +	/* Pairs with smp_store_release from below */
> +	gp_registered =3D smp_load_acquire(&drvdata.gp_registered);
> +	if (gp_registered)
> +		goto try_rgb;
> +
> +	ret =3D sysfs_create_groups(&drvdata.hdev->dev.kobj, top_level_attr_gro=
ups);
> +	if (ret) {
> +		dev_err(&drvdata.hdev->dev,
> +			"Failed to create gamepad configuration attributes: %i\n", ret);
> +		goto try_rgb;
> +	}
> +
>  	/* Pairs with smp_load_acquire in attribute show/store functions */
>  	smp_store_release(&drvdata.gp_registered, true);

[Severity: Medium]
After sysfs_create_groups() exposes the attributes to userspace, could a
fast userspace process read them and invoke gamepad_property_show() before
smp_store_release(&drvdata.gp_registered, true) executes?

If so, would this cause spurious -ENODEV errors for userspace, violating
the requirement that all private data needed by userspace callbacks must be
complete before publishing the interface?

> +	gp_registered =3D true;
> +
> +try_rgb:
> +	/* Pairs with smp_store_release from below */
> +	rgb_registered =3D smp_load_acquire(&drvdata.rgb_registered);
> +	if (rgb_registered)
> +		goto update_kobjects;
> +
> +	ret =3D devm_led_classdev_multicolor_register(&drvdata.hdev->dev, &gos_=
cdev_rgb);
> +	if (ret) {
> +		dev_err(&drvdata.hdev->dev,
> +			"Failed to create RGB device: %i\n", ret);
> +		goto update_kobjects;
> +	}
> +
> +	ret =3D devm_device_add_group(gos_cdev_rgb.led_cdev.dev, &rgb_attr_grou=
p);
> +	if (ret) {
> +		dev_err(&drvdata.hdev->dev,
> +			"Failed to create RGB configuration attributes: %i\n", ret);
> +		goto update_kobjects;
> +	}

[Severity: High]
If devm_device_add_group() fails, cfg_setup() jumps to update_kobjects with=
out
setting rgb_registered =3D true, and without unregistering the LED device
successfully created by devm_led_classdev_multicolor_register().

If a USB reset occurs, hid_gos_cfg_reset_resume() sees !rgb_registered and
reschedules cfg_setup(). When it runs again, it will call
devm_led_classdev_multicolor_register() on gos_cdev_rgb which is already
actively registered.

Does this execute list_add_tail() on a node already in the subsystem list,
corrupting it?

> +
> +	drvdata.led_cdev =3D &gos_cdev_rgb.led_cdev;
> +
>  	/* Pairs with smp_load_acquire in attribute show/store functions */
>  	smp_store_release(&drvdata.rgb_registered, true);
> +	rgb_registered =3D true;
> +
> +update_kobjects:
> +	if (gp_registered)
> +		kobject_uevent(&drvdata.hdev->dev.kobj, KOBJ_CHANGE);
> +	if (rgb_registered)
> +		kobject_uevent(&drvdata.led_cdev->dev->kobj, KOBJ_CHANGE);
>  }

[Severity: High]
The commit message mentions that a resume before setup has run shouldn't
prevent attribute creation. However, can the device fail to resume and
become unusable after a suspend/resume cycle?

If the system suspends, hid_gos_cfg_suspend() permanently disables the work
item:

hid_gos_cfg_suspend() {
    disable_delayed_work_sync(&drvdata.gos_cfg_setup);
    ...
}

When the system wakes, if cfg_setup() hadn't finished (e.g. within the 2ms
delay) or failed, hid_gos_cfg_reset_resume() will retry scheduling the work:

hid_gos_cfg_reset_resume() {
    ...
    if (!gp_registered || !rgb_registered) {
        ret =3D schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiff=
ies(2));
        if (!ret) {
            dev_err(&hdev->dev, "Failed to schedule startup delayed work\n"=
);
            return -ENODEV;
        }
        return 0;
    }
    ...
}

Because the work is permanently disabled and never re-enabled with
enable_delayed_work(), schedule_delayed_work() will return 0. Will this
cause hid_gos_cfg_reset_resume() to return -ENODEV, failing the resume
sequence entirely?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914225303.8685=
69-1-derekjohn.clark@gmail.com?part=3D7
