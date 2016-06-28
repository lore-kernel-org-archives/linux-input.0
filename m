From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] Input: Add SW_PEN_INSERTED define
Date: Tue, 28 Jun 2016 10:00:53 -0700
Message-ID: <1467133253-8075-1-git-send-email-dianders@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34093 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbcF1RBc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2016 13:01:32 -0400
Received: by mail-pf0-f177.google.com with SMTP id h14so8544462pfe.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jun 2016 10:01:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, hdegoede@redhat.com, robh@kernel.org, hans.verkuil@cisco.com, kamil@wypas.org, linux-kernel@vger.kernel.org

Some devices with a pen may have a switch that can be used to detect
when the pen is inserted or removed to a slot on the device.  Let's add
a define to the input event codes so that everyone can be on the same
page for what event we should generate when the pen is inserted or
removed.

In general the pen switch could be used by the software on the device to
kick off any number of actions when the pen is inserted or removed.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 737fa32faad4..d6d071fc3c56 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -780,6 +780,7 @@
 #define SW_ROTATE_LOCK		0x0c  /* set = rotate locked/disabled */
 #define SW_LINEIN_INSERT	0x0d  /* set = inserted */
 #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
+#define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
 #define SW_MAX			0x0f
 #define SW_CNT			(SW_MAX+1)
 
-- 
2.8.0.rc3.226.g39d4020

