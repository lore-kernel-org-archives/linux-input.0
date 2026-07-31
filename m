Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344842BE630
	for <linux-input@vger.kernel.org>; Fri, 31 Jul 2026 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785476548; cv=none; b=TfdaD2bFjgwQqExCXUX5Qhi7vF9hEJTN7FyU6FezXKFj3ca3Wo07Rm8+jJ6liJ1TOOFEydb7gg7kKacL0MjJ5V8z4AcXVneg4XS/+MU3k7E+Zq0WersELZ43Bwkme8DR+Kn5l1oR1z0+Zy56928zc6gxhMbPZHuJpAUpVKpuIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785476548; c=relaxed/simple;
	bh=WB6Is/aW7X8nzfWIcYl8N9yq/gQRIRs4y+DPBlroJFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grUHYfsOiq/kbtokl7rvSNTARZUMvbvfOHKSGj6heEYD6Qny+/eCGaBMi/giTPL15bW+pGLy9pHgPNkIHO6UKZ4vF8jnWq9lWshlRHFLXDo18noNPBnqXCdvJ9oz8TtuH2Z1a/Zw3KnJMsRwfl8XeI+rm5T9jCzZ6NN4/rzAaIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbCkZuUK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbCkZuUK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47362928f65so526567f8f.2
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785476543; x=1786081343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7QGUGNz9K4ZPFUWjxDSHtu8e3o7o4VUtg0MNM9GivyI=;
        b=SbCkZuUK2Y3ZIizSM8Jo1ZEUHrFAWzkqQdYA4S53w3OPre8U8Wvfo8slzmo9V6w6+0
         cGUSZyrsi8S1tHG/Uy1ogRjZE+QNHg9Qh6FNd3oyRG5PxJ1M6xgI4FaygGBOEdnTqG5l
         DKZ2KpsvXWLICzsesb9pWl9ZY+MsLBf0V/lI1PEyqXjqsFY9j2bn6ldAjWKSH5QyGDry
         ip3xsd2+ojPP/SxJ8Y+wMHasvhZCvoAhxs0crooPZx+e00lmOupE5iIISXVasPU6bx1e
         TbfAGEk/0oYhVtMViopABiuiR7aHMc3yJGqQZGqTbkSW4+wi8pnvRygAYHLgwhcw7C31
         s2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785476543; x=1786081343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QGUGNz9K4ZPFUWjxDSHtu8e3o7o4VUtg0MNM9GivyI=;
        b=e/AUEeqjkMpFeGXOMk3OBkVfrbvNpkkqof6FigsIUfondeM1yCh6BiWL8X1caQWCi1
         50mN2N3ie8QhKyYwDVAaluncbkAoA5DJPM31CH4lPWd9/LN2z0GVMgKM6L183bnJDKbC
         qO+wAMT51IS5oAZw9UAc2lxQ2maYHjHJmQmUuREDHxt0wT0Ol6neni602TVD6Tv8wAz0
         fGnz91sKossx1ot/4KXxzgoI0dZUKC+QlSnhD9PzNCiaUZtibSHCjvReE2/pf8MIvojC
         LX3bGqW0FGb2+2U6l0W+1RcY5N7a16s8r+bcL2GKGEbld4OvoaQXp1bocQso2JNPUaPi
         Zv1A==
X-Gm-Message-State: AOJu0YzzyjaOaxgsKvTUESn5IITYqmF8JTTdKUZm1wY/s101G6xue5yf
	MT40yhfMcwT6m1B/NRlcqwlMVFmwZt3O9dLIHLs3BjWseW6oVAQbrFPBXxzIg8sT
