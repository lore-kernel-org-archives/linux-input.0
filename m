From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/3] Make sure touch arbitration is applied consistently across devices
Date: Wed, 28 Jan 2015 09:42:59 -0800
Message-ID: <1422466979-17405-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:61043 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933300AbbA1UaA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2015 15:30:00 -0500
Received: by mail-pa0-f50.google.com with SMTP id rd3so29320811pab.9
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2015 12:30:00 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

stylus_in_proximity is used to make sure no touch event is sent while pen
is in proximity. touch_down is used to make sure a touch up event is sent
when pen comes into proximity while touch is down.

Two touch routines didn't store touch_down. One touch routine forgot to
check stylus_in_proximity before sending touch events. This patch fixes
those issues.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
v2: added commit comments as reqested by Jiri. No code update.
---
 drivers/hid/wacom_wac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f886149..6d490f6 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1042,7 +1042,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 
 	for (i = 0; i < contacts_to_send; i++) {
 		int offset = (WACOM_BYTES_PER_24HDT_PACKET * i) + 1;
-		bool touch = data[offset] & 0x1 && !wacom->shared->stylus_in_proximity;
+		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
 		int slot = input_mt_get_slot_by_key(input, data[offset + 1]);
 
 		if (slot < 0)
@@ -1072,6 +1072,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	if (wacom->num_contacts_left <= 0)
 		wacom->num_contacts_left = 0;
 
+	wacom->shared->touch_down = (wacom->num_contacts_left > 0);
 	return 1;
 }
 
@@ -1100,7 +1101,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 
 	for (i = 0; i < contacts_to_send; i++) {
 		int offset = (WACOM_BYTES_PER_MT_PACKET + x_offset) * i + 3;
-		bool touch = data[offset] & 0x1;
+		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
 		int id = get_unaligned_le16(&data[offset + 1]);
 		int slot = input_mt_get_slot_by_key(input, id);
 
@@ -1122,6 +1123,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 	if (wacom->num_contacts_left < 0)
 		wacom->num_contacts_left = 0;
 
+	wacom->shared->touch_down = (wacom->num_contacts_left > 0);
 	return 1;
 }
 
-- 
1.9.1

