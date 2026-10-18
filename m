Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E149BD6E
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327783; cv=none; b=mZ48T4C0MXk0+bLV7x+RZXN5a7wi+f9Lisstex0+dygcuOJ5iOdIB1YjidFpJwq48CidzedW0tPyz1VFlgmTk/qO48KXqLUiG35iHUsQ0xJsFFnaCk0kls1FnEWlu8iTIMVnHQTA+SEUwd8/81V+QLj0gYbykvWhdxgAyEC5b8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327783; c=relaxed/simple;
	bh=hFoleiRYuxww+aBs4PmsYuzUybRBo7dkHfaqv5PeqWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTc2WV4Sptn01Xvj7BYYw7aymAwAiJFfVjMu18xC9GqUyLEsDTg7btdmAIjBVwRTlLRWxp1GHqqI962+3+TFjWRMUGTYZVLNSyYlRRFGW0gGzIFodBQr4CQXbzGViOnMn0199hVy0Dy6ZuiBDsNVe+qC3rRpdsoRMjydQRnZ1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is7GHd0u; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is7GHd0u"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso8560895e9.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327779; x=1792932579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RHIXyjv+kk/62N7mqziPVmbdH9f+1Fdwi1yZnzBhWhQ=;
        b=Is7GHd0u53/reTqLcszVbPmHIrbKDmrfDhdZ17XBCBSCnzlSxY7sAtSYXXEi6+s+eo
         yNOZ0TV7EVbsjfFJWwQ/9QA46F32ffhxYtpcbwKMjD5AuTSm3QRLVDYwPBOxrOLa0iLD
         dizT9EK4qs6xuXMynP8Rtr8AIQwLfbD9kQbs86SblHbjcHlMbY+zKsiyocnC8En/+Z/H
         dhWoRi+4/+tFIuuibuq8h5GCuS/r7uLzMjGIyJfn3ibSoco3kvW+qjDKcL/5HFobAzEN
         3zKiVmVwoTBrqc916lihO7EpHW8d+Ci+VTS4bHIDyWVa0L/XutkR5qnx3y6qdGOQyBn+
         MAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327779; x=1792932579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RHIXyjv+kk/62N7mqziPVmbdH9f+1Fdwi1yZnzBhWhQ=;
        b=aXNqminpIp+9HecrSdbyJ9aJLVddls3MQr6ZBYW5aT39oMnoPGKt+uad3+8Z7wZU9V
         i/p6wJwnbfumezAkA2RSLRsYuCluN3OkJT7grXFzKueOtF/bYHhkqRXgeyWw00/+Z+GV
         LvlEcR276kTi6RHb8165R4A1EqPuzrSeOETuvSjJ8GYEZkhsnY1H5H5zLLfzm7axAvmO
         8nuO3run8GWG8GzxFh1rNwlNETKwN8LRA4uU0ZN3wC/hsF4V073qeRQ68yydvKipCdkr
         PhWQh+AMS7eKQFCL7cuVs79s+S9jcYSbeA2yemWpWaIfHDPPNwqRZx0roOUPIBKR01RS
         n8zw==
X-Forwarded-Encrypted: i=1; AKwUvBz5Q3ig4UEB/Bh1/o9x/nTCCcoFtydOcxTjTOWGTvwcLzPo4Eys4dSLL8DaHDYJQMOOLwGWZura9ldzBw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLhnVO5Eb1wRybpVI2AiOpVR7ic1va+VDyybVqkqMXUM8w/JJGd
	fffGxzeawG5UVt323mUCBsUlrQG0DTZa57fH609j9ebAeWRTMNOG4rW7HwrCOagezL1Ad3Bh
X-Gm-Gg: AYBFou3QZqaJmwoxB8AoZo/tsvYHJMgk8skBrimuHwGqmGcYo3ztNhS48zxjMECu2Bg
	RC0MgiVMe7sMVq5qiGqudhXLLelniAx/B29hzT2wi492Gnn7FN15hYiv5S26M9fGFOcCqPaykAY
	6XcVqt77qEit9SYIju+szxEe7Us0jiI4YDkQ51epEe9y778tnPhVhv/IGFS2t8qFXFNIU+Ky8AM
	Navai6buk3E5mzK+V7yP8EtRlOk8P90JRAcA1XxyGkl8qPYbVIxBY3uzbOZ/rvxCgJ7sSXvmdqR
	R3vIGVkjuS3KNlhK6BFnl5IR6wY6eVQcExU/ngb66QknxKm99RWcdAPIG0AWK5nq5ac6itDtDvY
	C6PGAOhPyZbHrFNek/K7eOsRHrKUk9QO0k9YlK8ddsx+amy/UWAtlQ7xvVVldzWDwON2nEph7M+
	UitdyGNxFGj3djDbXDBQkuAYbWBiSQkFDeeXGipx3bK3Z05wzhO1BgmTMMWv19ZyT23nw35FOzM
	4kskVZ2cLGyQ3K6i4aW0r4VWhJbk0EtZxvBRNtfBE0Bf1sXSAIDiBgvfvKas3sLPMndUw==
