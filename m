Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795765132;
	b=Hrokj8ZkwCxL34Vx9vcDG64QNNXqEilBvXaLvN7ZXDRpzoT9oks2qlrfYiTgaxgDJHmZ
	 bdRZcYiCd8SgNoZH10euxT7R9ud3VVeDCwo7NeZ+7EZ0lbY4FHH/6pqQsNimEiQ/ziKvw
	 g/k6xffiZEM1I3svcnGIeYx7TUkyY4gyiFxNc4DhV//DG4Y4wFuyTANzHWPskhzh21JKg
	 g9PLRbMxXIz5IHdv/yHJReMQlvAGHvsYTK7GtATVE0lDEAZ/GN/Qn9k5kSaU30ZVR2D7+
	 dL6EWEgRQ0ZSI0tnRNuBtVxQuaJ35CTilZBxXB/44OwTmvbAVpxq++JM/ilDybnvRPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765132;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=FoF4FqDi1Osud37TYCr769UiEfl7Xjpgz7E2oe8UPkU=;
	b=wE6P1e6EC3aC1snUnK/VvFYYZjoI4Ap+LW+gb1VtRecBgKlA/TGrpTdzT9nZs+TTY6Mx
	 nNLDUnShFBlkShw9cZYCEAOb3sMi72QdlS5AlyeshPD2Oh/mH7kZS7VgIjQW9V4TfpYAD
	 EA2FHQE0KtESDiQiBtXMMqCPbLfGS1p0YLr1tvR4nWrcQfSmNr5srWQxo1sadmJz0szHm
	 wZpyrpbZNA6ELamRe3e34DU7+lJZ2do6XiNDDRICGtkzeIi5smZVGMrL0VDYYk3NIl+8Z
	 zMmTuT6jsm1SNhZdrp0K1k0er+nB0HyA7qahmU3etHujs0ej448sCIDRAau3Py6U8Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hE4n84Gs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD029606A31C;
	Fri, 27 Nov 2026 07:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hE4n84Gs
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795765132;
	b=dgARksDWlhRE09kuhqP8AQ9v44H4Wf88mymSEk9s2s5tZ4t3yUL1Y2fFmmGBwEaIVe/8
	 zUuKIWVNNrntZMH9+Qu260s7bD5XVDt9RIV3lx1nZDSyRYIUe/Hg+nfHtFnO82AfCF0z6
	 I0V372KGYOQ1ZJ5q0waqBLTXlEVV8D9xc7AvylWpqc4JluarDDe4Imx6GZZru/DqWOyq1
	 vmRTAVjq+4Rdup/2bUwgR2TeFDWFBI3ijwHwHn7+B51+yMRUVJ/I5Yu1fQCWB++KhUNGp
	 gW6UFQmY8/l1N2mz3VVgdqs3c2R3axRfQNzlxqb9hXwcw8zvZj4RjULk1vvocrHYm8w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795765132;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FoF4FqDi1Osud37TYCr769UiEfl7Xjpgz7E2oe8UPkU=;
	b=I9BFQ6N83W5eEp8i0GB2met1XKLge268CpGIQt93D0TsZG4aRGp+r+PFEsM/dyqjgJwA
	 ZgB3Z2kAIOKPc3HGT1ogBhTfejsbUKvhLsKLoljem/YHzB3zTuowWyYu5V66Hm4WR6nB1
	 eY5uDUErpYGk65ds4l+LfCTS0Qfi62UukRV/RO0r9TNJ+LNqDBYe0qL8S5qKSktRiCN+H
	 9K6Jt3i0n9dK/R1wzuF/h8AjVtkGAsln0IfrNKY5oG0seHy+6zzY+8c0NoEkE+MEFFEC/
	 bpc3uPqgYV1kFlGHusS9+HAGHS3RLAZiTMm/yvNzn7V2KhbO1K6t251YTina6WQ4oWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7D1AA1F00899;
	Fri, 27 Nov 2026 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795765132;
	bh=FoF4FqDi1Osud37TYCr769UiEfl7Xjpgz7E2oe8UPkU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hE4n84GsjhO+Gxx1s2aNo/amKmIt1wSp/TgfV7meCoZM1rco/+u44Ey+HKH4gg4UH
	 YR2Ngt4poDlFZrzil7jZxd0+fMvfRdw2rMegYB9BeEfYyE/8HPDwWiDuFfVRvG4gLF
	 WQUyN4EnieFbHRd7UV4nYZY8CyuGO9Fsk4c0p2nsUQ0LWc5kQXoP+nX1lXxJMrGdbZ
	 Tc+43byZqZav6EDOyN7MncQqj/lPz/yZp2dtmhmoUZQDTxfMCqQq0LG7kGc4URtKKH
	 TFeK1nxieZeE63pAWYt9WBW5celx/dtsmSyDLYZuyLVx1Gz3lFH3Q5Po1/lEUBYY8K
	 S5/3dSmrVbhYA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ED5C74B615;
	Fri, 27 Nov 2026 07:38:41 +0000 (UTC)
