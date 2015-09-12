From: Michele Curti <michele.curti@gmail.com>
Subject: [PATCH] Input: elan_i2c - fix X205TA iap version
Date: Sat, 12 Sep 2015 09:24:44 +0200
Message-ID: <1442042684-748-1-git-send-email-michele.curti@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38154 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbILHY5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Sep 2015 03:24:57 -0400
Received: by wiclk2 with SMTP id lk2so79545391wic.1
        for <linux-input@vger.kernel.org>; Sat, 12 Sep 2015 00:24:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dusonlin@emc.com.tw
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Michele Curti <michele.curti@gmail.com>

After commit commit 58f1eae48e53 ("Input: elan_i2c - use iap_version to
get firmware information") the touchpad on the Asus X205TA does not 
work anymore, iap version is 0, so modify the switch-case index.

The 0x08 case was added for the X205TA in commit 534fcb3bdaab ("Input:
elan_i2c - enable ELAN0100 acpi panels")

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fa94530..c40a02d 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -98,7 +98,7 @@ static int elan_get_fwinfo(u8 iap_version, u16 *validpage_count,
 			   u16 *signature_address)
 {
 	switch (iap_version) {
-	case 0x08:
+	case 0x00:
 		*validpage_count = 512;
 		break;
 	case 0x09:
-- 
2.5.1