X-Gm-Gg: AR+sD11bEzYPrds1lcTeDK8ncazgD26vgLoHW+yywZJlwPtAKv0Jgv19QF17dX20ZxK
	tRHMYdKB2Yy21t4SAxYiHPPVNqBtpcAGD6uMPCVv9HPdczhxLbK5X+6gekAP5+w8kqwpgQyQ4kg
	dv6RqImUBipJquUpWlHcx8TmcRzXZOyyXRAGPgIrR3suGoSuAA3cT1Xxi4Q4ytFT2+c7QtGh62R
	rO0V3hmYwi5CCir36Q7xXmOk51E0jM3JdKzifXM523CydnD/gl47gz8jzjQR0NFXGZwVEGnUlX4
	SByKuXKP9HdkZMXUy4jS2x7VKGK5SMuh7Nee4wudCZmKj3Xie96NtEjjPRkXyxoqJMi7ZqYy9Cp
	T42+qwYFouohtxD/7Jonfo3DA0TespyUccMWgoqg66PPSMiNyY8Uq2uFJeSblNaFkbbd4/tGjMu
	0i7VEPXNNQ1ufn9msLez4EOkjnhBzT4Jbssu6eGBLz0TDqTFX0F7yGuiXlUffwGiq2fjEDwozVb
	UK5YrchuLMOW0xiMTlQ
X-Received: by 2002:a05:6000:41f7:b0:47f:6f89:7dae with SMTP id ffacd0b85a97d-47fd2abbe13mr1841814f8f.6.1785476543399;
        Thu, 30 Jul 2026 22:42:23 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0ae0sm412873f8f.33.2026.07.30.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:42:22 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v3 0/4] input: force feedback for trigger rumble motors
Date: Fri, 31 Jul 2026 07:41:55 +0200
Message-ID: <20260731054159.1982164-1-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
References: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some gamepads carry rumble motors behind their triggers, in addition to
the usual two in the grips: Xbox controllers call them impulse triggers,
and handhelds such as the ASUS ROG Xbox Ally X have them too. The force
feedback API cannot reach those motors.

v1: https://lore.kernel.org/linux-input/20260730095317.767418-1-guillaume.casal.42@gmail.com/
v2: https://lore.kernel.org/linux-input/20260730134004.1118476-1-guillaume.casal.42@gmail.com/

Changes since v2
================

Patch 1: the new structure was inserted between the kernel-doc block of
struct ff_haptic_effect and the structure itself, leaving that block
orphaned and stripping ff_haptic_effect of its documentation. It now goes
after ff_haptic_effect, before the kernel-doc of struct ff_effect. No
code change.

Patch 4: the description column no longer relies on a tab that overshoots
for a name this long.

Patches 2 and 3 are unchanged.

A fifth patch ratelimiting the pr_err() in get_compatible_type() was
prepared and dropped before sending: input_ff_upload() rejects any type
absent from dev->ffbit before storing the effect, and input_ff_create()
copies dev->ffbit into ff->ffbit, so the path it was meant to protect is
not reachable for an in-tree driver.

Changes since v1
================

v1 followed the 2022 series by Daniel Bomar and added trigger_left and
trigger_right to struct ff_rumble_effect. That was wrong, and I am
grateful the problem was pointed out on the list before it went any
further.

EVIOCSFF copies the whole struct ff_effect from userspace. An
application that sets only strong_magnitude and weak_magnitude, and does
not clear the rest of the union, passes uninitialised stack content in
the bytes that v1 gave meaning to. ff-memless would then scale that
content and hand it to the driver, so a program that works today would
start buzzing the triggers at random. Keeping the size of the union
unchanged makes the layout compatible, not the meaning. This is likely
why the 2022 series never went anywhere.

v2 therefore uses a distinct effect type, FF_TRIGGER_RUMBLE, with its own
struct ff_trigger_rumble_effect, following what was done for FF_HAPTIC.
No existing application emits this type, so no uninitialised byte can be
mistaken for a magnitude. The capability bit of v1 is dropped: userspace
discovers the type in the EVIOCGBIT(EV_FF) bitmap, as it does for
FF_RUMBLE.

Two smaller points raised on v1 are fixed here as well: the missing entry
in the force[] array of hid-debug.c, and the missing line in
Documentation/input/ff.rst.

No in-tree user yet
===================

I want to be upfront about this, since it is the obvious objection: at
the tip of this series, git grep FF_TRIGGER_RUMBLE matches only the four
files it touches. No driver advertises the type, so the new arm in
ml_combine_effects() cannot run yet.

