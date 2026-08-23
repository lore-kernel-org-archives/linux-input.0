Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7083939A6
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 22:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787524196; cv=none; b=KiB/a9pNwOmf3L+O8FSSQo+3Roru0JuDWPzBiYPx7cgjwcvvthCTMd7JoM1qZyYh0kzXPzToIItJSzRn8lDiYYX9hCbq3bdm7AsigWrSTxvUpH/SQdSj2r8aLkb3ssf1BKxzSfXm9BVUaNeeHNKoHI1/p1K0lrolG0gAAq8P2Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787524196; c=relaxed/simple;
	bh=YPtSVgt+I83Sizs3yqlmS4qpNDxhC5ISL27cr4nIfkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9JeWmDIMsfBSM3Ndh7fnIjcwjozHBxTQQtiFDfjKfrMptWtjG/ke7lZ0ImznifTOcCPefok5ykma63Aq68DF6On7+HDVKmX+gKKsY8fuZeVDT9wMC7HAcDaO/thjofY1VTrobq+lImavLYAVzYzPdhHyL97fbrUSQ4iy6v4cMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7cp4Qt+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7cp4Qt+"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b4747943b8so2384136e87.0
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787524193; x=1788128993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ce/iFmek4waUX1AI+D3lqcH6W5Vrp1c8Zj3tDAmkQBw=;
        b=F7cp4Qt+hjUAD/y3fNcwbb0faQ3mB6AYD7T91bPYbWznbeppou1UWGoGD5K+Sa4Gvv
         S0tcpUjHaFecV0352hw3crBQZx1maNElfgEaZTQRSQoFon8YX52Baroq/iM8qRYwwx8T
         nm3IHteImQ7bs4vIhDcElmhrisoorYStusqYyVFkTM9g/dX2cRbwnT+btmgCIg8TWrJj
         og54JXJ++WBQVHrLAXFO0pj8Ub1EuH568hfsZo99N4hk7rU2nRz2be02I0NE+22A+OLk
         fIOUADXh7U+PW9kyOinNwjjixZtWtu7CCaCQDHX7I9tiMd4ygozYv5n9ZWktdTzI9FZS
         ZtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787524193; x=1788128993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ce/iFmek4waUX1AI+D3lqcH6W5Vrp1c8Zj3tDAmkQBw=;
        b=eSsnG45Zjzvo/a48eZuuaKuI6Kg3KmCEicre/uLQEA0EIxSHq7GPxN5fjngngnsyhb
         SKqioDHA4d7fyCGbhwq6dT4CtT6uzbkmYOcdG1CQLosYH11qa54ZGLv5wGRZjLxLnhbA
         EMTc4sPj95R0P1VYlMHkG2bRbUTIyvemdlzaz/iNenZTAucYR4wxYTpNmNsAFpXt7ASd
         06bel/qfkz2O0jgneXhLB28FLpmYhUsPyqcSlOmHX7QaQfdgbgqmczAaL4/60yGK3rNZ
         A2CCFMy4AnotH/5l0Qxwo2XkvrEd1dM2t+nw1Jz9eTOcsRPlHO3S2RIxryg1fR0nRAM5
         lQYw==
X-Forwarded-Encrypted: i=1; AHgh+RpOwKxRaY0OMbjS5OeXQ+nWeGQFah56O+zebIpQ3hVwWmbpQMmcdbBKYhtBEF0iYYWgAYdhKT4x+uJd3w==@vger.kernel.org
X-Gm-Message-State: AFuF++nvS5ic1oDBTa7j+eXl29sUxDYHemRxz4eUq7QpQ6ri2Qzd82ED
	icMak/n0ydg7R5nkx/LP+up2xKNpi7WLw5jl6C/jxc4qx/WovJxACKJd
