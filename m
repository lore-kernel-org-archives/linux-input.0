From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 2/3] Input: ALPS - Add code to support "Rushmore" touchpads
Date: Sat, 26 Jan 2013 10:45:59 -0800
Message-ID: <CAJiQ=7DmMAuV8GPvxyUMJbTG8TBPBG8PaaZ5-kED6gFf_5k21Q@mail.gmail.com>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
	<092b691c8e994d31cb235fd7c45afee4@localhost>
	<87zjzwqhxi.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:55957 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab3AZSp7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jan 2013 13:45:59 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so818101pad.3
        for <linux-input@vger.kernel.org>; Sat, 26 Jan 2013 10:45:59 -0800 (PST)
In-Reply-To: <87zjzwqhxi.fsf@dell.be.48ers.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: dmitry.torokhov@gmail.com, seth.forshee@canonical.com, linux-input@vger.kernel.org

On Sat, Jan 26, 2013 at 3:53 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> Thanks. I've tested it here on a e6230 (bios rev 08), and it gets
> correctly detected (but twice?):
>
> input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input14
> input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input16

It should show one input device for the trackstick, and one input
device for the touchpad:

[397682.041027] input: DualPoint Stick as
/devices/platform/i8042/serio1/input/input17
[397682.054959] input: AlpsPS/2 ALPS DualPoint TouchPad as
/devices/platform/i8042/serio1/input/input18

I'm not sure what would cause it to register two identical touchpads;
I don't see that on either E6230 or E6430.  Did you build psmouse.ko
from my DKMS sources, or apply the patches on top of some other
baseline?

> But the input events seem very noisy (E.G. the cursor jumps up and down
> if I keep my finger pressed on the touchpad). Especially the Y
> coordinate seems unstable:

OK - I do see this on E6230 but not E6430.  Normal usage is fine but
the "pressed finger" test fails on E6230.  I'll do some digging and
try to figure out why.

In another thread [1] it was mentioned that the ALPS_BITMAP_*
constants needed to be tweaked for the Rushmore touchpads.  This might
be related.

I also saw some "lost sync" errors in the kernel log on E6430 after
running for a few days, but I don't know how to reproduce the issue.
They did not seem to be associated with any obvious touchpad
misbehavior.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/606238
