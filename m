From: Matt Sturgeon <matt@sturgeon.me.uk>
Subject: xpad: System freeze when using force feedback
Date: Tue, 2 Feb 2016 22:08:30 +0000
Message-ID: <CABVhHhqk1mme4Vg7YXy+Uu8QGL7PKzFtaTJMyNL4wfCR4XDD8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38503 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbcBBWIc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Feb 2016 17:08:32 -0500
Received: by mail-wm0-f54.google.com with SMTP id p63so43845809wmp.1
        for <linux-input@vger.kernel.org>; Tue, 02 Feb 2016 14:08:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I realise I sent the below email without a subject!

I am led to believe the patch
here[https://github.com/torvalds/linux/commit/7fc595f4c02636eadaeeecfe7bbc45b57c173004]
fixes the issue.

You should disregard this thread and resent me for wasting your valuable time :)


---------- Forwarded message ----------
From: Matt Sturgeon <matt@sturgeon.me.uk>
Date: Tue, Feb 2, 2016 at 1:14 AM
Subject:
To: linux-input@vger.kernel.org


Hi

There is a bug in xpad that (as far as I can tell) has a few fixes
implemented, but none are yet included upstream.

Whilst I am no computer scientist or engineer, I understand that the
bug is related to force feedback (vibration) on xpad controllers
causing the system to freeze up and require a hard reset (kernel
panic?)

My apologies if this has been addressed somewhere, but in my kernel
(4.2.0-25-generic #30-Ubuntu) the issue remains, particularly for me
when playing GRID Autosport using an wired Xbox 360 controller.

I've heard that valve have fixed the issue in their steamos kernel.
There is also a patch proposed in May 2014 by Sarah Bessmer
[http://www.spinics.net/lists/linux-input/msg31450.html] and an
updated version of the same patch
[http://steamcommunity.com/app/233130/discussions/0/611702631210587760/#c611702631218590990].

As far as reports of the issue, there are two threads on steam with
users reporting Sarah's patch fixes the issue. I myself can also
confirm the patch fixed the bug for me and I haven't noticed any side
effects, although I don't really know what to look for.

In conclusion, you may think of this as somewhat of a "bump" for
Sarah's patch. Whilst I do not consider myself a skilled or
experienced programmer and I've never really looked at lower level
stuff like drivers before, I am willing to help get a fix merged in
any way I can.

Apologies once more, if this is already in progress or I have
approached this in the wrong way,

Regards,

Matt Sturgeon
