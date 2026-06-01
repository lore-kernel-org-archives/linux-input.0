Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437B3AD512
	for <linux-input@vger.kernel.org>; Mon,  1 Jun 2026 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324002; cv=none; b=dDUXSxEWP6dkCnxmHqA2NIzgK6N6GyQhH94f8wdJ7st4RroHRU2v69YGRBe6fgJ3boBshHkTSdJ0DBdWlZex4b+s9Z4zosKzYxjEjq5HPCdn00vkV9H9zpUv6LyJ+qjlTmuQPm5izfwOLaDD7r8vsSEMqsivVnrCnT++3cxdi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324002; c=relaxed/simple;
	bh=XxIhJztzg8PjWH7VCGJEUFGLUF/eS5F+Pg8M990LuN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NkQiAKF7oW42kHeaV1oSVMrjH5NBpLABV1RI9SGsv4Rk4gxPHwi4w1uc8xbvzvnoeqr4H9O6pQZStz/sJZO7y85Iq1/fks+WSd45a0bJdEubr6hOplH5tirm1e/D6hP11cKOOLwvrrVLXU8AKRjloyNmq2E2oh3J1ANoQ2tXlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozWIFRoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozWIFRoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9510C1F00893;
	Mon,  1 Jun 2026 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324000;
	bh=JEVah1QlUFTO/+qze4c9GAsuJEetGLZScRbe9SOj5K4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozWIFRoZYcMBHRjhJNnusuKiq6mTvlkDDMiSdeMa0o70TaI0Z029q0QbQs3oQ/jug
	 3ibUKBBucPQwltvckSDeWN3yQujYl2kKoxVq+7STQ/uUNOTfnT3WbS+vHXijwvUUyk
	 8CP9f3SXhi49FxE2bw0QbOq5QmCGQHWgmSMxHYs1h9Cln3D4g7mJog3MfU8H88XlJJ
	 DjRVcAYDhT0igmoiSrZWAsJkDzl/y83EYCJ6ndojhMtt2TVkoWwQ7+pWi0MsRWRE5Y
	 S20Wlp70OrtWtf0nwCULFSbxw7FKekV30t7jI6FF3cs8zg/DvzOtnaBIq0HutUVy3J
	 EgkBxw7KW3h9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] HID: wacom: Fix Use-After-Free in
 wacom_intuos_pad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260601140845.1237227-1-lee@kernel.org>
References: <20260601140845.1237227-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 14:26:40 +0000
Message-Id: <20260601142640.9510C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Moving wacom_add_shared_data() to the end of wacom_parse_and_r=
egister() causes an unconditional NULL pointer dereference during device pr=
obe.
- [High] Moving wacom_add_shared_data() to the end of the probe function cr=
eates a window where wacom_wac->shared is NULL while hardware interrupts ar=
e active, leading to an asynchronous NULL pointer dereference.

Pre-existing issues:
- [High] The patch incompletely fixes a Time-of-Check to Time-of-Use (TOCTO=
U) race condition. It successfully converts wacom_intuos_pad() to use RCU, =
but leaves identical lockless accesses unprotected in wacom_wac_pad_event()=
, wacom_wireless_irq(), and wacom_status_irq().
- [High] Modifying input capabilities on the sibling touch device after it =
has already been registered with the input core.
--

commit 5bec6e8c12bc84f46d120679cc4bef944e215dc2
Author: Lee Jones <lee@kernel.org>

HID: wacom: Fix Use-After-Free in wacom_intuos_pad
   =20
This commit resolves a Time-of-Check to Time-of-Use race condition by
introducing RCU protection for the touch_input pointer. It also delays the
call to wacom_add_shared_data() to ensure correct devres release order.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c

[ ... ]

> @@ -2362,11 +2374,14 @@ static void wacom_set_shared_values(struct wacom_=
wac *wacom_wac)
>  	}
> =20
>  	if (wacom_wac->shared->has_mute_touch_switch &&
> -	    wacom_wac->shared->touch_input) {
> -		set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -		input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> -				     SW_MUTE_DEVICE);
> +	    rcu_access_pointer(wacom_wac->shared->touch_input)) {
> +		struct input_dev *touch_input =3D rcu_dereference_protected(wacom_wac-=
>shared->touch_input,
> +									lockdep_is_held(&wacom_udev_list_lock));
> +		set_bit(EV_SW, touch_input->evbit);
> +		input_set_capability(touch_input, EV_SW, SW_MUTE_DEVICE);
>  	}
> +
> +	mutex_unlock(&wacom_udev_list_lock);
>  }

