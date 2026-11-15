Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794713481;
	b=cfcsU62KbCmKDp/aJot0gDdoQ5UW1yZAdw4CIdOHKVRG8LXtREDoNlUh5Luaaiq8u2ga
	 8zxrRoOTqNJq/WQvkjT7zbBOc867I0q7eoCcTU/v6GARvSJMO9rwVnM7eKTNkwBmpgtwm
	 F42dlXc0nGsEzgkSurgOQgFHl6LHAgJVHkgORIWio4aQ8gxA8+OSBUNTounTDLzTZRyHz
	 IBLPaGmnM4+2R1hkPowzDODpnPMw4duAY5+0GVUpMtDMUKQ71kCOxQXfZvo/dxaxDDRUv
	 ehOa14nmG4qhXDXKoscyRmDXBWNdNUl1C4bIBQ0tMfg0ig7/XfhufGIRo48YarWnNHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794713481;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=opdnzTfzhNTWsQQC2dW8J1Z7hFTL4yr/jGk57Qwi/JM=;
	b=yBz72KmJ8LNjObL+5ZWKVnhlyYtPQoF8q2NPp+ti1Bm64rxDRBqwha0iptT4secFwFJY
	 W5rJ+A3lgOI3QNrltaxFLgVVzPrmWQz5qjtCrEkMa8Z26FdJrAGkETwvMKEdSdasSDBzW
	 9qREi3WnmtA+/vYFuNEbVIzjclkBTWFZOvvld1mdhfPIdkcXxmapVsf9pqf+wJClgXSXo
	 kmbLxO+usoEy+GqmT7nCSKxH1ZGZfTPADDk7XV/AweRmfP7tUrs5zmvHiGjjanou0oTkB
	 NpuuuNgmLOqObTiCOAgC9dwFjne2ZzMd61V2wD7+nJxu3rf1iTWDfzeJMEuBTX/EOhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keQPl7DD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFED606A323
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=keQPl7DD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A441F000C4;
	Sun, 15 Nov 2026 03:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794713481;
	bh=opdnzTfzhNTWsQQC2dW8J1Z7hFTL4yr/jGk57Qwi/JM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=keQPl7DD3+vZehssjUIOoRJUXL6/HMGfT0VIOMgGpd8dKRW6gVXxIkGhax3+lAIoU
	 21AbjRDn36hJOaqdOWNYjeT/+a9K+X79L7NqmzwlvoAHmwhE+czuz+F2kcQhx4y9zB
	 l/tTechlQC+I2WC9AXW1ll6A+PwSi9yhaF+c8OKmXXl198xpXywwHFKoT5CkGlvgbu
	 uL+eG/BMwUs6e0qv80uUD3TOmGfCK1PBXB1gTZuZJR2CuwKNSzvFknsT+O5agEpLQh
	 wnuzhbSUhLAq8xbLJzuGhD/eRd5ZiJKkd3jVsBPuEL9YNILin+rn/j+a4xAs1bBI6t
	 aPytmQCpVm8Og==
Message-ID: <sashiko-outbox-215202@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: hid-msi: Send a uevent when the MCU changes the
 mode by itself
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ana Veto" <green.koala2979@fastmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261115032314.7094-1-green.koala2979@fastmail.com>
References: <20261114221440.12580-1-green.koala2979@fastmail.com>
 <20261115032314.7094-1-green.koala2979@fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:31:20 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: hid-msi: missed uevent and stale state in
  claw_switch_mode() race
--

commit cd52e9bad8fc6caa521f438abf30e16af93b21b9
Author: Ana Veto <green.koala2979@fastmail.com>

HID: hid-msi: Send a uevent when the MCU changes the mode by itself

