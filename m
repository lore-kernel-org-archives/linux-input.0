Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B4440636
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170348; cv=none; b=A0R1d5ygNy7KP+HYHHKSqCNlyMZVOG94M/UY8fDw1S4ZnW+O7fcBmgu3Dfalr/0i5zOMKkHbAu+98SR7NQdRFryRoJZ37q0GqPCcdufbBeWvQnsADSmrOhtl0RbpZ1itoNMpneZ+QnEgx9itjC5HkNIqh41jO1UF7+vQHn30iv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170348; c=relaxed/simple;
	bh=HRfJ0XMvlzfykwGVEAX3JAYTmPlPt8lt6m/Aib5msg8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MZnaAEW5Bd5/hCsg4tPEMoLDoAl4c6X+d9NHRK7GLiliSHV/L4ojR6BNXIz/QEGgafHYr0NGfMH4QsHeFbBuu7sy/8xIplbyV8IvF9pjyGiHObJTYA+qrrrWum0Jxrt8vJNKLnSqY+uzYaU9MB62nv/VC5e3y9bBxzZ8XHXo9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9PUgEHt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9PUgEHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354281F000E9;
	Wed, 19 Aug 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170347;
	bh=PIw7YmNByeVGVoYe5xipx14cJfRccg3A2n536su24tc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9PUgEHtvTffCnsQmjS4/P3bgVgtHT3WFT8iy7x0oAyL/e6TKOp+EIU3y3lKbXSrz
	 Ss3y8uRCiEjs/Tuuy2rbllNydAO8Anj+UfJZqc/oV2KjFrEF+EkKqpAOIq9Wh7OJDJ
	 O7jQCRDP4pF47IMsyJkOe+iMlhGGhOFgmlFDOfkjyyYahbYUBz6hvAdyDJSjlJZNJC
	 fDOL5Ro15vvAnII0PSo5fTEXFEahA8Dy8opc99Pz748TqBEe01Sdw1zgTncVq/c27y
	 QrhP0Pfm3v4XS5YH5VqDhZ/33zXHLzsQexFdAis5y5XX+cCfwBBTD4ToDi73TRRAtb
	 7oSjp+Goqpuhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] HID: asus: add support to force feedback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260819195835.1649657-10-denis.benato@linux.dev>
References: <20260819195835.1649657-1-denis.benato@linux.dev>
 <20260819195835.1649657-10-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 20:12:26 +0000
Message-Id: <20260819201227.354281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Concurrent unbind of the gamepad interface causes a Use-After-Free=
 of its `hid_device` in `hid_asus_ally_init()`.
- [Medium] Data race and lifecycle violation on `ally_x_hdev` causes droppe=
d force-feedback events and undefined behavior.
--

--- Patch [9]: [PATCH v2 09/12] HID: asus: add support to force feedback ---
commit 009ee410a607fb5f11138c63d43a972421d99051
Author: Denis Benato <denis.benato@linux.dev>
Subject: HID: asus: add support to force feedback

