Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71F36404B
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741443; cv=none; b=EByPtf89MIjvhImrcaMbUv+tVE7VyJt0t8He7ok6gg9lYYV4I7W6w0Lv4anJeO/fznf4zObX86o7JfoviCH2dpYapsmutxFd73Pw6gTApVMYroz2fnPtzasqwGq7v7o7WCAVIngj4Tlp8Wi+QZRKnNYkpms2btenOZA3mcMyo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741443; c=relaxed/simple;
	bh=DBD1YHFGsO+bzNPNtVoHEkEPMXkahVwXs9hWhVcqX/w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=izIR9Uf9xrRW3vVr/RhWQaLO8TrBHNd/xLV9siupgKk26YX1VuW2oG3Wa+iOYyqsvbPI7BU8cp65lk4l0YDTijAOzUthVZLB0vNXr1dAD6Q/ot/mdIExiGBV5BQvyGqiasgWZHYynhW2h34gcrp0ExRWrg7rjR5o+OvXFb+ttec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjAA+T2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjAA+T2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F11AC2BCC7;
	Thu, 14 May 2026 06:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778741443;
	bh=DBD1YHFGsO+bzNPNtVoHEkEPMXkahVwXs9hWhVcqX/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bjAA+T2uHr6CfCSDYQKyJTmRH/Vy3sitYQEGd4lZO9G3R+lljiV9h3clfM/CYY93C
	 Xm12aDEuzUBnxJWM7iMgpl0qFSCcXhpS5ZUw9MjlaT3ASIXjqY7vzwsZwZaTWWUrjC
	 DWj+I0PMlwbTGHwo+ox+yChJMcxkrTPmuwo3zakQIsIg9JOS+E6g9FOlvmzPoED58k
	 C1TOWalVZ46JgjA1uVOaaDwKG+4VEwFg03G52UEEUNXE6+WvwcDFytazNFQPCuQyGD
	 e1SipzrzKJHYAOl6wTxdRfqbso7xgBxpk37F3qrMHgYKrkT+X1x4LB6JQDb6mxSn+I
	 h1fw0Dr60L26g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: Expose LattePanda IOTA UPS as a power_supply
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Maney" <andrewmaney05@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260513155723.230707-1-andrewmaney05@gmail.com>
References: <20260513155723.230707-1-andrewmaney05@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 06:50:42 +0000
Message-Id: <20260514065043.1F11AC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Kernel panic due to invalid type cast when transport is not USB (e=
.g. uhid).
- [High] Kernel panic from dereferencing an ERR_PTR in the raw event handle=
r.
- [High] Exposing fabricated 0 values for unsupported TIME_TO_EMPTY propert=
ies causes immediate system shutdown.
- [Medium] Hardcoded sysfs name prevents multiple devices and causes probe =
failure.
- [Medium] Data race on `ups->charge_limit`.
- [Low] Missing `POWER_SUPPLY` dependency in Kconfig causes build failures.
- [Low] Driver synchronously blocks the probe path for 3 seconds.
--

commit 7d140ce589ec6c637bec5ce8b0c27bf8634322c6
Author: Andrew Maney <andrewmaney05@gmail.com>
Subject: HID: Expose LattePanda IOTA UPS as a power_supply device

This commit adds a driver for the LattePanda IOTA UPS. It exposes battery
status, capacity, and charging status via the power_supply subsystem by par=
sing
custom HID reports.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -105,6 +105,16 @@ config HID_HAPTIC
> =20
>  menu "Special HID drivers"
> =20
> +config HID_LATTEPANDA_IOTA_UPS
> +	tristate "LattePanda IOTA UPS"
> +	depends on USB_HID && X86

If the kernel is configured with CONFIG_POWER_SUPPLY=3Dm and
CONFIG_HID_LATTEPANDA_IOTA_UPS=3Dy, will the built-in HID driver fail to li=
nk
against the modular power supply core? Should this include a dependency on
POWER_SUPPLY?

> diff --git a/drivers/hid/hid-lattepanda-iota-ups.c b/drivers/hid/hid-latt=
epanda-iota-ups.c
> --- /dev/null
> +++ b/drivers/hid/hid-lattepanda-iota-ups.c
[ ... ]
> +static enum power_supply_property iota_ups_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_SCOPE,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> +	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,

