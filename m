Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD09439F78
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197976; cv=none; b=CwTeySJ8udtKCX4FfS2VbXP1RjhjFTQ/cfC1R/tKo6tp++BWS3sEmpn4dQJDnRGMNyw7gIFgUzg7wilsncxfcRHlJioP9AeZGecIa9jDoyQORi2m7McbmWOEpdoCZCaWL4rjkxJe5C0jtuRZwm815Db3tfa7mgVGHQXi4Ujbas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197976; c=relaxed/simple;
	bh=w0F21NhBP1DaAH5916IeI0CcqGRcA8IW2Hq4/2ZB2F0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U8ZRKGE0P3+0NfOjYLO5hBMkdEsejfq1O9sdjmbWWrt4b5+WsKaoo1dkS7dFUoMD16m5+srHG4/L4C7186J119tu/DwAgoge4oORZCNYlrcssvCmRR8kKmZtbUQYCjXi7ztnEi5fs34FK4UBtYfAoCAmHg+OE12sJQDJMku7J/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHIweGrp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHIweGrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2E21F000E9;
	Mon, 31 Aug 2026 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788197974;
	bh=I2/qR8kljNIbjrXoGPeydEAN/oGrI5VDK/6Xz4XJfx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cHIweGrpdvcBt74t32XXi8x4c5AW5aAydoJ38lT+dBr1dpdcb8XZusfajdhJUMhdi
	 KsqHrWrdtHDzLli9/lz6CVJPBCoxQk2lkPrsWw801zIFwLkR0hAfUlO7eoPvzfSK6O
	 MG3po4ldyOFcchyvHynbfYZnLvxjS/LTv6SAMP4j3RS8i6cbL16NPGecLz6W2F0uLu
	 tFSQzOn14WFmvJZyRCm4spYZ7xZlDe4aUPfBnON3xsylySMcxG+h5n2ccVVRTAy1Es
	 6yQgLINTyEqDMTD4hS3ONW8e5lKDaFAyWIQEueKcAFBp3oZdz1N1W9n0kAVOP1A8g4
	 V7yveqP0i/Nmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] HID: hidpp: fix potential UAF in
 hidpp_connect_event()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260831133314.4125787-633-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-633-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:39:34 +0000
Message-Id: <20260831173934.8D2E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Force feedback initialization in `hidpp_ff_init()` creates a T=
OCTOU race that leads to a guaranteed NULL pointer dereference in `input_ff=
_upload()`.
- [Critical] Missing `hid_hw_stop()` and resource cleanup in the `probe()` =
error path for G920 devices leads to a catastrophic Use-After-Free.
- [High] Concurrent access to `hidpp->input` between `hidpp_connect_event()=
` error path and `hidpp_raw_event()` leaves a race window leading to a Use-=
After-Free.
- [High] Unhandled permanent Use-After-Free for non-delayed initialization =
devices if `hidinput_connect()` fails.
- [High] Missing `cancel_work_sync(&hidpp->reset_hi_res_work)` in the `hidp=
p_probe()` error path leads to a Use-After-Free if the work was scheduled.
--

commit 4c51abc31c5c6d9a8be9e395178ab70d3b017d36
Author: Jiri Kosina <jikos@kernel.org>
Subject: HID: hidpp: fix potential UAF in hidpp_connect_event()

This commit attempts to fix a potential use-after-free (UAF) by setting
hidpp->input to NULL before calling input_free_device() in the error
path of hidpp_connect_event().

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 5e763de4b94fd..bc8761ed41a1c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4276,6 +4276,7 @@ static void hidpp_connect_event(struct work_struct =
*work)
> =20
>  	ret =3D input_register_device(input);
>  	if (ret) {
> +		hidpp->input =3D NULL;

[Severity: High]
This is a pre-existing issue, but does this still leave a TOCTOU race windo=
w?

hidpp_populate_input() assigns the allocated input to hidpp->input before
calling input_register_device(), exposing it to concurrent raw hardware
events processed in SoftIRQ (like wtp_raw_event()).

If a concurrent SoftIRQ thread evaluates !hidpp->input just before it is
set to NULL here, will it subsequently dereference the freed pointer?

>  		input_free_device(input);
>  		return;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this leave a permanent
dangling pointer if registration fails?

drivers/hid/hid-logitech-hidpp.c:hidpp_input_configured() {
	...
	if (!hidpp)
		return 0;

	hidpp_populate_input(hidpp, input);
	...
}

hidinput_connect() allocates input_dev and calls .input_configured, which
unconditionally sets hidpp->input =3D input here.

If input_register_device() then fails inside hidinput_connect(), the core
branches to out_unwind and frees the input device.

However, hid_connect() may still return success (e.g., if hidraw binds
successfully), allowing probe to finish. hidpp->input is never cleared and
remains a dangling pointer, accessed on the next hardware event.

[Severity: Critical]
This is a pre-existing issue, but does this FF initialization create a TOCT=
OU
race leading to a NULL pointer dereference?

drivers/hid/hid-logitech-hidpp.c:hidpp_probe() {
	...
	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
		struct hidpp_ff_private_data data;

		ret =3D g920_get_config(hidpp, &data);
		if (!ret)
			ret =3D hidpp_ff_init(hidpp, &data);
	...
}

hid_connect() registers the input device, making it exposed to userspace.
Then hidpp_ff_init() is called, which calls input_ff_create() setting the
EV_FF bit.

If a subsequent memory allocation in hidpp_ff_init() fails, it returns
-ENOMEM leaving ff->upload as NULL. Because the device is already
registered, userspace can open it and issue the EVIOCSFF ioctl, which
will blindly execute ff->upload(dev, effect, old).

[Severity: Critical]
This is a pre-existing issue, but does this bypass the error cleanup labels
and skip hid_hw_stop() when G920 initialization fails?

drivers/hid/hid-logitech-hidpp.c:hidpp_probe() {
	...
		if (ret)
			hid_warn(hidpp->hid_dev,
		     "Unable to initialize force feedback support, errno %d\n",
				 ret);
	}

	/*
	 * This relies on logi_dj_ll_close() being a no-op so that DJ connection
	 * events will still be received.
	 */
	hid_hw_close(hdev);
	return ret;
	...
}

When ret is non-zero, it returns directly here. This leaves the device
active in the HID subsystem, processing hardware interrupts, while the
driver's devm resources are freed by the core, leading to a Use-After-Free.

[Severity: High]
This is a pre-existing issue, but does this error path fail to cancel
reset_hi_res_work?

drivers/hid/hid-logitech-hidpp.c:hidpp_probe() {
	...
hid_hw_start_fail:
	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
	cancel_work_sync(&hidpp->work);
	mutex_destroy(&hidpp->send_mutex);
	return ret;
}

hidpp_probe() calls hid_device_io_start(), enabling incoming hardware event=
s.
A battery online event can trigger hidpp_raw_hidpp_event() to schedule
reset_hi_res_work.

If a subsequent step in probe (like hid_connect()) fails, the error cleanup
path cancels hidpp->work but misses hidpp->reset_hi_res_work. The hidpp
struct is then freed by devres, leaving the scheduled work item pointing to
freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-633-sashal@kernel.org?part=3D1
