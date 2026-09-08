Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86029326D44
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788839134; cv=none; b=UdJJLs77I+c36VpUHERgqwvrkfsSTZ6gvMQaVo4+iawKbaZ9VbVc71OssVEg6ha9KDD8YioAKiuMRDeTq7P8h9/Xj9bPnpp01pEIOtRDBfTODmeEm5KvvawZ0kb722wdXBdL3yhnFj56Fd47CGyhXFZVY/E0I9/pQoX+VFEPi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788839134; c=relaxed/simple;
	bh=/cuxtsDWqnTDIA020oB8WBhti0eVxKO39MdbUrdMC2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=icfdPg7AwjuGeXLgMlNQdwf47hAkwCu8FN4eVTuwdfWjmDiquNSH/CU/ZQ9ni3H83CGPxJJCpNwUfLzZYmoBLMqHN06tOHoltRrYdACCCPPT526QbqBLODPhZwUFXRM8akS5iyRMaTpL9ZMJ6r1Bii7plms6iKwHeo9U43aWNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8mqyBf4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8mqyBf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D3F1F00A3A;
	Tue,  8 Sep 2026 03:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788839126;
	bh=F0+Sew0fQ5NovcuppCds+ZlkTi/0GvocVvkl+zJnJJA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B8mqyBf4TPJEgtgsUTnDxdjzmXwWZxnoUOvjX0TY889WgB1btfiqJ3pDHpb1x7gjJ
	 ueqke9nJKCDabtowPSXYKrtlVTQcenDVI1pujXle1+/lkYiR8o5OnXfNQZzLsuEvh+
	 9JzWvZqX2PhIcUr17aOatYT1aj0r4oqnqh2umxdJcZu5nc7ZAYiLRmt0JU7gNuJghT
	 +aS9oCW0m07T8dzaRFhyf6mgblt2zaTTxTjSBqlpY8qFqCwSEQ1zuermNOXm8U1ctn
	 rn2nlwnyVSviwstzpbpzSMNmHMrSyO33DQ4XCiCJQpe2JfWHByiFfpQJJ5O757Bbi8
	 mFY+HNYOQ+oMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/12] Input: xbox_gip - Add HID relaying
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-5-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-5-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:45:25 +0000
Message-Id: <20260908034526.24D3F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] gip_handle_command_hid_report() uses hid_input_report() instead of=
 hid_safe_input_report(), bypassing buffer size checks.
- [Medium] gip_create_hdev() contains a redundant synchronize_rcu() call af=
ter publishing the newly allocated hdev pointer.
- [Medium] The hid_device's uniq field is not initialized before hid_add_de=
vice() is called.
- [Low] gip_free_devices() leaks the RCU-protected hdev pointer outside the=
 read-side critical section, violating the RCU API contract.

Pre-existing issues:
- [Critical] gip_disconnect() cancels the receive workqueue before killing =
the active URB, introducing a race condition that causes Use-After-Free of =
the gip_device.
- [Critical] The LED classdev is embedded in the attachment but registered =
using the devres of the ephemeral input_dev, leading to list corruption upo=
n device reset.
- [High] Resetting the attachment leaks input_dev structures because devm_i=
nput_allocate_device() is used but the memory is never explicitly freed bef=
ore reallocation.
--

commit 4a45548f46c49c18ea22bd85490b3cf588327135
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add HID relaying
   =20
GIP allows tunneling of HID packets, with the HID descriptor embedded in
the GIP metadata exchanged during the initial handshake. This patch creates
a hid_device for this HID descriptor if found, as well as relaying the HID
packets.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index a5ed5f3bf3fed..dc174560ee49f 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

> @@ -1310,6 +1358,50 @@ static int gip_init_input_device(struct gip_attach=
ment *attachment)
>  	return rc;
>  }
> =20
> +static int gip_create_hdev(struct gip_attachment *attachment)
> +{
> +	struct hid_device *hdev;
> +	int rc;
> +

[ ... ]

> +	hdev->dev.parent =3D to_gip_device(attachment);
> +	hdev->driver_data =3D attachment;
> +	if (attachment->name)
> +		strscpy(hdev->name, attachment->name);
> +	else
> +		strscpy(hdev->name, "Xbox Chatpad");
> +	strscpy(hdev->phys, attachment->phys);

[Severity: Medium]
Does this code forget to initialize hdev->uniq?

The HID subsystem documentation explicitly mandates that transport drivers
fully initialize fields including uniq before calling hid_add_device().
While the input_dev correctly populates this, it appears to be omitted here,
which leaves the device missing standard sysfs attributes.

> +	rc =3D hid_add_device(hdev);
> +	if (rc) {
> +		gip_err(attachment, "HID device add failed: %d\n", rc);
> +		hid_destroy_device(hdev);
> +	} else {
> +		rcu_assign_pointer(attachment->hdev, hdev);
> +		synchronize_rcu();

[Severity: Medium]
Is it necessary to block the thread for an RCU grace period here?

Since rcu_assign_pointer() publishes the newly allocated hdev pointer
(replacing NULL or a synchronized teardown state), and no memory is being
reclaimed at this point, this synchronize_rcu() call appears completely
redundant and needlessly delays device initialization.

> +	}
> +
> +	return rc;
> +}

[ ... ]