This commit schedules a work item to emit a KOBJ_CHANGE uevent when an
incoming GAMEPAD_MODE_ACK report changes the stored gamepad mode or M-key
function, and updates the stored state after a SWITCH_MODE output report
unless a report arrived during the transfer.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 23d731f700c90..dcbab90f32060 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -387,17 +389,40 @@ static int get_endpoint_address(struct hid_device *=
hdev)
>  	return -ENODEV;
>  }
> =20
> +static void claw_mode_event_fn(struct work_struct *work)
> +{
> +	struct claw_drvdata *drvdata =3D container_of(work, struct claw_drvdata=
, mode_event);
> +
> +	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
> +}
> +
>  static int claw_gamepad_mode_event(struct claw_drvdata *drvdata,
>  				   struct claw_command_report *cmd_rep)
>  {
> +	bool changed;
> +
>  	if (cmd_rep->data[0] >=3D ARRAY_SIZE(claw_gamepad_mode_text) ||
>  	    !claw_gamepad_mode_text[cmd_rep->data[0]] ||
>  	    cmd_rep->data[1] >=3D ARRAY_SIZE(claw_mkeys_function_text))
>  		return -EINVAL;
> =20
>  	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
> +		changed =3D drvdata->gamepad_mode !=3D cmd_rep->data[0] ||
> +			  drvdata->mkeys_function !=3D cmd_rep->data[1];
>  		drvdata->gamepad_mode =3D cmd_rep->data[0];
>  		drvdata->mkeys_function =3D cmd_rep->data[1];
> +		drvdata->mode_reports++;
> +	}
> +
> +	/*
> +	 * The MCU changes the mode or M-key function by itself, e.g. while
> +	 * View+LB is held. Userspace learns of changes only through uevents.
> +	 */
> +	if (changed) {
> +		guard(spinlock_irqsave)(&drvdata->registration_lock);
> +		/* Pairs with smp_store_release from cfg_setup_fn and claw_remove */
> +		if (smp_load_acquire(&drvdata->gp_registered))
> +			schedule_work(&drvdata->mode_event);
>  	}
> =20
>  	return 0;
> @@ -656,11 +681,14 @@ static int claw_hw_output_report(struct hid_device =
*hdev, u8 index, u8 *data,
>  static int claw_switch_mode(struct hid_device *hdev, enum claw_mode_fiel=
d field, u8 val)
>  {
>  	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	unsigned int reports;
>  	u8 data[2];
> +	int ret;
> =20
>  	guard(mutex)(&drvdata->cfg_mutex);
> =20
>  	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
> +		reports =3D drvdata->mode_reports;
>  		switch (field) {
>  		case CLAW_FIELD_GAMEPAD_MODE:
>  			data[0] =3D val;
> @@ -673,8 +701,23 @@ static int claw_switch_mode(struct hid_device *hdev,=
 enum claw_mode_field field,
>  		}
>  	}
> =20
> -	return __claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, dat=
a,
> -				       ARRAY_SIZE(data), 0);
> +	ret =3D __claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SWITCH_MODE, da=
ta,
> +				      ARRAY_SIZE(data), 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The driver's own change is no change to report. A report that came
> +	 * in during the transfer may already show a newer state; keep it.
> +	 */
> +	scoped_guard(spinlock_irqsave, &drvdata->mode_lock) {
> +		if (drvdata->mode_reports =3D=3D reports) {
> +			drvdata->gamepad_mode =3D data[0];
> +			drvdata->mkeys_function =3D data[1];
> +		}
> +	}
> +
> +	return 0;
>  }

[Severity: Medium]
Can a GAMEPAD_MODE_ACK report that arrives during claw_switch_mode()
suppress drvdata->mode_event when it carries the same state that was stored
in drvdata before the write?

When a report sets drvdata->mkeys_function to CLAW_MKEY_FUNCTION_DISABLED,
userspace reacts to the uevent by calling mkeys_function_store() ->
claw_switch_mode() to write CLAW_MKEY_FUNCTION_MACRO.  Because
claw_switch_mode() leaves drvdata->mkeys_function at the old value while
__claw_hw_output_report() runs, a second report carrying
CLAW_MKEY_FUNCTION_DISABLED during the transfer sees no change from the
pre-write state:

CPU0                                  CPU1
claw_switch_mode()
  /* mkeys_function is DISABLED */
  reports =3D drvdata->mode_reports;
  data[1] =3D CLAW_MKEY_FUNCTION_MACRO;
  __claw_hw_output_report(...)
                                      claw_gamepad_mode_event()
                                        /* cmd_rep->data[1] is DISABLED */
                                        changed =3D false;
                                        drvdata->mode_reports++;
                                        /* mode_event not scheduled */
  /* mode_reports !=3D reports */
  /* skips updating drvdata */        <-- no uevent emitted

If that report was sent after the MCU processed SWITCH_MODE (for example,
View+LB overriding M-keys back to disabled), the controller stays disabled
with no KOBJ_CHANGE uevent emitted; if the report was already in flight
before the MCU processed SWITCH_MODE, the MCU switches to macro while
drvdata->mkeys_function remains DISABLED, so the next unsolicited report
reverting to disabled will also see changed =3D=3D false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115032314.7094=
-1-green.koala2979@fastmail.com?part=3D1
