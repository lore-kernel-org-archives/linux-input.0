Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB6349CE8
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494949; cv=none; b=gxdJIfbUMiDTA84O1Ny2l7Za6+CAgm7N7WLdb7RddJR5SiMl17ch19Hl41/wIlX5tkZ7sn28fyIAPp42BlA5kFtn2vIbhrn34ov8lFaI83ADBk/xKy5B1ct8SHyQqvfJ8wUDgtPO0usaPkAd/d4NlPR1nrG3iwlX/R+7oPUXYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494949; c=relaxed/simple;
	bh=XAVA4GsPJulYdTC1U7HRoo7PRQ4Xfw/23QXXI6zD3YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYhpb52isrme5DItijCQb8sH2B6jHcP+o7jScBHewNer1+Ku8BPT5q1gJXQPFX9YujIAXKRDq88H+Bc+9nkuP03RmjUSBUqilPkZfePtrTzEeV082RJd4dzw87P3yqHs9R+l/nTN7264ltbgduKQjvS9pEPCiRLbPXdeSgAcyjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNOLSlVo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNOLSlVo"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b01146b205so1734017e87.2
        for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787494943; x=1788099743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LxUnTB7qoqswJZnIJ6oxAON0IR3zkHXMNyQNy7CGibg=;
        b=UNOLSlVo6UzMbcriMgOfKC3qzKIiWvgbOOlIbqpOl/ep8CfaTdhZJtR0/Hx/f5jEbb
         +FYqRU7S/pMl+4wdMMTAFHPguJho8BzuR0mFZ2n5WR9XmNK/p0/hrgMLaFKpoc2Iu5Ya
         xMrrn2F2198qysiu3B9wrSxEwV1ybquqvcES1WYIGq+dmbYmtDqeB/hMSJqi5thN7pLd
         VmssHg9fKPHf5sr7HiMyw1p3tlA0isWEcHP1nG53wl3H3lcBBMn+5zadVR4qgmVuD6ei
         Y7H96f2cSB5zczgXUEzGjUHr/RwSy0n+/jEygrdgGIy+MwmJqN3d0sks98cD7q2eEPxW
         luTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787494943; x=1788099743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LxUnTB7qoqswJZnIJ6oxAON0IR3zkHXMNyQNy7CGibg=;
        b=e3OLu0VBAGPkBH1zKJhf0MRM6UfFo0N1utAV6eogE83evxbg7/gVqAqD1B/uyUcbbN
         XPOqYGbioES3M9zJDQWNhW7eQ2mSt2IkJ2kI9WcfUAbb7oV8kDDm9Tf+SgotdiOp/z6b
         khsNgpRhwD0SQFENN/Sgnhz8X0IsaxjUqUTPJmNO8t87KgCu0eXOilsiDh5cTvRCc0Wy
         v7gYhadt3qin3sE4TbvvdpVmtF0KJA3FQoqUw6aof3zi1BfggL65h2XGg5jYQ+4mmNR6
         ScbIJ8N6ZPBqJKqjyjNx5OdWz5z5jUcIEalqtqC2KgYHdBKFu+TsRCeIEFz5mgg3drlN
         gFDw==
X-Forwarded-Encrypted: i=1; AHgh+Rpc2EpBpxd9qbjJ9FS2NSG/kUN99vYjAYheNEXAe2Lxqieskjt1aL62x6KOWTHrwlHLlXcksKGK2TGFEw==@vger.kernel.org
X-Gm-Message-State: AFuF++kmhHEvOLW4Y8ZM23w9NWwzwHMUA4M9fqnR7fLTJTNkZXOpkVDX
	QK/t1M27ZgL/0+MuaNzyf1IWCXsg/D+KuiWHkDJT0DfZ905xM4InsKlAaOBK3tpO2IVchQ==
X-Gm-Gg: AR+sD12LLHVLbP2xDyJ/75xcjqtBIu7TF5fKx+bHXapw0Fc7FhV6WU9XC6LiCf+Lq78
	RAwt1p4YJ5rs43DUZGFQwXP1dNCqBowSJQhkvEt0MY4G7TNGCgTGBWJCQlbDLHGkQKudRFYRVQF
	I4fWr7dYsXv6PXYX7XP/tdqIdwLES8UOIktB7sOiux1UQjMoWY4Msg3l1M0Fy4poAgL1wdE70Ku
	13viFmGuZTSmK6jLu77/jF996WGJNHcGQXF3r8bp2v+aYq65Qb5EVHzXru2fi52bC3IBYx/Lf7v
	+iGtznoDvzG/uNd8zPyC8WpRHL1RdvrbwhM9a9X2STwEYL+eRRb4OG+G1uta9dVh/4m045Ay8M+
	j/bSdOQ8fmcE37Dp6msOlzG8qkFPHKbpAUFCqnv83b2KKX4jmYkndS26eE39xabjEeKq20QbRja
	zobe7aoPIRbDPBGg6bxC+1vN4MW5oBSz/I8KHLx+aThfvJTNe/kn5r6xCn+SzvrnQVl+fd+Sy6s
	7eQmia4Qrw7S+u792WXuY8caXMPO4aix7rv2SJE0XAX4TfCTC5/jn78r9k+3JBbOSPsYlw=
