Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251C3FFAA4
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407963; cv=none; b=HYk6QgjNMbdyeylzmqIs1TR+5d9TcajPWvhHDIhPtUF4BlVIPdwoZ5ThZ1PBCYNCYb/WgbzjGjkVqY2VFD+b5xb4i072CfxjK1HIbguigJ7H5F3l84DqtddqPa2NGlWhj1p5LJ1ADXBwkdNZaq4n/i8tPV0vko3WmlxL5ZdIBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407963; c=relaxed/simple;
	bh=qFG0F+XfCp+r5Ik9yy8r86TM2/Lux5PGNvZtGjpHzKM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c3NUegXi+8YR40AY70cbOnhLZeWeMk5e6itlGip02kw72IMxdNrjGDMuMjUQVfF41kkh1NRY0W1+CYLS6AEYpzLkwUC+0OzNifXD7v/hRPJX07j8Slm/cPzTsBdBEimebzyit6JrZiXJ6L/iobNCmQYgAyRTBnzXvkKMqqFuoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD8WoxZ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD8WoxZ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CB91F000E9;
	Thu, 30 Jul 2026 10:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407961;
	bh=1wfV/yKPf13GMgRoDOqB8Qfq8zQzYMx/cXpaWIH9HCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RD8WoxZ1+vkyl0bIgxXEy5FQPs89QSEHfq5VrlIG3CRuAsvuXHlvZjsAsdzHPLvx5
	 ymdUgPWQDG3JsPYWp1QagyXtwJVt3s0K57CUjJCyxbYP+tYaYfFe1v/JSNqq6IO3Dp
	 4h46Pe3iiNj4RnO0hEg94rnTyRQmgwknYM0tM13gDRcT0OnyS0SsDvkiJdktceYO1C
	 zj7fae65HXyXWkYUIi1aZSvAKp2U5SRgZuWDedzh3CsBR8AX0vOyiX3p1PoIiNeD4o
	 4CPT+SH8oi+a0qbRy9r8G70qZpEwtBqYEBJig5AlcH3a84bWi04UdupU68q+Xpwplq
	 /YJGAIxjLmdlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] input: Add FF_TRIGGER_RUMBLE capability bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guillaume Casal" <guillaume.casal.42@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730095317.767418-4-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730095317.767418-4-guillaume.casal.42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:39:20 +0000
Message-Id: <20260730103921.37CB91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Extending `struct ff_rumble_effect` within the `ff_effect` union b=
reaks backward compatibility for older userspace applications that use `EVI=
OCSFF` by exposing uninitialized memory as trigger magnitudes.
- [Low] Missing `FF_TRIGGER_RUMBLE` string representation in the `force` ar=
ray in `hid-debug.c`.
- [Low] `FF_TRIGGER_RUMBLE` is not documented in the Force Feedback API doc=
umentation.
--

--- Patch [3]: [PATCH 3/3] input: Add FF_TRIGGER_RUMBLE capability bit ---
commit 454627a6a6ad091c91ae3a0477831268ea8fe178
Author: Guillaume Casal <guillaume.casal.42@gmail.com>

input: Add FF_TRIGGER_RUMBLE capability bit

This commit adds the FF_TRIGGER_RUMBLE capability bit to allow userspace to
discover if a device has motors under the triggers. The capability is added
as a read-only bit at 0x62 to avoid conflicting with the effect id space.

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 3d62603a387b9..677e9505a4aa3 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -528,6 +528,7 @@ struct ff_effect {
> =20
>  #define FF_GAIN		0x60
>  #define FF_AUTOCENTER	0x61
> +#define FF_TRIGGER_RUMBLE	0x62

[Severity: High]
Does extending struct ff_rumble_effect (as mentioned in the commit message)
cause a regression for older userspace applications using EVIOCSFF?

Legacy applications frequently allocate struct ff_effect on the stack,
initialize only known fields like strong_magnitude and weak_magnitude, and
pass the struct to the EVIOCSFF ioctl.

In drivers/input/evdev.c:evdev_do_ioctl():

    case EVIOC_MASK_SIZE(EVIOCSFF):
        if (input_ff_effect_from_user(p, size, &effect))
            return -EFAULT;

This copies the entire union size from userspace. If uninitialized stack
garbage is copied, it could be interpreted as trigger_left and trigger_righ=
t.

Then in drivers/input/ff-memless.c:ml_combine_effects():

    trigger_left =3D (u32)new->u.rumble.trigger_left * gain / 0xffff;
    trigger_right =3D (u32)new->u.rumble.trigger_right * gain / 0xffff;

These uninitialized fields are actively read and processed into the final
effect playback state. Could this result in random, unintended vibration of
the trigger motors?

[Severity: Low]
Is the FF_TRIGGER_RUMBLE string representation missing in the force array?

In drivers/hid/hid-debug.c:force:

    static const char *force[FF_CNT] =3D {
        [FF_RUMBLE] =3D "FF_RUMBLE",

Without adding [FF_TRIGGER_RUMBLE] =3D "FF_TRIGGER_RUMBLE" here,
names[EV_FF][0x62] evaluates to NULL. This causes hid_resolv_event() to fall
back to printing the raw hex value ('0062') instead of 'FF_TRIGGER_RUMBLE'
in debugfs.

[Severity: Low]
Is FF_TRIGGER_RUMBLE missing from the Force Feedback API documentation?

Documentation/input/ff.rst:Querying device capabilities lists supported
EV_FF capability bits:

    - FF_GAIN    gain is adjustable
    - FF_AUTOCENTER  autocenter is adjustable

Since this commit introduces a new capability, should it be documented here
so userspace developers know how to discover trigger rumble support?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730095317.7674=
18-1-guillaume.casal.42@gmail.com?part=3D3
