From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 09/16] HID: uhid: add UHID_START and UHID_STOP events
Date: Sun, 10 Jun 2012 15:16:21 +0200
Message-ID: <1339334188-21766-10-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61152 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755114Ab2FJNQs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:48 -0400
Received: by weyu7 with SMTP id u7so1506983wey.19
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:47 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

We send UHID_START and UHID_STOP events to user-space when the HID core
starts/stops the device. This notifies user-space about driver readiness
and data-I/O can start now.

This directly forwards the callbacks from hid-core to user-space.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/uhid.c   |    8 +++++++-
 include/linux/uhid.h |    2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 0d011db..2e7f3a0 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -82,11 +82,17 @@ static int uhid_queue_event(struct uhid_device *uhid, __u32 event)
 
 static int uhid_hid_start(struct hid_device *hid)
 {
-	return 0;
+	struct uhid_device *uhid = hid->driver_data;
+
+	return uhid_queue_event(uhid, UHID_START);
 }
 
 static void uhid_hid_stop(struct hid_device *hid)
 {
+	struct uhid_device *uhid = hid->driver_data;
+
+	hid->claimed = 0;
+	uhid_queue_event(uhid, UHID_STOP);
 }
 
 static int uhid_hid_open(struct hid_device *hid)
diff --git a/include/linux/uhid.h b/include/linux/uhid.h
index 6eb42be..f8ce6f7 100644
--- a/include/linux/uhid.h
+++ b/include/linux/uhid.h
@@ -25,6 +25,8 @@
 enum uhid_event_type {
 	UHID_CREATE,
 	UHID_DESTROY,
+	UHID_START,
+	UHID_STOP,
 	UHID_INPUT,
 };
 
-- 
1.7.10.4

