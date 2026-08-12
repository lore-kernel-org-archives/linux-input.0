Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4001E5B70
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498494; cv=none; b=lMSUlrZAgQHToz+eo0QaOu9fUQX1ST6En7Bfcw21y5H5m90LDp22ToQbwVa4tD3aj6T90OKRng3yUAI279y3mJOQOy3GIv2J8Lm2dC1Uq4z057oJ5xrShGC1Ztg6kJ5p4w+3xvu6gtbk9hxK4dYCKMnoUAAG9kcmpdl0i6md2oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498494; c=relaxed/simple;
	bh=KwT18RB2yCzTCMuL5h4wmEoRR/6dCDWFbRDZk1rdmSE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gtr5/Qh6EpMfnugRZufs6M0PUqkN7tQ5ljZE61bHsk6KJTk1d9+Oac1v5UYhQEFgaywKzr4nicWXVIINapBlxr7wJhsNZJnS6TRP/GRMMMYrvtL4OsKI450oDZjD7+xWEjgxFAmJcEwIPR0WMDRsb/cr5JiejVWau+iK7Xq3GT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkb5tZOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkb5tZOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF59B1F00AC4;
	Wed, 12 Aug 2026 01:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498488;
	bh=NKnDvfAOkmCbi6XshrigbBryEcyaD26DkwJxCCOivec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xkb5tZOuKtXduXNuHlBmIX4VkZ+5vsPSlf5pOA051IMrN9Gdo9WrFnsBoyobQ08u0
	 Ac8bURwmbnKuIBz2mgnM7GsbTKcOxIQk4EmOvzkw13o4CiV3sQuZlcBRRg+5YqZ5lz
	 a+ipAisee+uzc8GqNgqtN3W6cQKr0bCBJMMpDRxx11LXJchr5vDg8dIbN98pGWOz5F
	 FOKdyhg/XmTTIbeSTdtH1O3kNzQWFQVwts/grBjDG7bH4RdbuSGdKpOKnbJ0YThGTL
	 d2jk+RT4dQ6AVBz77T6I/Jy5vHg9XKaYyphEGVY5fsVkyHHmaJqq9M8c0sjHrBnwcs
	 EQRDGtfO+R8fg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260812012037.3251614-2-vi@endrift.com>
References: <20260812012037.3251614-1-vi@endrift.com>
 <20260812012037.3251614-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 01:34:48 +0000
Message-Id: <20260812013448.AF59B1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Missing `usb_unanchor_urb()` on `usb_submit_urb()` failure in `swi=
tch2_usb_probe()` causes an infinite loop during cleanup.
- [High] Player LED class devices are registered using devm helpers attache=
d to an unmanaged `input_dev`, causing a Use-After-Free on device unplug.
- [High] Calling `ida_free()` with an unallocated ID (`U32_MAX`) on error a=
nd unbind paths triggers a `BUG_ON()` kernel panic.
- [High] The controller context (`ns2`) is freed before stopping incoming H=
ID reports during device removal.
- [High] Submitting the bulk-in URB before successfully attaching the contr=
oller configuration causes a TOCTOU race and Use-After-Free if `switch2_con=
troller_attach_cfg()` fails.
--

--- Patch [1]: [PATCH v13 1/3] HID: nintendo: Add preliminary Switch 2 cont=
roller driver ---
commit d121d655a283cdffdd144741982d049db4fd8c05
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add preliminary Switch 2 controller driver

This adds a new driver for the Switch 2 controllers. The Switch 2 uses an
unusual split-interface design such that input and rumble occur on the main
HID interface, but all other communication occurs over a configuration
interface. This initial work supports general input for the Switch 2 Joy-Co=
n,
Pro Controller, and GameCube NSO controllers.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1f..78c9ad3c16104 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> +static int switch2_player_led_brightness_set(struct led_classdev *led,
> +					    enum led_brightness brightness)
> +{
> +	struct device *dev =3D led->dev->parent;
> +	struct input_dev *input =3D to_input_dev(dev);
> +	struct switch2_controller *ns2 =3D input_get_drvdata(input);
> +
> +	if (!ns2)
> +		return -ENODEV;
> +
> +	guard(mutex)(&ns2->lock);
> +	return switch2_set_leds(ns2);
> +}

[ ... ]