X-Gm-Gg: AR+sD13LDaNazXldKjjDRqsGKQO4cdM3axLkECBSRjy19AFp4dLNiO63Yl5gS0Q2ME6
	baQx7Igl2U/HCgOobFR7jj1QMthEOeLLdpc58AcX9yx+82wBKbu4G9U4Rc31j5toTNkM+JIfmDJ
	vjxjt9wy0FAAAorWzNDPt+wqGT5Cm8Z9cpENJ7rqqq0qw86aEW5wwiVmbIbVWRnDwsAyw7EYiyG
	AVDVV7gLyWrg8BVP6d8+7BJE/vLHlfLgfSee/yRMV/iNvc0kCJyBFi1QOEp5eRpPOtArN/oqCLL
	ZTdEq44QMnCqJ3e7XT75BRctcsWKia+RCu4Zsi/hf0XfZerEj6o6kIoHUgt2Nm8g7ubWpiU+Lsu
	Fy1V0AragSqWvzN1RzcasrypIBU8HJrGHOHWifC9iRaPQp68QjQpj+I4bTE2YcTe12U+6BNVFaE
	jHzwdxEDp4gD7sG8I5cfz9VgAHdmYhRcya1B6c1/jVZbgdQwNaZ9gadkIY7bHFO5QY3e7trnw/Q
	qD48NKGgQXswMpkveuIhO0Mbnmrxgfp8mx20DMKBrcWjptThywnlBwWqHvEeUkndR+uTs8=
X-Received: by 2002:a05:6512:3c98:b0:5b1:5451:d969 with SMTP id 2adb3069b0e04-5b48b8aef26mr3724914e87.25.1787524192898;
        Sun, 23 Aug 2026 15:29:52 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2bccsm1227499e87.28.2026.08.23.15.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 15:29:51 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v4 0/2] ALSA: usb-audio: the Topping M62's vendor controls
Date: Mon, 24 Aug 2026 03:29:44 +0500
Message-ID: <20260823222946.171345-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
References: <20260823194822.29430-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 answers the automated review of v3. One of its three findings led to
a change; the other two do not hold, and I would rather say why here
than leave the question hanging for a human reader of the thread.

The change is in 2/2. The driver marks its elements USB_MIXER_BESPOKEN,
which opts them out of the mixer core's restore_mixer_value(), so
restoring across a suspend became this driver's own business. For the
gains that is covered -- the device announces them and the cache
re-syncs by itself -- but a source selector is never reported by the
device at all, so nothing covered it: if the card had come up on its
own defaults while the host slept, the driver's idea of the selector
would have been silently wrong, and writing the remembered value back
would have looked like no change and done nothing. The resume path now
writes the chosen value again.

Said plainly, because it matters for how you weigh it: I did not
observe that. This card has a battery, and with the headphone selector
on Playback 3/4 and music playing into that bus, a full suspend and
wake brought the sound straight back untouched. The change closes a gap
this driver opened by opting out of the core's restore, not a fault
seen on the hardware.

The two findings I am not acting on both concern a control callback
using a freed private structure during disconnect. The ALSA core
already excludes it. snd_ctl_elem_read() and snd_ctl_elem_write() take
snd_power_ref_and_wait(card) around the callback;
snd_card_disconnect() ends with snd_power_sync_ref(card), which waits
until every such reference is dropped; and in usb-audio's disconnect,
snd_card_disconnect() runs before usb_audio_disconnect_components()
reaches snd_usb_mixer_disconnect() and hence this driver's
private_free(). So no callback can be inside the driver when the
structure is freed, and none can enter afterwards --
snd_power_ref_and_wait() sees card->shutdown and returns -ENODEV. The
observation that the controls themselves live until snd_card_free() is
correct; the access path to them is closed earlier.

Nothing else changed since v3. The questions in the v2 cover letter --
about a third form in which snd-usb-audio would register the hid_driver
itself, and about a control that can be written but not read -- still
stand.

Tested on the hardware: values arrive by themselves after probe, a
front panel knob still reaches the driver ten minutes later and after a
suspend and resume cycle, a write reaches the analogue stage (one
source recorded at gain 30 and at gain 60 differs by 30.4 dB against
the 30.0 dB the taper table predicts), the audible selector test
passes, unbind and bind again works, and alsactl stores and restores
these controls without complaint. On a KASAN and lockdep kernel,
including unplug while a stream was running; no reports.

Mikhail Gavrilov (2):
  ALSA: usb-audio: expose the Topping M62's analogue gains as mixer
    controls
  ALSA: usb-audio: let the M62's outputs say what they listen to

 MAINTAINERS               |   6 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-quirks.c  |   2 +
 sound/usb/Makefile        |   1 +
 sound/usb/card.c          |  19 +
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 734 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 sound/usb/usbaudio.h      |   4 +
 9 files changed, 781 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h


base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.55.0

