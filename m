Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794277612;
	b=Pk1M+FBJ7ZVGfRzOv/vvxjEWylvCQbVUkQ80c+KkwJVwLNSwv9IOcgL0d4IOfjHKCjSD
	 pMAut43nmY641MlMVlJ5ZPQfHbgzBHsIspmar+LOQeVc1FuLb8MTXSf7Wfw84M1rUMPX1
	 bDlFGYPhfbGbs8VKVX871Q47hhxGtnI/xYil3OYQXUS1l0D+qOPSagwbNAG7i9vbmH4Gi
	 MntcMQo9owkKSwhFOvFl4hXIWDs5UfFp9GXqLezgQ8lxQjHSEkLEqUNexgFQi/T+W83C8
	 B9AsYxlFhjj7xd5a2oluccwwkqQGSxQgIIp8n02sNy3qav9EkQuXzu2U6kDVBiWOaGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794277612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pGOLXfbJoZpGjYl0Tap4GTUEfcKyTrcCqnjrO/UmhOA=;
	b=Whax1+wn04QmHgrv9ueCs5J5Bvx8xzvhm3v6wcTf2hddpbAGec+nrl9D3Z3kJpjwTrkO
	 /1c4R274uzv2tkvP1MXZ1Q6Itsdze1DxVZH1njUhV/Cg75cJxZ3eWckBgSsroEIuMbZdZ
	 L4j7idDxYl1M+e/tHbHfnwJR8+jQTyB62wdo1U2db5hNFU8a6LJMSqSIL+3ojgbHJsRN5
	 HVxhBWa9vh0ogBWq1w0EJ4JPv4c5aFhLkAX+Kp4ut0Zb9y+Uw+7aw6/w0bFsaC37SnFID
	 cOq09q/t9kub/lRv87rsmAHSfc9I+iE3Xe5hkXE95ixLcTHFw7GGSu794nkoVvsDebA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVL+Y4V2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7986606A31C
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVL+Y4V2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6AA1F0089F;
	Tue, 10 Nov 2026 02:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794277611;
	bh=pGOLXfbJoZpGjYl0Tap4GTUEfcKyTrcCqnjrO/UmhOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVL+Y4V2V9Y4v77EQj1ea37Y4S5SsZFDNgpJnrDjCGXUVp2hxfS5tdtzECjHoITu4
	 4kFLlYx8EWt73/NF7qkVuNJM3M7j3AAkRIq0A1AirXJz8thDpUXxUZmVXt7IZgr5w1
	 VsVfjQpqCcOzdRuBYneHVi97gZ528pXRceOuXaVSIZxm+vrnxKXV8olacCUj15cspf
	 8E3q9Qbox/UF1jNruznrpaKAFLE2ySQI1uH5nmIhqDgaw5dmUQUDSt4594IkPCrRcZ
	 Pe9TkEtiEyVLX/w0i/Q9qiyV8oYigSzESpHDiwm2g/I36kI53gqc22/UN5YgkdX08/
	 909Md/39XbUkw==
Message-ID: <sashiko-outbox-206045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 02/18] HID: asus: add support for ROG Ally handhelds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110020036.112884-3-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
 <20261110020036.112884-3-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 02:26:50 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] HID: asus: unignored report 0x0B in asus_input_mapping()
  duplicates gamepad
- [Medium] HID: asus: wrong report type and interface for FF off in
  hid_asus_ally_init()
- [Medium] HID: asus: missing resume_work scheduling in
  asus_reset_resume()
--

commit 31ea255aca65ddd5d73673198b56e960840e1aa1
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add support for ROG Ally handhelds

