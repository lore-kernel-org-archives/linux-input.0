From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 0/5] HID: sony: misc fixes and cleanups
Date: Mon, 16 Feb 2015 18:12:19 +0100
Message-ID: <1424106744-12872-1-git-send-email-ao2@ao2.it>
References: <20150216150659.db522f3d.cand@gmx.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:46246 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753017AbbBPRMj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 12:12:39 -0500
In-Reply-To: <20150216150659.db522f3d.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

Hi,

here are a few cleanups for hid-sony.

Changes are meant to follow the patch titled:
[PATCHv4] HID: sony: Enable Gasia third-party PS3 controllers

Frank, hi, I'd like to have your explicit ack at least for patch 1 and
2.

Thanks,
   Antonio


Antonio Ospite (5):
  HID: sony: Fix a WARNING shown when rmmod-ing the driver
  HID: sony: Use the minimum accepted size for feature report 0xf2
  HID: sony: Don't use magic numbers in sixaxis_set_operational_usb()
  HID: sony: Use __u8 * for the buffer in sixaxis_set_operational_usb()
  HID: sony: Coding style cleanups in sixaxis_set_operational_usb()

 drivers/hid/hid-sony.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
