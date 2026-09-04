Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355834AE8BD
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531129; cv=none; b=exfonn3GMjeIobENTOVf8bHxgkkCW/c49i555jFC293P8BM32lj3gPa/SsX0VrdganQpcqwDQJdIZ8DBrT1OKpxw3kY6stsjRI4MB50NjqCEJGuPrdXOwlTGdcGGUcZu5y6QuL2c7rH4TuZ3ZEiLnamqbv8kgAPTD+kAx41pMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531129; c=relaxed/simple;
	bh=o7qwfV22RsRaxa5PF4Zkk+tx4olXOcpRrxhfqiDgQBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al/B0yiKAIILzcUMSQLo2j54pB4Vw7zeqQu50WJCDaJ2PrLhHHou32PygFw1eD5eeQbxZaZsvXob5qp4VBx5Bwk7S24OPs/y0Q+AgbONjkJtY03Ju3Xl6hIFnKXMBynAq15gPZVPdtwoi+dt2eD9hgVKQ8mC1/RAvJ/YWoJpeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr/wKaHS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr/wKaHS"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aec201b582so1252543e87.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 07:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788531125; x=1789135925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=giefFbYJnxXweExm99mm3enYQv1jOphCqfhZ+67U7jE=;
        b=fr/wKaHSLE4qJD+Jbq6AQ+tuF71BMBX82KVkvPQFHqw1B4QSZIXiXNb0xUnokLOEM0
         wmH+fe0wGrmnyRXNQVy9nGWHTsqB4g7QSdEZ40L1qoouyXoYjMXdA7E5Yxl+focIft9K
         BugkR6rTURQyg45bTZ1cKypBKrXMY13A4KpWpBwZsd10T4VMBzD5+LQo9NrWCHR0VOKP
         8A5hw4bmw2ZiAqBSeOB/O2hs2PI7Qme7dBBgVfaIiV988gFxsPuwaj1S5tpi0AQ8nKew
         nVZFbMupNL3y0QeVQtGHcHf1EnSOO3F3i1Ym/wAxxkvcRHz7VcL7L8lUAN4VBdAA4VPH
         hHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788531125; x=1789135925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=giefFbYJnxXweExm99mm3enYQv1jOphCqfhZ+67U7jE=;
        b=cBDQ6L5mdhTTlB3ICd15BcSQc+JucxjNHL8jKLCmowEy+KP88VmnMou2+8VuGQ5uMK
         L7d7TQUusxfdYLoqitTKey6U3C2//0tbuTikOiDlCOEYRTNBY8qQEq4yoRRFLDrqQ42T
         xLwIyyVFgOqlE+ac4EhRCOw4+d6dAo7WvAnLwrzaTHnZwpwzJ2BeGmt+SBP+tc5SIPqS
         3UggGQO/T479nXecusDEFoj/bFyOEhRI+M4XxzzYxFIVnZMLkPD1V4E40LBluxnsmVE3
         G/pPFCOqneY9muBG6oSmX0/D+1l/jjvSCbn4eQXsuzBSkDGTZAH6dT/AdYKUhH/5kNyv
         i4ZQ==
X-Forwarded-Encrypted: i=1; AKwUvByZsb1WJ3n+JXPd2b1fAW4cvsR7WHQbfpICyytM1cik/yyN2yT8G2+xS/OA21GEfwKmjQkPfc7v6xiOlw==@vger.kernel.org
X-Gm-Message-State: AFuF++nEyLEt/ZC88fDy3wR7VZCAbFmAv093N1X6RKjZRy+J37Jj79xs
	HHzOxpjYeI0EAurXeTSqVIKPv2pvi2lc4c0rJFjSRPz95vb2UVgdHAQk
X-Gm-Gg: AYBFou06TMj6wUZqYo6ZKowDwt6xvtFGLMx262FlD5Jkre8F3gaFJVw80E93kvRKtOc
	ylW98qdwA3CGs9BUl3DXe6ZbbedHTbm+Wh8wCL4VjW6C4SCEXI1L94rfz26DunZYg+kk9geBPDZ
	q6H6VO6udBV/x4laIPB2t2iNaDFqeFCalHqFD/3Svr9IUh2eH7PNm9rdzumymSN4N3FuyoYYSe/
	fC/MfjSyYfkjiOw7rkAe4BRZiXqseK/h05IvktBYBGrwNVsfmePdFPc2QL3510cRq+2GGSu7aqp
	zzuBxT8JerFcTWG8yOYuQUoNj4sH5eAKokP4J7HTLDtOQNA2ETVwAoqir8jOaISKXUyOE+4t/jW
	/ivnpz2cv1q+MoWLLVO5tpsVAZNI2/r1QEOPdet3+bB3jFI3/Bg72Fdd9GEhFgHPII+LT2WVtty
	OkZv5q6YxOhHgOkEDEqUo2Q4KAMtisZg/Y8HWOjHeorw2iGPV7T4qwwd4wfR+YUbFl0lFiKwln2
	F4LfiqJbTExDIakGF6T9BCwyf5Vg8oCACYlDAAOkrLIFoXrKS4CobqjmR6U
