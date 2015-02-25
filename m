From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/2] HID: wacom: add support of Bamboo PAD
Date: Wed, 25 Feb 2015 11:43:38 -0500
Message-ID: <1424882620-22733-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbbBYQnz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 11:43:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: josep.sanchez.ferreres@est.fib.upc.edu, ACHARD.Frederic.frederic.achard@free.fr, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

So here is the v2 of the patch set to support the Bamboo PAD.

It has been tested by Josep (thanks!) on the wired version and I
developped it on the wireless version. I guess it should be good
to go if the reviews goes well.

Cheers,
Benjamin

Benjamin Tissoires (2):
  HID: wacom: store the hid_device pointers of the sibling devices
  HID: wacom: add full support of the Wacom Bamboo PAD

 drivers/hid/wacom_sys.c |  49 +++++++++++++++++++++---
 drivers/hid/wacom_wac.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/wacom_wac.h |   7 ++++
 3 files changed, 150 insertions(+), 6 deletions(-)

-- 
2.1.0

