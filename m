Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B29137F8AD
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889931; cv=none; b=C5/LhwzBSqwmbp8WMyNL3G7JQfueC1n9CCATGCoHVYoV4hN8f6sj/tXkk+35O7WhyKH+PgE7Ezt7CiEwcJJPqd8Q0XeHxJpzvKkYcVcrEbP4uq2U6rBM5MjUM5pjI587Geon8WVSJk4kaYXYVCNAXdO0CMhBAyZ+Fr9BLKp1pgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889931; c=relaxed/simple;
	bh=bgBvw6Bjc6ruOK3KexxJOYa1ia9c4qtq29K/fdrDc/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rLDfQNADe0DQ7eXS+/1usvcsHuuZ465uZoM+lXM10Ddyk4ZOmQTg380Aj1bGXuHfmaYrKOT+QgF+H+IOCIuKUkT0FJ63LGB5sziDWeiaOZZbYKvAMv2Rbe8v5ws3WVoPUClSl/skw0O3AnmViPVwWzCp1rM4wCYpdnfzD8j9OLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq2fVDQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq2fVDQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685821F000E9;
	Wed,  1 Jul 2026 07:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782889928;
	bh=5Ni1SJbArofI4NseGcahcnyH4yZ3MHpp8g9xbf0YU5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nq2fVDQ1jbyhnhymAlreW08xtnNRV9bxjHOwVPtjj2I3M19rhe3IW5Of1TJegr3o7
	 bGmvYBV9ppgPrGSA4PoeKiRv/SLtnzzO5eq///ndE6SXUqrPR2GfBtN2N5h/hM8UsM
	 5mmcqPOyc19q7xdlCd23bRU1Po5+RXdIc7uyOFtSfxjoBCHftV7I6vTqFImPlaYvcV
	 RLjjsutLj7SPXTz9W1s1fAosgF2npSFzlxM9CIDdSbml/DCD87wAUIv5c+0a/Yj5YO
	 pwKNcGJDdMSZnXMC7qkgrj2elIvbp+PWeAFIGXgJ+t3w1V7vghRTQtRgGLAacial00
	 +t96OoEc/+f2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260701065606.4169999-2-vi@endrift.com>
References: <20260701065606.4169999-1-vi@endrift.com>
 <20260701065606.4169999-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 07:12:07 +0000
Message-Id: <20260701071208.685821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Potential NULL pointer dereference in `switch2_handle_flash_read()=
` when receiving spontaneous or delayed USB messages.
- [High] Race condition in `switch2_remove()` clearing drvdata before hardw=
are stop causes NULL pointer dereference.
- [High] Unconditional `ida_free()` with `U32_MAX` triggers a `BUG_ON` pani=
c on probe failure or device removal.
- [High] Using `devm_led_classdev_register` with `&input->dev` causes a dev=
res circular reference, leaking devices and causing a Use-After-Free.
- [High] The `-EBUSY` error path in `switch2_probe` erroneously destroys th=
e active input device of the existing interface.
- [High] TOCTOU race condition in `switch2_usb_disconnect` causes UAF due t=
o missing `usb_kill_urb`.
- [Medium] URB slot leak and stuck polling on transient USB errors, plus pr=
ocessing of invalid data.
--

commit ef162798bccd0977cafe2dea531f9e56194e0992
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add preliminary Switch 2 controller driver

This patch adds a new driver for Nintendo Switch 2 controllers, using a
split-driver design for HID and USB configuration interfaces. It brings
support for Joy-Con 2, Pro Controller 2, and GameCube NSO controllers via U=
SB.

