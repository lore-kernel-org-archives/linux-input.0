From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [RFC, PATCH 0/2] Enable setting leds via hidraw on Sixaxis
Date: Wed, 13 Oct 2010 22:57:36 +0200
Message-ID: <1287003458-3791-1-git-send-email-ospite@studenti.unina.it>
References: <4CA9DD89.2010106@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:55006 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab0JMU6d (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 16:58:33 -0400
In-Reply-To: <4CA9DD89.2010106@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Alan Ott <alan@signal11.us>, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, =?UTF-8?q?Mikko=20Virkkil=C3=A4?= <mvirkkil@cc.hut.fi>, falktx@gmail.com

Hi,

this series adds a new quirk to force output reports to be sent over the
control endpoint rather than the interrupt ep, this is needed on our
"beloved" Sixaxis controller in order to set leds via hidraw, sending
the output report on the interrupt endpoint does not have any effect
whatsoever.

This is just an RFC for now, the quirk name can be improved, and I have
to make clear in the code and in the commit messages if this is for
hidraw only, but you can get the idea already.

Thanks,
   Antonio


Antonio Ospite (2):
  HID: usbhid, new quirk to force out reports on the control ep
  HID: hid-sony, use HID_QUIRK_FORCE_OUT_CONTROL_EP for Sixaxis

 include/linux/hid.h           |    1 +
 drivers/hid/hid-sony.c        |    4 +++-
 drivers/hid/usbhid/hid-core.c |    3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)


-- 
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
