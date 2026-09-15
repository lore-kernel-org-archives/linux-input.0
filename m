Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56058313277
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503978; cv=none; b=UqSu4J6bWNVmcEhYieAnTh3owYdXUl+Yae1uRaxnS+pHjSkqyBnFwiF+dzwekSwwuW+hYGAn0B/re5nq9ZpNi49lfMfxvoxwf6KeZ2HbKsIfTwLtlX2fSf+pptwYpq+V8hp/PnGSEherZaQzyXyDL2VuV4oVkOlrKPe94atjUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503978; c=relaxed/simple;
	bh=rodqxPVYDpTb8J/vNk80OBSMOWqcofzygw+FTVwFHeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WAaDQoWAcwLpkTzOHFXdDuDrp7asTnOmUMNy4teXRN1VgiNudt684vB6Ennwp7s9+xU9R6R3tjcH7n+hh4KdXuDYtG6xqARxJPL7TMe2jltilcEnEjvwxnzBlkD6RD3OMvjobrRbmC35uqWBPWn08YPf4AY55S+0rvmh5D+Fr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5yvyHTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5yvyHTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C5B1F000FF;
	Tue, 15 Sep 2026 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789503977;
	bh=vDE2KaZ7sj+WNrpFV1HQK5LT/8nI4Q+6I8dMAuLVmIY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D5yvyHTycJjtU4i99+f7N9bCclcv+At/P5s2viblwmDml2WYjUAKVrwL1xMEHyg24
	 IzJKX2wQRLFzMgfNbWk+/5XGyhUfok72MstGD4W9mKyxFa2KUp2SMY74SgyBr6X3H9
	 FHAz5e5ELRj2j7vsdS78DmdoYjb2NxdRm/htnF6yT3IBsqRhUc6ge++M5OpN8jWSc3
	 QoFoD61Cgn0vFjMGGviYXe1soe1dwgaQaCjuaEzAMcpGSo/OYf3cFsj7+tfsFKbdh8
	 +UJ/U8r8tlp+A+K3dHC+5CrtSefOVV1tGcsExEYweMFRjzLVBiVUD9LIJ6vcmMwwyt
	 4zuoEGtmhiaRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/12] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260915201314.28279-3-denis.benato@linux.dev>
References: <20260915201314.28279-1-denis.benato@linux.dev>
 <20260915201314.28279-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 20:26:16 +0000
Message-Id: <20260915202616.B7C5B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hid-asus: ROG Ally hotplug is permanently broken due to uncleared =
probe_in_progress flags
- [Medium] hid-asus: TOCTOU race in ally_put_udev_if_orphaned drops USB dev=
ice reference prematurely
- [Medium] hid-asus: TOCTOU race in keyboard interface publication violates=
 singleton safety
--

commit 88e0fb100cdf5cb20d748a018414785e32e69eed
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit adds support for ASUS ROG Ally handhelds to the hid-asus driver=
.=20
It extends the driver to handle multiple HID interfaces (gamepad, config,=20
keyboard) using a shared global state structure and implements specific=20
input mappings and events.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
>  static void ally_put_udev_if_orphaned(void)
>  {
>  	struct usb_device *udev;
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&ally_data_lock, flags);
>  	if (!ally_drvdata.udev || ally_drvdata.keyboard_hdev ||
>  	    ally_drvdata.cfg_hdev || ally_drvdata.ally_x_hdev) {
>  		spin_unlock_irqrestore(&ally_data_lock, flags);
>  		return;
>  	}

[Severity: Medium]
Does this prematurely drop the USB device reference during a concurrent
probe? This condition checks the published pointers but doesn't check the
cfg_probe_in_progress or ally_x_probe_in_progress flags. If one interface
fails its initialization and calls this function while another is currently
sleeping in its probe, it appears the udev reference will be dropped,
breaking the singleton safety check.

[ ... ]

