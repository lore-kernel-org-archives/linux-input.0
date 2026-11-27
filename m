Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795763732;
	b=FFDqsEEdhqzD0C4I93Tu3pbY/cWuxJqKzvk4QxIh84bOoHCHYnMMvtCsRueB5jKghzvL
	 sHDfOG9RsKpIynH0TJLVJ9Q4em9stKwwxUguoVkzXQa7r7P67tb7xRm+HN/5AU3O9g59x
	 AXWEMvBsGd+gP3gChzpsFnW5hhleb8LmPBcEFBKYnZcMP+OM8lq8jkphyFgp0XXeyia70
	 M/X6liK33XtYk7gKuunfpl/ftkwQ9gUQ/S6+JYhxihWnsX6DXzOKAAHY+gsybaC8VDbAy
	 D0nNV17PUr0u49xvFmIJ7R4UL0sXc6jDc8pPN64ZX9Fwwh3Jselmva8LTK5XvXi9TUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763732;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=yHuX3HFjSSMOPaajuVozxl5jxmse0rZffXCwLljYMdo=;
	b=xq0ntT/RA3Qe1porkh6LCgBS+xuTMfkNbEyXVkaJWLaamdEyNVKPokUT4lnvipvsFyvf
	 7WTVNPcOEGG8s7Wj91ddF27TxXa4ISX/ANVQRuzzSCBpfiBDvc0t5A/nwXZYn+mJWPuZU
	 yeAAZ4tTHQBkZqeIuQf+T3GLIUnvcSvq1XIRROPk3AHm2tsVsA5a79Gc1690lgJUuVvSi
	 a2SqMfB5MCc9HzRUn4Tcn8JNLwdt+C1ZzIR+0u5X9MnHr6JBsxc0MzHFVenEPULlicrrL
	 C1sy+ZRaJcdTUqUBs0n7FzzZTHXxxmCzvClzFH2TRpzkZrcStQ3V353vUUypou5CQRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bduT+fgQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299B4606A321;
	Fri, 27 Nov 2026 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bduT+fgQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795763732;
	b=ka68mixIR/sdt7Pie395O3GfIL8SC0k2h3oqYpDfRiWQkW+0z2ag89U5hImhgJb+lP9N
	 /Gq92hm2hvTOIxQZ+ONDXwQlhg8ZMlKhaWf76KnAeOdysjMh8OL6bIShEJqUIe/GcUD7I
	 JCDTCUYZV8885b4csLtY8OidnUbHmUoF1+G0eBlMqCHkdjOdQ7CmyfWUtyzfVQeOyIuBD
	 ak+fScv2FgY3xUXajAwUSu8N+ptFcH4Rflj/5wI/Y2RwmyrBIUEBIVi9SyaxnJQu92LRb
	 F7Q9E2aSD2xOILLfj5BlKV4k8bMz6e0vW7sKCJu6aTM6e8W57hcRLg4yRGoed4cJdtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795763732;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=yHuX3HFjSSMOPaajuVozxl5jxmse0rZffXCwLljYMdo=;
	b=PAaKQiBEefm9j8VlZsKW4qGOSoNYPNJSvDIscGZZOYYzgX/QeBjV257yL1b2mlOlueTf
	 pD9uMF/QLHC50PuBNIwyIc3KdxloOycFEvD3sGT4P8QmBbNRoZkUo8qAwBWS/fF1r9fSJ
	 pLkrbe4efANl0r4vb7J5BUtp7GdepXRbbx6LguC+KjNupgNLYoXB8FUMtCb7AxYPyJCI4
	 IoCgrxouPyF9reBIJ1yjJDyJDj7+IJfRakJQEVSxFSwxej37szTn/4lF+GhVii41ozQkj
	 eBIV++NX7DYhUXvxT9LV5AlWnMrJKxxCGvexpStUmvigA2mDf9OMGE3f1Bj1Sr4jOnw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1FFC51F00919;
	Fri, 27 Nov 2026 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795763732;
	bh=yHuX3HFjSSMOPaajuVozxl5jxmse0rZffXCwLljYMdo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=bduT+fgQ55ol1VlIwOoeJj8fPXwzaeX02VqZe19kucwAWz7RatpTftcRn/tfqnFNU
	 wI6XmANbrblEVrFvlRZfjqVNSlplTxNFhZMt18/rnIAF2eIAS+VnuNb9MF0b5yztpg
	 m1FQGqLiQS6EHH1Q/iuk1wOwWRyYsjtBp0cFbQTa/BkFA/CqRt65UyCftp7uwIRLSq
	 /KFr1WM3dNkrJGEHYBFWZ/D5DVw1woKMtM0LPfBQmy44JPsqNUFR7td/ouxLLBYyMS
	 8V51JhiEcrblKtgWul8aFCl1XQ7PPkS09hkd2QT+Q+dz1RqQ/V0Hepp+9CZCrLFj9S
	 4ezrAhJ3b8G9w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A6B9D4B5F5;
	Fri, 27 Nov 2026 07:15:21 +0000 (UTC)
From: Andrei Aleksandrov via B4 Relay <devnull+aladex.gmail.com@kernel.org>
Subject: [PATCH RFC 0/2] ALSA: usb-audio: Make the EPOS GSX 1000 v2 volume
 ring work
Date: Fri, 27 Nov 2026 08:15:20 +0100
Message-Id: <20261127-gsx1000-v1-0-833554c37b82@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyNz3fTiCkMDAwNdS1ODNCNLc3MTAwsDJaDqgqLUtMwKsEnRSkFuzkq
 xEMHi0qSs1OQSkBlKtbUAxIqMdnAAAAA=
X-Change-ID: 20261127-gsx1000-950f29774080
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-input@vger.kernel.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrei Aleksandrov <aladex@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795763720; l=2896;
 i=aladex@gmail.com; s=20261127; h=from:subject:message-id;
 bh=Cx5E16DVxiKC2W4AXUGiE4DSUnwoqavuCDkkSrkCAGU=;
 b=/FLIARca831KI99M2Hcc6myUHvdtGx/mI4TXGlV5zWmzSOlqmag+JNTZkIRBB4qduNEd8uorU
 Pg224/1KH9rDDKSEzgLOjFosffB5ildc4BkuL6UEUahhlnhf56BPzz/
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
Andrei Aleksandrov (2):
      ALSA: usb-audio: Add Windows volume scale quirk for EPOS GSX 1000 v2
      ALSA: usb-audio: Handle the EPOS GSX 1000 v2 volume ring in the driver

 sound/usb/mixer_maps.c   |  11 ++
 sound/usb/mixer_quirks.c | 343 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 354 insertions(+)
---
base-commit: 486060b97284c95384744f030706f89e1980a46e
change-id: 20261127-gsx1000-950f29774080

Best regards,
--  
Andrei Aleksandrov <aladex@gmail.com>


