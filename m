From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/4] TTY: fix Caps Lock LED
Date: Fri, 27 Jan 2017 18:13:14 +0100
Message-ID: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932198AbdA0RPl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Jan 2017 12:15:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Well, it's quite an old issue, but it looks like no one cared much before :)

So by default, on Fedora and RHEL at least*, the Caps Lock LED is broken while
in a VT. I tracked down the issue to be a change in ckbcomp introduced because
the kernel just can't properly handle all keymaps. However, if the keymap now
works thanks to the work around in place, the LED just doesn't.

This series aims at trying to have a consistent LEDs status while in VT.
It detects the ckbcomp workaround (which seems mainline now), and syncs
both caps lock with left control lock when it has to. This way, we shouldn't
break existing user-space if the distribution changes the trigger to
kbd-controllllock instead of kbd-capslock.

Cheers,
Benjamin

* ubuntu also seems affected:
  https://bugs.launchpad.net/ubuntu/+source/console-setup/+bug/425704


Benjamin Tissoires (4):
  tty/vt/keyboard: use defined macros for masks
  tty/vt/keyboard: Fix Caps Lock LED on major distributions
  tty/vt/keyboard: reset the LEDs state at each console change
  Input: leds - force the LED status after .probe()

 drivers/input/input-leds.c | 33 ++++++++++++++++++++++++++++
 drivers/tty/vt/keyboard.c  | 55 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 83 insertions(+), 5 deletions(-)

-- 
2.9.3

