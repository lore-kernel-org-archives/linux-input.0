Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CB3537F5
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484669; cv=none; b=ufMdxMdjbPBf4krxMP85YA5oH+FDr8eqjNka1mqXziggXk7fetzl7iThKlCB/zc7JjhICnMWwNbKGcnML4lSvCj8gAOig8Qr46rOxU87HmoW5lwPdVK8feckDur1Q0qkL4y/rMkqwuKKi7ZK9asb34ERv0SeG23YEfWNpN9ka1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484669; c=relaxed/simple;
	bh=SJwGrGOso1jmWzB7PbpDPvyT4wim9b/i4ofs/keTe8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hYc1Z8gPomZySValnYNlH9S3A6FbJ61vGlsmEASRtB4B6DskGnEAjUWa2opuW9p0GfwJHs9VOAJPUi5fxj25OW/6I0W+CYNm2IDa0IYk5okJDwpsl8omoouL4uzjGH8VUrrMNJPuZA47ioagpBM8qZgQcgjJ5Ul+rtGyukFSXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9VzvyZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9VzvyZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E60F1F000E9;
	Fri, 31 Jul 2026 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785484667;
	bh=6SydWzpkAfUMEFoA1lKuzD+Yc4iXcMkrm4NRQZ//SsI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B9VzvyZDlrXJ+wQMFJ1QLRDLINME9SfUxVzmFsmmRsV9t86uvY/Fi5NmaYdjYgc+H
	 8cUAC+WILAewEUv5l8HNgRlZZuydgcuwEBLzGDhyknesYcyUm4UBhysKSGcYXGf4ue
	 z+05ByhDUF3L98LOA0Rx6QVD9z9eRfjdC2EBs/tibBz8gY0mpu7nll6eo8yvaAZ0uX
	 5iJr+FmLNi7utJ3pKmChh0QdhVuoglWsSr9UD9240J1qVbRbW8R401Xp94A0pIXYg7
	 xvNnkgLAObq2ctFhfGO4AnplOto9OxNtLW5DH/8/xrwKs8/QMYSTfz1V59fYehmTRs
	 1pUUALMAYUgWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] input: Add FF_TRIGGER_RUMBLE effect type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guillaume Casal" <guillaume.casal.42@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260731054159.1982164-2-guillaume.casal.42@gmail.com>
References: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
 <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
 <20260731054159.1982164-2-guillaume.casal.42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 07:57:47 +0000
Message-Id: <20260731075747.9E60F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The memoryless force-feedback core (`ff-memless.c`) lacks suppor=
t for the newly added `FF_TRIGGER_RUMBLE` effect, causing trigger rumble ef=
fects to be silently discarded.
- [Low] The `FF_TRIGGER_RUMBLE` effect is missing from the HID debug subsys=
tem's string mapping array.

Pre-existing issues:
- [High] Pre-existing 4-byte kernel stack memory leak to userspace in 32-bi=
t compat EVIOCSFF ioctl via partially uninitialized struct ff_effect.
--

--- Patch [1]: [PATCH v3 1/4] input: Add FF_TRIGGER_RUMBLE effect type ---
commit 3d2db8431a4c26c55eb87cf71c1052fd6e1eefd5
Author: Guillaume Casal <guillaume.casal.42@gmail.com>

input: Add FF_TRIGGER_RUMBLE effect type

Some gamepads carry rumble motors behind their triggers, in addition to
the ones in the grips that FF_RUMBLE drives: Xbox controllers call them
impulse triggers, and handhelds such as the ASUS ROG Xbox Ally X have
them too. The force feedback API cannot reach those motors.

[ ... ]

Based on an earlier attempt by Daniel Bomar:

  https://lore.kernel.org/lkml/20220410220449.5071-1-dbdaniel42@gmail.com/

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 6aa703fcfcfb7..e63d19d9a093d 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h

[ ... ]

> @@ -483,6 +501,7 @@ struct ff_effect {
>  		struct ff_periodic_effect periodic;
>  		struct ff_condition_effect condition[2]; /* One for each axis */
>  		struct ff_rumble_effect rumble;
> +		struct ff_trigger_rumble_effect trigger_rumble;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but does
adding to this union highlight a potential kernel stack memory leak when
struct ff_effect is used in the 32-bit compat EVIOCSFF ioctl?

When evdev_do_ioctl() in drivers/input/evdev.c declares the struct on
the stack without zero-initializing it:

drivers/input/evdev.c:evdev_do_ioctl() {
        struct ff_effect effect;
        ...
        case EVIOC_MASK_SIZE(EVIOCSFF):
                if (input_ff_effect_from_user(p, size, &effect))

Does the compat handler in drivers/input/input-compat.c leave the last
4 bytes of the 48-byte struct uninitialized by only copying 44 bytes?

drivers/input/input-compat.c:input_ff_effect_from_user() {
        compat_effect =3D (struct ff_effect_compat *)effect;

        if (copy_from_user(compat_effect, buffer,
                           sizeof(struct ff_effect_compat)))

If the evdev device is backed by uinput, can those uninitialized stack
bytes then be copied to the 64-bit uinput daemon?

drivers/input/misc/uinput.c:uinput_ff_upload_to_user() {
        if (copy_to_user(buffer, ff_up, sizeof(struct uinput_ff_upload)))

>  		struct ff_haptic_effect haptic;
>  	} u;
>  };
> @@ -491,6 +510,7 @@ struct ff_effect {
>   * Force feedback effect types
>   */
> =20
> +#define FF_TRIGGER_RUMBLE	0x4e

[Severity: Medium]
Does the memoryless force-feedback core need to be updated to support
this new effect?

Looking at ml_combine_effects() in drivers/input/ff-memless.c, it
appears FF_TRIGGER_RUMBLE will fall through to the default case and log
an error instead of populating the combined effect magnitudes:

drivers/input/ff-memless.c:ml_combine_effects() {
        switch (new->type) {
        case FF_CONSTANT:
        ...
        default:
                pr_err("invalid type in ml_combine_effects()\n");

[Severity: Low]
Should this new effect type also be added to the string mapping array in
the HID debug subsystem?

Looking at drivers/hid/hid-debug.c, debugfs reads will fail to display
the string name for FF_TRIGGER_RUMBLE without it:

drivers/hid/hid-debug.c:
static const char *force[FF_CNT] =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731054159.1982=
164-1-guillaume.casal.42@gmail.com?part=3D1
