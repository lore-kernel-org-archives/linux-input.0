From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v3 02/18] HID: wacom: Have WACOM_PEN_FIELD and WACOM_FINGER_FIELD recgonize more fields
Date: Wed, 19 Oct 2016 18:03:38 -0700
Message-ID: <20161020010354.4049-2-killertofu@gmail.com>
References: <20161006212231.31440-1-killertofu@gmail.com>
 <20161020010354.4049-1-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33769 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbcJTBEJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 19 Oct 2016 21:04:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id i85so3838838pfa.0
        for <linux-input@vger.kernel.org>; Wed, 19 Oct 2016 18:04:09 -0700 (PDT)
In-Reply-To: <20161020010354.4049-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Jason Gerecke <killertofu@gmail.com>

We've defined several new usages (e.g. WACOM_G9_PEN and WACOM_G9_TOUCHSCREEN)
which aren't checked by the WACOM_PEN_FIELD and WACOM_FINGER_FIELD macros but
probably should be.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index f58bbd1..d2629c8 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -98,10 +98,14 @@
 				 ((f)->physical == HID_DG_PEN) || \
 				 ((f)->application == HID_DG_PEN) || \
 				 ((f)->application == HID_DG_DIGITIZER) || \
-				 ((f)->application == WACOM_HID_WD_DIGITIZER))
+				 ((f)->application == WACOM_HID_WD_DIGITIZER) || \
+				 ((f)->application == WACOM_HID_G9_PEN) || \
+				 ((f)->application == WACOM_HID_G11_PEN))
 #define WACOM_FINGER_FIELD(f)	(((f)->logical == HID_DG_FINGER) || \
 				 ((f)->physical == HID_DG_FINGER) || \
-				 ((f)->application == HID_DG_TOUCHSCREEN))
+				 ((f)->application == HID_DG_TOUCHSCREEN) || \
+				 ((f)->application == WACOM_HID_G9_TOUCHSCREEN) || \
+				 ((f)->application == WACOM_HID_G11_TOUCHSCREEN))
 
 enum {
 	PENPARTNER = 0,
-- 
2.10.0

