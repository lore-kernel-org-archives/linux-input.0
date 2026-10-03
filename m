Received: from mail-wr2-f31.google.com (mail-wr2-f31.google.com [74.125.225.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5AD45FFC7
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791052956; cv=none; b=JqqPm2UFGj0v5kMyiJgPR+rAeqHFCyXR+ufLJ3Mt+Ssvh15ydf31mpy7DgT1e5bHe7gaSlPnFPrG/oCLSHf3bsWvu/G8q7RViyGPViYFq/dDZ4DgLZIJOgt+zuJi0vIaFDupF2sHRWfZsNT1jXZBno9eLMVZPEdOj+KToyh18/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791052956; c=relaxed/simple;
	bh=ehFcinO38efKwLN6697dwFR9DfjXzYQPuBtnz8zjWZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DPJK5rY/D1Mya/lXKTB2omg8Z1EiNU1QT+jELqcYBksFHG8SJ4UvPvLa5Yka0QqP52YSjj+u4EVUwFvUM/rOh4D0hDYqoq2WIk7IlMT7firk6rRQIBZCpQ0vrCDM7+NRfSul4mWEjH+rhH+fq2j+kYuonA3YOwkCnx/tt1HT318=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S04Vami5; arc=none smtp.client-ip=74.125.225.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S04Vami5"
Received: by mail-wr2-f31.google.com with SMTP id ffacd0b85a97d-488811c9ebaso231803f8f.2
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2026 11:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791052945; x=1791657745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8XZhufYvSNdF2L93Or54jngFXPZoArn3Na5/nvULWdw=;
        b=S04Vami5olT4MKKUwBdMOzUqg5Sz4VHFBsMzxSVXOJz2VVO48PqPWyJJN4fshyhYCO
         UjEpTzjHLHaJdZP51Y/gX0AdTFfrfuSpXn6mo0dyP9Izme7Kei0bptSKc65zdcDT07Rp
         wlEfT+oIndPTJE9v1Jfe25srUPE/EYh2SdikTofWZsjtPVajLBfmT9u1tgw6FHWy/sMJ
         kxglxL0NOBOtdlxVuPhw75iLeWBX0RuwCZfiSxT6gq1xtoShHvTElBFT3bK2M1RRzjYr
         e7a9ZncU+FCjWO4yu2kUwUin/Dffre4NnghG3eb6T5hgh/eqwCvkQl3eBERqXfFgtVkH
         r1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791052945; x=1791657745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XZhufYvSNdF2L93Or54jngFXPZoArn3Na5/nvULWdw=;
        b=BZE9PqX9yJA4v9JXS99PM3y8/l1ejVFa+bDPNhuDx7QGggzc7bWPPTMC7HJYClfxvL
         TCW1x4OyK1os+hU8EyJOfPI+3Y4fmzMVs+KtA6qd/zVa1RlwdKNXXcXbTbU8rLC0NW5h
         IiIzkYKGj3jqBP3pIeFTYM1ApUnekQSfIE/5HFDvmXn5TokdIQ4lnC0UygGZaaQ/JkbW
         RLAyksYAkCp5R1xGBZNWmy2/tdoLAB27rxg73da7IZKazPLM1XCdgqxvNst21KkFlEtY
         VHvrW1qVQxknGOMJ42vYK749y1t9Ee/bgI0IvEtRvzRu/0vkD32CfeFG1EFCMmD8XcuZ
         dEPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsC1GEdu3Bxc7iHS8dXT+rlStlMBoW6bEis0HhtVSMaHKXJ/5T0w4iRogUVxVn6ewm00gJQ2RyGH+XZg==@vger.kernel.org
X-Gm-Message-State: AFuF++lgTZXttKVUziDDF+AhKBS0zjsCTuJ2IoMEntUvy1CyGpCZ8p4j
	abc614fRSljrC5ysbw0EYoiQAV1qtsteWXZzQxBkuS087eGvLDel6OiF
X-Gm-Gg: AYBFou35NUQSklzfnDqrLANasfCaDmPgc/ACXY/lT4LQR+ktQaF5gEF7Decy+EPtfIr
	LGWmhamIQuRnl37L8nwM/yr3B+6MCM9WKlYGeb7DL1uijJJ5HAksc1RTfFCwmBln8dPZPM7rafW
	3ncjQ3l8Zg2bAvRtvTwq6jAo0N9Ploemw8Ta6VKdpIsp6KdHDoVwccFgXYSDzztqS5PRZwOKlR5
	54SF3O3hECHX1f8ZJs3RjwXIXtsHXAVnedblETSnsvFgamfhyEK2Fyf8R5vO4C6c0s7Mtfx7SzL
	ZOX8ki4yNxQI/SU2Q9E1o4RH8J2sSUp7AzmOw/bs3LPbP68/2XbLKxp/KqZAjc/9BQOU8iBYBmo
	L0ZwrkWT4UKlqJuHtWJnG5InoWWz3L3pA34wDXaR3nVl21M1rTlnfIW09E/NcDPhiOnjPnv19D4
	KyXmmDQs/971I/X/iDbMVT3M6zhdDnNqXkyCnjHiQUxiuIQr54/heMqBUwU4ZCDjgODV5U2iltp
	y36EDIpXlZNl6Qvjjqcplc+M3ICZz9jD1R+VTSaSnyFj8vO/JeUgoDZSH6lt2JSmSq4M4w=
X-Received: by 2002:a05:600c:6992:b0:4a0:1a7f:2abf with SMTP id 5b1f17b1804b1-4a02755fd98mr106492225e9.7.1791052944478;
        Sat, 03 Oct 2026 11:42:24 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02770e8f2sm169437095e9.6.2026.10.03.11.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:42:22 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v8 0/2] the Topping M62's vendor controls, on the component framework
Date: Sat,  3 Oct 2026 23:42:15 +0500
Message-ID: <20261003184217.34671-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Topping M62 keeps its analogue input gains, output volumes and
output source selectors behind a vendor protocol on a HID interface,
outside the USB Audio Class. On Linux they can only be set by hand on
the front panel; the one capture gain snd-usb-audio exposes is a
digital trim after the converter.

This series makes them ordinary ALSA controls on the card
snd-usb-audio already creates. 1/2 is a HID driver that carries the
protocol. 2/2 adds the controls to the M62's mixer quirk, which is
also the component master the HID driver binds to.

Two things change since v7.

The controls now live as long as the card. In v7 the HID driver
created them on the card it was handed at bind and removed them at
unbind, so reloading it was visible to everything holding the card:
the controls came back with new numids, a stored alsactl state no
longer matched them -- and restore then fell back to its generic init,
which sets any "Headphone Playback Volume" to -20 dB, here the
analogue headphone stage -- a sound server kept the elements it had
already enumerated, and a volume the card was still holding read as
zero. Now the controls are snd-usb-audio's and the HID driver is the
transport: it fills in an ops structure the master owns, in the shape
of struct drm_audio_component (new: include/sound/topping.h), and
passes on what the card reports. Unbinding it changes nothing about
the controls, not even their active flag, since alsa-lib's simple
mixer handles an INFO event by removing the element and adding it
again -- the very churn this is meant to spare a sound server. A value
written meanwhile is kept, and the next bind writes it back. Controls
are no longer removed from a live card either, which is what set off
the alsa-lib heap corruption described in the v7 cover letter.

The selectors no longer have an "Unknown" item. The card never reports
a source selector, and reports an output volume only when its knob
turns. Topping were asked for a command that reads the selection and
declined to provide one or to commit to adding one. So the driver now
sets what it cannot read: at the first bind each output listens to
Playback 1/2, the analogue headphone volume starts at its quiet end --
what init_cur_mix_raw() does for a volume it cannot read -- and the
OTG stream at unity. alsactl and the sound server override these as
soon as the card appears, and after a resume they are written again
from the cache.

On the tree question: 2/2 includes the header 1/2 adds, so it builds
only on top of 1/2; at run time neither needs the other. 1/2 alone
binds, subscribes and passes nothing on; 2/2 alone registers a master
that never matches.

Changes since v7
(https://lore.kernel.org/all/20260930213322.32454-1-mikhail.v.gavrilov@gmail.com/):

  - the controls, their table, tapers and cache moved from
    hid-topping-m62 into sound/usb/mixer_topping.c; the HID driver
    keeps the frame, the subscription and the power management, and
    hands the audio side every valid frame;
  - include/sound/topping.h is the interface between the two;
  - the HID driver is now hid-topping, CONFIG_HID_TOPPING: captures of
    Topping's own application driving their E2x2 OTG show the same
    frame, and a module name is hard to change once it has been
    released;
  - the controls survive the HID driver's unbind without an event, and
    a write made while it is unbound reaches the card at the next bind;
  - the "Unknown" item is gone; what the card does not report is
    written at the first bind and after a resume;
  - a gain the card has not reported and nobody has set is left alone
    at a rebind rather than written as the zero the cache holds.

Sashiko's question on v7 2/2, whether topping_private_free() can race
the devres unwind of a failed probe, applies to this version
unchanged, and so does the answer: both run under the usb_device lock
(https://lore.kernel.org/all/20260930224954.121402-1-mikhail.v.gavrilov@gmail.com/).

Tested

Fedora, 7.3.0-rc5-e767a4ea70a3 plus this series, with KASAN (generic),
lockdep and UBSAN; M62 firmware V87.05.45.48.27, bcdDevice 3.27. Both
loaded modules, hid-topping and snd-usb-audio, were matched against
the installed files by build ID, and the new source files in the tree
they were built from against these patches. Two M62s were connected
throughout, the second on other firmware, bcdDevice 1.45; the runs
below address the first unless they say otherwise.

A reboot with both connected: hid-topping bound the two at 11.6 and
11.7 s, and the components were bound at 27.3 and 34.0 s from inside
snd-usb-audio's probe, each card to the HID device of its own unit, so
the nine controls existed before either card was registered -- numids
11 to 19 on the first card, 12 to 20 on the second, whose USB Audio
Class part has one control more; the first card's headphone selector
with fourteen items, on Playback 1/2.

Module unload and load against the live cards with PipeWire running:
"amixer -c M62 contents" was identical before and after, and "wpctl
get-volume @DEFAULT_AUDIO_SINK@" read 0.29 before and after.

Fifty further cycles of module unload and load, one second apart, with
PipeWire running on an alsa-lib that carries the remap fix: a hundred
binds, two per cycle; WirePlumber was never restarted by systemd, and
nothing on the system dumped core.

With the card's headphone volume at 20, "Headphone Playback Volume"
set to 30 while hid-topping was unloaded read 30 after the module was
loaded again, and one step of the front-panel knob then brought the
card's own report of 31: the new bind had written 30 to the card.

"alsactl restore M62" exits 0, with no fallback to the generic init,
before and after a system suspend to RAM. Around a second suspend, one
step of a card's headphone knob moved that card's "Headphone Playback
Volume" by one and left the other card's alone -- before the suspend
on the first card, after it on both.

The first card's cable pulled out while audio was playing: one failed
URB submission from snd-usb-audio, the disconnect, and nothing else;
plugged back in, the HID driver and the component bound again within
a second. The second card was not disturbed.

The cable pulled out again while a loop wrote 30 and 31 into
"Headphone Playback Volume" back to back: five writes during the pull
returned EPROTO to amixer, then the card was gone. The log held the
disconnect and nothing else, and both bound again within a second of
the plug going back in. The second card's cable pulled out once as
well: the disconnect alone, and both bound again within a second of
the plug going back in.

No WARNING, BUG, KASAN, UBSAN, lockdep report or call trace in the
kernel log of the whole boot.

Not re-run for v8, after passing on v7: Mobile Mode without a UCM
profile.

Not tested:

  - the reload cycles with stock alsa-lib: this machine carries the
    remap fix;
  - the HID driver binding after the card has registered, so that the
    restorers run before the controls exist: on every boot here the HID
    driver bound first;
  - the write-back after a resume of what the card does not report,
    which changes nothing a control shows and was not listened for;
  - an audio-side unbind and rebind with the HID driver left bound;
  - hibernation, and with it .reset_resume, which shares
    topping_resume() with .resume: this machine powers off instead of
    saving an image, for reasons unrelated to this series;
  - kmemleak, compiled in here but disabled at boot;
  - a card whose battery has run down;
  - a big-endian host.

Mikhail Gavrilov (2):
  HID: topping: transport for the M62's vendor controls
  ALSA: usb-audio: add the Topping M62's vendor controls

 MAINTAINERS               |  10 +
 drivers/hid/Kconfig       |  20 +
 drivers/hid/Makefile      |   1 +
 drivers/hid/hid-ids.h     |   3 +
 drivers/hid/hid-quirks.c  |   3 +
 drivers/hid/hid-topping.c | 498 +++++++++++++++++++++
 include/sound/topping.h   |  57 +++
 sound/usb/Makefile        |   1 +
 sound/usb/mixer_quirks.c  |   5 +
 sound/usb/mixer_topping.c | 902 ++++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |   7 +
 11 files changed, 1507 insertions(+)
 create mode 100644 drivers/hid/hid-topping.c
 create mode 100644 include/sound/topping.h
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

-- 
2.43.0