> +static int switch2_init_input(struct switch2_controller *ns2)
> +{

[ ... ]

> +	ns2->leds =3D devm_kcalloc(&input->dev, JC_NUM_LEDS, sizeof(*ns2->leds)=
, GFP_KERNEL);
> +	if (!ns2->leds) {
> +		hid_err(ns2->hdev, "Failed to allocate LEDs\n");
> +		input_unregister_device(input);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < JC_NUM_LEDS; i++) {
> +		struct led_classdev *led =3D &ns2->leds[i];

[ ... ]

> +		ret =3D devm_led_classdev_register(&input->dev, led);
> +		if (ret < 0) {
> +			dev_err(&input->dev, "Failed to register player %d LED; ret=3D%d\n",
> +				i + 1, ret);
> +			break;
> +		}
> +	}

[Severity: High]
Is it safe to tie the LED devm allocations to the unmanaged input device he=
re?

If userspace holds an open file descriptor for the input device when it is
unregistered during unplug, the devres cleanup is deferred. Could a subsequ=
ent
sysfs write to the LED brightness trigger a use-after-free when
switch2_player_led_brightness_set() dereferences the already freed controll=
er
context?

[ ... ]

> +static int switch2_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{

[ ... ]

> +	ns2->player_id =3D U32_MAX;
> +	ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
> +	if (ret < 0)
> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d\n", r=
et);
> +	else
> +		ns2->player_id =3D ret;

[ ... ]

> +err_cleanup:
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
> +	ns2->hdev =3D NULL;
> +	mutex_unlock(&ns2->lock);
> +	switch2_controller_put(ns2);
> +	kref_put(&ns2->refcount, switch2_kref_put);
> +
> +	return ret;
> +}
> +
> +static void switch2_remove(struct hid_device *hdev)
> +{
> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> +
> +	switch2_controller_put(ns2);
> +	mutex_lock(&ns2->lock);
> +	ns2->hdev =3D NULL;
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);

[Severity: High]
If ida_alloc() fails or is skipped, ns2->player_id remains U32_MAX. Since
ida_free() expects a valid ID and asserts on negative values, could
unconditionally freeing U32_MAX cause a kernel panic here?

> +	mutex_unlock(&ns2->lock);
> +	kref_put(&ns2->refcount, switch2_kref_put);
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);

[Severity: High]
If the hardware continues sending events during device removal, could a rep=
ort
arrive after kref_put() frees the controller context but before hid_hw_stop=
()
completes?

This appears to leave a window for a use-after-free in switch2_event() when
dereferencing the controller context.

> +}

[ ... ]

> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/inpu=
t/joystick/nintendo-switch2-usb.c
> new file mode 100644
> index 0000000000000..36a5ffbd6a756
> --- /dev/null
> +++ b/drivers/input/joystick/nintendo-switch2-usb.c

[ ... ]

> +static void switch2_usb_message_in_work(struct work_struct *work)
> +{

[ ... ]

> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		urb =3D &ns2_usb->bulk_in[i];
> +		if (urb->state !=3D NS2_URB_IN)
> +			continue;
> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +		if (ns2_usb->cfg.parent) {
> +			err =3D switch2_receive_command(ns2_usb->cfg.parent,
> +				urb->urb->transfer_buffer, urb->urb->actual_length);

[Severity: High]
Is it possible for the endpoint to respond immediately after the bulk-in URB
is submitted in switch2_usb_probe(), scheduling message_in_work?

If switch2_controller_attach_cfg() subsequently fails, it will clean up and
free the controller context. Could this cause a use-after-free if the worker
thread evaluates ns2_usb->cfg.parent as non-NULL just before the failure fr=
ees
it, passing a dangling pointer to switch2_receive_command()?

[ ... ]

> +static int switch2_usb_probe(struct usb_interface *intf, const struct us=
b_device_id *id)
> +{

[ ... ]

> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	ns2_usb->bulk_in[0].state =3D NS2_URB_OUT;
> +	usb_anchor_urb(ns2_usb->bulk_in[0].urb, &ns2_usb->bulk_in_anchor);
> +	ret =3D usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +	if (ret < 0)
> +		goto err_free_out;

[Severity: High]
When usb_submit_urb() fails, does the URB stay on the anchor list?

Since usb_kill_anchored_urbs() does not manually unanchor unsubmitted URBs,
could this cause an infinite loop when the error path eventually calls
usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor)?

> +
> +	ret =3D switch2_controller_attach_cfg(phys, &ns2_usb->cfg);
> +	if (ret < 0)
> +		goto err_free_out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812012037.3251=
614-1-vi@endrift.com?part=3D1
