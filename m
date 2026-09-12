Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F252D2BCF4C
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183374; cv=none; b=DVYfh+QFgnegSvUEtnJ0rhZGqBlZ2EMqB9QPEie88gGkzf9lTMKZ1m1lsVXt8dz9SdrgbGmHuZ3ltaLbtSZBiUudbeYHFmhLnKOjjWQTH/nEULQstUFI0FRgthBcmHuSEQRZe32a/N+Xa1txxCcaIxyT6khhUCqsjxq3DQ/7h2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183374; c=relaxed/simple;
	bh=T269Rs0aaTUWFI+MmHAvPOIcMacB+m8A7wsiwu+/LAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BNxpSmBGxxYdZhDRzNkRSMX9dO8oAELE2UrYTKtoIcK1mohTS02+tAQ5rwXz6YuaN11F5THheWYHKeyhMZnENTYxfV2DMUCSKM9s7iSGqB7/Me9ht+UtjeDp+tCNKVLmQgBDU5CzbtRcYhCKqx+MhFTkij/oc1Htm9wkFZ9z6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeRXBgRI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeRXBgRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A335C1F00893;
	Sat, 12 Sep 2026 03:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183372;
	bh=iFqphlTi25xZMGcQV2M0TyOx6s/70qsSZfBQIQAaYYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EeRXBgRIiAQTsEcSZHoOBGb9xxL+dOygojod3CKNECStmfyFDmURWhkK64u6PB7QM
	 N37Ca7UkdCYV4dkeown2dJwSM8Nci8K4OTvKOVIL45Xe8HQBV8B5xgDuN3dbq4YwKW
	 N4vmXsu7n/a+MN/FJptn3fC6qXKCZtm4zrbU2lUZ1BhzO5TV46187ckBS2wSjZmZbp
	 YAir7OgWqRo3Xlk0uaPWLGHM5LguAzb+qtrUF+/DeGlgSkm0bMvHv5UspixpgRiJAt
	 HlW9+L62HzGzxyW9DJICBTzZGSlCGlqLtO445pr5KPbDNpTsfjb1XkhwO9UisMFaKm
	 lV0AzHC5zh/Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/12] Input: xbox_gip - Add battery support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912030426.2997003-6-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:22:52 +0000
Message-Id: <20260912032252.A335C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] The devm-managed power supply is tied to the `input_dev`'s lif=
ecycle instead of the physical device, leading to a Use-After-Free of `atta=
chment` when sysfs properties are read after unplug.
- [High] Memory and device leak of the power supply across metadata resets =
due to a devres mismatch when unregistering the input device.
- [High] Data race and potential Use-After-Free on `attachment->battery` du=
ring concurrent device status URB processing and device teardown.

Pre-existing issues:
- [Critical] Use-after-free of `gip_device` and `gip_attachment` due to inc=
orrect teardown order of the URB and workqueue in `gip_disconnect`.
--

commit e93493b8a8fc4d66dfb37174e70166cba8bd408c
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add battery support

