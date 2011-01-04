From: Alan Ott <alan@signal11.us>
Subject: [PATCH 1/1] hidraw: Added Compatibility ioctl() for 32-bit applications.
Date: Tue,  4 Jan 2011 00:37:22 -0500
Message-ID: <1294119442-6827-2-git-send-email-alan__20956.4268625856$1294120843$gmane$org@signal11.us>
References: <1294119442-6827-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:58057 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab1ADGAA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Jan 2011 01:00:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 63DBD1CCAB6D
	for <linux-input@vger.kernel.org>; Tue,  4 Jan 2011 00:37:29 -0500 (EST)
In-Reply-To: <1294119442-6827-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, Antonio Ospite <ospite@studenti.unina.it>, Tejun Heo <tj@kernel.org>, Marcel Holtmann <marcel@holtmann>
Cc: Alan Ott <alan@signal11.us>

Added the ioctl function to the compat_ioctl pointer in the file_operations struct. Before this, some ioctls would fail for 32-bit apps on 64-bit systems.

Signed-off-by: Alan Ott <alan@signal11.us>
---
 drivers/hid/hidraw.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 29495e6..57ccc5f 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -428,6 +428,9 @@ static const struct file_operations hidraw_ops = {
 	.open =         hidraw_open,
 	.release =      hidraw_release,
 	.unlocked_ioctl = hidraw_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= hidraw_ioctl,
+#endif
 };
 
 void hidraw_report_event(struct hid_device *hid, u8 *data, int len)
-- 
1.7.0.4