From: Andrei Aleksandrov via B4 Relay <devnull+aladex.gmail.com@kernel.org>
Subject: [PATCH RFC v2 0/2] ALSA: usb-audio: Make the EPOS GSX 1000 v2
 volume ring work
Date: Fri, 27 Nov 2026 08:38:41 +0100
Message-Id: <20261127-gsx1000-v2-0-0a0f20f1a2da@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNwQ6CMBAFf4Xs2ZptAVs8mZj4AV4NB6gF1gg1L
 TYY0n8X8OhxXibzZvDGkfFwTGZwJpAnOywgdgnorhpaw+i+MAgUB86FZK2fOCKyIsdGFFJmqBA
 W++VMQ9NWusH1cobyN/p3/TB6XBur1pEfrftsf4Fv8l86cIZMpWmeZzqVtRKntq/oude2hzLG+
 AW+FZZ7tQAAAA==
X-Change-ID: 20261127-gsx1000-950f29774080
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrei Aleksandrov <aladex@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795765121; l=3309;
 i=aladex@gmail.com; s=20261127; h=from:subject:message-id;
 bh=qWqYIVJB2Kl0iaCVihfViowKE0k4LYUKSyZcNfvPbtE=;
 b=9/Seeke55kD094J59SdKFvG4Ons31sjzlklo6wKBlilPmgIxAxJgbntT6qjv2DonWyodhGX4Y
 0JOynA9SjtqCkEeUkObMUmnXJkIAM2/vqScDsMvAILyn0kZ0Dev1YGH
X-Developer-Key: i=aladex@gmail.com; a=ed25519;
 pk=BRFQEVGQ1X027TItMW+SIsAtbYscopzlk1EJT8Girkg=
X-Endpoint-Received: by B4 Relay for aladex@gmail.com/20261127 with
 auth_id=1663
X-Original-From: Andrei Aleksandrov <aladex@gmail.com>
Reply-To: aladex@gmail.com

The volume ring of the EPOS / Sennheiser GSX 1000 v2 has never worked on
Linux: turning it makes the volume oscillate or run down, and the usual
workaround is to disable it with a hwdb rule [1][2][3]. This series makes
it behave as on Windows, based on USB captures of the Windows inbox
driver (usbaudio.sys + HID, there is no vendor driver):

- the ring sends HID Vol+/Vol- until the volume the host writes to FU 12
  matches the ring position, and compares it with 1/256 dB precision;
- Windows writes fractional dB values from its 0..100 % scale to
  channels 1 and 2 of FU 12, in 2 % steps per ring detent.

Patch 1 replaces the 1 dB FU 12 volume with a 0..100 control that writes
the exact values measured from Windows. Patch 2 answers the ring's
Vol+/Vol- in the driver with the Windows step.

This is an RFC because of two design choices I would like your opinion
on:

1. The new control has no dB TLV, on purpose: with a TLV, PipeWire and
   PulseAudio map their volume through the dB curve, and the number on
   the device display no longer matches the desktop percent. Without it
   they map linearly onto the 101 steps and the display matches, as on
   Windows. Would you prefer a TLV (e.g. a DB_RANGE over the table)
   instead, accepting the display mismatch?

2. Patch 2 registers an input handler with a .filter callback that
   swallows KEY_VOLUMEUP/KEY_VOLUMEDOWN from this card's own HID
   interface. Subscribing to HID input from mixer_quirks.c has a
   precedent (the DualSense jack detection), filtering does not. Is this
   acceptable in snd-usb-audio, should it be optional (a module
   parameter), or would you rather see it done elsewhere?

Only 1395:00b1 is enabled. The GSX 1000 v1 (005e, 00a0) and GSX 1200
(005f, 00a1) are likely similar, but I have no captures of them.

The captures, their decoding and a DKMS package of the same code (in
use on 7.3) are at https://github.com/Aladex/epos-gsx.

Disclosure: the reverse engineering and these patches were prepared with
the help of an AI coding assistant. I reviewed the code, and I tested it
on my own device; the captures are from my hardware.

[1] https://bugs.launchpad.net/bugs/1821496
[2] https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3714
[3] https://github.com/evilphish/sennheiser-gsx-1000

Signed-off-by: Andrei Aleksandrov <aladex@gmail.com>
---
Changes in v2:
- Take the snd_usb_lock reference before vol->lock everywhere: taking it
  under vol->lock could autoresume the device, and the resume callback
  takes vol->lock (self-deadlock). Reported by the Sashiko AI review.
  Tested by forcing the device into runtime suspend and setting the
  volume from it.
- Link to v1: https://patch.msgid.link/20261127-gsx1000-v1-0-833554c37b82@gmail.com

---
Andrei Aleksandrov (2):
      ALSA: usb-audio: Add Windows volume scale quirk for EPOS GSX 1000 v2
      ALSA: usb-audio: Handle the EPOS GSX 1000 v2 volume ring in the driver

 sound/usb/mixer_maps.c   |  11 ++
 sound/usb/mixer_quirks.c | 355 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 366 insertions(+)
---
base-commit: 486060b97284c95384744f030706f89e1980a46e
change-id: 20261127-gsx1000-950f29774080

Best regards,
--  
Andrei Aleksandrov <aladex@gmail.com>