X-Received: by 2002:a05:6512:3b2a:b0:5b6:1870:2689 with SMTP id 2adb3069b0e04-5b6187043c0mr865547e87.58.1788531124648;
        Fri, 04 Sep 2026 07:12:04 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166fe10asm530844e87.47.2026.09.04.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:12:03 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [RFC PATCH v2 0/2] the Topping M62's vendor controls, on the component framework
Date: Fri,  4 Sep 2026 19:11:56 +0500
Message-ID: <20260904141158.33398-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904112610.3286659-1-mikhail.v.gavrilov@gmail.com>
References: <20260904112610.3286659-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the experiment Takashi suggested in the v8 thread: an
individual HID driver joined to snd-usb-audio through the component
framework, instead of a mixer quirk that claims the HID interface for
itself. It is posted as an RFC rather than as v9 because v8 is not
withdrawn -- it remains the alternative, and the choice between the two
is the question this series exists to answer.

I said this morning that I would hold this until the questions in that
thread were answered. I am sending it anyway, because a patch gets a
better answer than a question does, and because the last of those
questions answered itself: the correction I sent a few hours ago
proposed deferring the controls until the card reports, and working out
how that lands in code showed why it cannot -- which is in the section
below. The only question still genuinely open is the HID one, and it
touches one line.

Changes since the RFC, all three from the Sashiko bot's review of it:
 
  - .raw_event() read the control pointer under the lock and used it
    after releasing it. snd_ctl_notify() dereferences the id it is
    given -- it compares id->numid and copies the structure into the
    event -- so an unbind racing between the two could free the
    control first, and the card pointer was stale by then as well.
    The notify now happens under the same lock; it is safe there,
    taking read_lock_irqsave and allocating with GFP_ATOMIC, and
    usb-audio's own mixer already notifies from a URB completion.
 
  - the keepalive could outlive the driver. topping_unbind() cancelled
    the work before clearing m62->card, so a resume in that window
    could see a live card and schedule it again, and topping_remove()
    never cancelled at all -- devm would free the driver data with the
    timer still armed. The clear now comes first, resume tests and
    schedules under the same lock, and remove() cancels
    unconditionally.
 
  - the third finding, that topping_drop_kctls() passes NULL to
    snd_ctl_remove(), is not a defect. That function returns 0 on a
    NULL control as its first statement and its kerneldoc says so;
    the loop is deliberately unconditional so that a partly built set
    unwinds through one path.
 
No other changes: the sound side is untouched.
 
  - topping_send() logged at err level for -EPROTO, so pulling the
    cable out of a card that was being written to produced eight
    complaints about a device that was already leaving. EPROTO and
    EILSEQ join ENODEV and ESHUTDOWN in the quiet list. The keepalive
    still gives up only on the latter two: EPROTO can be a transient
    bus error, and stopping on it would leave the subscription dead
    until the next replug.

What the shape buys, measured rather than argued:

  - card.c is not touched at all. The v8 series had to add
    snd_usb_claim_iface() and snd_usb_release_iface() there, and had a
    defect I reported separately: an interface claimed and marked
    USB_AUDIO_IFACE_UNUSED never gets told to wind down, because
    usb_audio_disconnect() returns at its first line. With no claim
    there is no such interface and the defect has nothing to attach
    to. Watching the wire with usbmon: unbind the audio interface and
    the keepalive stops. In v8 it kept going.

  - the hid_ignore_list entry goes away, so hidraw stays available.
    That matters because five of the card's functions -- the mixer
    matrix, the mutes, the loopback routing, the input power and the
    EQ -- are reachable only through the vendor protocol, and v8 made
    them unreachable from userspace as the price of the quirk.

  - two M62s on one host bind to their own cards. The match is by
    descent from the shared USB device, and it holds: gains set on one
    do not appear on the other, and unplugging one leaves the other's
    controls in place. The quirk road could not be tested for this at
    all.

On the timing worry from that thread: it does not bite on an ordinary
plug. The master goes up from snd_topping_init() inside
snd_usb_create_mixer(), so the bind is synchronous and the controls
exist before try_to_register_card() -- the same ordering as v8. From
HID probe to component bind, 54 to 57 ms across five replugs. Only a
module reload onto a live card adds controls after registration, and
there a desktop mixer does not follow the renumbered elements until
wireplumber is restarted. That is a real wart and I have not found a
way around it that is worth the code.

What the card does and does not report

I got this wrong twice in the v8 thread and would rather state it
plainly here, since the design follows from it.

