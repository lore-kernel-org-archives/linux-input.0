Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792973426;
	b=XMASupwOjpLmc3iqok+gCkiP1HAnAQ7iqTbZck/m2duxxV2TT/TO/+V+uGuaqUTkG9LN
	 eGJg1nz8vcDC5wKs440fNN5B4LUHgTByJi3wfIIMxTAtKLv7dZAn11lZ0hg6dGdEutQdQ
	 tqHdpTECv9rdCG6Sm6MbeNS3+QXbRsD4fWDIBsEGCSzs76IYnliecwuGDQWzl+wL1YtA4
	 5VTf8lPqbkVVVGkFoVZMzsHzgmDy/iNyruFXneWlj4VtRsNofCVvG+Ywo+llwF6ZO3dp5
	 6/pPv7L0LK9d6Q1AoGgPFRIdbudUEq3toSyYsr3ssZH/xDuS9ZHKUKqhcINeQdldK8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792973426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Bh5DT01A7m5MQ8fu3yeh6nS9Ql41tUw0Zqx2//FEzQ=;
	b=rv0wbJIP16DSOBJLVCT/6Sp1pqbPAVK687hui+s998pTyeiQvd6Ws0Vm9ve4SfCXE48J
	 202R7hGIVsvg1T03ofmta/1c17CaIlMRpoIlzqmX6Ysm+nk3ERd8Fcg9Tm/EFZVQ86TqA
	 DttaLl7lOjq4lgmqpU0jZI2o+QPZpib84csNrKaO0Q/JNFF/MVcw9IzsGqHWNNpkBbeVJ
	 EpmQGSmCsMyiYje/rh205SOQaKNF3zoUwNQ66Tp/GF3lJSL1FfSjC28h2Cg12V8258aa6
	 7DlApA9EyMQoWG2HoAGmJvWUGio0zeU+RWeEwRm2Med/DZhFkCyCrkx5y+9KrqJV3IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSRI9pk2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B5606A31A
	for <linux-input@vger.kernel.org>; Mon, 26 Oct 2026 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DSRI9pk2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4595D1F01825;
	Mon, 26 Oct 2026 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792973426;
	bh=6Bh5DT01A7m5MQ8fu3yeh6nS9Ql41tUw0Zqx2//FEzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DSRI9pk2ifgXcPHBSGid/01aHwhTZbNwFDEnz12JXQobOMbahIIRnuVMFWJfCyi0t
	 jc2RPqP2L7zPtjJXKOl4wtgkHV4RNF1AXEpjtXjzN3kP/yfCod6f9hO1dikWORVW4z
	 DYgY+Jnx1wEVS4Kt84u2PLYF+1PzVW5VY+Dr+VQNOArkyQvTPwh4L7k0m+usUm0Daq
	 22Zb8leSNHhZV+siFfyWesPOhaQaOrRrtttj5x1vSZn1k9yCzRAl8W+9QjLzbjSZsl
	 TEiGn+TIHVkk1xljIY8v+akamp6m/tkzrPLhyvWPZEMaI4+RUizUHqrMm4t6QElkii
	 24v3RHLr268VQ==
Message-ID: <sashiko-outbox-184554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/18] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261025235232.129945-2-denis.benato@linux.dev>
References: <20261025235232.129945-1-denis.benato@linux.dev>
 <20261025235232.129945-2-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 00:10:25 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] HID: asus: untracked endpoints claim udev in hid_asus_ally_probe=
()
- [Low] HID: asus: duplicate and unused BTN_TRIGGER_HAPPY1 capability in al=
ly_x_setup_input()
--