>  static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
>  {
>  	unsigned long flags;
>  	int ret, ep =3D ally_get_endpoint_address(hdev);

[ ... ]

>  	if ((ep =3D=3D HID_ALLY_INTF_CFG_IN &&
>  	     (ally_drvdata.cfg_hdev || ally_drvdata.cfg_probe_in_progress)) ||
>  	    (ep =3D=3D HID_ALLY_X_INTF_IN &&
>  	     (ally_drvdata.ally_x_hdev || ally_drvdata.ally_x_probe_in_progress=
)) ||
>  	    (ep =3D=3D HID_ALLY_INTF_KEYBOARD_IN && ally_drvdata.keyboard_hdev)=
) {
>  		spin_unlock_irqrestore(&ally_data_lock, flags);
>  		hid_err(hdev,
>  			"An interface of a ROG Ally controller is already connected\n");
>  		return ERR_PTR(-ENODEV);
>  	}
> =20
>  	/* Reserve the role for as long as the initialization below runs. */
>  	if (ep =3D=3D HID_ALLY_INTF_CFG_IN)
>  		ally_drvdata.cfg_probe_in_progress =3D true;
>  	else if (ep =3D=3D HID_ALLY_X_INTF_IN)
>  		ally_drvdata.ally_x_probe_in_progress =3D true;

[Severity: High]
These probe_in_progress flags are set to true here to reserve the role, but
looking at the successful completion paths below, they never seem to be set
back to false. Once an interface successfully probes, do these flags remain
permanently stuck at true, causing hotplug attempts to fail?

>  	if (!ally_drvdata.udev) {
>  		usb_get_dev(udev);
>  		ally_drvdata.udev =3D udev;
>  	}
>  	spin_unlock_irqrestore(&ally_data_lock, flags);
> =20
>  	/*
>  	 * The interface initialization sleeps (it performs USB transfers),
>  	 * so it must not run under ally_data_lock: the role stays reserved
>  	 * while it runs, and the pointers are published only once it
>  	 * succeeded.
>  	 */
>  	switch (ep) {

[ ... ]

>  	case HID_ALLY_INTF_KEYBOARD_IN:
>  		spin_lock_irqsave(&ally_data_lock, flags);
>  		ally_drvdata.keyboard_hdev =3D hdev;
>  		if (!list_empty(&hdev->inputs)) {
>  			hidinput =3D list_first_entry(&hdev->inputs, struct hid_input, list);
>  			ally_drvdata.keyboard_input =3D hidinput->input;
>  		}
>  		spin_unlock_irqrestore(&ally_data_lock, flags);
>  		break;

[Severity: Medium]
Can a TOCTOU race occur here for the keyboard interface? The lock is dropped
after checking ally_drvdata.keyboard_hdev earlier in this function, and
re-acquired here to assign the pointer. Since the keyboard interface doesn't
use a probe_in_progress reservation, could two concurrent keyboard probes
both see the pointer as NULL, pass the check, and then both overwrite the
shared state here?

[ ... ]

>  static void hid_asus_ally_remove(struct hid_device *hdev, struct ally_ha=
ndheld *ally)
>  {
>  	struct input_dev *x_input =3D NULL;
>  	unsigned long flags;
> =20
>  	if (!ally)
>  		return;

[ ... ]

>  	spin_lock_irqsave(&ally_data_lock, flags);
>  	if (ally->ally_x_hdev =3D=3D hdev) {
>  		x_input =3D ally->ally_x_input;
>  		ally->ally_x_input =3D NULL;
>  		ally->ally_x_hdev =3D NULL;
>  	}

[Severity: High]
The hdev pointers are cleared here during removal, but there is no code to
clear the corresponding cfg_probe_in_progress or ally_x_probe_in_progress
flags. Should these flags be reset to false when the device is unbound to
prevent permanently blocking future probes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915201314.2827=
9-1-denis.benato@linux.dev?part=3D2
