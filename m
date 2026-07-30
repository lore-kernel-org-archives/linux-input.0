Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE482E4257
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419602; cv=none; b=r9lgBtBd1TBwGLSctHzV2R+8VFu9fDaBYd1IkOcQ7UyN9Fx1fbrPNKD1zbNhBBF5h0c7BO3T3BGPQu8kZZvMKYYIjrUzIrKTTN+0Wk3c5up9PUnd+IegiUQ3qch+KbBN4uEBniYpMiIuEyUJKHcfhNHvD/+a8BxeTrMwbj9LGOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419602; c=relaxed/simple;
	bh=gKoog7CoB4HXbPfYp2SMYUytpqzQbb7XfdiPaxBs/ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZiJh3ze6oKabEd787/Cxk8fwkIT5LMU847bt0YEahkhq30wB1343TRIrOrV8rNU9gESBkAMKgGTcZnGjERq645QHEjwjhXYKZnHM0kpuD0m6wBm+HJSAQGsNG/480Vky1YmjBtZdWh99bVSCb1lAgtgUMxPnHC6qZFW0TQJyCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+U22U8r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+U22U8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF351F00A3A;
	Thu, 30 Jul 2026 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785419601;
	bh=fmguS4yDbwRCFYmQK2E4x2LmUU9Ul7AVg5SNHVIfviM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+U22U8roCQFxp0YCx38xsskTmUg4F0HVLJ/EoABM6G1td9Mr6SJ3JK8DvRXgB5Wz
	 iq2mpKptzuF7ulec1OwcngEm9PeU8qXQAK4amVXKa7GxTwBUGS/wY46snqsdbfTxlz
	 CQG70yGzZChTF420aKcGOCXU7EK0pTn0z3rSBJlgjnDcT58Ylp6CDkqMFntDNbDW69
	 zy03deanzsYeWvHe/5JhmctUkyEkw3GuWGBTzruAo5bajT39vEbsaW0l8qJxlmxtwG
	 /FXsvmWHrEp4w+ybuf/ZvInukalrI/MoafbBwkq3cnuKo9xcmkMwX0PWJQsODphjAx
	 zgL2pI884Wwtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] input: Add FF_TRIGGER_RUMBLE effect type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guillaume Casal" <guillaume.casal.42@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260730134004.1118476-2-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
 <20260730134004.1118476-2-guillaume.casal.42@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:53:20 +0000
Message-Id: <20260730135320.EEF351F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel stack memory leak via `evdev` compat IOCTL and `uinput`.
--

--- Patch [1]: [PATCH v2 1/4] input: Add FF_TRIGGER_RUMBLE effect type ---
commit 2bed919a335670e21f97b67d6c9c64308176a631
Author: Guillaume Casal <guillaume.casal.42@gmail.com>
Subject: input: Add FF_TRIGGER_RUMBLE effect type

This commit adds a new FF_TRIGGER_RUMBLE force feedback effect type to supp=
ort
impulse triggers found on modern gamepads. It introduces the
ff_trigger_rumble_effect structure and adds it to the ff_effect union. This
avoids ABI compatibility issues that could arise from reusing existing stru=
cts
with uninitialized tail bytes.

> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 6aa703fcfcfb7..1d172489f8bc5 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h

[ ... ]

> @@ -483,6 +497,7 @@ struct ff_effect {
>  		struct ff_periodic_effect periodic;
>  		struct ff_condition_effect condition[2]; /* One for each axis */
>  		struct ff_rumble_effect rumble;
> +		struct ff_trigger_rumble_effect trigger_rumble;
>  		struct ff_haptic_effect haptic;
>  	} u;
>  };

[Severity: High]
This is a pre-existing issue, but could the handling of EVIOCSFF via compat
ioctl lead to a kernel stack memory leak when used with uinput?

When a 32-bit userspace client calls the EVIOCSFF ioctl on an evdev device
backed by a uinput device, evdev_do_ioctl() allocates a 48-byte
struct ff_effect on the kernel stack without initialization:

drivers/input/evdev.c:evdev_do_ioctl() {
    struct ff_effect effect;
    ...
    case EVIOC_MASK_SIZE(EVIOCSFF):
        if (input_ff_effect_from_user(p, size, &effect))
            return -EFAULT;

        error =3D input_ff_upload(dev, &effect, file);
    ...
}

For compat applications, input_ff_effect_from_user() only copies 44 bytes
(sizeof(struct ff_effect_compat)), leaving the last 4 bytes of the effect
struct uninitialized:

drivers/input/input-compat.c:input_ff_effect_from_user() {
    compat_effect =3D (struct ff_effect_compat *)effect;

    if (copy_from_user(compat_effect, buffer,
               sizeof(struct ff_effect_compat)))
    ...
}

If a 64-bit userspace daemon retrieves the force-feedback effect using the
UI_BEGIN_FF_UPLOAD ioctl, uinput_ioctl_handler() copies the full 48-byte
structure back to userspace:

drivers/input/misc/uinput.c:uinput_ioctl_handler() {
    ff_up.effect =3D *req->u.upload.effect;
    ...
    retval =3D uinput_ff_upload_to_user(p, &ff_up);
    ...
}

Does this sequence allow the 64-bit uinput daemon to read 4 bytes of
uninitialized kernel stack data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730134004.1118=
476-1-guillaume.casal.42@gmail.com?part=3D1
