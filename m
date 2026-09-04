Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2623B9937
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535860; cv=none; b=pUgZe6GjBXFyshnrm6GJBhT7K00CleShUlhcpm+POWRR6WfcDdnAio74l/J1hPZyLK5EVIdFzpjarMPDtnU7JL5mGEHtR4/cb69JL9nLnmy+Cv/TJ1gqmSZ/k/gGEQEE8JGVpRFPocUgxDuoNXo4ExYATqnVCDg9rDyDyU3JpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535860; c=relaxed/simple;
	bh=Fc4fLddr02kRxM33eAKsYPez5anu/pcU9EZivRIxfaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFg3RvcNjFTmbd1DtqullcuMyB/Gw9YIMl8PxdU8t9b7pTUzD4gV8L4XhhYNJuw0u40xKtXGeK+o9XSutkdyrt38GfGDv6CmMelnovB2Fbui0liX0qJ2V+DsbWgjxmWeqIX5Aatlj7h56x1zOfaoby4M3h1oQDZ3FXEiQKgRpZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN+s89+g; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN+s89+g"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b4aa47bc97so902992e87.2
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788535856; x=1789140656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0TPZ21eFA3bZ8m6vgcnAoZQZ18Q53I/Yk61gntK1kQw=;
        b=DN+s89+g1xyrUN23VuKAW3AAiQ/I7aoDRKwS3gs5RJetZgA8D2F0k70s4WbIDEaVcV
         YapmIJN6PEvFFvTJbTVyihQNFkSPNZbAQdYr30eipeMxkircoX2kXlmNmMbaNVv1/ctI
         DbRlVYCb65V2CYA1YK4ZS1urHoYigsbjgPII3VT1NmCsRM/znpJu45qkSooLtNTyUEVH
         FfHICe+mVp3uOPzb+KqmnNdnWY0T7qEJgm38C6S1zmhO0q2EWU9gsZhOr/mrjtVlDEL7
         FPh//3TEdbWSA3gbwjpWjDNk9hNVY/n88JTYH6rr9ZM6hTYZgxz/BQRtds9WsobomTDk
         zC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788535856; x=1789140656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0TPZ21eFA3bZ8m6vgcnAoZQZ18Q53I/Yk61gntK1kQw=;
        b=MNdGpfMveEXHDE45iJTCTYM+G+CJ7CCrga+/nJBmxvtZvS5/s94+Ev7mXvKdf+luGz
         xBeOokSlLXoYf4qLO7cAhl3gZMLEzXxS4VUiU444mXVTSXK6t1+iqzdlBGagXnuGmkhk
         O8M2bq22yoMjDQGbP4Qq3kDZuBYhPU1kl0HDWuo2mLoUrAwPkEgQASQ3yD5mTd+aFeoy
         D3gEbPW7/Yj9HDrJH8psv4HEhRLbT1rz0sthougWc8J+Hkq0Wuc0TS7i7yaYIlFhQSWa
         AUXmpPSMBrV7+5m6Hpbn0X0MF4CzDICpMWCD9oWQlm4Hp32vVEqiq3iY8xhxRZhI6qk2
         dIFA==
X-Forwarded-Encrypted: i=1; AKwUvBz1sFxfQyBrmxSVOLP4WrZqHTZYRSRwRS5mmy/hxTDLc2M21KgIlv5/NbUi2L6tc9jlwHU8Bt4e/cYTSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kOMAH405HYtzoIPximq7ft6uH9GHgXRpGnJsllRIPzHfOlXUr1
	5gD7DgqKK+BeTa7Idzi/EJDAkMYLe3SjSvFJK4M8/pZX0LTZreu5K7P9
