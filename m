Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F84EBAC5
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538965; cv=none; b=W0M2zfkscyd0Hc7T/MrdvPrOeGlu9eXth7JT+ms3tDcsp8sbNPTcbPAp3s9erjD3r6zEEvVFGSpk9rnKdKAK/E9uea9k+P2Z8dqLbujQOz3igYvem2p8QHlgPtde4P+/NoyKCiL08FlAFCvO0vqZclD0X0CI4paSG4B5eDlG4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538965; c=relaxed/simple;
	bh=tzK3UKTtS9JIjsbVctIiNEivUU+ANwbZzqbfNXNfpRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKr+HJz/52ziRFSjcXZS/b7lRRL32psPt4DuNJEBJg6h2Q8GqVAwUQhToIGruBuVh4Qh4rcM9c5BvZi1Q2SAsaUl8aPg5MyFUngGTq7kaEM5rbaseOY7BJ4Y8oBGblvz0O7zactqR5YVBJryH22z9oDjH6EtpOGsnGL7rFdIUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYiZO2fv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYiZO2fv"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b14d1f9315so1188738e87.2
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788538960; x=1789143760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/2ZdZdl6qmR51zeaL+nCzu0LwWvHRFYyLrBt4GeQgM=;
        b=sYiZO2fvaxkC8pDZcQsFIDf+/rO4gZVP42g6LWm4QbWYW+zIbj/47dHqyX0SdNTUbo
         3fEOFULefgz3lZSh3TbGzorEKJqgzQNIG0aqceweAr1m179FZnkt4gyC7JrwPfEs9tEB
         9eGg8n5iq6SUPEny5+3mjZ7jGz9ET6YsK9L/64y9LW49nhPkHwwWXNK8y6DcYlxxO7gK
         /n08VOW9189Ks54zSCnC0PEmWEyGTXCS0kO6diux1MhMl4ft4Ok5uIpNenA0ORFgW4g+
         ytUQ2kn/61KiXYRMpSH8CqaLGQ152kzSsiWOTgwWyGptuyUuOoloXfG980MMmqYp9NVJ
         Ea2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538960; x=1789143760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/2ZdZdl6qmR51zeaL+nCzu0LwWvHRFYyLrBt4GeQgM=;
        b=ALV6x2texffz6OSqIuEplts62Xhn01eTQS/0L0pgBwpfpeuWgclixiwfdnd0fCkg66
         z4UjAhTZJleHVPt/lSGPXYQNt/rZ1JNoAk6VGSrKDTKFCevq6PgrY7eSO1w+8IjLGpxm
         +TXJhSl/gvancj58zgnOcd6zBBL1ApgUwfUlt8+WliBuZK+VN/Qjf4A7qAu6MoiR145R
         XUlPLxG7J0RJYmn8fUClI4AzQkXP4M/U4C+agwjSWjMqskP1L/qirIfDZ32g3bixfmqD
         tU+tZ8GSIylzm2dHA3RDq12Aa0IpuDAFLYJYsqHdLbADcoDmoAPSfy/U1wnRF32IT6f0
         VheQ==
X-Forwarded-Encrypted: i=1; AKwUvBwe9Fuv+J2Li9MsSSpVX4sBQihCxFjrXagJIpG6sb3OjnmW67QQewb0t54JBWo/7T7ZURl7uut+wUtESA==@vger.kernel.org
X-Gm-Message-State: AFuF++lNRWqsXuf64VUrgMYWAwc8g17MZkiWb6yBl3e/3qnhPDbuaNFz
	H7g9dpzRZt8xKf19NTSoKhHrExao/iMaMs28wuByfR4oNpK3skhEjClQ
X-Gm-Gg: AYBFou2IDyGeFoiwUvPiZv9qMRWKA3hqhj5lft/QGv7umZPsfYh1XLntH1x4mfbho3m
	/X7HZuN5/tAYvcxf8kuTedii0Sfs935z1c7TEUVS6xoGwuoGr7WeBlvtGoviX/N6jTLe4AvvBso
	Pu/SOXcjyP5BOW59NHlEEfsOCZeSY7NL/KscIxRUWc8DdmykI54R2j8ABH1taqYl9SmIXd2SCOP
	tSqvXIofsly2Gc408lOQWoZfDkSKYrPvrdANURZIF9CswOyfjpfh+eFpn1wPtX2xtDat8GPq7nv
	l6GLKQSaXSZG59FUKhFp2bQ+OP9bD72JE0MmvJAj6uRTlE9Ou6A92FTyV20Gl3y1V76HaZkw1UR
	purUj/VKValoD1UxF4nbZcV2VYZF/F9FFZ0ZsA7KwdN8QPd27HaEp1Nr13wp91KzVzXxTsJlkif
	aEndORVBCIyl8oUORUQ6SKqLLT/msU8GQm4d0siePjWFiRiFCRU5QaEupwOIG3FV7/yYPKvbWk7
	8j4HFJgmkghd8x2ZXf7edRkE+gtWZHgNuf7Ub14epLY/W6/QHVxNxsfvlYq
X-Received: by 2002:a05:6512:3985:b0:5b4:ac27:6bb0 with SMTP id 2adb3069b0e04-5b616f4ba31mr1908487e87.25.1788538960167;
        Fri, 04 Sep 2026 09:22:40 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b667b6c30fsm281370e87.9.2026.09.04.09.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:22:39 -0700 (PDT)
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
Subject: [RFC PATCH v5 0/2] the Topping M62's vendor controls, on the component framework
Date: Fri,  4 Sep 2026 21:22:34 +0500
Message-ID: <20260904162236.3212370-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904153051.1785280-1-mikhail.v.gavrilov@gmail.com>
References: <20260904153051.1785280-1-mikhail.v.gavrilov@gmail.com>
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

Changes since v4:
 
  - the master's teardown could not work from the path it was written
    for. topping_master_release() called component_master_del(), which
    calls topping_master_unbind(), which looked its own context up with
    devres_find() -- and devres_release_all() moves every node off the
    device before it calls a single release, so that lookup always came
    back empty. The WARN_ON fired and the unbind was skipped, leaving
    the component bound to a master that no longer existed.
 
    Worse, the skip was load-bearing: component_unbind_all() walks the
    match array, and component_match_add() had put that array in devres
    after the context, so devres releases it first. Had the unbind gone
    ahead it would have walked freed memory.
 
    Two changes. topping_master_unbind() no longer looks anything up:
    it passes NULL as the component data, and the HID side takes its
    controls off the card it was handed at bind, which it still has.
    And the teardown moved out of the release into its own devres
    action, registered after component_match_add(), so that it unwinds
    before the match array rather than after it.
 
    topping_master_release() is storage again, and the ordering that
    v4's release was reaching for is now expressed by where the action
    is registered rather than by hoping.

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
 drivers/hid/hid-topping-m62.c | 925 ++++++++++++++++++++++++++++++++++
 sound/usb/Makefile            |   1 +
 sound/usb/mixer_quirks.c      |   5 +
 sound/usb/mixer_topping.c     | 227 +++++++++
 sound/usb/mixer_topping.h     |   7 +
 10 files changed, 1200 insertions(+)
 create mode 100644 drivers/hid/hid-topping-m62.c
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

-- 
2.55.0

