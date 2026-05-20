Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D6E3F1661
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299043; cv=none; b=re+0GaJIxfFvc7y5jeXePbSoT98Ga2EO1FITGtCYxivtHqeh2FRHD9qT1wgH5otq3Vs+slCBpU0hv2KDMwGb2leaDKNOOy4L8zBlE69hXAmk3U0cgi52fuhJyFW5CWArxonpa1eFOaMT6TVoiAD6f0Ygvezcum3z8t3NI7vMvQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299043; c=relaxed/simple;
	bh=+yNv5WqZ4B4ITHMNKlUFaHWLVlgHpZ1Zv3IJFxI4GSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ch+PXTeyggwxlhhqlFN+05gn7OuYyrNel5/ejXQn2u5U70yt1HcNikbM5K2pJHRUhiwWFoE844abJ+pct8i2/7kRvsV6Py/Udb89XxDKYiw5EJtYkPLkssuRjBpnEq2Kg3bE9U5eEVjnGBSGbRkzPKjueBBBYcmW1Au7yhV3QbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5/wMuA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5/wMuA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE571F00893;
	Wed, 20 May 2026 17:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779299042;
	bh=uZvvxxPt3zudQNobh+WvNMA5bNl8u2VARJG/Ue4g2CE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z5/wMuA6T0T0HpwcdnrrfA633Pu3ZoxUl6lMiJTe6lgDYBWR1VzzZKLxS5ELPpk7a
	 rkZZDu6vgMv5XEkjrlUcbxexHyTOX4vITejzVOuf0gkL8v/B7mFEcfaeUTPNA4PSnn
	 N3FdFRjJdIpN9pAmArdRbfAPS0slgng5X/ZSCFeogBw3GLgR46peH+W/UiZNZ9QGUM
	 OcgtAzwLiCTKE7/KRL10VbYJS0MoNPj9InOR8fMSWefqMNIc2ei3M7w9CCbCtC/dHK
	 CL7qmb7I4o8NtHjUnuSP6olj0oNChnw/egnhA6Bcdc7ro5L1VSYTsYG3rvPN5rVN5D
	 wSfsUESYoTAYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 2/2] HID: cp2112: Configure I2C bus speed from
 firmware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Kaehn" <danny.kaehn@plexus.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520-cp2112-dt-v14-2-b1b4b6734b6f@plexus.com>
References: <20260520-cp2112-dt-v14-2-b1b4b6734b6f@plexus.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 17:44:01 +0000
Message-Id: <20260520174401.BDE571F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The driver silently overwrites custom hardware I2C clock speeds =
with a 100kHz default for devices without firmware nodes.

Pre-existing issues:
- [High] Firmware nodes are attached to device structures without holding a=
 reference, leading to a dangling pointer and use-after-free.
- [High] The delayed work `gpio_poll_worker` is not canceled in the probe e=
rror path, leading to a use-after-free if the probe fails.
--

commit 07ff467e4d8df706a7a27476591cd82570fb8287
Author: Danny Kaehn <danny.kaehn@plexus.com>

    HID: cp2112: Configure I2C bus speed from firmware
   =20
    Now that the I2C adapter on the CP2112 can have an associated firmware
    node, set the bus speed based on firmware configuration.

> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index e960fc988058f..04379db93571b 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
[ ... ]
> @@ -1308,6 +1309,9 @@ static int cp2112_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  		goto err_power_normal;
>  	}
> =20
> +	i2c_parse_fw_timings(&dev->adap.dev, &timings, true);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does this new call dereferen=
ce
a dangling pointer?

Earlier in cp2112_probe(), the reference to the child firmware node is
dropped either explicitly via fwnode_handle_put(child) in the OF path, or
implicitly when the fwnode_for_each_child_node loop iterates or completes
in the ACPI path:

	} else if (is_of_node(cp2112_fwnode)) {
		child =3D fwnode_get_named_child_node(cp2112_fwnode, "i2c");
		device_set_node(&dev->adap.dev, child);
		fwnode_handle_put(child);
	}

device_set_node(&dev->adap.dev, child) assigns the pointer without taking
its own reference, leaving dev->adap.dev.fwnode as a dangling pointer.

This newly added i2c_parse_fw_timings() call dereferences this released
fwnode via device_property_read_u32().

Could this lead to a use-after-free?

> +	config.clock_speed =3D cpu_to_be32(timings.bus_freq_hz);

[Severity: Medium]
Since use_defaults is set to true, does this overwrite custom hardware I2C
clock speeds with a 100kHz default for devices without firmware nodes?

Before this patch, it looks like cp2112_probe() read the current SMBus
configuration from the device, only modified retry_time, and wrote it back.
This preserved the device's original configured clock speed (which might be
set to 400kHz in the EEPROM).

By calling i2c_parse_fw_timings() with an uninitialized local timings
struct and use_defaults =3D true, timings.bus_freq_hz will be
unconditionally set to 100kHz if the device lacks a firmware property.

Is it intended to silently downgrade the speed and override user-configured
EEPROM settings?

[Severity: High]
This is a pre-existing issue, but is there a missing cancellation of the
delayed work in the probe error path?

If sysfs_create_group() fails during probe, the code jumps to the
err_gpiochip_remove label, which calls gpiochip_remove(&dev->gc) and
returns:

	ret =3D sysfs_create_group(&hdev->dev.kobj, &cp2112_attr_group);
	if (ret < 0) {
		...
		goto err_gpiochip_remove;
	}
	...
err_gpiochip_remove:
	gpiochip_remove(&dev->gc);
err_free_i2c:

Because gpiochip_add_data() was already called, an IRQ consumer could have
concurrently requested a GPIO line, triggering cp2112_gpio_irq_startup()
and queuing dev->gpio_poll_worker.

Unlike cp2112_remove(), the error path lacks a call to
cancel_delayed_work_sync(&dev->gpio_poll_worker).

Could this mean the queued work will execute on freed memory?

>  	config.retry_time =3D cpu_to_be16(1);
> =20
>  	ret =3D cp2112_hid_output(hdev, (u8 *)&config, sizeof(config),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-cp2112-dt-=
v14-0-b1b4b6734b6f@plexus.com?part=3D2