Controllers are required to give information about the battery in the
controller, if present. This patch exposes that information as a
power_supply device.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 411b67399e018..92bfdd6d76826 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -1218,6 +1225,97 @@ static int gip_guide_led_probe(struct gip_attachme=
nt *attachment, struct device
[ ... ]
> +static int gip_battery_create(struct gip_attachment *attachment, struct =
device *dev)
> +{
> +	struct power_supply_config supply_config =3D { .drv_data =3D attachment=
, };
> +	int rc;
> +
> +	attachment->battery_desc.properties =3D gip_battery_props;
> +	attachment->battery_desc.num_properties =3D ARRAY_SIZE(gip_battery_prop=
s);
> +	attachment->battery_desc.get_property =3D gip_battery_get_property;
> +	attachment->battery_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
> +	attachment->battery_desc.name =3D devm_kasprintf(dev, GFP_KERNEL, "gip-=
%s", dev_name(dev));
> +
> +	if (!attachment->battery_desc.name)
> +		return -ENOMEM;
> +
> +	attachment->battery =3D devm_power_supply_register(dev,
> +		&attachment->battery_desc, &supply_config);

[Severity: Critical]
Does this tie the power supply's devres lifecycle to the child input_dev=20
rather than the parent attachment?

If dev is &input->dev, the power supply will outlive the attachment=20
structure if a user unplugs the device while keeping the input device open.=
=20

Since attachment is explicitly freed on disconnect, couldn't this lead to=20
a use-after-free when the user subsequently reads sysfs properties (via=20
gip_battery_get_property) which dereferences the freed attachment?

> +	if (IS_ERR(attachment->battery)) {
> +		rc =3D PTR_ERR(attachment->battery);
> +		attachment->battery =3D NULL;
> +		devm_kfree(dev, attachment->battery_desc.name);
> +		return rc;
> +	}
> +
> +	power_supply_powers(attachment->battery, dev);
> +	return 0;
> +}
[ ... ]
> @@ -1514,6 +1615,8 @@ static void gip_free_devices(struct gip_attachment =
*attachment)
> =20
>  	rcu_assign_pointer(attachment->input, NULL);
>  	rcu_assign_pointer(attachment->hdev, NULL);
> +	/* The following are freed by devres */
> +	attachment->battery =3D NULL;
>  	synchronize_rcu();
> =20
>  	if (input)

[Severity: High]
Does this code assume devres will immediately free the battery upon
calling input_unregister_device()?

Because the devres lifecycle of input_dev depends on its parent (the USB
interface), its refcount doesn't drop to zero until the USB interface=20
unbinds.=20

If a device sends repeated reset requests that invoke gip_free_devices(),
could this leak power_supply devices and their sysfs entries indefinitely
across metadata resets?

> @@ -1647,10 +1750,14 @@ static int gip_handle_command_status_device(struc=
t gip_attachment *attachment,
>  	if (num_bytes < 1)
>  		return -EINVAL;
> =20
> -	attachment->status.base.battery_level =3D bytes[0] & 3;
> -	attachment->status.base.battery_type =3D (bytes[0] >> 2) & 3;
> -	attachment->status.base.charge =3D (bytes[0] >> 4) & 3;
> -	attachment->status.base.power_level =3D (bytes[0] >> 6) & 3;
> +	scoped_guard(spinlock_irqsave, &attachment->battery_lock) {
> +		attachment->status.base.battery_level =3D bytes[0] & 3;
> +		attachment->status.base.battery_type =3D (bytes[0] >> 2) & 3;
> +		attachment->status.base.charge =3D (bytes[0] >> 4) & 3;
> +		attachment->status.base.power_level =3D (bytes[0] >> 6) & 3;
> +	}
> +	if (attachment->battery)
> +		power_supply_changed(attachment->battery);

[Severity: High]
Is it safe to access attachment->battery here without RCU read-side=20
protection or READ_ONCE()?

Since gip_handle_command_status_device() executes concurrently with=20
device teardown, gip_free_devices() might concurrently clear the pointer=20
(attachment->battery =3D NULL) and call synchronize_rcu().=20

Without rcu_read_lock() held here, synchronize_rcu() will not wait,
potentially allowing the battery pointer to be freed underneath this reader,
leading to a use-after-free.

[Severity: Critical]
This is a pre-existing issue, but can a use-after-free of gip_device and
gip_attachment happen due to an incorrect teardown order in gip_disconnect(=
)?

Looking at gip_disconnect(), it calls gip_shutdown() which cancels the
receive_message workqueue. However, the URB that re-queues this work is=20
not killed until gip_deinit_input() runs later.

Could this open a race window where an interrupt packet arrives just after=
=20
cancel_work_sync(&gip->receive_message), allowing gip_urb_in() to=20
reschedule the work?=20

The device structures would then be freed by devm_kfree() at the end of
disconnect, and the newly scheduled work would dereference freed memory
when it executes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D5
