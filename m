From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH resend] Input: psmouse - Fix a synaptics protocol detection mistake
Date: Sun,  3 Jan 2010 14:56:33 +0000 (GMT)
Message-ID: <20100103145633.E2E9C9D400D@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:54129 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750977Ab0ACPBm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 3 Jan 2010 10:01:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

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

Originally submitted 19/11/2009 with no response

diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 401ac6b..613a55a 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -627,8 +627,12 @@ static int psmouse_extensions(struct psmouse *psmouse,
 		synaptics_hardware = true;
 
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
index 05689e7..b4d38f5 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -743,6 +743,11 @@ int synaptics_init(struct psmouse *psmouse)
 	return -1;
 }
 
+int synaptics_supported(void)
+{
+	return 1;
+}
+
 #else /* CONFIG_MOUSE_PS2_SYNAPTICS */
 
 void __init synaptics_module_init(void)
@@ -754,5 +759,10 @@ int synaptics_init(struct psmouse *psmouse)
 	return -ENOSYS;
 }
 
+int synaptics_supported(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
 
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 838e7f2..d53ffe6 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -109,5 +109,6 @@ void synaptics_module_init(void);
 int synaptics_detect(struct psmouse *psmouse, bool set_properties);
 int synaptics_init(struct psmouse *psmouse);
 void synaptics_reset(struct psmouse *psmouse);
+int synaptics_supported(void);
 
 #endif /* _SYNAPTICS_H */
-- 
1.6.2.5

