From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/3] HID: wacom: Consult the application usage when determining field type
Date: Mon, 24 Nov 2014 15:32:12 -0800
Message-ID: <1416871934-14133-2-git-send-email-killertofu@gmail.com>
References: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47354 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaKXXc0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Nov 2014 18:32:26 -0500
Received: by mail-pd0-f169.google.com with SMTP id fp1so10608031pdb.14
        for <linux-input@vger.kernel.org>; Mon, 24 Nov 2014 15:32:26 -0800 (PST)
In-Reply-To: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, pinglinux@gmail.com, Jason Gerecke <killertofu@gmail.com>

It is not necessarily sufficient to look only at the physical and logical
usages when determining if a field is for the pen or touch. Some fields
are not contained in a sub-collection and thus only have an application
usage. Not checking the application usage in such cases causes us to
ignore the field entirely, which may lead to incorrect behavior.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_wac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9565d31..1468f00 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1484,9 +1484,11 @@ static void wacom_wac_finger_report(struct hid_device *hdev,
 }
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
-				 ((f)->physical == HID_DG_STYLUS))
+				 ((f)->physical == HID_DG_STYLUS) || \
+				 ((f)->application == HID_DG_PEN))
 #define WACOM_FINGER_FIELD(f)	(((f)->logical == HID_DG_FINGER) || \
-				 ((f)->physical == HID_DG_FINGER))
+				 ((f)->physical == HID_DG_FINGER) || \
+				 ((f)->application == HID_DG_TOUCHSCREEN))
 
 void wacom_wac_usage_mapping(struct hid_device *hdev,
 		struct hid_field *field, struct hid_usage *usage)
-- 
2.1.3