This commit adds ROG Ally and ROG Ally X handheld support to hid-asus,
including per-interface state management, MCU readiness checks, Ally X
gamepad input device registration, and vendor/Ctrl+Alt+Del key handling.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 46643022b68d0..123ed945ea77c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -129,121 +164,965 @@ struct asus_work_action {

[ ... ]

> +static const u8 ally_force_feedback_off[] =3D {
> +	0x0D, 0x0F, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00, 0xEB
> +};

[ ... ]

> +static int hid_asus_ally_init(struct hid_device *hdev)
> +{
> +	int ret;
> +
> +	/* Failure at this point is non-critical. The packet goes to this inter=
face. */
> +	ret =3D ally_gamepad_send_packet(hdev, ally_force_feedback_off,
> +				       sizeof(ally_force_feedback_off));
> +	if (ret < 0)
> +		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> +
> +	return 0;
> +}

[Severity: Medium]
Does hid_asus_ally_init() send ally_force_feedback_off as the wrong report
type on the wrong interface?

hid_asus_ally_init() runs on endpoint 0x83 (HID_ALLY_INTF_CFG_IN) and calls
ally_gamepad_send_packet() -> ally_dev_set_report() ->
asus_kbd_set_report(), which looks up buf[0] (0x0D) in HID_FEATURE_REPORT
via asus_report_len().  Report 0x0D is an output report on the gamepad
interface (endpoint 0x87, HID_ALLY_X_INTF_IN), as later added in commit
"HID: asus: add support to force feedback", rather than a feature report on
the configuration interface.  As a result, asus_kbd_set_report() fails with
-EINVAL (or sends a zero-padded feature report to the wrong interface) and
logs hid_err() on every probe and reset_resume.

[ ... ]

> @@ -512,6 +1393,25 @@ static int asus_raw_event(struct hid_device *hdev,
>  	if (drvdata->quirks & QUIRK_MEDION_E1239T)
>  		return asus_e1239t_event(drvdata, data, size);
> =20
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		/*
> +		 * Return -1 to suppress further processing by the generic HID
> +		 * input parser for reports we fully handle. The interface is
> +		 * published with rcu_assign_pointer() only after its fields
> +		 * are set, and is kept alive by the RCU read-side lock even
> +		 * if it races with the teardown in asus_remove(). Letting
> +		 * report 0x0B reach the default parser creates a generic
> +		 * gamepad and Steam Input overlaps.
> +		 */
> +		rcu_read_lock();
> +		intf =3D rcu_dereference(drvdata->ally); /* fields are published */
> +		stop_parsing =3D hid_asus_ally_raw_event(hdev, intf, data, size);
> +		rcu_read_unlock();
> +
> +		if (stop_parsing)
> +			return -1;
> +	}

[Severity: Medium]
Does returning -1 in asus_raw_event() actually prevent hid-core from
creating a duplicate generic gamepad input device for report 0x0B
(HID_ALLY_X_INPUT_REPORT)?

Returning -1 from asus_raw_event() only drops incoming reports at runtime.
The generic hid_input device is created and registered earlier during
hid_hw_start(hdev, HID_CONNECT_DEFAULT) via hidinput_connect() ->
asus_input_mapping().  Because asus_input_mapping() does not return -1 when
field->report->id =3D=3D HID_ALLY_X_INPUT_REPORT on QUIRK_ROG_ALLY_XPAD dev=
ices,
hid-core maps the standard Generic Desktop and Button usages in report 0x0B
onto hi->input and registers a second, non-functional gamepad evdev node
alongside intf->gamepad.

In addition, if report 0x0B arrives before drvdata->ally is published in
asus_probe(), or is truncated (size < 1 + sizeof(*in_report)),
ally_x_raw_event() returns false and lets the report reach the generic HID
parser.

[ ... ]

> @@ -1578,12 +2382,25 @@ static int __maybe_unused asus_resume(struct hid_=
device *hdev)
>  	if (drvdata->listener.brightness_set)
>  		asus_kbd_backlight_set(&drvdata->listener, drvdata->kbd_backlight_brig=
htness);
> =20
> +	/*
> +	 * Published with rcu_assign_pointer() after the fields are set. The
> +	 * RCU read-side lock keeps @intf alive even if the resume races with
> +	 * the teardown in asus_remove(): a work that got quiesced in the
> +	 * meantime is disabled and schedule_delayed_work() just drops it.
> +	 */
> +	rcu_read_lock();
> +	intf =3D rcu_dereference(drvdata->ally);
> +	if (intf)
> +		schedule_delayed_work(&intf->resume_work, msecs_to_jiffies(500));
> +	rcu_read_unlock();
> +
>  	return 0;
>  }
> =20
>  static int __maybe_unused asus_reset_resume(struct hid_device *hdev)
>  {
>  	struct asus_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret;
> =20
>  	if (!drvdata->tp)
>  		asus_initialize_reports(hdev);
> @@ -1591,6 +2408,22 @@ static int __maybe_unused asus_reset_resume(struct=
 hid_device *hdev)
>  	if (drvdata->tp)
>  		return asus_start_multitouch(hdev);
> =20
> +	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
> +		/*
> +		 * hid_asus_ally_reset_resume() only NULL-tests the interface,
> +		 * it never dereferences it: rcu_access_pointer() suffices and
> +		 * does not need an RCU read-side section, which would be
> +		 * illegal here anyway as the reset resume sleeps in the raw
> +		 * request it sends to the device.
> +		 */
> +		ret =3D hid_asus_ally_reset_resume(hdev,
> +						 rcu_access_pointer(drvdata->ally));
> +		if (ret) {
> +			hid_err(hdev, "Failed to resume ROG Ally HID extensions: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }

[Severity: Medium]
Should asus_reset_resume() also schedule intf->resume_work?

When a USB device is reset across system suspend/resume, the USB core calls
.reset_resume instead of .resume, not both.  Because neither
asus_reset_resume() nor hid_asus_ally_reset_resume() schedules
intf->resume_work, ally_release_vendor_keys() will not run after a
reset-resume, which is the exact USB reset/re-probe case the workaround
targets and can leave KEY_F16, KEY_F17, KEY_F18, or KEY_PROG1 stuck
pressed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110020036.1128=
84-1-denis.benato@linux.dev?part=3D2
