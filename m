From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom - make sure touch_input is valid before using it
Date: Thu,  6 Nov 2014 17:30:51 -0800
Message-ID: <1415323851-16453-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49234 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaKGBbM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Nov 2014 20:31:12 -0500
Received: by mail-pa0-f52.google.com with SMTP id fa1so2438056pad.39
        for <linux-input@vger.kernel.org>; Thu, 06 Nov 2014 17:31:12 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

touch_input is stored in wacom_shared for pen data to report touch
switch status. It is possible, although we didn't see it happen on
Linux yet, that pen data is procesed before touch interface is
fully probed.

As a by-product of this patch, it fixes the FreeBSD issue reported
by Denis Akiyakov http://www.spinics.net/lists/linux-input/msg33971.html

Reviewed-by: Hans Petter Selasky <hps@selasky.org>
Tested-by: Denis Akiyakov <d.akiyakov@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8ce7fab..1048295 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1681,7 +1681,9 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	    return 0;
 
 	if (data[0] == WACOM_REPORT_USB) {
-		if (features->type == INTUOSHT && features->touch_max) {
+		if (features->type == INTUOSHT &&
+		    wacom->shared->touch_input &&
+		    features->touch_max) {
 			input_report_switch(wacom->shared->touch_input,
 					    SW_MUTE_DEVICE, data[8] & 0x40);
 			input_sync(wacom->shared->touch_input);
@@ -1774,7 +1776,8 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 		int pid, battery, ps_connected;
 
 		if ((wacom->shared->type == INTUOSHT) &&
-				wacom->shared->touch_max) {
+		    wacom->shared->touch_input &&
+		    wacom->shared->touch_max) {
 			input_report_switch(wacom->shared->touch_input,
 					SW_MUTE_DEVICE, data[5] & 0x40);
 			input_sync(wacom->shared->touch_input);
-- 
1.9.1

