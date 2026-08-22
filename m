Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BC127A91D
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366299; cv=none; b=p7BVQRqL0wrnQYFODhCFjsjV3KA63Kiy8fZrzPzmvFQFGnUI+bV5rE9Y8xRZ8uEX9Y5AAuuUnTn/oRTSX45sejqxEABbI6X3gQBuYfJ7+6Q6ERB73/kDCGxOb/cUymh/Bu2BjJ5eO94mkzgxsOUPP0snROBrUJV2oas/+Kmfqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366299; c=relaxed/simple;
	bh=cVSxYpapg5iwvXC45vYYvoGTi1m1Ox+BTkX+vYgCHsY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F6jSvqCuLt20pheR74fp/U3pO7Pj4H6Nrd0DRf9dHlHhsBR+iYLUI8mpsphvCVWRPq9RbrZFfKc362zwkAL5qIgpSTzcgxfduBTUJ0ivgW4ac2kMxFCWUfOZtGcM98b61A5VUlisPE3rXWYv71y0sGj3/34jIyUG29RPnTQuNbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5y2Z5Wq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5y2Z5Wq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863FB1F00A3A;
	Sat, 22 Aug 2026 02:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366297;
	bh=zH/KnYUbepQyluM1tS2xcqUisjs6NyKIQbRYe85GU/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B5y2Z5Wq46hPWI7w5AF24FlgY2JdTfI5UC35AUzaOUEp59JEfAl4Qvu8pztZInZNS
	 9Z8ir/ldXmLkVSPDpoJqSW5CalBvHlU7DDLB+j14o1/IK4P7cr7souuJvsU9EtTeVA
	 PvacOdQ9mLRFjg6J8o9HkTJI032GPnpnT4ZfNq1n9y+xYWu81CURm99qadSuPo3syK
	 NexURVhncUMQYk0s2rYRcWhlTwNOKeN3C8D/Xm7yeQWYKbeCKy8n7neSON0tVkbJSb
	 3N3YM+087WNYSH8dU+dv26cr77HVR7dAU2NObUoF3UNQRRoKZA9RGDWKziFE7wU9eh
	 8Rw6G4wAnOVxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/12] Input: xbox_gip - Add battery support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260822021140.1149546-6-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-6-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:38:17 +0000
Message-Id: <20260822023817.863FB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free of `attachment` via battery sysfs properties due to=
 devres lifecycle mismatch.
- [Medium] Missing `power_supply_changed()` call prevents userspace from re=
ceiving battery state updates.
- [Low] Data Race on battery status fields causes torn reads in sysfs.

Pre-existing issues:
- [High] Use-After-Free of `attachment` via LED sysfs properties due to dev=
res lifecycle mismatch.
- [High] Dangling `attachment->input` pointer on `input_register_device` fa=
ilure causes Use-After-Free.
- [High] AB-BA Deadlock between `gip_shutdown` and `gip_fragment_timeout`.
- [High] Out-of-Bounds Read in `gip_receive_fragment` due to missing bounds=
 check.
--

--- Patch [5]: [PATCH v4 05/12] Input: xbox_gip - Add battery support ---
commit 467fca5f8d0f00e2e7affd3b50a79e158dfc1b7d
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add battery support
   =20
Controllers are required to give information about the battery in the
controller, if present. This patch exposes that information as a
power_supply device.
   =20
