From: rydberg@euromail.se
Subject: [PATCH 0/2] Support for 2013 Macbook Air
Date: Sun, 30 Jun 2013 21:04:44 +0200
Message-ID: <1372619086-3532-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:47833 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab3F3TEv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 15:04:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Dmitry, Jiri,

Please find enclosed two patches yielding support for the
MacbookAir6,2. As usual, there is one HID and one Input patch. Given
the closeness to the merge window, I suppose we could backport this to
3.10, unless Linus decides to wait another week. Backports should be
fine back to v3.7, inclusive. Dmitry, would you care to take the
patches, if Jiri is ok with that?

Thanks,
Henrik

Henrik Rydberg (2):
  HID: apple: Add support for the 2013 Macbook Air
  Input: bcm5974 - Add support for the 2013 MacBook Air

 drivers/hid/hid-apple.c       |  6 ++++++
 drivers/hid/hid-core.c        |  6 ++++++
 drivers/hid/hid-ids.h         |  3 +++
 drivers/input/mouse/bcm5974.c | 36 ++++++++++++++++++++++++++++++++++--
 4 files changed, 49 insertions(+), 2 deletions(-)

-- 
1.8.3.1