> @@ -1393,19 +1489,25 @@ static void gip_fragment_timeout(struct work_stru=
ct *work)
>  static void gip_free_devices(struct gip_attachment *attachment)
>  {
>  	struct input_dev *input;
> +	struct hid_device *hdev;
> =20
>  	if (attachment->driver && attachment->driver->remove)
>  		attachment->driver->remove(attachment);
> =20
>  	rcu_read_lock();
>  	input =3D rcu_dereference(attachment->input);
> +	hdev =3D rcu_dereference(attachment->hdev);
>  	rcu_read_unlock();
> =20
>  	rcu_assign_pointer(attachment->input, NULL);
> +	rcu_assign_pointer(attachment->hdev, NULL);
>  	synchronize_rcu();
> =20
>  	if (input)
>  		input_unregister_device(input);
> +
> +	if (hdev)
> +		hid_destroy_device(hdev);

[Severity: Low]
Can this leak the RCU-protected hdev pointer outside the read-side
critical section?

The hdev pointer is extracted using rcu_dereference() under rcu_read_lock(),
but it is utilized outside the critical section to destroy it. While this
might be functionally safe here because the thread is the exclusive updater
and synchronizes before destruction, it violates RCU API rules. Should this
use rcu_access_pointer() or rcu_dereference_protected() instead?

>  }
> =20
>  static void gip_reset_metadata(struct gip_attachment *attachment)

[ ... ]

> @@ -1770,9 +1872,16 @@ static int gip_handle_command_firmware(struct gip_=
attachment *attachment,
>  static int gip_handle_command_hid_report(struct gip_attachment *attachme=
nt,
>  	const struct gip_header *header, uint8_t *bytes, int num_bytes)
>  {
> -	gip_warn(attachment, "Unimplemented HID report message\n");
> +	struct hid_device *hdev;
> =20
> -	return -EOPNOTSUPP;
> +	guard(rcu)();
> +	hdev =3D rcu_dereference(attachment->hdev);
> +	if (hdev)
> +		return hid_input_report(hdev, HID_INPUT_REPORT, bytes, num_bytes, true=
);

[Severity: High]
Could this cause an out-of-bounds read in the HID core?

The raw byte array from untrusted hardware input is passed directly to
hid_input_report() without providing the allocated buffer size. The HID
subsystem explicitly directs transport drivers to use hid_safe_input_report=
()
with the allocated buffer size to ensure proper boundary checks are perform=
ed
against the report descriptor.

> +
> +	gip_warn(attachment, "Got HID report with no HID descriptor\n");
> +
> +	return -EPROTO;
>  }

While reviewing this file, I also noticed a few pre-existing regressions
elsewhere in the codebase:

> static void gip_disconnect(struct usb_interface *intf)
> {
> 	struct gip_device *gip =3D usb_get_intfdata(intf);
> 	int i;
>=20
> 	if (!gip)
> 		return;
>=20
> 	gip_shutdown(gip);
>=20
> 	usb_kill_urb(gip->data.urb_in);

[Severity: Critical]
This is a pre-existing issue, but does this destruction order cause a
use-after-free of the gip_device?

The cleanup function gip_shutdown() cancels the receive_message workqueue
before usb_kill_urb() is called. If the urb_in completes concurrently after
the workqueue is canceled but before the URB is killed, it will reschedule
the receive_message work. This work then executes concurrently with the rest
of gip_disconnect(), which frees the gip_device.

> static int gip_setup_input_device(struct gip_attachment *attachment)
> {
> 	struct input_dev *input;
> 	int rc;
>=20
> 	if (!attachment->driver || !attachment->driver->setup_input)
> 		return -ENODEV;
>=20
> 	rcu_read_lock();
> 	input =3D rcu_dereference(attachment->input);
> 	rcu_read_unlock();
> 	if (input)
> 		return 0;
>=20
> 	input =3D devm_input_allocate_device(to_gip_device(attachment));

[Severity: High]
This isn't a bug introduced by this patch, but are input_dev structures
leaked when the attachment is reset?

The input_dev is allocated using devm_input_allocate_device(). During a
protocol reset, input_unregister_device() is explicitly called, but this
does not free the devres-managed memory until the parent USB interface
unbinds. Re-allocating the device on subsequent resets appears to accumulate
leaked structures in memory.

> static int gip_guide_led_probe(struct gip_attachment *attachment, struct =
device *dev)
> {
> 	int rc =3D 0;
>=20
> 	if (!gip_supports_system_message(attachment, GIP_CMD_LED, false))
> 		return 0;
>=20
> 	if (attachment->features & GIP_FEATURE_GUIDE_COLOR) {
> 		struct mc_subled *mc_led_info;
> 		struct led_classdev_mc *mc_cdev =3D &attachment->guide_led.color;
> 		struct led_classdev *cdev =3D &mc_cdev->led_cdev;
>=20
> 		mc_led_info =3D devm_kcalloc(dev, 4,
[ ... ]
> 		if (!rc)
> 			rc =3D devm_led_classdev_multicolor_register(dev,
> 				mc_cdev);

[Severity: Critical]
This is a pre-existing issue, but does tying the embedded LED classdev
registration to the ephemeral input_dev lead to list corruption?

The led_classdev is embedded in the attachment structure, but it is
registered using devm_led_classdev_register() tied to the input_dev's
lifecycle. On reset, the input_dev is unregistered, but its devres cleanup
is deferred until the last userspace reference is closed. If the driver
reallocates the input_dev and re-registers the exact same embedded
led_classdev structure before cleanup completes, it corrupts the LED
subsystem's linked lists.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D4