X-Received: by 2002:a05:600c:a4e:b0:49c:fa20:cbfd with SMTP id 5b1f17b1804b1-4a1d760005bmr89750565e9.20.1792327778597;
        Sun, 18 Oct 2026 05:49:38 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e3ebb3aasm71214555e9.0.2026.10.18.05.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:49:37 -0700 (PDT)
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
Subject: [PATCH v9 0/8] the Topping M62's and E2x2 OTG's vendor controls, on the component framework
Date: Sun, 18 Oct 2026 17:48:30 +0500
Message-ID: <20261018124838.129349-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Topping M62 and E2x2 OTG keep part of their mixer behind a vendor
protocol on a HID interface, outside the USB Audio Class: on the M62 the
analogue input gains, the output volumes, the MUTEs beside them and the
output and loopback routing, on the E2x2 OTG the input gains, the
faders, the routing and the output switches. On Linux they can only be
set by hand on the front panel where it has a knob for them, and not at
all where it has none. An E2x2 OTG whose headphone, TRS and AUX outputs
were switched off by the vendor's application stays silent on Linux, and
so does an M62 input or output that application left muted. The M62's
battery level, which the card reports, shows nowhere, and an M62 whose
USB-C port that application has set not to charge from the computer runs
its battery down, with nothing on Linux to set it back.

This series makes them ordinary ALSA controls on the card snd-usb-audio
already creates. 1/8 is a HID driver that carries the protocol, and 2/8
adds the M62's controls to its mixer quirk, which is also the component
master the HID driver binds to; these are v8's two patches, 1/8
unchanged and with Jiri Kosina's Acked-by, 2/8 with the changes below.
3/8 and 4/8 add the E2x2 OTG, which speaks the same frame; 5/8 offers
the M62's battery level as a power supply, 6/8 the power settings of
its two USB ports as controls, 7/8 the M62's MUTEs as switches and 8/8
the E2x2 OTG's input MUTEs. 1/8, 3/8 and 5/8 are HID, the other five
ALSA: the ALSA patches build on the header 1/8 adds and need nothing
else from the HID side.

