From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCHES] hid: Add support for more Huion tablets
Date: Wed, 23 Jul 2014 15:42:53 +0300
Message-ID: <1406119378-24551-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:47630 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbaGWMnT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 08:43:19 -0400
Received: by mail-we0-f178.google.com with SMTP id w61so1150420wes.9
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 05:43:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

Hi everyone,

These patches add support for more Huion tablet models. At least five models
were verified working with the out-of-tree driver [1] which these patches are
based on. This in-tree driver was verified working with Huion H610N.

The Huion tablets seem to all use a single product ID and the iProduct strings
are inconsistent. So there isn't much to identify the models with so far,
although the magic string descriptor containing tablet parameters has some
internal model name which might be used to identify them in the future.

For now, though, the driver leaves the mouse and keyboard interfaces enabled
unconditionally as some models do use them, and it doesn't try to adjust
keyboard report descriptor or interpret keyboard reports to make reported key
combinations more suitable to Linux applications as they might be different
between models.

The driver uses a somewhat non-standard approach: it puts the parameters
extracted from the magic string descriptor into a report descriptor template
and then feeds it to the generic HID layer. This appears simpler than creating
the input device and then parsing the reports in the driver.

However, if the particular approach or implementation is wrong or undesirable
in some way, I'm ready to change it.

Thank you.

Nick

 drivers/hid/hid-core.c  |   2 +-
 drivers/hid/hid-huion.c | 271 ++++++++++++++++++++++++++++++++----------------
 drivers/hid/hid-ids.h   |   2 +-
 3 files changed, 182 insertions(+), 93 deletions(-)

[1] https://github.com/DIGImend/huion-driver
