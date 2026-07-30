Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2C3BB67F
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405888; cv=none; b=erJeAETPCt9Dk1YyxZD/2tSY8qrEQV+aOXngdP37xY0X8b4Owv4yTLI98wiTgy/vggX9+w8kJLWUz3ZY988km5wS2HD5SqSnEBIB+NDaQgQGGGQ6uT9sK97mtYm6Y58tpNKx5VckjeeVad+Et6+YnxC/xOx8s54PdDwU6ov5cCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405888; c=relaxed/simple;
	bh=dbof+drmw4J29RphJq5vHunFZV+h5S9UwvWUfVVIFck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXyEfwN/G15O0hKIyY9ZiIswhKjpns9PgtD2y8j1w55WJsDTQizZzE0LzkOJs3+A7GPt1Ok4xg99lsxHcYa6OApspgS4FW05Ms8ZAOTJDHkZpZgYSlJxdrSgk/Q4v+tElFHHTg5yWU5O/OHSU8brRbXlSiqkUD9tS6loalZA8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDSGgXqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDSGgXqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5599E1F000E9;
	Thu, 30 Jul 2026 10:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785405886;
	bh=iXw4iCH21gJgm91TIZVC89O3QWOG8NNcCXljdwPoyIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IDSGgXqCLqiQ7/ZHN8GnrZvubCTowHbu9DRxlDgFzyJ0R2v/V97zKnrUAffMgyRYH
	 nXz8+GTyQf/C/yGAz+orz190m4nLDjuUtCNQBR/NjUF2mMFW//kdPr59yvmEn8qW09
	 1OyiQ3dMa3Q7e+/Ut9uTREQgYnS/5Jxr82KRVp0a36TjMNUjBgnqBpAShUGnICjEJa
	 liE+jFiSOjZk4ex2xNQshAYuszEyB5BiGiHixvA5CXmV5Bd/OoV4irXEEcMTL9cUr8
	 ngiNHWnr5jMq13iWsHiWQLqsFTKE6SPgWboGKhGrNgOoLnIgWaKUy3e1oR54z3O+NP
	 4WxAnqYS9PWDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] input: uapi: Add trigger_left and trigger_right to
 ff_rumble_effect struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guillaume Casal" <guillaume.casal.42@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730095317.767418-2-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730095317.767418-2-guillaume.casal.42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:04:45 +0000
Message-Id: <20260730100446.5599E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Adding `trigger_left` and `trigger_right` to `struct ff_rumble_eff=
ect` within a union breaks backward compatibility and causes random device =
actuation for legacy userspace applications.

Pre-existing issues:
- [High] 4 bytes of uninitialized kernel stack memory are leaked to userspa=
ce via the `uinput` subsystem when a 32-bit compat application sends an `EV=
IOCSFF` ioctl.
--

--- Patch [1]: [PATCH 1/3] input: uapi: Add trigger_left and trigger_right =
to ff_rumble_effect struct ---
commit 47b93f39a2f9b455e85b8381fa40a96ca5aaac36
Author: Daniel Bomar <dbdaniel42@gmail.com>

input: uapi: Add trigger_left and trigger_right to ff_rumble_effect struct

This adds two variables to control the trigger motors to the struct that
is passed in from userspace. It reuses existing union padding to maintain
the total size of struct ff_effect.

Link: https://lore.kernel.org/lkml/20220410220449.5071-1-dbdaniel42@gmail.c=
om/

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 6aa703fcfcfb7..3d62603a387b9 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
[ ... ]
> @@ -427,6 +429,8 @@ struct ff_periodic_effect {
>  struct ff_rumble_effect {
>  	__u16 strong_magnitude;
>  	__u16 weak_magnitude;
> +	__u16 trigger_left;
> +	__u16 trigger_right;
>  };

[Severity: High]
Does this break backward compatibility for legacy userspace applications?

Because struct ff_rumble_effect resides within a union inside struct ff_eff=
ect,
extending its size from 4 to 8 bytes does not change the overall size of
struct ff_effect, and the EVIOCSFF ioctl number remains identical.

Legacy userspace applications typically allocate struct ff_effect on the st=
ack
without zero-initializing the entire union padding. When calling EVIOCSFF f=
or
a rumble effect, they leave uninitialized stack memory in the trailing bytes
that now correspond to trigger_left and trigger_right.

Could an updated driver read these uninitialized fields and actuate the tri=
gger
motors based on random stack garbage?

[Severity: High]
This isn't a bug introduced by this patch, but does the input subsystem leak
uninitialized kernel stack memory to userspace during 32-bit compat ioctls?

In drivers/input/evdev.c:evdev_do_ioctl(), an uninitialized 48-byte effect
variable is declared on the stack:

	struct ff_effect effect;

When a 32-bit compat application calls EVIOCSFF, input_ff_effect_from_user(=
) in
drivers/input/input-compat.c copies only 44 bytes from userspace:

		if (copy_from_user(compat_effect, buffer,
				   sizeof(struct ff_effect_compat)))
			return -EFAULT;

This leaves 4 bytes of the effect structure untouched, containing uninitial=
ized
kernel stack data.

If this effect is uploaded to a virtual uinput device, uinput_dev_upload_ef=
fect()
stores a pointer to this stack variable. When a 64-bit uinput daemon process
calls the UI_BEGIN_FF_UPLOAD ioctl in
drivers/input/misc/uinput.c:uinput_ioctl_handler():

		retval =3D uinput_ff_upload_to_user(p, &ff_up);

it copies the entire 48-byte struct ff_effect back to userspace, reliably
disclosing 4 bytes of uninitialized kernel stack memory per ioctl call. Cou=
ld
this be exploited to read kernel memory layout?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730095317.7674=
18-1-guillaume.casal.42@gmail.com?part=3D1