I found a few regressions while reviewing this patch.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1f..5aacb8e88b704 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2838,7 +2845,1194 @@ static int nintendo_hid_suspend(struct hid_devic=
e *hdev, pm_message_t message)
> [ ... ]
> +static void switch2_handle_flash_read(struct switch2_controller *ns2, ui=
nt8_t size,
> +	uint32_t address, const uint8_t *data)
> +{
> +	bool ok;
> +
> +	switch (address) {
> [ ... ]
> +	case NS2_FLASH_ADDR_FACTORY_PRIMARY_CALIB:
> +		if (size !=3D NS2_FLASH_SIZE_FACTORY_AXIS_CALIB)
> +			return;
> +		switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_PRIMARY_CALIB);
> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[0], data);
> +		if (ok) {

[Severity: High]
Can this cause a NULL pointer dereference? If the USB configuration
interface receives a flash read reply before the HID interface finishes
probing, or if a delayed response arrives from a previous session,
ns2->hdev will be NULL when hid_dbg is called.

> +			hid_dbg(ns2->hdev, "Got factory primary stick calibration:\n");
> +			hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
> [ ... ]
> +static int switch2_init_input(struct switch2_controller *ns2)
> +{
> [ ... ]
> +	for (i =3D 0; i < JC_NUM_LEDS; i++) {
> +		struct led_classdev *led =3D &ns2->leds[i];
> +		char *name =3D devm_kasprintf(&input->dev, GFP_KERNEL, "%s:%s:%s",
> +				      dev_name(&input->dev),
> +				      "green",
> +				      joycon_player_led_names[i]);
> +
> +		if (!name) {
> +			dev_err(&input->dev, "Failed to allocate name for player %d LED; ret=
=3D%d\n",
> +				i + 1, ret);
> +			break;
> +		}
> +
> +		led->name =3D name;

[Severity: High]
Could this create a circular devres reference? The LED class devices hold
references to their parent (the input device). When the controller is
removed, the input device's devres cleanup won't run until its refcount
hits 0, which cannot happen because the LED devices still exist.

Since the led_classdev structures are embedded in ns2 (which is freed on
removal), might this cause a use-after-free when the leaked LED sysfs
nodes are later accessed?

> +		ret =3D devm_led_classdev_register(&input->dev, led);
> +		if (ret < 0) {
> +			dev_err(&input->dev, "Failed to register player %d LED; ret=3D%d\n",
> [ ... ]
> +static int switch2_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
> [ ... ]
> +	ns2->player_id =3D U32_MAX;
> +	ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
> +	if (ret < 0)
> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d\n", r=
et);
> +	else
> +		ns2->player_id =3D ret;
> [ ... ]
> +	hid_hw_close(hdev);
> +err_stop:
> +	hid_hw_stop(hdev);
> +err_cleanup:
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
> +	ns2->hdev =3D NULL;

[Severity: High]
Does this error path break the already active controller? If a second HID
interface for the same physical controller probes and detects a conflict,
it returns -EBUSY and jumps to err_put.

However, unconditionally calling switch2_controller_put(ns2) here tears
down the input device for the existing, bound interface.

> +err_put:
> +	switch2_controller_put(ns2);
> +	mutex_unlock(&ns2->lock);
> +	kref_put(&ns2->refcount, switch2_kref_put);
> +
> +	return ret;
> +}
> +
> +static void switch2_remove(struct hid_device *hdev)
> +{
> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> +
> +	mutex_lock(&ns2->lock);
> +	switch2_controller_put(ns2);
> +	ns2->hdev =3D NULL;

[Severity: High]
Can this cause a race condition leading to a NULL pointer dereference?
The drvdata is set to NULL before hid_hw_stop() halts the hardware.

If an input interrupt triggers switch2_event() in this window, it will
retrieve a NULL pointer from hid_get_drvdata() and immediately dereference
it when calling rcu_dereference(ns2->input).

> +	hid_set_drvdata(hdev, NULL);

[Severity: High]
Does this trigger a panic if ida_alloc() failed during probe? If the probe
fails to allocate the ID, ns2->player_id remains U32_MAX.

Unconditionally calling ida_free() during removal passes this value, which
casts to -1 and will trigger the BUG_ON((int)id < 0) inside the ida_free()
implementation.

> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
> +	mutex_unlock(&ns2->lock);
> +	kref_put(&ns2->refcount, switch2_kref_put);
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}

> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/inpu=
t/joystick/nintendo-switch2-usb.c
> new file mode 100644
> index 0000000000000..0a004918c1f10
> --- /dev/null
> +++ b/drivers/input/joystick/nintendo-switch2-usb.c
> @@ -0,0 +1,464 @@
> [ ... ]
> +static void switch2_bulk_in(struct urb *urb)
> +{
> [ ... ]
> +	switch (urb->status) {
> +	case 0:
> +		schedule =3D true;
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		dev_dbg(&ns2_usb->udev->dev, "shutting down input urb: %d\n", urb->sta=
tus);
> +		return;
> +	default:
> +		dev_dbg(&ns2_usb->udev->dev, "unknown input urb status: %d\n", urb->st=
atus);
> +		break;
> +	}
> +
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		int err;
> +		struct switch2_urb *ns2_urb;
> +

[Severity: Medium]
Does this leak the URB slot and process invalid data? If an URB completes
with an error, the schedule flag remains false, but the state is set to
NS2_URB_IN. If both IN URBs fail, the workqueue is never scheduled again.

If the workqueue is scheduled by the other URB, switch2_usb_message_in_work=
()
will process this failed URB without validating urb->status, passing
potentially garbage data to switch2_receive_command().

> +		if (ns2_usb->bulk_in[i].urb =3D=3D urb) {
> +			ns2_usb->bulk_in[i].state =3D NS2_URB_IN;
> +			continue;
> +		}
> [ ... ]
> +static void switch2_usb_disconnect(struct usb_interface *intf)
> +{
> [ ... ]
> +	/* Prevent any further IN URBs from being scheduled */
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	ns2_usb->shutdown =3D true;
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +

[Severity: High]
Is there a TOCTOU race condition here during disconnect? The USB core
unanchors URBs before invoking their completion handler.

If switch2_bulk_in() is running concurrently, usb_kill_anchored_urbs()
won't wait for it. cancel_work_sync() might return immediately if the
handler hasn't yet called schedule_work().

Could the handler then schedule work on the freed ns2_usb structure,
leading to a use-after-free?

> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> +	cancel_work_sync(&ns2_usb->message_in_work);
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701065606.4169=
999-1-vi@endrift.com?part=3D1
