Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED432DB79F
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838740; cv=none; b=ihA4UJzguLML+whiLAU7r3rELE7k8qjGpQtcmF8pWSq1rL0cV7vzZBPPVLOKQRiQ/g/n8sfvjlhrxF/9x0Y00YZjVUvlpFAjelrdh7FxvbXQ3YcDu5P0x0wgbrGgbh75B0Xz8M6yl0japyy/vGjMMVvNVqFvUyE9Gztq/hvcX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838740; c=relaxed/simple;
	bh=H8CVpUJfKKAjeWMJkNrbnJMu83Q2iUYikflpLBMV9Ao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pNm11xw7OAngOVs2BzRXPaIdOjIWdL2/WQ6F19PZaRjYtWS7DECG2pJaOoJ6kMczwrvObdZn5QLLPKxdCn0JwVmPRp3zggyWRu2Xi5bWZcjVg6+wRg+VfIGM1NdvBEzNayW75mXkbuU9RAH/0OYXPe8H7x2EWXEDe0FqFVPN7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewJATe6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewJATe6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D41F00A3A;
	Tue,  8 Sep 2026 03:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788838710;
	bh=YAA9gLhuaiw5cOt5qwU4OAkZlL9X/bJajQFk5/f0aTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewJATe6FPEc8XU/9B/l+2XV7wHb8aMRs5i/vHvG3JbSv3Gfhg26m8IpKtaiW8YjNW
	 7lEaOcH9hxOH6ERZsGjbCNe9X7r3alLmgqluyxCl8Jbg0eK6QfDHnO2jUF3S93poTg
	 LNnaapub6nPN3Ij9775QedHoNfAJWRDOrMVOQW1DTlGWa869WXDG+GQB0fBKyiZpnf
	 A0BdC5r+vPt23gcPKzM6GPCSV9+/3K4a9uNSRpNpAijNU17iEaRgTW3YdUJLmovcPb
	 Poc2HojXgIjupKyM9OW0FjXBou6zBCuzQVnpsm8MPNFeVmgKdfezH8KDWa+igLmzZQ
	 r7LK5sIAYUdXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/12] Input: xbox_gip - Add battery support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-6-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:38:29 +0000
Message-Id: <20260908033830.6E1D41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Attaching power_supply devres to the input_dev creates a Use-After=
-Free due to lifecycle mismatch.

Pre-existing issues:
- [High] Preexisting Use-After-Free in LED registration due to lifecycle mi=
smatch with input_dev.
- [High] Improper cleanup ordering in gip_disconnect allows receive_message=
 work to run after structures are freed.
--

commit fc70d38900f23e7e70d19f7c2913e3ee24cac40d
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add battery support

Controllers are required to give information about the battery in the
controller, if present. This patch exposes that information as a
power_supply device.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index dc174560ee49f..568877a4ce4b4 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -1206,6 +1213,97 @@ static int gip_guide_led_probe(struct gip_attachme=
nt *attachment, struct device
>  	return rc;
>  }
> =20
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

[Severity: High]
Does registering the power supply against the refcounted input_dev create a
use-after-free risk?

Because input_dev is refcounted (e.g. via evdev), its destruction can be
delayed by a user holding an open file descriptor. However, the attachment
structure (passed as driver data) is freed synchronously upon device
disconnect.

If the device is unplugged, attachment is freed, but the power supply remai=
ns
registered until input_dev is closed. Reading the battery sysfs files during
this window will dereference the freed attachment.

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
> @@ -1319,6 +1417,9 @@ static int gip_setup_input_device(struct gip_attach=
ment *attachment)
>  	rc =3D gip_guide_led_probe(attachment, &input->dev);

[Severity: High]
This is a pre-existing issue, but does registering the LED devices against
input->dev create a similar use-after-free risk?

In gip_guide_led_probe() in drivers/input/joystick/gip/gip-core.c,
devm_led_classdev_register() (and the multicolor variant) use input->dev as
the devres parent. Like the battery, the LED class devices will remain
registered as long as the input_dev exists.

Since the underlying attachment structure is freed upon unplug, this results
in a use-after-free when sysfs LED attributes are read or written after
disconnection.

>  	if (rc)
>  		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
> +	rc =3D gip_battery_create(attachment, &input->dev);
> +	if (rc)
> +		gip_err(attachment, "Failed to register battery: %d\n", rc);
> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but could the cleanup ordering in
gip_disconnect() allow the receive_message work to run after the gip struct=
ure
is freed?

gip_disconnect() in drivers/input/joystick/gip/gip-core.c calls gip_shutdow=
n()
(which does cancel_work_sync(&device->receive_message)) before it calls
usb_kill_urb(gip->data.urb_in):

drivers/input/joystick/gip/gip-core.c:gip_disconnect() {
    ...
    gip_shutdown(gip);
    ...
    usb_kill_urb(gip->data.urb_in);
    ...
}

If a USB completion interrupt arrives between cancel_work_sync() and
usb_kill_urb(), gip_urb_in() will execute with a success status and put the
work back on the queue:

drivers/input/joystick/gip/gip-core.c:gip_urb_in() {
    ...
    schedule_work(&gip->receive_message);
    ...
}

gip_disconnect() then frees the gip structure. When the workqueue runs, it
will dereference the freed gip pointer. Can we reverse the order to cancel =
the
work after killing the URBs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D5