After a subscribe the card reports itself in two waves: jacks at about
0.9 s, then at about 5.2 s the jacks again plus the output mutes plus
the gain of every input whose jack is present. Every turn of a
front-panel knob is reported as it happens, gains and output volumes
alike. What is never reported is a source selector, because the card
reports events and a selector has no front-panel control, so no event
can exist; and an output volume before anyone has touched it, because
it is a setting rather than a physical fact.

So five of the nine controls have a source of truth on the card, two
have one only after a hand moves them, and two never do.

That looked at first like an argument for deferring the controls until
the first report lands, so that a value read at connect would be the
panel's rather than something restored over it. I have not done that,
and here is why: alsactl restores once, at card add, and does not
come back for elements that appear later. Deferring would therefore
trade an accurate value for five controls against no restore at all
for nine, and would wait forever for an input with nothing plugged
into it -- which on a five-input card is the normal case.
The controls are published at bind, as in v8, and the value at
connect is the restored one.

Open question, not blocking the review

hid_hw_open() sets intf->needs_remote_wakeup, and usbhid offers no way
to take input reports without it. This card does not advertise remote
wakeup (bmAttributes 0xc0, no power/wakeup node), so that forbids
runtime suspend to the whole device -- undoing something an earlier
revision of the v8 series had to fix. The driver clears the flag after
opening, with a comment saying so, because it resynchronises on resume
and has no use for a device-initiated wakeup. Jiri and Benjamin have
been asked whether that is acceptable or whether usbhid should offer
something; the question is in the same thread and unanswered. If the
answer is that the clear must go, HID_CONNECT_DRIVER replaces
HID_CONNECT_HIDRAW and the hidraw node goes with it.

Tested

Fedora, 7.3.0-rc1-bc35965f6940 plus this series, with KASAN,
PROVE_LOCKING and UBSAN enabled. One M62, firmware V87.05.45.48.27,
and a second of the same for the two-card test. Everything below was
run after the fixes listed above, not before them.
 
All nine controls read and written from amixer and from the front
panel, values cross-checked against the panel.
 
One hundred cycles of module load and unload against a live card,
which is the path the fixes touch: the controls come and go while the
meter stream keeps arriving, so .raw_event() runs against a set of
controls that is being taken apart. No splat and no lockdep complaint,
including on the lock order the first fix introduces -- m62->lock is
now held across snd_ctl_notify(), which takes the card's
controls_rwlock inside it.
 
An audio-side unbind and rebind, exercising topping_unbind() through
the master rather than through the HID driver's own remove.
 
The cable pulled out of a card while a control was being written in a
loop. That produces a run of failed writes and then the disconnect,
and after the last fix it does so without a line of complaint each.
 
System suspend and resume: the subscription survives it -- turning a
front-panel knob afterwards still moves the control -- and the
selectors are written back on the way out, as they must be since the
card never reports them.
 
Two cards on one host, on different ports of the same hub: the
component match is by descent from the shared USB device and it holds
-- dmesg shows snd-usb-audio 3-1.3:1.0 binding one HID device and
3-1.4.2:1.0 the other, each card carries its own nine controls, gains
set from one front panel move only that card's controls, and
unplugging one leaves the other's in place.
 
Not tested:
 
  - hibernation, and with it .reset_resume, which shares
    topping_resume() with .resume. This machine is not set up for it:
    there is no resume= on the command line and zram takes swap
    priority, so the attempt logs "PM: Image not found (code -16)" and
    powers off instead of saving an image. That is the same on a stock
    kernel and has nothing to do with this series, but it does mean
    the path is unexercised;
  - kmemleak, compiled in on this system but disabled at boot;
  - a card whose battery has run down;
  - anything on a big-endian host.

Ordering

The HID driver comes first. Between the two patches it binds, speaks
to the card and creates no controls, which is harmless; the reverse
order leaves a master that never matches, which is equally harmless
but leaves hid-generic making a bogus input device out of the
descriptor in the meantime.

Mikhail Gavrilov (2):
  HID: topping-m62: driver for the M62's vendor controls
  ALSA: usb-audio: bind the Topping M62's vendor controls

 MAINTAINERS                   |   9 +
 drivers/hid/Kconfig           |  19 +
 drivers/hid/Makefile          |   1 +
 drivers/hid/hid-ids.h         |   3 +
 drivers/hid/hid-quirks.c      |   3 +
 drivers/hid/hid-topping-m62.c | 889 ++++++++++++++++++++++++++++++++++
 sound/usb/Makefile            |   1 +
 sound/usb/mixer_quirks.c      |   5 +
 sound/usb/mixer_topping.c     | 173 +++++++
 sound/usb/mixer_topping.h     |   7 +
 10 files changed, 1110 insertions(+)
 create mode 100644 drivers/hid/hid-topping-m62.c
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

-- 
2.55.0

