Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CCF439903
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418831; cv=none; b=lsZjjg2LkHQ08sMF+B/ohLw14QQ//KeFYnf13wxL+VXwsSyl4eoYvogrn0TEifRdksn6gGCnQu8tBEExZ2UX5yoSkDDU1zUdNlKnOLhide6vHBjIYXR0qaK2fDWqoyrL8e120O6eCr1SnUKll3eBLIj6FmpewIZ/K90pf+xOyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418831; c=relaxed/simple;
	bh=/q1OjoHS6MiKNeHhu9PPhy+3MlydIup74UGW+aL9gS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrZ+YI9LftUY6Tdys9MbmZl9EM5ZPXTQJBJBEgGIw0CVOABZMVjjmI2kqnmkfhp4Wh9pvU41i0eZXzqi8xkenrwciFGA+YjDNwu7QRqsFKZnefqtB+Hhm39+GqRLqhPNMgejkZjaPkxmgCfGNEU3+8va89pnp1K7wEsRlGl/GHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfHFyO47; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfHFyO47"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so20834125e9.2
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785418828; x=1786023628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hAFpVRzBiMTtEH84JsrcqWwHWR7JlfZJmQLb9fZx3Lg=;
        b=hfHFyO476PnPaEVSq2iCfR8XfH6xJjNw2sk95nwQ9GPluVGijzT5NzQ2tOSBbEoByj
         MbrGeOHXxPGAetrdbghU2TiNinVvKkdH97qW3kdO/F8AXlWByCfO4eixgz7QnLR6muY0
         O7VTOh/dpLju9yERsR7dKxRdc0rVbzMHhXHqlyvemGINbQIo4w9nYW8PWVJVP5w0KOp5
         mRwNu+/lSnGB/4le2Np7l6ZEX4MV1QrPONP7IW/IVuPf/8WA6/FbCYKduI2fIHgSj9kh
         lrCZAgZ06562ckfWXMbiuFG169rQl7UwBWvfVJS3WT9aboeH97ty6ontNL61ZDY9fTXH
         ou6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418828; x=1786023628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hAFpVRzBiMTtEH84JsrcqWwHWR7JlfZJmQLb9fZx3Lg=;
        b=eptgqYxc7yNLXv98JpFsBxUMRfVImznfJLM0eAFRui367z+gz9aOZZS6wwdlDrXCKd
         cB9EWbo1fnaR/U+NY3RnwAQiCRbqRgQbGFRj2HBocwmDzsPL+Tzudf4pK82XEj6wxgLe
         Q9wv0P3M9gVPZ1o4VG8SCAxOMK0+tgvgRZY0ZxeuDIQ6ByPjDQJpWKey1InWLxs3uCQa
         DHtj6MfZcLLpO0n4Ylx/lrVjkeMzDbEOAHX2cnhr5RXEL/6iKzPv2B0g9+5okr0Q/kYx
         3V/pqXJR2+jXkeO3UzYrBfRaIVvfx2nQ1xe/GuPozV8xR2t+Cd8v5lhF9fXumFFPU1nl
         UkJw==
X-Gm-Message-State: AOJu0Yz+dD8BzRiL812H9SS/Of7Re0PXZpCWTBrX0tpGuJ5fBWpT3lxa
	IGFfgdgfZRKLoyAnnyGdxKwH21iu/2naHfS1b/Qk1EnLwavB+qdsHooO849vQiDX
X-Gm-Gg: AR+sD10BglLXA+j000ClwzqQD9v1yR7O6WW7T96NtUTTSr1JNacloRiimfkxOU8W5An
	mehF2YdtmA7rFpyGOtleHflq+N1ppEEiFnO+YTGc7q2dRgAKtM82MOcbyVE2PoFtClDk8ByorBV
	tv0Bl30Z3HhIMjYvfy7mF0bWmW60odUF0E6S0Bj2mWLMVqdLtSAuz8yPW8ixQN4X6viHJQ3Hmxs
	lR63Ef4NniilEqowdoewM5u9jNHM1rUaPrqpgEjFhP7fsNWkkV4Q26F/TJGEyom/LIBv42HorOi
	aUcPxwW8fzJSMN3eK4i2H+DOYo4a4YO03V3Ky6WQtxnBoF43dEG+o82ibdstsb/gv8Rs41GfhLK
	//E59GfaaPhLhkh8g/sQXMRqWXG7kTod6oS5cpdpIwyzqND4Jp/XgYsKwmjMOR4/zpXvfr/nODS
	i2cb8/JCF9Hpw/3jv3Af4eZaXXcJFWGzliCXmZho+k115yqkEbwlFJF7eNy/N0XApU1mDyCyCNw
	Z2RLRNp0IdXg7WQzMdP
X-Received: by 2002:a05:600c:4f8a:b0:495:472c:208d with SMTP id 5b1f17b1804b1-49800ebb090mr37096515e9.38.1785418827676;
        Thu, 30 Jul 2026 06:40:27 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498012168e7sm66405305e9.15.2026.07.30.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:40:27 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v2 0/4] input: force feedback for trigger rumble motors
Date: Thu, 30 Jul 2026 15:40:00 +0200
Message-ID: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
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
 include/uapi/linux/input.h | 17 ++++++++++++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)