If the hardware doesn't support reporting time remaining, is it safe to
include these properties and return 0?=20

Returning 0 seconds remaining while discharging can signal to userspace pow=
er
daemons like UPower or systemd-logind that the battery is empty, which might
trigger an immediate emergency suspend or shutdown. Could these unsupported
properties be omitted from the array entirely?

[ ... ]
> +static int iota_ups_set_property(struct power_supply *supply,
> +				 enum power_supply_property psp,
> +				 const union power_supply_propval *val)
> +{
> +	struct iota_ups *ups =3D power_supply_get_drvdata(supply);
> +
> +	if (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD) {
> +		/*
> +		 * V1.0 supports 80% and 100% charge limits only, set via
> +		 * DIP switch on the board. This property allows userspace
> +		 * to inform the driver which limit is configured.
> +		 */
> +		if (val->intval !=3D 80 && val->intval !=3D 100)
> +			return -EINVAL;
> +		ups->charge_limit =3D val->intval;

Does this introduce a data race on ups->charge_limit?=20

This field is modified here without holding ups->lock, but it is concurrent=
ly
read in iota_ups_raw_event() and iota_ups_get_property() where it is
protected by spin_lock_irqsave(). Should this assignment also be
protected by the spinlock?

[ ... ]
> +static int iota_ups_raw_event(struct hid_device *hdev,
> +			      struct hid_report *report,
> +			      u8 *data, int size)
> +{
> +	struct iota_ups *ups =3D hid_get_drvdata(hdev);
[ ... ]
> +	/*
> +	 * Notify the power_supply core outside the spinlock. This
> +	 * triggers UPower's PropertiesChanged signal with the new values.
> +	 */
> +	if (changed && ups->psu)
> +		power_supply_changed(ups->psu);

Could ups->psu contain an error pointer here?

In iota_ups_probe(), if devm_power_supply_register() fails, it returns an
error pointer like ERR_PTR(-ENOMEM), which gets directly assigned to ups->p=
su.

Because hid_hw_start() is called earlier, raw HID events can be processed
concurrently before the hardware is stopped in the error path. Since an err=
or
pointer is not NULL, the check (changed && ups->psu) would pass, and
power_supply_changed() would be called with the error pointer, leading to a
crash.

Would it be safer to assign the return value of devm_power_supply_register()
to a local variable first, and only update ups->psu on success?

[ ... ]
> +static int iota_ups_probe(struct hid_device *hdev,
> +			  const struct hid_device_id *id)
> +{
[ ... ]
> +	/* Retrieve serial number from the USB descriptor */
> +	udev =3D to_usb_device(hdev->dev.parent->parent);
> +	if (udev->serial)
> +		strscpy(ups->serial, udev->serial, sizeof(ups->serial));

Can this cause a kernel panic if the HID device is instantiated via userspa=
ce
mock drivers like uhid?

When using uhid (which allows setting the bus type to BUS_USB), the parent
device is the uhid character device, not a usb_interface. Dereferencing the
resulting struct usb_device pointer would perform an out-of-bounds memory
read.

Should the driver verify the transport layer using hid_is_usb() before
dereferencing USB-specific structures, or simply use hdev->uniq instead?

[ ... ]
> +	/*
> +	 * Wait for both status and capacity reports before registering.
> +	 * The device sends reports every ~1 second; 3 seconds is safe.
> +	 */
> +	wait_for_completion_timeout(&ups->got_initial_data,
> +				    msecs_to_jiffies(3000));

Does blocking the probe path for 3 seconds cause issues for device
enumeration?=20

Calling wait_for_completion_timeout() synchronously stalls the kernel's
device enumeration thread for that bus, which can unnecessarily delay the
overall system boot process or stall the handling of other devices during
hotplug.

Could the registration be deferred, or could the device be registered
immediately with an unknown state instead of blocking?

> +
> +	ups->psu_desc.name			=3D "lattepanda-iota-ups";

Is it possible to have multiple of these UPS devices connected to a single
system?=20

If a second device is plugged in, it will attempt to register a sysfs
directory with the exact same hardcoded name, which fails with -EEXIST.

This probe failure would then trigger the error pointer panic mentioned
earlier. Should the driver dynamically construct a unique name using
devm_kasprintf() with dev_name(&hdev->dev)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513155723.2307=
07-1-andrewmaney05@gmail.com?part=3D1
