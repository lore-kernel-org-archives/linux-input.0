From: Alan Ott <alan@signal11.us>
Subject: [PATCH v5 0/2] Documentation and Sample for hidraw
Date: Sat, 19 Mar 2011 20:29:43 -0400
Message-ID: <1300580985-10726-1-git-send-email-alan__47108.0124647871$1300581041$gmane$org@signal11.us>
References: <1297829209-10511-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:34595 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab1CTAaG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Mar 2011 20:30:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 327A51CCAC34
	for <linux-input@vger.kernel.org>; Sat, 19 Mar 2011 19:30:05 -0500 (EST)
In-Reply-To: <1297829209-10511-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jonathan Corbet <corbet@lwn.net>, Antonio Ospite <ospite@studenti.unina.it>, Jiri Kosina <jkosina@suse.cz>, Jason
Cc: Alan Ott <alan@signal11.us>

Sorry I've been slack in getting v5 of this patch out. Because
it's been so long, I'll recap what happened last time:

 * Jon Corbet suggested that the example programs be moved into samples/ .
 * Randy Dunlap indicated his acked-by when this was done.

These patches add hidraw.txt to a new Documentation/hid/ directory.

It creates an example program which is now in samples/ with a Kconfig item.

The existing hiddev.txt has been moved from Documentation/usb/ to
Documentation/hid/

This is based on .38+

Alan Ott (2):
  HID: Documentation for hidraw
  HID: Move hiddev.txt to the new Documentation/HID directory

 Documentation/{usb => hid}/hiddev.txt |    0
 Documentation/hid/hidraw.txt          |  119 +++++++++++++++++++++++
 samples/Kconfig                       |    6 +
 samples/Makefile                      |    2 +-
 samples/hidraw/Makefile               |    8 ++
 samples/hidraw/hid-example.c          |  167 +++++++++++++++++++++++++++++++++
 6 files changed, 301 insertions(+), 1 deletions(-)
 rename Documentation/{usb => hid}/hiddev.txt (100%)
 create mode 100644 Documentation/hid/hidraw.txt
 create mode 100644 samples/hidraw/Makefile
 create mode 100644 samples/hidraw/hid-example.c


