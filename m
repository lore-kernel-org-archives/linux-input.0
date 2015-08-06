From: Ari Entlich <atrigent@gmail.com>
Subject: ALPS v7 trackpad passthrough to Thinkpad trackpoint
Date: Thu, 6 Aug 2015 07:07:19 -0400
Message-ID: <CANULwrQyVOhorRXb-+m=V-SZofn9dM3QJBU-xi=yFFOhq4t_2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35125 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbbHFLHU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 07:07:20 -0400
Received: by wibxm9 with SMTP id xm9so17697090wib.0
        for <linux-input@vger.kernel.org>; Thu, 06 Aug 2015 04:07:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!

I'm an owner of a Thinkpad T440p, and was always unhappy with the
buttonless trackpad. I was ecstatic when I learned that trackpads from
the 50 series laptops, with buttons, are compatible with 40 series
laptops. I have since performed this mod, and all of the hardware
seems to be working.

The only problem I've been having is a software one. It seems that the
trackpad and trackpoint are usually arranged such that the trackpoint
is "behind" the trackpad and all communication with the trackpoint
goes through the trackpad. This allows the trackpad to provide an
abstraction of the trackpoint for OSes that don't explicitly support
it.

With my old trackpad, which was a Synaptics device, Linux would detect
the trackpoint as its own device with the TPPS/2 protocol. It seems
that it was able to do this because the Synaptics driver has support
for a "pass-through port" which allows the OS to send commands
directly to the trackpoint. However, the new trackpad that I received
is an ALPS v7 device. I see some references to passthrough support in
drivers/input/mouse/alps.c, but it doesn't appear to be used in the
same way as it is in the Synaptics driver and doesn't seem to be
supported at all for v7 devices. Therefore, instead of showing up as
its own special device, the trackpoint shows up as a "DualPoint
Stick". In general this is fine, because the trackpoint works.
However, the dedicated trackpoint driver allows you to modify a few
trackpoint-specific hardware settings, most notably the sensitivity.
This was much more of an issue before this:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=088df2ccef75754cc16a6ba31829d23bcb2b68ed
commit, but I still think it would be nice to be able to control my
hardware as much as possible.

Interestingly, I've been able to find very little discussion of this
limitation of the ALPS driver. Here are the few links that I've been
able to find:

https://bugzilla.kernel.org/show_bug.cgi?id=8864 (comment 24 seems
especially relevant)
https://bugzilla.redhat.com/show_bug.cgi?id=483224
http://www.spinics.net/lists/xorg/msg49549.html
http://thinkpad-forum.de/threads/185025-T*50-Clickpad-in-T*40-Trackpoint-Konfiguration
(German)

Since the trackpad that I received is from some Thinkpad model (I
don't know which one though), there presumably should be other 50
series Thinkpad users who are affected by this same issue. It could
just be that the number of people with the right device who use Linux
and want to adjust the hardware sensitivity and care enough to post
about it online is essentially zero, but I've had a hard time
convincing myself of this.

Comment 24 in the first link states that ALPS has been unwilling to
share the secret to the passthrough port for their hardware. However,
this comment is 8 years old, so I'm hoping things have changed. The
second and third links seem to be describing approximately the same
problem, with one difference being that disabling the trackpad in the
BIOS does not cause the trackpoint driver to be used for me - it only
causes the trackpad device to stop emitting events. Perhaps this is
because the buttons are now part of the trackpad device, or maybe it's
just because this is a non-standard mod. The fourth link seems to be
describing the exact problem that I'm having, however my ability to
read German is only as good as Google Translate ability to translate
it.

If there's anything that I can do to help get this implemented, please
let me know. I'd even be willing to try and figure out how the Windows
driver does this, if that becomes necessary.

Also: I am aware that sensitivity/speed/acceleration/whatever can be
adjusted somewhat through libinput settings. That is not what I'm
asking about, so please don't suggest it. :)

Thanks!

Ari