[Severity: High]
This is a pre-existing issue, but does this capability modification happen
too late?

In wacom_set_shared_values(), input capabilities are modified on the sibling
touch device. Because the Pen interface probes after the Touch interface,
this occurs on a sibling's touch_input device that was already fully probed
and registered.

The input subsystem requires that all capabilities must be fully initialized
before calling input_register_device(). Modifying capabilities
post-registration means the ADD uevent has already been emitted, and
userspace components miss the capability changes and might fail to process
events like SW_MUTE_DEVICE.

[ ... ]

> @@ -2442,10 +2457,6 @@ static int wacom_parse_and_register(struct wacom *=
wacom, bool wireless)
>  		goto fail;
>  	}
> =20
> -	error =3D wacom_add_shared_data(hdev);
> -	if (error)
> -		goto fail;
> -
>  	error =3D wacom_setup_inputs(wacom);
>  	if (error)
>  		goto fail;

[Severity: Critical]
Does this change introduce a regression during device probe?

By removing wacom_add_shared_data() from this earlier location,
wacom_wac->shared is left uninitialized (NULL). However, wacom_setup_inputs=
()
is called immediately after:

wacom_setup_inputs()
   wacom_setup_touch_input_capabilities()
       if (wacom_wac->shared->touch->product =3D=3D 0x361) {

Because wacom_wac->shared is unconditionally dereferenced for some devices
like INTUOSP2_BT and WACOM_27QHDT inside wacom_setup_touch_input_capabiliti=
es(),
could this cause a NULL pointer dereference during initialization?

[ ... ]

> @@ -2496,6 +2507,10 @@ static int wacom_parse_and_register(struct wacom *=
wacom, bool wireless)
>  		}
>  	}
> =20
> +	error =3D wacom_add_shared_data(hdev);
> +	if (error)
> +		goto fail_quirks;
> +
>  	wacom_set_shared_values(wacom_wac);
>  	devres_close_group(&hdev->dev, wacom);

[Severity: High]
Is there a race condition here since wacom_add_shared_data() is now called
at the very end of the probe function?

Before reaching this point, wacom_parse_and_register() has already called
hid_hw_start() and wacom_register_inputs(). hid_hw_start() enables incoming
HID reports and wacom_register_inputs() exposes the device to userspace.

If a hardware interrupt fires right after hid_hw_start(), the interrupt
handlers can execute while wacom_wac->shared is still NULL:

wacom_bpt_pen()
    wacom->shared->stylus_in_proximity =3D true;

Could this cause an asynchronous NULL pointer dereference if a report
arrives before the shared data is allocated?

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c

[ ... ]

> @@ -650,11 +650,18 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  	input_report_key(input, KEY_CONTROLPANEL, menu);
>  	input_report_key(input, KEY_INFO, info);
> =20
> -	if (wacom->shared && wacom->shared->touch_input) {
> -		input_report_switch(wacom->shared->touch_input,
> -				    SW_MUTE_DEVICE,
> -				    !wacom->shared->is_touch_on);
> -		input_sync(wacom->shared->touch_input);
> +	if (wacom->shared) {
> +		struct input_dev *touch_input;
> +
> +		rcu_read_lock();
> +		touch_input =3D rcu_dereference(wacom->shared->touch_input);
> +		if (touch_input) {
> +			input_report_switch(touch_input,
> +					    SW_MUTE_DEVICE,
> +					    !wacom->shared->is_touch_on);
> +			input_sync(touch_input);
> +		}
> +		rcu_read_unlock();
>  	}

[Severity: High]
This is a pre-existing issue, but did this patch miss a few other places
where touch_input is accessed locklessly?

This update successfully converts wacom_intuos_pad() to use RCU, but there
are other HID event handlers in wacom_wac.c that still directly dereference
wacom_wac->shared->touch_input without holding rcu_read_lock().

For example, in wacom_wac_pad_event():

    if (wacom_wac->shared->touch_input) {
        ...
        input_report_switch(wacom_wac->shared->touch_input, ...);

Similar direct accesses happen in wacom_wireless_irq() and
wacom_status_irq(). Because these readers do not establish an RCU read-side
critical section, synchronize_rcu() in wacom_remove_shared_data() will not
wait for them.

If the sibling touch device is unbound, could the input_dev be freed while
these handlers are still running, resulting in the same use-after-free issu=
e?
Direct access to an __rcu pointer may also trigger Sparse warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601140845.1237=
227-1-lee@kernel.org?part=3D1
