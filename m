Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593E8484250
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633819; cv=none; b=P94Qo1tBEAWpIS/1HNTl1Hj7V7I7tPv7XSJeV6kK/Zh8zAM2RzCINMWCnIfNcK0f0mzKZ3qSdQ6SbfwtOXeAT+ou/YnT+P1OP4jze2l/XAsjvTH2Daa+5JDO7Mek8adNLUR/748U0YBWg3d/8qzljIvMABJuEy9BXDt+qsUbbC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633819; c=relaxed/simple;
	bh=c3SegYpGHH+W82r5UpBDlldU0bF4eb1UoPklh4rMmPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vxd75Gn/deBuyDWBd/fn/OTS9AqaLbkr3bxYhJ++aryk4dgrlkhklzH2GygffBLaFTKI5K6hnOevLDvNB7Aer7dyhPkOssyBMvax3R+Ny/8OctAjlS25PSrPSc1lQAFdPHIoFw5CYEI63+5ayCSd50SsFOSZZrWIot/NqW0ex4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amn1l1sD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amn1l1sD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E0B1F000E9;
	Thu, 13 Aug 2026 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633817;
	bh=9kRzrnSmbUCw9bpEQsja19nj/5anN7TZG4uM/ybNFFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=amn1l1sDaBnYJvcaaIFmjmcJ6+oueURetXR5dyfhNU7ujRBl2HcgmCy8G1WraX0iV
	 ULmUKLp5wFJLzOKChLhWM/mpJKe2Ss3gew6C+sGNLEdBmyhfdL9+SoCBlmUsNVzQqx
	 TJhgacGVXnuwHcDMPuz8kKMNrXyuCyW+B+t3Zbv1N9TwxViZ79eT7IOg6oMDoGlS5Q
	 Mtw/Jhe1TiflQDfW5IyJ/IkEDSW1YTV3cgwBmqqc+nWivHU1vw9j5MNnNDd69pQmj7
	 AYGSFZNrNCrk2pOjOsvTYipz5x3OiSAxKz7VNtul1Ns5R+jgxU94wQhzWAC8L4KbMv
	 6bC3Yyin3q1eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260813144736.2477941-10-denis.benato@linux.dev>
References: <20260813144736.2477941-1-denis.benato@linux.dev>
 <20260813144736.2477941-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:10:13 +0000
Message-Id: <20260813151013.C4E0B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Ignoring the return value of `input_ff_create_memless` and proceed=
ing with `input_register_device` leads to a guaranteed NULL pointer derefer=
ence in `input_ff_upload()`.
- [High] Disabling the force-feedback workqueue in `hid_asus_ally_remove()`=
 before stopping the hardware leaves the device actively rumbling.
- [Medium] Force feedback output report is incorrectly sent as a Feature re=
port, and during initialization it is sent to the wrong USB interface.
--

--- Patch [9]: [PATCH 09/12] HID: asus: add support to force feedback ---
commit 84e3caa9147b2fcf6cc7ac8459e2b9e55841248a
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add support to force feedback

This commit adds force feedback (FF_RUMBLE) support for the ROG Ally X by=20
implementing a work-queue based approach for sending vendor-specific DInput=
=20
protocol rumble packets.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 8018e61cf0264..301fe33f66b1f 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -2254,6 +2282,59 @@ static bool ally_x_raw_event(struct input_dev *inp=
ut, struct hid_device *hdev,
>  	return true;
>  }
> =20
> +static void ally_x_ff_work_fn(struct work_struct *work)
> +{

[ ... ]

> +	if (!update || !hdev)
> +		return;
> +
> +	ret =3D ally_gamepad_send_packet(ally, hdev, (u8 *)&report, sizeof(repo=
rt));

[Severity: Medium]
Does ally_gamepad_send_packet() send this data as a Feature report instead=
=20
of an Output report?

The ff_data struct is documented as an XInput force-feedback output report=
=20
(0x0d), but if ally_gamepad_send_packet() internally hardcodes the transfer=
 as=20
a HID_FEATURE_REPORT, will the hardware reject this packet?

> +	if (ret < 0)
> +		hid_err(hdev, "Failed to send force-feedback: %d\n", ret);
> +}

[ ... ]

> @@ -2308,6 +2389,16 @@ static int ally_x_setup_input(struct hid_device *h=
dev, struct ally_handheld *all
>  	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY);
>  	input_set_capability(input, EV_KEY, BTN_TRIGGER_HAPPY1);
> =20
> +	memcpy(&ally->ff_packet, ALLY_FORCE_FEEDBACK_OFF, sizeof(ally->ff_packe=
t));
> +	spin_lock_init(&ally->ff_lock);
> +	INIT_WORK(&ally->ff_work, ally_x_ff_work_fn);
> +	ally->ff_work_initialized =3D true;
> +
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +	ret =3D input_ff_create_memless(input, NULL, ally_x_play_effect);
> +	if (ret)
> +		hid_warn(hdev, "Failed to create force-feedback: %d\n", ret);
> +
>  	ret =3D input_register_device(input);

[Severity: High]
If input_ff_create_memless() fails, will this leave dev->ff as NULL while=20
EV_FF is still advertised?

Since the warning is printed but input_register_device() is still called on=
=20
failure, could this cause a NULL pointer dereference in input_ff_upload()=20
when userspace invokes the EVIOCSFF ioctl on the registered device?

>  	if (ret) {
>  		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);

[ ... ]

> @@ -2460,6 +2551,9 @@ static void hid_asus_ally_remove(struct hid_device =
*hdev, struct ally_handheld *
> =20
>  	scoped_guard(mutex, &ally_data_mutex) {
>  		if (ally->ally_x_hdev =3D=3D hdev) {
> +			scoped_guard(spinlock_irqsave, &ally->ff_lock)
> +				ally->ff_work_initialized =3D false;
> +			cancel_work_sync(&ally->ff_work);

[Severity: High]
Will this leave the device vibrating indefinitely if it is unbound while=20
rumbling?

By setting ff_work_initialized to false and synchronously canceling the=20
workqueue here, before the devres action has a chance to unregister the=20
input device, won't the input subsystem's subsequent stop commands be=20
silently discarded by the disabled workqueue?

>  			ally->ally_x_input =3D NULL;
>  			ally->ally_x_hdev =3D NULL;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813144736.2477=
941-1-denis.benato@linux.dev?part=3D9
