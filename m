From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 0/3] Input/HID: Guitar/Drums support
Date: Mon, 26 Aug 2013 19:14:45 +0200
Message-ID: <1377537288-19289-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f169.google.com ([209.85.215.169]:56714 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3HZRPL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Aug 2013 13:15:11 -0400
Received: by mail-ea0-f169.google.com with SMTP id k11so1759286eaj.14
        for <linux-input@vger.kernel.org>; Mon, 26 Aug 2013 10:15:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>

Hi

This series adds wiimote extension support for guitars and drums. The patches
are fairly simple and work the same as the other 5 wiimote extensions. But as we
currently don't have IDs to report drums or guitar events to user-space, I had
to add them.

Patch #1 adds basic IDs to <linux/input.h>. I tried to find as many devices as I
could and looked what IDs would be required. Turned out, the device I was
implementing already supported almost all (except 2 instead of 4 cymbals and 3
instead of 4 toms).

Patch #2 and #3 add the wiimote extensions.

This has been mostly worked out and tested by Nicolas (thanks!) and we started
this work almost 3 month ago. Due to holidays it took a bit longer to get
pressure reports working. But now everything should be fine.

The xwiimote user-space tools already support this and provide testing utilities
if someone is interested: http://github.com/dvdhrm/xwiimote

Jiri, Dmitry, can we try merging this for 3.13? I know it's late, but it did see
a lot of testing from Nicolas.

Regards
David

Btw., if someone has similar PS3 or WorldTour devices, I'd be glad to add
support for them!

David Herrmann (2):
  Input: introduce BTN/ABS bits for drums and guitars
  HID: wiimote: add support for Guitar-Hero drums

Nicolas Adenis-Lamarre (1):
  HID: wiimote: add support for Guitar-Hero guitars

 drivers/hid/hid-wiimote-core.c    |  14 ++
 drivers/hid/hid-wiimote-modules.c | 392 ++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h         |   3 +
 include/linux/mod_devicetable.h   |   2 +-
 include/uapi/linux/input.h        |  25 ++-
 5 files changed, 433 insertions(+), 3 deletions(-)

-- 
1.8.4

