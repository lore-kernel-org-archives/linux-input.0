From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 09/19] HID: wacom: generic: Add support for vendor-defined "Fingerwheel" usage
Date: Thu,  6 Oct 2016 14:22:21 -0700
Message-ID: <20161006212231.31440-10-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33922 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935190AbcJFVWz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 17:22:55 -0400
Received: by mail-qt0-f196.google.com with SMTP id f6so835468qtd.1
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 14:22:54 -0700 (PDT)
In-Reply-To: <20161006212231.31440-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

The airbrush fingerwheel does not have a usage that corresponds cleanly
with a standard HID usage, so we add explicit support for it via its
vendor-defined usage.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 3 +++
 drivers/hid/wacom_wac.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index aa51684..009c25d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1539,6 +1539,9 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	case HID_DG_TOOLSERIALNUMBER:
 		wacom_map_usage(input, usage, field, EV_MSC, MSC_SERIAL, 0);
 		break;
+	case WACOM_HID_WD_FINGERWHEEL:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
+		break;
 	}
 }
 
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 1ced6e4..18cae38 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -89,6 +89,7 @@
 #define WACOM_HID_SP_DIGITIZERINFO      0x00100000
 #define WACOM_HID_WD_DIGITIZER          (WACOM_HID_UP_WACOMDIGITIZER | 0x01)
 #define WACOM_HID_WD_DISTANCE           (WACOM_HID_UP_WACOMDIGITIZER | 0x0132)
+#define WACOM_HID_WD_FINGERWHEEL        (WACOM_HID_UP_WACOMDIGITIZER | 0x0d03)
 #define WACOM_HID_WD_DATAMODE           (WACOM_HID_UP_WACOMDIGITIZER | 0x1002)
 #define WACOM_HID_UP_G9                 0xff090000
 #define WACOM_HID_G9_PEN                (WACOM_HID_UP_G9 | 0x02)
-- 
2.10.0

