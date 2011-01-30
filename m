From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 8/8] HID: roccat: Fixed bug that prevented roccat chardev
 from removing devices
Date: Sun, 30 Jan 2011 13:38:30 +0100
Message-ID: <1296391110.2283.187.camel__22333.1017223702$1296391220$gmane$org@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:60180 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754253Ab1A3Mij (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jan 2011 07:38:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>, Jiri Kosina <jkosina@suse.cz>, Mauro Carvalho Chehab <mchehab@redhat.com>, Stefan Achatz <erazor_de@users.sourceforge.net>, Andrew Morton <akpm@li>

pointer to device was cleared too early. This is fixed now.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 0fa23de..bbe294c 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -356,13 +356,16 @@ void roccat_disconnect(int minor)
 
 	mutex_lock(&devices_lock);
 	device = devices[minor];
-	devices[minor] = NULL;
 	mutex_unlock(&devices_lock);
 
 	device->exist = 0; /* TODO exist maybe not needed */
 
 	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
+	mutex_lock(&devices_lock);
+	devices[minor] = NULL;
+	mutex_unlock(&devices_lock);
+	
 	if (device->open) {
 		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
-- 
1.7.3.4



