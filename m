From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] input: fix input-mt kernel-doc warning
Date: Tue, 06 Nov 2012 17:07:42 -0800
Message-ID: <5099B45E.8080105@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:54136 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab2KGBHu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Nov 2012 20:07:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Henrik Rydberg <rydberg@euromail.se>

From: Randy Dunlap <rdunlap@infradead.org>

Fix new kernel-doc warning in input-mt.c:

Warning(drivers/input/input-mt.c:38): No description found for parameter 'flags'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Henrik Rydberg <rydberg@euromail.se>
Cc:	linux-input@vger.kernel.org
---
 drivers/input/input-mt.c |    1 +
 1 file changed, 1 insertion(+)

--- lnx-37-rc4.orig/drivers/input/input-mt.c
+++ lnx-37-rc4/drivers/input/input-mt.c
@@ -26,6 +26,7 @@ static void copy_abs(struct input_dev *d
  * input_mt_init_slots() - initialize MT input slots
  * @dev: input device supporting MT events and finger tracking
  * @num_slots: number of slots used by the device
+ * @flags: device flags (see include/linux/input/mt.h)
  *
  * This function allocates all necessary memory for MT slot handling
  * in the input device, prepares the ABS_MT_SLOT and
