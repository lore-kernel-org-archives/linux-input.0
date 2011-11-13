From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/16] HID: wiimote: Add extension initializer stubs
Date: Sun, 13 Nov 2011 14:27:08 +0100
Message-ID: <1321190839-3517-6-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1KMN2B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:28:01 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so4910956bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:28:01 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Add stub functions to read and identify extensions and then initialize all
connected extensions.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-ext.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 631566d..540feb0 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -33,10 +33,48 @@ enum wiiext_type {
 	WIIEXT_NUNCHUCK,	/* Nintendo nunchuck controller */
 };
 
+/* diable all extensions */
+static void ext_disable(struct wiimote_ext *ext)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ext->wdata->state.lock, flags);
+	ext->motionp = false;
+	ext->ext_type = WIIEXT_NONE;
+	spin_unlock_irqrestore(&ext->wdata->state.lock, flags);
+}
+
+static bool motionp_read(struct wiimote_ext *ext)
+{
+	return false;
+}
+
+static __u8 ext_read(struct wiimote_ext *ext)
+{
+	return WIIEXT_NONE;
+}
+
+static void ext_enable(struct wiimote_ext *ext, bool motionp, __u8 ext_type)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ext->wdata->state.lock, flags);
+	ext->motionp = motionp;
+	ext->ext_type = ext_type;
+	spin_unlock_irqrestore(&ext->wdata->state.lock, flags);
+}
+
 static void wiiext_worker(struct work_struct *work)
 {
 	struct wiimote_ext *ext = container_of(work, struct wiimote_ext,
 									worker);
+	bool motionp;
+	__u8 ext_type;
+
+	ext_disable(ext);
+	motionp = motionp_read(ext);
+	ext_type = ext_read(ext);
+	ext_enable(ext, motionp, ext_type);
 }
 
 /* schedule work only once, otherwise mark for reschedule */
-- 
1.7.7.3

