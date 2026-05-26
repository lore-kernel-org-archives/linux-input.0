Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932641C31E
	for <linux-input@vger.kernel.org>; Tue, 26 May 2026 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817942; cv=none; b=RaUTy0bzPw+oGqz3ErDMdd4fpO6mszNh8OLq+BN5A6RhHVtIXadmH3HgVhNvm4evWN/TSyor3bzE965nC9bX9MzqQO6UDI/3WFoHfSGWRkAlyAH0Wxt4+hTj5dBFW1H00EVXAmDW+tBtPOZyjtELU2BdapXeoBuW1aGrZxAShug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817942; c=relaxed/simple;
	bh=QCTDlT5QoOjEaxbWgZ3bESPxwXiIfYRUO72RqRjTpmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohclnxHMZPsKadDmTWCTebFWsrE/WOn/RpwMhALba1lzDP+I+GrWngYsvUz3bYjp3wIWeWCSDI8JKrcyxWk/aepk/jYTvk8Ch7gVA67ngWV8Cxa0ArpfEeYSmTmTU1jN3OTnm/WO3vQrMhXEVzOdiZ2KIN9X9fpijEwpsK9Dous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktpE93KF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktpE93KF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C5E1F000E9;
	Tue, 26 May 2026 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817940;
	bh=69NQLedV/41kwLRM2i3JaPyuvpCzwaj8QDll2Mr4ACI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ktpE93KFoSxpEEAqtgyl79XoWhS9Y8op/iXf5Zg+Olp+Xq798flyEsW0o9ShAuxMd
	 axykU9mLw6YgJt9UCqaOmSLscUJpSrkCTGx3Mqo3LoEdaxLloGRaBveLcTAsj71Qpn
	 2KxvbWXGnIpzYWZOzwwAdlrpqt61kWg6VmfesrLxUwWz376cguz2ZHQwM1/t1An2Wn
	 tDgwBIgdCQ1v1Qe8o7aVpcdvzkFvgLVOCiAKK7rHCeV3NdIHj9/Qo5ovc5ufZTm5JB
	 s6+w4jY7pW4okdqAYX0PypoAOfQ2rYv/oIwiqkUeDh22uvX2Hce2vtEGvdBv3Sjace
	 +q6zPCoz54O6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: nintendo: add support for HORI Wireless Switch Pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hector Zelaya" <hector@hectorzelaya.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260526-hori-support-v1-1-1861c0abc2e0@hectorzelaya.dev>
References: <20260526-hori-support-v1-1-1861c0abc2e0@hectorzelaya.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 17:52:20 +0000
Message-Id: <20260526175220.77C5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Unintentional probe failure due to uncleared error codes during no=
n-fatal IMU and Rumble timeouts for licensed controllers.
- [High] Incompatible SPI flash data is erroneously read and parsed as IMU =
calibration.
- [Low] Confusing kernel warning printed when intentionally using default j=
oystick calibration.
- [Low] `JOYCON_CTLR_TYPE_LIC_PRO` is missing from the `jc_type_has_right()=
` capability macro.
- [Low] Falsely advertising hardware capabilities (Rumble and IMU) that fai=
l to initialize.

Pre-existing issues:
- [High] The input device is registered before its capabilities and force-f=
eedback interfaces are configured.
- [High] Race condition in `joycon_ctlr_handle_event` reading shared state =
locklessly.
--

commit 6f0bfb377cdb5252c860b0efda09360159b62479
Author: Hector Zelaya <hector@hectorzelaya.dev>

HID: nintendo: add support for HORI Wireless Switch Pad