Changes since v8
(https://lore.kernel.org/all/20261003184217.34671-1-mikhail.v.gavrilov@gmail.com/):

  - 3/8 and 4/8 are new: the E2x2 OTG, 152a:8756. It takes the same
    frames without a subscription or a keep-alive and gets 21 controls:
    three digital input gains, six faders, the headphone, TRS and AUX
    output switches, the headphone gain switch, the two MON switches and
    six source selectors. The control tables become per model, chosen by
    USB ID, with the per-card state sized from the model, and the HID
    device table names the interface each card carries the protocol on:
    another card on the same protocol is then its tables and its entries;
  - 2/8: the M62's four loopback returns get a source selector and a
    gain each. The card reports neither, so they start where the vendor
    application puts them; the gain is written as that application
    writes it, Q25 in whole decibels from -89 to +12 dB;
  - 2/8: "Mic-1" and "Mic-2" become "Mic1" and "Mic2", as every other
    control name in the tree has it;
  - 2/8: every input gain is written at the first bind too, at 0 dB,
    where it changes nothing. The card reports a gain only for an input
    with something plugged into it, and never BT's or OTG IN's, so a
    gain it had not reported showed 0, which alsactl stored and wrote
    back at the next connect, muting AUX, BT and OTG IN. A resume writes
    the gains again with everything else;
  - 2/8: the M62's operating mode is read from bcdDevice. Live Streaming
    Mode goes with Pro Audio. In Mobile Mode, where the card records one
    mix of all its inputs and part of the address map means something
    else, the loopback returns and the selectors, which that mode has
    not, are left out, and the Playback 1/2 knob and the Recording fader
    are offered instead, written at 0 dB at the first bind;
  - 5/8 is new: the M62's battery level as a power supply of device
    scope, registered once the card has reported a level. A card in
    Mobile Mode announces its level only inside a session, so the driver
    now opens one at bind and at resume, with the handshake 0x11/0x01
    the vendor application sends, and like that application waits for
    the card's answer before it subscribes or writes anything;
  - 6/8 is new: the M62's USB-C and OTG port power settings as
    enumerated controls with the vendor application's items, written at
    the first bind, the USB-C port to Charge and the OTG port to Off,
    and kept up to date from the card's announce, which leaves them out
    now and then;
  - 7/8 is new: the MUTE beside each of the M62's levels, as a switch
    named after it. The card releases HP's MUTE in about half the writes
    of HP's volume made under it, and a sound server writes such a
    volume whenever it switches back to a device it has saved as muted,
    so a level set while its switch is off is kept and written when the
    switch is turned on;
  - 8/8 is new: the E2x2 OTG's input MUTEs, which that card keeps as the
    input gain's 0, as switches named after the gains.

The selectors keep "... Source". Named "... Playback Route" or
"... Capture Route", a selector would join the volume of the same name
in alsa-lib's simple mixer, which then reads and writes only the
selector.

Tested

Fedora, 7.3.0-rc7-24a19b953e2a plus this series, with KASAN (generic),
lockdep and UBSAN, an M62 (firmware V87.05.45.48.27, bcdDevice 3.27 in
Pro Audio Mode, 1.45 in Mobile Mode) and an E2x2 OTG (firmware V1.10,
bcdDevice 1.10). Both loaded modules were matched against the installed
files by build ID.

  - fifty cycles of hid-topping unload and load with both cards
    connected and PipeWire running: a hundred binds, two per cycle, and
    every mixer control of both cards the same before and after;
  - five audio-side rebinds of each card with the HID driver left bound,
    all three snd-usb-audio interfaces unbound and the control interface
    bound again: ten binds, every control back;
  - "alsactl restore" exits 0 on both cards;
  - suspend to RAM and back: the controls of both cards unchanged, and
    afterwards the M62's headphone knob and an E2x2 OTG MON button each
    reported to their own card;
  - the cable pulled out twice on each card during playback while a loop
    wrote a loopback gain: each time the card bound again once plugged
    back; after the last plug the control took the loop's writes again
    and read the last one written, and neither driver logged an error;
  - the M62 switched to Mobile Mode and back: the driver's twenty
    controls in Mobile Mode, the first bind writing every one of them,
    and alsactl's restore the stored gains 0.11 s later;
  - the M62's port power at eighteen first binds with the HID driver
    loaded after the card, out of reach of alsactl's restore: on a card
    left on Off and Discharge the bind wrote Charge and Off, and Off and
    Discharge written right after the bind, as a restore of those values
    would, left the card on the bus for the 10 s it was watched; every
    value of the two the card announced afterwards was the one last
    written;
  - the M62 answered each of the 74 handshakes captured in these runs
    10 to 314 ms after it, and nothing else was sent to it in between;
  - the M62's Loopback 1/2, with a 1 kHz tone at -20 dBFS peak on
    Playback 1/2 and all sixteen capture columns recorded: its source
    set to Playback 3/4 turned the two Loopback 1/2 columns into digital
    zero and set back brought the tone back; its gain at -20 and +12 dB
    moved them by -20.00 and +12.00 dB;
  - each M62 input's switch turned off took the input to digital zero,
    in its own capture columns in Pro Audio Mode and in the recording in
    Mobile Mode, IN 1 and IN 2 there once the card's reverb had died
    away, and turned on brought it back;
  - each E2x2 OTG input's switch turned off silenced the card's meter of
    that input; a gain set while it was off was not written, and the
    switch turned on wrote it and the meter came back;
  - no WARNING, BUG, KASAN, UBSAN, lockdep report or call trace in the
    kernel log over these runs.

The M62's battery shows as a power supply, and in UPower, 2.6 to 2.8
seconds after the card is plugged in, and 3.5 to 3.7 seconds after in
Mobile Mode.

With PipeWire and the M62's UCM profile
(https://github.com/alsa-project/alsa-ucm-conf/pull/826), the M62's
headphone level follows the desktop volume and the front-panel knob
both ways; with the E2x2 OTG's profile, to be sent after that pull
request, the desktop volume moves the E2x2 OTG's Master.

Not tested:

  - the reload cycles with stock alsa-lib: this machine carries the
    remap fix;
  - hibernation, and with it .reset_resume;
  - kmemleak, compiled in here but disabled at boot;
  - a card whose battery has run down;
  - a big-endian host.

The plain E2x2, 152a:8752, is left out: it needs its own channel names
and a test by someone who has one.

Mikhail Gavrilov (8):
  HID: topping: transport for the M62's vendor controls
  ALSA: usb-audio: add the Topping M62's vendor controls
  HID: topping: add the E2x2 OTG
  ALSA: usb-audio: add the Topping E2x2 OTG's vendor controls
  HID: topping: report the M62's battery level
  ALSA: usb-audio: add the Topping M62's port power settings
  ALSA: usb-audio: add the Topping M62's mutes
  ALSA: usb-audio: add the Topping E2x2 OTG's input mutes

 MAINTAINERS               |   10 +
 drivers/hid/Kconfig       |   22 +
 drivers/hid/Makefile      |    1 +
 drivers/hid/hid-ids.h     |    4 +
 drivers/hid/hid-quirks.c  |    4 +
 drivers/hid/hid-topping.c |  686 ++++++++++++++++++
 include/sound/topping.h   |   57 ++
 sound/usb/Makefile        |    1 +
 sound/usb/mixer_quirks.c  |    6 +
 sound/usb/mixer_topping.c | 1452 +++++++++++++++++++++++++++++++++++++
 sound/usb/mixer_topping.h |    7 +
 11 files changed, 2250 insertions(+)
 create mode 100644 drivers/hid/hid-topping.c
 create mode 100644 include/sound/topping.h
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

base-commit: f6e8d5ebde5ceb7d3c0eef6e9e4d82862b503ade
-- 
2.43.0

