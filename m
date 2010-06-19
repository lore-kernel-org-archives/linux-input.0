From: Alan Ott <alan@signal11.us>
Subject: [PATCH v2 0/2] HID: hidraw documentation
Date: Fri, 18 Jun 2010 22:13:41 -0400
Message-ID: <1276913623-6126-1-git-send-email-alan@signal11.us>
References: <1276832283-12084-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:41829 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab0FSCNw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 22:13:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 69EB6104301
	for <linux-input@vger.kernel.org>; Fri, 18 Jun 2010 22:13:51 -0400 (EDT)
In-Reply-To: <1276832283-12084-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Antonio Ospite <ospite@studen>
Cc: Alan Ott <alan@signal11.us>

These patches add the hidraw.txt file to a new Documentation/hid/ directory.

The example program has been moved out of the document and fixed up for style
(it's now checkpatch.pl clean), and a Makefile has been created for it.

I integrated the comments provided.

hiddev.txt has been moved from Documentation/usb/ to Documentation/hid/


Alan Ott (2):
  HID: Documentation for hidraw
  HID: Move hiddev.txt to the new Documentation/HID directory

 Documentation/hid/Makefile            |    8 ++
 Documentation/hid/hid-example.c       |  167 +++++++++++++++++++++++++++++++++
 Documentation/{usb => hid}/hiddev.txt |    0
 Documentation/hid/hidraw.txt          |  119 +++++++++++++++++++++++
 4 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hid/Makefile
 create mode 100644 Documentation/hid/hid-example.c
 rename Documentation/{usb => hid}/hiddev.txt (100%)
 create mode 100644 Documentation/hid/hidraw.txt


