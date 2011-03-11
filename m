From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/2] hid-input: Keyboard and MT support for MacBookPro8
Date: Fri, 11 Mar 2011 19:45:21 +0100
Message-ID: <1299869123-18346-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:36613 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752054Ab1CKSnE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 13:43:04 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Jiri, Dmitry,

Keyboard and MT support for the new MacBookPro models. The first patch
is against HID, the second against Input. As usual, they need to be
synced.

The patches have been tested on the Ubuntu forums, many thanks to Andy
for the nice patches.

Thanks,
Henrik

Andy Botting (2):
  HID: hid-apple: Add keyboard support for MacBookPro8
  Input: bcm5974 - add support for MacBookPro8

 drivers/hid/hid-apple.c       |    6 ++++++
 drivers/hid/hid-core.c        |    6 ++++++
 drivers/hid/hid-ids.h         |    3 +++
 drivers/input/mouse/bcm5974.c |   20 ++++++++++++++++++++
 4 files changed, 35 insertions(+), 0 deletions(-)

-- 
1.7.4.1

