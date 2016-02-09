From: Antonio Ospite <ao2@ao2.it>
Subject: [RESEND PATCH 0/6] HID: minor misc fixes
Date: Tue,  9 Feb 2016 13:55:02 +0100
Message-ID: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:60698 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbcBIMze (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 07:55:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Antonio Ospite <ao2@ao2.it>

Hi,

resending the patches as asked by Jiri, leaving out the one about the
BUZZ controller as agreed with Frank.

Here is the previous cover letter:

Hi Jiri,

patches from 1 to 3 are all about fixing the same typo, I split them in
case you preferred to apply them per driver. Feel free to squash them if
you like.

The other changes are just readability improvements.

The last patch in the series is a refreshed version of a patch sent by
Pavel Machek some time ago.

Thanks,
   Antonio

Antonio Ospite (5):
  HID: dragonrise: fix a typo in descriptors comments
    s/Joystik/Joystick/
  HID: lg: fix a typo in descriptors comments s/Joystik/Joystick/
  HID: sony: fix a typo in descriptors comments s/Joystik/Joystick/
  HID: sony: fix errors from scripts/checkpatch.pl
  HID: sony: fix some warnings from scripts/checkpatch.pl

Pavel Machek (1):
  HID: sony: underscores are unnecessary for u8, u16, s32

 drivers/hid/hid-dr.c   |   4 +-
 drivers/hid/hid-lg.c   |  10 +--
 drivers/hid/hid-sony.c | 167 ++++++++++++++++++++++++++-----------------------
 3 files changed, 95 insertions(+), 86 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