Unlike ROG ally the X version and following ones uses DInput protocol
and the force feedback needs to be implemented as its protocol is
vendor-specific, therefore add support for FF_RUMBLE with magnitude
scaling on a work-queue based approach to avoid using possibly
sleeping calls in atomic context.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 6f43b7317168f..ca3050fea843b 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
[ ... ]
> @@ -2519,6 +2555,86 @@ static bool ally_x_raw_event(struct input_dev *inp=
ut, struct hid_device *hdev,
[ ... ]
> +static void ally_x_ff_work_fn(struct work_struct *work)
> +{
> +	struct ally_handheld *ally =3D
> +		container_of(work, struct ally_handheld, ff_work);
> +	struct hid_device *hdev =3D NULL;
> +	struct ff_report report;
> +	bool update =3D false;
> +	int ret;
> +
> +	scoped_guard(spinlock_irqsave, &ally->ff_lock) {
> +		if (ally->update_ff) {
> +			report =3D ally->ff_packet;
> +			ally->update_ff =3D false;
> +			update =3D true;
> +			hdev =3D ally->ally_x_hdev;
[Severity: Medium]
Will this read of ally_x_hdev race with the assignment in
hid_asus_ally_probe()?

Here in ally_x_ff_work_fn(), the hdev pointer is read under the ff_lock.
However, during probe, ally_x_hdev is assigned under a different lock
(ally_data_lock):

hid_asus_ally_probe() {
	...
	spin_lock_irqsave(&ally_data_lock, flags);
	ally_drvdata.ally_x_hdev =3D hdev;
	spin_unlock_irqrestore(&ally_data_lock, flags);
	...
}

> +		}
> +	}
[ ... ]
> @@ -2574,6 +2690,21 @@ static int ally_x_setup_input(struct hid_device *h=
dev, struct ally_handheld *all
[ ... ]
> +	ret =3D input_ff_create_memless(input, NULL, ally_x_play_effect);
> +	if (ret) {
> +		hid_err(hdev, "Failed to create force-feedback: %d\n", ret);
> +		goto ally_x_setup_input_err;
> +	}
> +
>  	ret =3D input_register_device(input);
[Severity: Medium]
Is it possible for userspace to immediately send force-feedback events as
soon as this registers, before ally_x_hdev is initialized?

If input_register_device() returns successfully, the device is exposed to
userspace. If a client immediately sends an effect, ally_x_play_effect() can
schedule ally_x_ff_work_fn().

Since ally_x_hdev is only assigned later in hid_asus_ally_probe() after
setup completes, could ally_x_ff_work_fn() see a NULL ally_x_hdev and drop
the initial effects?

>  	if (ret) {
>  		hid_err(hdev, "Failed to register Ally X gamepad device: %d\n", ret);
[ ... ]
> @@ -2592,13 +2723,28 @@ static int ally_x_setup_input(struct hid_device *=
hdev, struct ally_handheld *all
> =20
>  static int hid_asus_ally_init(struct hid_device *hdev, struct ally_handh=
eld *ally)
>  {
> -	int ret;
> +	struct hid_device *x_hdev;
> +	unsigned long flags;
> =20
> -	/* Failure at this point is non-critical */
> -	ret =3D ally_gamepad_send_packet(ally, hdev, ALLY_FORCE_FEEDBACK_OFF,
> -				       sizeof(ALLY_FORCE_FEEDBACK_OFF));
> -	if (ret < 0)
> -		hid_err(hdev, "Ally failed to init force-feedback off: %d\n", ret);
> +	/*
> +	 * The force-feedback "off" packet belongs to the gamepad interface,
> +	 * which consumes it as an output report: the config interface probed
> +	 * here would reject it. The gamepad probe path sends the packet itself,
> +	 * so this only matters when the gamepad interface is already bound,
> +	 * e.g. after a reset resume that re-initialized the MCU.
> +	 */
> +	spin_lock_irqsave(&ally_data_lock, flags);
> +	x_hdev =3D ally->ally_x_hdev;
> +	spin_unlock_irqrestore(&ally_data_lock, flags);
> +
> +	if (x_hdev) {
> +		/* Failure at this point is non-critical */
> +		int ret =3D ally_x_send_ff_off(ally, x_hdev);
[Severity: High]
Can this use the hid_device after it has been freed?

The ally_x_hdev pointer is read and cached under ally_data_lock, but it
is used after the lock is dropped without acquiring a reference via
get_device().

If userspace concurrently unbinds the gamepad interface via sysfs, the
gamepad's remove callback (hid_asus_ally_remove) will clear
ally->ally_x_hdev and return, allowing the HID core to destroy and free
the hid_device structure.

Since hid_asus_ally_init() operates outside the lock without a reference,
would this result in ally_x_send_ff_off() dereferencing a freed pointer?

> +
> +		if (ret < 0)
> +			hid_err(hdev, "Ally failed to init force-feedback off: %d\n",
> +				ret);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819195835.1649=
657-1-denis.benato@linux.dev?part=3D9
