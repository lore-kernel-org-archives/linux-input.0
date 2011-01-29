From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH] HID: hidraw: fixed hidraw_disconnect()
Date: Sat, 29 Jan 2011 02:17:30 +0100
Message-ID: <1296263850.2299.11.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:54622 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754722Ab1A2BRf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 20:17:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

hidraw_disconnect() first sets an entry in hidraw_table to NULL
and calls device_destroy() afterwards. The thereby called
hidraw_release() tries to read this already cleared value resulting
in never removing any device from the list.
This got fixed by changing the order of events.

Maybe commit 0a504541b3ba593535d70f3124546e5e471a175e should be
undone if the talkativeness was misdiagnosed due to this error.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hidraw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 468e87b..5516ea4 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -428,12 +428,12 @@ void hidraw_disconnect(struct hid_device *hid)
 
 	hidraw->exist = 0;
 
+	device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
+
 	mutex_lock(&minors_lock);
 	hidraw_table[hidraw->minor] = NULL;
 	mutex_unlock(&minors_lock);
 
-	device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
-
 	if (hidraw->open) {
 		hid_hw_close(hid);
 		wake_up_interruptible(&hidraw->wait);
-- 
1.7.3.4



