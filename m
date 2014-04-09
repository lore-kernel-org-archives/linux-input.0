From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] serio: Add pnp_id to struct serio
Date: Wed,  9 Apr 2014 16:02:59 +0200
Message-ID: <1397052181-22768-2-git-send-email-hdegoede@redhat.com>
References: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1948 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933453AbaDIODI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Apr 2014 10:03:08 -0400
In-Reply-To: <1397052181-22768-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Serio device drivers need access to the pnp_id of the serio port, windows
drivers bind by the pnp-id and some drivers need to know the exact pnp-id
used so they know exactly with which hardware model / revision they are
dealing with.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 include/linux/serio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/serio.h b/include/linux/serio.h
index 9f779c7..6532440 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/pnp.h>
 #include <uapi/linux/serio.h>
 
 struct serio {
@@ -28,6 +29,7 @@ struct serio {
 	bool manual_bind;
 
 	struct serio_device_id id;
+	struct pnp_id *pnp_id;
 
 	spinlock_t lock;		/* protects critical sections from port's interrupt handler */
 
-- 
1.9.0