This commit adds support for the HORI Wireless Switch Pad by introducing
the new JOYCON_CTLR_TYPE_LIC_PRO controller type. It provides a dedicated
button mapping and handles initialization quirks for the device.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 29008c2cc5304..b5e799ace2492 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -316,6 +316,7 @@ enum joycon_ctlr_type {
>  	JOYCON_CTLR_TYPE_JCL  =3D 0x01,
>  	JOYCON_CTLR_TYPE_JCR  =3D 0x02,
>  	JOYCON_CTLR_TYPE_PRO  =3D 0x03,
> +	JOYCON_CTLR_TYPE_LIC_PRO =3D 0x06,

[Severity: Low]
Since JOYCON_CTLR_TYPE_LIC_PRO is a new controller type, does it need to be
added to the jc_type_has_right() macro?

Without it, the macro might evaluate to false, skipping the creation and
registration of the HOME LED device in joycon_leds_create().

[ ... ]

> @@ -2156,7 +2180,10 @@ static int joycon_input_create(struct joycon_ctlr =
*ctlr)
>  		joycon_config_left_stick(ctlr->input);
>  		joycon_config_right_stick(ctlr->input);
>  		joycon_config_dpad(ctlr->input);
> -		joycon_config_buttons(ctlr->input, procon_button_mappings);
> +		if (ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO)
> +			joycon_config_buttons(ctlr->input, lic_procon_button_mappings);
> +		else
> +			joycon_config_buttons(ctlr->input, procon_button_mappings);

[Severity: High]
This is a pre-existing issue, but is the input device registered before its
capabilities and force-feedback interfaces are configured?

Looking at joycon_input_create(), input_register_device() is called
immediately after the input device is allocated:

joycon_input_create() {
    ...
    ret =3D input_register_device(ctlr->input);
    if (ret)
        return ret;

    if (joycon_type_is_right_joycon(ctlr)) {
    ...
}

After this registration, the code proceeds to configure axis limits, set up
button capability bits, and add the force-feedback rumble interface.

Modifying an input device's capabilities after it has been registered can
introduce race conditions where userspace reads an incomplete capability ma=
sk
before the driver finishes initializing it.

[ ... ]

> @@ -2503,13 +2530,30 @@ static int joycon_init(struct hid_device *hdev)
> =20
>  	if (joycon_has_joysticks(ctlr)) {
>  		/* get controller calibration data, and parse it */
> -		ret =3D joycon_request_calibration(ctlr);
> -		if (ret) {
> +		if (ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO) {
>  			/*
> -			 * We can function with default calibration, but it may be
> -			 * inaccurate. Provide a warning, and continue on.
> +			 * Licensed controllers may have incompatible SPI flash
> +			 * layouts. Use default calibration values.
>  			 */
> -			hid_warn(hdev, "Analog stick positions may be inaccurate\n");
> +			hid_info(hdev, "using default cal for licensed controller\n");
> +			joycon_use_default_calibration(hdev,
> +						       &ctlr->left_stick_cal_x,
> +						       &ctlr->left_stick_cal_y,
> +						       "left", 0);

[Severity: Low]
Does calling joycon_use_default_calibration() with an error code of 0 cause=
 a
confusing kernel warning to be logged on every successful connection?

joycon_use_default_calibration() unconditionally prints a warning:

joycon_use_default_calibration() {
    ...
    hid_warn(hdev,
             "Failed to read %s stick cal, using defaults; e=3D%d\n",
             stick, ret);
    ...
}

This might falsely signal a hardware failure to users when the driver is
functioning exactly as intended.

> +			joycon_use_default_calibration(hdev,
> +						       &ctlr->right_stick_cal_x,
> +						       &ctlr->right_stick_cal_y,
> +						       "right", 0);
> +		} else {

[ ... ]

> @@ -2527,8 +2571,12 @@ static int joycon_init(struct hid_device *hdev)
>  		/* Enable the IMU */
>  		ret =3D joycon_enable_imu(ctlr);
>  		if (ret) {
> -			hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret);
> -			goto out_unlock;
> +			if (ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO) {
> +				hid_dbg(hdev, "IMU enable failed for licensed controller, continuing=
\n");

[Severity: High]
The commit message states that SPI flash calibration data is incompatible,
but does this bypass joycon_request_imu_calibration() which is called right
before this block?

Because the controller type is treated as a Pro Controller, joycon_has_imu()
returns true, and the driver might issue an SPI read to the incompatible
flash layout, parsing garbage data into ctlr->accel_cal and ctlr->gyro_cal.
This could cause incorrect IMU divisor calculations and corrupted telemetry.

[Severity: Low]
While the initialization timeouts are treated as non-fatal, does the driver
still register the IMU device and force-feedback capabilities?

If joycon_has_imu() and joycon_has_rumble() still return true, userspace
applications might be falsely informed that the controller supports rumble
and motion tracking.

> +			} else {
> +				hid_err(hdev, "Failed to enable the IMU; ret=3D%d\n", ret);
> +				goto out_unlock;
> +			}
>  		}
>  	}
> =20
> @@ -2543,8 +2591,12 @@ static int joycon_init(struct hid_device *hdev)
>  		/* Enable rumble */
>  		ret =3D joycon_enable_rumble(ctlr);
>  		if (ret) {
> -			hid_err(hdev, "Failed to enable rumble; ret=3D%d\n", ret);
> -			goto out_unlock;
> +			if (ctlr->ctlr_type =3D=3D JOYCON_CTLR_TYPE_LIC_PRO) {
> +				hid_dbg(hdev, "rumble enable failed for licensed controller, continu=
ing\n");

[Severity: High]
Is it possible that ret remains set to -ETIMEDOUT after skipping the
goto out_unlock?

Since this is the last step in joycon_init(), the function might erroneously
return the error code when it reaches the end of the function, causing the
entire probe to fail for the newly added controller.

> +			} else {
> +				hid_err(hdev, "Failed to enable rumble; ret=3D%d\n", ret);
> +				goto out_unlock;
> +			}
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but is there a race condition in
joycon_ctlr_handle_event() when reading shared state locklessly?

The interrupt handler joycon_ctlr_handle_event() checks
mutex_is_locked(&ctlr->output_mutex) and then locklessly reads ctlr->msg_ty=
pe
and ctlr->subcmd_ack_match.

If a delayed response arrives from an old timed-out subcommand while a thre=
ad
is preparing to send a new subcommand, the IRQ handler might accept the old
packet if the subcommand IDs match. It then writes the old data to the buff=
er
and signals completion, prematurely waking the waitqueue and causing the new
subcommand attempt to consume stale data.

Could proper synchronization via ctlr->lock prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-hori-suppo=
rt-v1-1-1861c0abc2e0@hectorzelaya.dev?part=3D1