commit 2082b890016be96a18a64dd50b259758d2e05629
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit adds ROG Ally handheld support to hid-asus, including device
readiness checks, Ally X gamepad input mapping, AC button long-press handli=
ng,
and shared state tracking across the controller's USB interfaces.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index f6aa1be09ad53..9e6796bbbdcbd 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -240,12 +297,906 @@ static const struct asus_touchpad_info medion_e123=
9t_tp =3D {
[ ... ]
> +static bool ally_x_raw_event(struct input_dev *input, u8 *data, int size)
> +{
[ ... ]
> +	byte =3D in_report->buttons[1];
> +	input_report_key(input, BTN_THUMBL, byte & BIT(0));
> +	input_report_key(input, BTN_THUMBR, byte & BIT(1));
> +	input_report_key(input, BTN_MODE, byte & BIT(2));
[ ... ]
> +static int ally_x_setup_input(struct hid_device *hdev, struct ally_handh=
eld *ally)
> +{
[ ... ]
> +	input_set_capability(input, EV_KEY, KEY_PROG1);
> +	input_set_capability(input, EV_KEY, KEY_F16);
> +	input_set_capability(input, EV_KEY, KEY_F17);
> +	input_set_capability(input, EV_KEY, KEY_F18);
> +	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
> +	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);

[Severity: Low]
In include/uapi/linux/input-event-codes.h, BTN_TRIGGER_HAPPY and
BTN_TRIGGER_HAPPY1 both expand to 0x2c0, while the second button is
BTN_TRIGGER_HAPPY2 (0x2c1).

At the same time, ally_x_raw_event() only reports bits 0..2 from
in_report->buttons[1] and never emits any BTN_TRIGGER_HAPPY* events.

Were these two capabilities intended to be BTN_TRIGGER_HAPPY1 and
BTN_TRIGGER_HAPPY2 with corresponding reporting in ally_x_raw_event(), or
should they be dropped from ally_x_setup_input()?

> +
> +	ret =3D input_register_device(input);
[ ... ]
> +static struct ally_handheld *hid_asus_ally_probe(struct hid_device *hdev)
> +{
[ ... ]
> +	/* Reserve the role for as long as the initialization below runs. */
> +	if (ep =3D=3D HID_ALLY_INTF_CFG_IN)
> +		ally_drvdata.cfg_probe_in_progress =3D true;
> +	else if (ep =3D=3D HID_ALLY_X_INTF_IN)
> +		ally_drvdata.ally_x_probe_in_progress =3D true;
> +	else if (ep =3D=3D HID_ALLY_INTF_KEYBOARD_IN)
> +		ally_drvdata.keyboard_probe_in_progress =3D true;
> +
> +	if (!ally_drvdata.udev) {
> +		usb_get_dev(udev);
> +		ally_drvdata.udev =3D udev;
> +	}
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	/*
> +	 * The interface initialization sleeps (it performs USB transfers),
> +	 * so it must not run under ally_data_lock: the role stays reserved
> +	 * while it runs, and the pointers are published only once it
> +	 * succeeded.
> +	 */
> +	switch (ep) {
[ ... ]
> +	default:
> +		/* This is normally supposed to happen */
> +		break;
> +	}
> +
> +	return &ally_drvdata;
> +}

[Severity: Medium]
Can an untracked endpoint on the composite USB device (such as the mouse
interface, which has an endpoint address other than HID_ALLY_INTF_CFG_IN,
HID_ALLY_X_INTF_IN, or HID_ALLY_INTF_KEYBOARD_IN) cause ally_drvdata.udev to
get out of sync with the bound interfaces?

In hid_asus_ally_probe(), any endpoint matching QUIRK_ROG_ALLY_XPAD acquires
ally_drvdata.udev before switching on ep, and then hits the default branch
without setting any *_hdev pointer or *_probe_in_progress flag, while still
returning &ally_drvdata to be stored in drvdata->rog_ally.

Because ally_put_udev_if_orphaned() only checks the three tracked roles:

	if (!ally_drvdata.udev || ally_drvdata.keyboard_hdev ||
	    ally_drvdata.cfg_hdev || ally_drvdata.ally_x_hdev ||
	    ally_drvdata.cfg_probe_in_progress ||
	    ally_drvdata.ally_x_probe_in_progress ||
	    ally_drvdata.keyboard_probe_in_progress) {
		spin_unlock_irqrestore(&ally_data_lock, flags);
		return;
	}

two regressions seem possible:

1. If a default-branch interface probes first and a tracked role interface
subsequently fails in hid_asus_ally_probe() (or if the three tracked role
interfaces are later unbound via sysfs while the default-branch interface
remains bound), ally_put_udev_if_orphaned() sees all tracked pointers and
reservation flags cleared and drops ally_drvdata.udev while the
default-branch interface still holds drvdata->rog_ally =3D &ally_drvdata.
Unbinding that interface later will run hid_asus_ally_remove() ->
cancel_delayed_work_sync() and ally_put_udev_if_orphaned() against global
state that may now belong to another connected controller.

2. Conversely, if only a default-branch interface binds (for example, if the
three tracked role interfaces fail in hid_parse() or hid_hw_start() before
reaching hid_asus_ally_probe(), or on a device with the Ally VID/PID exposi=
ng
only other endpoints), ally_drvdata.udev stays pinned with no tracked role
bound, preventing any other controller from probing.

Should hid_asus_ally_probe() return NULL (or avoid claiming ally_drvdata.ud=
ev
and &ally_drvdata) when ep is not one of HID_ALLY_INTF_CFG_IN,
HID_ALLY_X_INTF_IN, or HID_ALLY_INTF_KEYBOARD_IN?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025235232.1299=
45-1-denis.benato@linux.dev?part=3D1
