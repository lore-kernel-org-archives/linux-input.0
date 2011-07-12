From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] Input: intel-mid-touch - remove pointless checking for
 variable 'found'
Date: Tue, 12 Jul 2011 15:13:51 +0800
Message-ID: <1310454831.16511.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:33927 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789Ab1GLHN7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2011 03:13:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Sreedhara Murthy. D.S" <sreedhara.ds@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The implementation does break from the for loop after we assign i to variable
'found'.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/touchscreen/intel-mid-touch.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/intel-mid-touch.c b/drivers/input/touchscreen/intel-mid-touch.c
index 66c96bf..9283284 100644
--- a/drivers/input/touchscreen/intel-mid-touch.c
+++ b/drivers/input/touchscreen/intel-mid-touch.c
@@ -454,9 +454,6 @@ static int __devinit mrstouch_chan_parse(struct mrstouch_dev *tsdev)
 	found = -1;
 
 	for (i = 0; i < MRSTOUCH_MAX_CHANNELS; i++) {
-		if (found >= 0)
-			break;
-
 		err = intel_scu_ipc_ioread8(PMICADDR0 + i, &r8);
 		if (err)
 			return err;
-- 
1.7.4.1