The driver that does drive it exists and is tested, on the handheld
described below, but it lives in hid-asus, which is not in mainline. Its
maintainers carry the gamepad support out of tree and upstream it in
steps. Sending its patch with this series would mean sending a patch
against a file that does not contain the code it modifies.

So the order is deliberate: settle the API here, then the driver patch
goes to its maintainers, then the SDL side. If you would rather see a
user in the same series, I can hold this until the gamepad part of
hid-asus lands upstream, but that is not under my control.

Design notes
============

ml_get_combo_effect() groups playing effects by type, so a trigger rumble
effect forms its own combo and reaches the driver in its own
play_effect() call, without disturbing FF_RUMBLE. An effect that has
finished still contributes its type with zero magnitudes, so the stop
path needs no change.

Testing
=======

checkpatch.pl reports no warnings on any of the four patches.

I booted v7.2-rc5 with this series applied under QEMU, with a small
memless driver compiled in that advertises both types and logs the
magnitudes it is handed. Userspace side, a static init issues the
EVIOCSFF ioctls. Output, kernel lines interleaved with userspace ones:

  capabilities advertised : FF_RUMBLE yes, FF_TRIGGER_RUMBLE yes

  triggers only      -> FF_TRIGGER_RUMBLE left=65535 right=65535
  grips only         -> FF_RUMBLE         strong=65535 weak=65535
  left trigger only  -> FF_TRIGGER_RUMBLE left=65535 right=    0
  right trigger only -> FF_TRIGGER_RUMBLE left=    0 right=65535

Each effect is followed by a call with zero magnitudes when it expires,
so the existing stop path needs no change.

The last case is the one that matters for the concern raised on v1. The
test fills the whole struct ff_effect with 0xAA, sets only type,
replay.length and the two rumble magnitudes, and uploads it, which is
what a careless application does today:

  old-style app, dirty union
                     -> FF_RUMBLE         strong=32768 weak=32768
                        and no FF_TRIGGER_RUMBLE call at all

The dirty bytes cannot be mistaken for trigger magnitudes, because they
never carry that meaning for an FF_RUMBLE effect. With v1 they would have
been scaled and sent to the hardware.

The same was then run against real hardware. The vendor kernel of my
handheld cannot be rebuilt, its sources are not published, so I booted
the patched kernel in a VM on the same machine and handed it the gamepad
by USB passthrough. The driver bound it as usual and the device came up
advertising both types:

  peripheral: /dev/input/event8 (ASUS ROG Ally X Gamepad)
  capabilities advertised : FF_RUMBLE yes, FF_TRIGGER_RUMBLE yes

Capturing the physical bus from the host with usbmon while the VM drove
the pad gives the reports the firmware actually received:

  triggers: L=100 R=100   grips: L=  0 R=  0    triggers only
  triggers: L=  0 R=  0   grips: L=100 R=100    grips only
  triggers: L=100 R=  0   grips: L=  0 R=  0    left trigger only
  triggers: L=  0 R=100   grips: L=  0 R=  0    right trigger only
  triggers: L=  0 R=  0   grips: L= 50 R= 50    old-style app, dirty union

The four actuators are driven independently, and the careless
application gets its 50% in the grips with nothing in the triggers,
which is the whole point of the change in shape since v1.

The driver patch that fills those two magnitudes is not part of this
series: that driver is not in mainline, and I will send it to its
maintainers once the API here settles.

Guillaume Casal (4):
  input: Add FF_TRIGGER_RUMBLE effect type
  input: ff-memless: Handle FF_TRIGGER_RUMBLE
  HID: debug: Add FF_TRIGGER_RUMBLE name
  Documentation: input: Document FF_TRIGGER_RUMBLE

 Documentation/input/ff.rst |  1 +
 drivers/hid/hid-debug.c    |  1 +
 drivers/input/ff-memless.c |  9 +++++++++
 include/uapi/linux/input.h | 18 +++++++++++++++++-
 4 files changed, 29 insertions(+), 1 deletion(-)
