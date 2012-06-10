From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 10/16] HID: uhid: forward open/close events to user-space
Date: Sun, 10 Jun 2012 15:16:22 +0200
Message-ID: <1339334188-21766-11-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60560 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755183Ab2FJNQt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:49 -0400
Received: by wibhj8 with SMTP id hj8so1970186wib.1
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:48 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

HID core notifies us with *_open/*_close callbacks when there is an actual
user of our device. We forward these to user-space so they can react on
this. This allows user-space to skip I/O unless they receive an OPEN
event. When they receive a CLOSE event they can stop I/O again to save
energy.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/uhid.c   |    7 ++++++-
 include/linux/uhid.h |    2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 2e7f3a0..0226ba3f 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -97,11 +97,16 @@ static void uhid_hid_stop(struct hid_device *hid)
 
 static int uhid_hid_open(struct hid_device *hid)
 {
-	return 0;
+	struct uhid_device *uhid = hid->driver_data;
+
+	return uhid_queue_event(uhid, UHID_OPEN);
 }
 
 static void uhid_hid_close(struct hid_device *hid)
 {
+	struct uhid_device *uhid = hid->driver_data;
+
+	uhid_queue_event(uhid, UHID_CLOSE);
 }
 
 static int uhid_hid_input(struct input_dev *input, unsigned int type,
diff --git a/include/linux/uhid.h b/include/linux/uhid.h
index f8ce6f7..351650b 100644
--- a/include/linux/uhid.h
+++ b/include/linux/uhid.h
@@ -27,6 +27,8 @@ enum uhid_event_type {
 	UHID_DESTROY,
 	UHID_START,
 	UHID_STOP,
+	UHID_OPEN,
+	UHID_CLOSE,
 	UHID_INPUT,
 };
 
-- 
1.7.10.4

