From: Xiaolei Yu <dreifachstein@gmail.com>
Subject: [PATCH] HID: add two missing usages for digitizer
Date: Sat, 25 Mar 2017 14:04:58 +0800
Message-ID: <e974c5f4-1c4a-4c24-2874-af6cc40514a2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34244 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966954AbdCYGFQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 02:05:16 -0400
Received: by mail-pg0-f67.google.com with SMTP id w20so1728461pgc.1
        for <linux-input@vger.kernel.org>; Fri, 24 Mar 2017 23:05:15 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org, linux-input@vger.kernel.org

They are part of HUTRR34 for multi-touch digitizers:

0x0E    Device configuration    CA      16.7
0x23    Device settings         CL      16.7

Signed-off-by: Xiaolei Yu <dreifachstein@gmail.com>
---
 drivers/hid/hid-debug.c | 2 ++
 include/linux/hid.h     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index c6c9c51c806f..5271db593478 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -140,9 +140,11 @@ static const struct hid_usage_entry hid_usage_table[] = {
     {0, 0x03, "LightPen"},
     {0, 0x04, "TouchScreen"},
     {0, 0x05, "TouchPad"},
+    {0, 0x0e, "DeviceConfiguration"},
     {0, 0x20, "Stylus"},
     {0, 0x21, "Puck"},
     {0, 0x22, "Finger"},
+    {0, 0x23, "DeviceSettings"},
     {0, 0x30, "TipPressure"},
     {0, 0x31, "BarrelPressure"},
     {0, 0x32, "InRange"},
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 28f38e2b8f30..536f11fd21d5 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -268,6 +268,8 @@ struct hid_item {
 #define HID_CP_APPLICATIONLAUNCHBUTTONS	0x000c0180
 #define HID_CP_GENERICGUIAPPLICATIONCONTROLS	0x000c0200
 
+#define HID_DG_DEVICECONFIG	0x000d000e
+#define HID_DG_DEVICESETTINGS	0x000d0023
 #define HID_DG_CONFIDENCE	0x000d0047
 #define HID_DG_WIDTH		0x000d0048
 #define HID_DG_HEIGHT		0x000d0049
-- 
2.11.0

