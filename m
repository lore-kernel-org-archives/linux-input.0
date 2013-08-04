From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] HID: wiimote: work around broken DRM_KAI on GEN10
Date: Sun,  4 Aug 2013 18:50:10 +0200
Message-ID: <1375635010-2468-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:37412 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab3HDQum (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Aug 2013 12:50:42 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so1176686eek.38
        for <linux-input@vger.kernel.org>; Sun, 04 Aug 2013 09:50:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

GEN10 and earlier devices seem to not support DRM_KAI if we run in basic
IR mode. Use DRM_KAIE instead. This might increases overhead slightly as
the extension port is read and streamed but we stream accelerometer data
constantly, too, so this is negligible.

Note that our parsers are hardcoded on IR-formats, so we cannot actually
use 96-bit IR DRMs for basic IR data. We would have to adjust the parsers.
But as only GEN20 and newer support this, we simply avoid mixed DRMs.

This fixes a bug where GEN10 devices didn't provide IR data if
accelerometer and IR are enabled simultaneously. As a workaround, you can
enable DRM_KAIE without this patch via (disables device power-management):
  echo "37" >/sys/kernel/debug/hid/<dev>/drm

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Reported-by: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 0c06054..6602098 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -212,10 +212,12 @@ static __u8 select_drm(struct wiimote_data *wdata)
 
 	if (ir == WIIPROTO_FLAG_IR_BASIC) {
 		if (wdata->state.flags & WIIPROTO_FLAG_ACCEL) {
-			if (ext)
-				return WIIPROTO_REQ_DRM_KAIE;
-			else
-				return WIIPROTO_REQ_DRM_KAI;
+			/* GEN10 and ealier devices bind IR formats to DRMs.
+			 * Hence, we cannot use DRM_KAI here as it might be
+			 * bound to IR_EXT. Use DRM_KAIE unconditionally so we
+			 * work with all devices and our parsers can use the
+			 * fixed formats, too. */
+			return WIIPROTO_REQ_DRM_KAIE;
 		} else {
 			return WIIPROTO_REQ_DRM_KIE;
 		}
-- 
1.8.3.4

