From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] Input: psmouse - Fix a synaptics protocol detection mistake
Date: Thu, 19 Nov 2009 10:05:48 +0000 (GMT)
Message-ID: <20091119100548.D29239D404F@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:32652 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753055AbZKSKFp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 05:05:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, devel@lists.laptop.org

For configurations where synaptics hardware is present but the synaptics
extensions support is not compiled in, the mouse is reprobed and a new
device is allocated on every suspend/resume.

During probe, psmouse_switch_protocol() calls psmouse_extensions() with
set_properties=1. This calls the dummy synaptics_init() which returns an
error code, instructing us not to use the synaptics extensions.

During resume, psmouse_reconnect() calls psmouse_extensions() with
set_properties=0. This caused PSMOUSE_SYNAPTICS to be returned as the
supported extensions, and as this is a different result from earlier it
then causes psmouse_reconnect() to fail and a full reprobe happens.

Fix this by tweaking the set_properties=0 codepath in psmouse_extensions()
to be more careful about offering PSMOUSE_SYNAPTICS extensions.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/psmouse-base.c |    6 +++++-
 drivers/input/mouse/synaptics.c    |   10 ++++++++++
 drivers/input/mouse/synaptics.h    |    1 +
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index b407b35..85f052a 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -610,8 +610,12 @@ static int psmouse_extensions(struct psmouse *psmouse,
 		synaptics_hardware = 1;
 
 		if (max_proto > PSMOUSE_IMEX) {
-			if (!set_properties || synaptics_init(psmouse) == 0)
+			/* be careful to only offer the synaptics protocol for use when
+			 * the support is available */
+			if (synaptics_supported() &&
+					(!set_properties || synaptics_init(psmouse) == 0))
 				return PSMOUSE_SYNAPTICS;
+
 /*
  * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
  * Unfortunately Logitech/Genius probes confuse some firmware versions so
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c65e245..e0ed951 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -738,6 +738,11 @@ int synaptics_init(struct psmouse *psmouse)
 	return -1;
 }
 
+int synaptics_supported(void)
+{
+	return 1;
+}
+
 #else /* CONFIG_MOUSE_PS2_SYNAPTICS */
 
 int synaptics_init(struct psmouse *psmouse)
@@ -745,5 +750,10 @@ int synaptics_init(struct psmouse *psmouse)
 	return -ENOSYS;
 }
 
+int synaptics_supported(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
 
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 3023821..f85e644 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -108,5 +108,6 @@ struct synaptics_data {
 int synaptics_detect(struct psmouse *psmouse, int set_properties);
 int synaptics_init(struct psmouse *psmouse);
 void synaptics_reset(struct psmouse *psmouse);
+int synaptics_supported(void);
 
 #endif /* _SYNAPTICS_H */
-- 
1.6.2.5

