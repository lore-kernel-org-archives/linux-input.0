From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 05/12] HID: wiimote: Add extension initializer stubs
Date: Tue,  4 Oct 2011 15:36:46 +0200
Message-ID: <1317735413-17299-6-git-send-email-dh.herrmann@googlemail.com>
References: <1317735413-17299-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39173 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757163Ab1JDNha (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 09:37:30 -0400
Received: by wwf22 with SMTP id 22so815239wwf.1
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 06:37:29 -0700 (PDT)
In-Reply-To: <1317735413-17299-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, David Herrmann <dh.herrmann@googlemail.com>

Add stub functions to read and identify extensions and then initialize all
connected extensions.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-ext.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
index 1def9bc..a3d7a5a 100644
--- a/drivers/hid/hid-wiimote-ext.c
+++ b/drivers/hid/hid-wiimote-ext.c
@@ -34,14 +34,52 @@ enum wiiext_type {
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
 
 	/* fresh worker needs no reschedule so reset schedule count */
 	atomic_set(&ext->schedule, 1);
 
+	ext_disable(ext);
+	motionp = motionp_read(ext);
+	ext_type = ext_read(ext);
+	ext_enable(ext, motionp, ext_type);
+
 	/* worker done; check for reschedule */
 	if (!atomic_dec_and_test(&ext->schedule))
 		schedule_work(work);
-- 
1.7.7

