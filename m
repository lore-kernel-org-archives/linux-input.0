Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FB43A0E8B
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532993; cv=none; b=fCSFWrPYFj04JrPcM9dv7Vs5D/vGtr/C0iZaMtTlEGyo7hphvH3fxPse600wmZXBB0rKpAD+iZIFcvuU/el3UbsWNUaY2TMFBHELqE9zyvbtiRDwJipbPb0SA2645m8TnYNYj3e5zwRflBFLFsCq4UIp5+8S5cx43XjUiFp962M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532993; c=relaxed/simple;
	bh=HZWJUJYl5qzZUZNxhWFbl4RPscpqQuHfVQ96gb8EV/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MNTwn/EgbB1wA9buS7pJeMap3JS37fYdj2KxXDrWm00el8rpfF0sapBLKszV5u9cVm5EuciHDp8FTfLP5End+MSO93ddH5yW9iUqz7bLB4SYEf4lb49RQKZvLa2djPa8ndxpP6AR9zkfNnmATe0ffUvXl/0Z6YynEp2hOKILqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sam3CX/M; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sam3CX/M"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b159850b16so1046415e87.3
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788532988; x=1789137788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Frach9V7xuyTlDSnYyXixBxqHiyY2R8LaYBpW7CwPLw=;
        b=Sam3CX/MevqP4Q5y5K9h2Zm/hpUVgLwEpW7yiAfuI68xyAcGyBBLWmddoOoYuUreG9
         IAmPmxua2FxihUtkeT0xGpkkBrj0pnSZZMxBfS0zj/KnilIfqgVnbFJuUV9Wv+uQSnWd
         E5wCtjpSWfgMnEYnQw3+ZQya5zGI7hquAAamZMC5hYQ9Cxa9CXfhw28isvvocbFtLuUA
         bjCqu3th6oYP1fIGlBmY35vV6s/dFJS+iZXyuK+WqnZ6tKbbL9hn8jtR+luxElq+Agwk
         jqkWy4Bkgd9BQPHRhYXdnHxyOFTghc+HalLdr7xELCeFc7Xkj22TDEfcl6i0qBNbtAUV
         sQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788532988; x=1789137788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Frach9V7xuyTlDSnYyXixBxqHiyY2R8LaYBpW7CwPLw=;
        b=ljYy9plniEsOV3gcAZC+29r6qebK7kBAN8o/5JCMc9oRhTKhPWs/TiquCApw8pdWIU
         hOdyvzIuSArgARYvNoV+kHEdmwFrscLYMcsqFHekvJQMYkiEvoPJqp5Fnoul4AgwBeMi
         hSRzXw8pt+9AX7+Wh1tO5zX9CIpdu73wXG9CENV0VovKrMtpv8kKwxXaPXK6ygZbbWHJ
         RApfq2LMI+1QVzis0f7v7XKjTB36XhczyF0YtKUl2kfi+ubrjJQNU3HuYShG+irDyPGa
         Ysyu5pBv+7QEzBCmlacX1Ya//rZJYBfQTjA1HcVvCFySLfT7s1syfeE4yOBPqWTcTNSe
         DguA==
X-Forwarded-Encrypted: i=1; AKwUvBxy+p7p2UO8c1BLjziWNgXWeZ0GjkRkis9QXUQuIDqSdsQTzAqxiQU/Wm6FWoT8VMmlT0uV1gMXjRtXNA==@vger.kernel.org
X-Gm-Message-State: AFuF++mdKkkRzWb7potp4GJGnfK+cvMKTQbD8dufds8vLH2JWgXMBenu
	iZvIv2DxdzWt179SX5dlBM5zexce8nweZkLTCQQa5jLoDWL6Va0iIkWA
X-Gm-Gg: AYBFou3jEU9TQZWjAbP5umqTdrP0SaHbHjus27HZv9PjKrNVF3FrvIsYHFnlh8Nx0qq
	RdT44qpn+bMui9e3QtHRgUTBxfm5ZwrZNrMHxsjlYlMY28FFfwWN8CV982aKIcJtzTeBMf4hlPw
	Sn9R5vovZ+GU6esTv4Pv4ySaJBvbCYFI30vVX5M7GR7Plou1q/cRCq9+hZ0X/mWSj41Mj6cRBg4
	CE4tR4Bmb3OvYUndKk1Z97Vgcs9tT+YEDX3/u+kHBZIOXc2q4KE8RX9TyQU0MNyQ9/iIPV1jdAP
	ByDCN4a25lzABXSYSX4Eb/pykeJaHOVnlDINFQ/9vMMXE+ZKANyeD2xJT+bCQxcf9LD7s9o2QG2
	ShPWdfla0BSWOlGgB9of8wgfShGs7K1Ct1zTtiMSWaJLb+Z981P14Kx7sjsRlhwM9I5jzHJjMkG
	sdyCkdUznj4MQA6pcwurItoi3jRbSQfoobzryZ/pSJWHH+Zp6IZ1alIM4jmKorWmtLbs7QcKXO/
	yapTy1LmxVSh/zlp2vo2FdZoctHnp3EhwsUL9uyh2+OncN8OQT4SVp5fWh1UgwbboKHYi8=
X-Received: by 2002:a05:6512:3a8d:b0:5b6:7fa:e96b with SMTP id 2adb3069b0e04-5b616f075bdmr2148081e87.14.1788532987650;
        Fri, 04 Sep 2026 07:43:07 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b61670537esm549289e87.66.2026.09.04.07.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:43:06 -0700 (PDT)
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
Subject: [RFC PATCH v3 0/2] the Topping M62's vendor controls, on the component framework
Date: Fri,  4 Sep 2026 19:42:58 +0500
Message-ID: <20260904144300.529289-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904141158.33398-1-mikhail.v.gavrilov@gmail.com>
References: <20260904141158.33398-1-mikhail.v.gavrilov@gmail.com>
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

Changes since v2:
 
  - topping_bind()'s error path dropped the controls before clearing
    m62->card, so a report arriving while a half-built set was being
    unwound could still find a control that snd_ctl_remove() had just
    freed. It is the race v2 fixed in topping_unbind() and left here.
    err_drop now clears the card under the lock first, as unbind does.
 
  - snd_topping_init() passed component_match_add()'s result straight
    to component_master_add_with_match(). The former reports a failed
    allocation by storing ERR_PTR(-ENOMEM) in the match pointer rather
    than by returning, and the latter reads match->num without an
    IS_ERR() check, so an allocation failure would have dereferenced
    an error pointer. There is now a check, and the two failure exits
    share one label.

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
 drivers/hid/hid-topping-m62.c | 898 ++++++++++++++++++++++++++++++++++
 sound/usb/Makefile            |   1 +
 sound/usb/mixer_quirks.c      |   5 +
 sound/usb/mixer_topping.c     | 186 +++++++
 sound/usb/mixer_topping.h     |   7 +
 10 files changed, 1132 insertions(+)
 create mode 100644 drivers/hid/hid-topping-m62.c
 create mode 100644 sound/usb/mixer_topping.c
 create mode 100644 sound/usb/mixer_topping.h

-- 
2.55.0