X-Gm-Gg: AYBFou1r2hGkMsMNyDXEWENGgN/xrqgT8AFRbyZl3vUPLo1njnClY2jrPnroM1m+hT4
	UrJ3BqA86vPp9dEW/dJa3k8TzdEa50pe602ifbEtWBoW1tmhGPiyQAdBjz8sxDoxvDEaIOJO6vn
	jvl6zjIteXtRcdesvd2/qJORYh4JfXaiDRQusM+9gb3aQoQGxTN+MlM6objxLRycmtuR40N+mYc
	Zp+jgPLvHETxBhRHkRcxsL9lTDy70im4eC3yUfL/zhBhHzGBoYB/gWe+OwrYzRNTppe0aj+dgzR
	HjwzrTgYQThXcamRILNgWZo78PhCepfhOu4uH7Zv11lm4tPhnkizWItmGokRG16WmEW05YL+WVt
	qN8JDAL1Zko3r2nARN59bPIg2vBclLHEyTUwKXjX2ZLVoYf8GbUP+9ZvotfVUh82Duqc3jSilEl
	nEALlTQKttQ3ROJpSYIX5BSTyVALawH7+IZp6+MDbjXhdSg8Yh4XdE7aXXGHlnQlQakcIIjOWzM
	e//j3JPc4bAG5P76JN0MaUK1hSmXLpMxW54bZ7hzz7INinOHC0+D2H9gH7g
X-Received: by 2002:a05:6512:6c9:b0:5b6:183c:5c93 with SMTP id 2adb3069b0e04-5b6183c5d80mr932144e87.49.1788535855351;
        Fri, 04 Sep 2026 08:30:55 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166f6c0csm597079e87.39.2026.09.04.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:30:54 -0700 (PDT)
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
Subject: [RFC PATCH v4 0/2] the Topping M62's vendor controls, on the component framework
Date: Fri,  4 Sep 2026 20:30:49 +0500
Message-ID: <20260904153051.1785280-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904144300.529289-1-mikhail.v.gavrilov@gmail.com>
References: <20260904144300.529289-1-mikhail.v.gavrilov@gmail.com>
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

Changes since v3:
 
  - m62->kctl[] was written without the lock that .raw_event() takes to
    read it. The object behind the pointer was safe by accident --
    snd_ctl_add() takes controls_rwsem, whose release orders the
    initialisation before the pointer store -- but the asymmetry itself
    is a data race and reads as one.
 
    Rather than paper over it with a barrier, the whole set is now
    built into a local array, where no interrupt can reach it, and
    published in one store under the lock together with m62->card.
    That makes m62->card the single flag: while it is NULL,
    .raw_event() never looks at m62->kctl[] at all. topping_unbind()
    is its mirror, taking the set away under the lock and only then
    calling snd_ctl_remove(), which sleeps and cannot run from in
    there.
 
  - with that, topping_bind() no longer needs a goto, which also
    settles the second finding: cleanup.h asks that "goto" and
    scope-based cleanup are never mixed in one function, and the error
    path now returns normally. topping_add_kctl() and
    topping_drop_kctls() work on the array they are handed and no
    longer touch m62 at all.
 
  - the master's devres context could outlive its usefulness the other
    way round. usb_audio_probe() deliberately leaves the card and its
    mixer list alone when a probe fails on an interface after an
    earlier one succeeded, so a mixer created by that failed probe
    stays on chip->mixer_list while the interface's devres -- and with
    it this master's context -- is released. A later disconnect then
    reached topping_private_free() with a private_data pointing at
    freed storage.
 
    topping_master_release() was empty, since the normal road goes
    through devres_destroy() and never calls it. It now does the work
    that road needs: the context carries a back pointer to its mixer,
    and the release takes the master down and unhooks private_data and
    private_free, so nothing is left pointing at it.

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
 drivers/hid/hid-topping-m62.c | 916 ++++++++++++++++++++++++++++++++++
 sound/usb/Makefile            |   1 +
 sound/usb/mixer_quirks.c      |   5 +
 sound/usb/mixer_topping.c     | 204 ++++++++
 sound/usb/mixer_topping.h     |   7 +
 10 files changed, 1168 insertions(+)
 create mode 100644 drivers/hid/hid-topping-m62.c
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

-- 
2.55.0