X-Received: by 2002:a05:6512:2c8b:b0:5b2:e890:e69f with SMTP id 2adb3069b0e04-5b48b781ec3mr3111608e87.2.1787494943000;
        Sun, 23 Aug 2026 07:22:23 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48cda2b73sm1006644e87.23.2026.08.23.07.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:22:21 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 0/2] ALSA: usb-audio: the Topping M62's vendor controls
Date: Sun, 23 Aug 2026 19:22:14 +0500
Message-ID: <20260823142216.79704-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
References: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2, and the road is the mixer quirk. The HID driver is dropped from
this posting; it is in the RFC thread if anyone wants to argue for it.
The cost of this road is accepted knowingly: with the hid_ignore_list
entry there is no hidraw node, so a future Linux control application
would have no channel of its own to the card.

Changes since the RFC:

  - guard() and __free() as you asked. The spinlock is guard() where a
    whole function holds it and scoped_guard() elsewhere; one goto that
    would have jumped out of a guarded scope is gone, replaced by a
    flag, since the cleanup runs either way but the jump reads like a
    trap.

  - The OTG input's gain is in. It was the one gap the RFC cover letter
    named: it has no front panel control, so it never announced itself.
    A capture of the vendor application moving it names it target 0x27
    on the same taper family as Bluetooth, and the indices it dwelt on
    match the decibels it displayed.

  - The subscription is renewed every two seconds. It lapses: a
    listener that subscribed once got the meters and the identification
    block and then very little, while one that kept repeating got the
    gains too, about five seconds in. The vendor application does the
    same.

  - New in 2/2: the outputs' source selectors, as enumerated controls.

A correction to my own follow-up, which said the HID road leaves a
hidraw node open for a future vendor application while the quirk closes
it. Half of that is wrong: the HID driver as posted calls
hid_hw_start(hdev, 0), which creates no hidraw either. It would take
one word to fix there and cannot be fixed on this road at all, so the
comparison stands, but the archive should not carry a claim the code
did not support.

Which raises a form neither posting covered: snd-usb-audio could
register the hid_driver itself. usbhid stays the transport, so hidraw
survives and no hid_ignore_list entry is needed; the controls still
land on the card the device already has, because it is all one module
holding the mixer pointer; and the claim helper in card.c goes away.
The cost is that snd-usb-audio would depend on the HID core, and I find
no precedent for that direction -- the reverse exists, hid-prodikeys
registers a card of its own. The probe-order and disconnect questions
do not disappear, but they stay inside one module. I mention it rather
than implement it: you have picked a road, and I would rather ask
whether this is a better one than send a fourth variant unasked.

About 2/2 and one thing in it I am not comfortable with. Each output
listens to one source chosen inside the card -- a mix, an input, or one
playback bus straight from USB -- and the device NEVER reports that
choice. Not to this driver, and not to the vendor's own application,
which pushes its whole workspace on connect rather than reading
anything. So the control can be written but not read, and the item list
starts with "Unknown", which is what it shows until a hand has chosen;
selecting it is refused. If there is a convention for this that I have
missed, I would rather use it.

Both patches are on mainline 98f21c54f995 and have been exercised on
the hardware: values arrive by themselves after probe, a front panel
knob still reaches the driver ten minutes later, and a write reaches
the analogue stage -- recording one source at gain 30 and at gain 60
differs by 29.7 dB against the 30.0 dB the taper table predicts, which
also confirms the decoded scale. For 2/2, the audible test: point an
output away from the bus being played and it goes silent, point it back
and the sound returns. Tested on a KASAN and lockdep kernel, including
unplug while a stream was running; no reports.

Mikhail Gavrilov (2):
  ALSA: usb-audio: expose the Topping M62's analogue gains as mixer
    controls
  ALSA: usb-audio: let the M62's outputs say what they listen to

 MAINTAINERS               |   6 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-quirks.c  |   2 +
 sound/usb/Makefile        |   1 +
 sound/usb/card.c          |  14 +
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 636 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 sound/usb/usbaudio.h      |   3 +
 9 files changed, 677 insertions(+)
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h


base-commit: 2709dd5ae32f0828f386327c76bba9f39f63a1c6
-- 
2.55.0

