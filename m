From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH 0/2] patches for Innomedia INNEX GENESIS/ATARI adapter
Date: Fri, 16 Dec 2016 21:31:28 +0000
Message-ID: <20161216213130.19303-1-tk@the-tk.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:37666 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933302AbcLPViS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Dec 2016 16:38:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Kramkowski <tk@the-tk.com>

This is a couple of patches which fix issues with the (1292:4745)
Innomedia INNEX GENESIS/ATARI controller USB adapter. I've personally
tested these patches against the master of the hid tree.

Patch 2 depends on patch 1.

I wasn't sure if adding a new config symbol meant I needed to add it to
some default config so I left that alone.

Hopefully I didn't screw anything up.

Thanks,

-- 
Tomasz Kramkowski

Tomasz Kramkowski (2):
  HID: add Innomedia INNEX GENESIS/ATARI adapter support
  HID: usbhid: add quirk for Innomedia INNEX GENESIS/ATARI adapter

 drivers/hid/Kconfig             |  6 ++++
 drivers/hid/Makefile            |  1 +
 drivers/hid/hid-core.c          |  1 +
 drivers/hid/hid-ids.h           |  3 ++
 drivers/hid/hid-innomedia.c     | 63 +++++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |  1 +
 6 files changed, 75 insertions(+)
 create mode 100644 drivers/hid/hid-innomedia.c

-- 
2.10.2

