From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/4] Input: Add new property INPUT_PROP_JOYDEV_IGNORE
Date: Thu, 24 Aug 2017 16:11:50 -0700
Message-ID: <20170824231153.8809-2-roderick@gaikai.com>
References: <20170824231153.8809-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:37774 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754095AbdHXXMB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Aug 2017 19:12:01 -0400
Received: by mail-qk0-f178.google.com with SMTP id k126so4649789qkb.4
        for <linux-input@vger.kernel.org>; Thu, 24 Aug 2017 16:12:01 -0700 (PDT)
In-Reply-To: <20170824231153.8809-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

This new property can be set on input devices to blacklist them
from getting picked up by joydev. This is meant for devices, which
pass joydev its heuristics, but for which there is no good generic
way of updating the heuristics.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 Documentation/input/event-codes.rst    | 9 +++++++++
 include/uapi/linux/input-event-codes.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
index a8c0873..ae8c546 100644
--- a/Documentation/input/event-codes.rst
+++ b/Documentation/input/event-codes.rst
@@ -356,6 +356,15 @@ can report through the rotational axes (absolute and/or relative rx, ry, rz).
 All other axes retain their meaning. A device must not mix
 regular directional axes and accelerometer axes on the same event node.
 
+INPUT_PROP_JOYDEV_IGNORE
+------------------------
+
+The joydev interface uses heuristics to determine whether it should expose an
+input device through joydev. Some devices pass its heuristics, but don't
+make sense to expose. In some cases the generic heuristics can be updated,
+but in other cases this is not easy. The INPUT_PROP_JOYDEV_IGNORE flag can
+be set by drivers to explicit request blacklisting by joydev.
+
 Guidelines
 ==========
 
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 1798910..f6aac0e 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -26,6 +26,7 @@
 #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
 #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
 #define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */
+#define INPUT_PROP_JOYDEV_IGNORE	0x07	/* hint to ignore device by joydev */
 
 #define INPUT_PROP_MAX			0x1f
 #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
-- 
2.9.4