Signed-off-by: Vicki Pfau <vi@endrift.com>

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index c833b10259ab8..d694ac5516395 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c
[ ... ]
> @@ -1196,6 +1203,92 @@ static int gip_guide_led_probe(struct gip_attachme=
nt *attachment, struct device
>  	return rc;
>  }
> =20
> +static int gip_battery_get_property(struct power_supply *psy,
> +	enum power_supply_property psp, union power_supply_propval *val)
> +{
> +	struct gip_attachment *attachment =3D power_supply_get_drvdata(psy);
> +
> +	guard(mutex)(&attachment->lock);

[Severity: Low]
Does taking this mutex fully protect the battery status fields?

Looking at gip_handle_command_status_device(), the fields are updated
directly without acquiring attachment->lock:

gip_handle_command_status_device()
	attachment->status.base.battery_level =3D bytes[0] & 3;
	attachment->status.base.battery_type =3D (bytes[0] >> 2) & 3;
	attachment->status.base.charge =3D (bytes[0] >> 4) & 3;
	attachment->status.base.power_level =3D (bytes[0] >> 6) & 3;

Could a concurrent sysfs read observe torn or partially updated state?

[Severity: Medium]
Also, when gip_handle_command_status_device() updates the battery state,
is a call to power_supply_changed(attachment->battery) needed?

Without it, will userspace applications be notified of the updated battery
state, or will they only see changes if they manually poll sysfs?

[ ... ]
> +static int gip_battery_create(struct gip_attachment *attachment, struct =
device *dev)
> +{
> +	struct power_supply_config supply_config =3D { .drv_data =3D attachment=
, };
> +
> +	attachment->battery_desc.properties =3D gip_battery_props;
[ ... ]
> +	attachment->battery =3D devm_power_supply_register(dev,
> +		&attachment->battery_desc, &supply_config);

[Severity: High]
Could this lead to a use-after-free when the device is disconnected?

The power supply is registered using devm with the input device as its
parent, so its release is deferred until the input device's reference
count drops to zero.

However, gip_disconnect() immediately frees the attachment structure:

gip_disconnect()
	devm_kfree(to_gip_device(attachment), attachment);

If a userspace process holds the input evdev node open, the power supply
sysfs node remains registered. Could a subsequent sysfs read trigger
gip_battery_get_property() and dereference the freed attachment structure?

> +	if (IS_ERR(attachment->battery))
> +		return PTR_ERR(attachment->battery);
> +
> +	return power_supply_powers(attachment->battery, dev);
> +}
[ ... ]
> @@ -1308,6 +1401,9 @@ static int gip_setup_input_device(struct gip_attach=
ment *attachment)
>  	rc =3D gip_guide_led_probe(attachment, &input->dev);

[Severity: High]
This isn't a bug introduced by this patch, but does gip_guide_led_probe()
have the same devm lifecycle mismatch as the battery creation?

The LEDs are registered using devm_led_classdev_multicolor_register()
with the input device as their parent.

Since gip_disconnect() frees the attachment structure manually, could writi=
ng
to the LED brightness sysfs node trigger callbacks that dereference the
freed attachment if userspace still holds the input device open?

[Severity: High]
This is also a pre-existing issue, but if gip_setup_input_device() fails,
is there a dangling pointer left behind?

The pointer is published before registration:

gip_setup_input_device()
	rcu_assign_pointer(attachment->input, input);
	rc =3D input_register_device(input);
	if (rc)
		goto err_free_device;

But the error path does not clear it:

err_free_device:
	input_free_device(input);
	return rc;

Could an incoming hardware event trigger gip_handle_ll_input_report()
and read the freed attachment->input pointer?

>  	if (rc)
>  		gip_err(attachment, "Failed to register LEDs: %d\n", rc);
> +	rc =3D gip_battery_create(attachment, &input->dev);
> +	if (rc)
> +		gip_err(attachment, "Failed to register battery: %d\n", rc);
> =20
>  	return 0;
[ ... ]
> @@ -2623,6 +2719,7 @@ static int gip_shutdown(struct gip_device *device)
>  			hdev =3D rcu_dereference(attachment->hdev);
>  			rcu_read_unlock();
> =20
> +			attachment->battery =3D NULL;

[Severity: High]
This isn't a bug introduced by this patch, but can gip_shutdown() deadlock
with gip_fragment_timeout()?

In gip_shutdown(), the lock is acquired before cancelling the work:

gip_shutdown()
	scoped_guard (mutex, &attachment->lock) {
		cancel_delayed_work_sync(&attachment->metadata_next);
		cancel_delayed_work_sync(&attachment->in_fragment_timeout);

If gip_fragment_timeout() runs concurrently, it attempts to acquire the
same mutex:

gip_fragment_timeout()
	guard(mutex)(&attachment->lock);

Could cancel_delayed_work_sync() block waiting for the work to finish,
while the work blocks waiting for the mutex?

>  			rcu_assign_pointer(attachment->input, NULL);
>  			rcu_assign_pointer(attachment->hdev, NULL);
>  			synchronize_rcu();

[Severity: High]
This is a pre-existing issue, but does gip_receive_fragment() have an
out-of-bounds read when processing fragments?

When parsing a non-initial message fragment, it uses header->length directly
in memcpy():

gip_receive_fragment()
	if (header->length !=3D 0)
		memcpy(&attachment->in_fragment_data[*fragment_offset],
			&bytes[offset], header->length);

Is there a check to ensure that offset + header->length does not exceed
the actual size of the received USB buffer? Could a malicious USB device
sending a fragmented message with an artificially large length cause an
out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D5
