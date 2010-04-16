From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: [PATCH] Reset ps/2 port should psmouse_probe fail before retrying
Date: Fri, 16 Apr 2010 18:52:50 -0400
Message-ID: <4BC8EA42.6030507@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:34075 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692Ab0DPWww (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Apr 2010 18:52:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rubini@ipvvis.unipv.it

Hi All,

I filed a bug on this too:

https://bugzilla.kernel.org/show_bug.cgi?id=15780

This particular laptop will lose it's synaptics touch
pad on return from suspend state. Reloading the psmouse
module makes no difference. I came up with the attached
work around which simply calls psmouse_reset on the
port should the initial probe fail. This solves the problem
for me and I've tested this on several laptops.

Initially discovered on Ubuntu 2.6.31 (karmic) and the problem
continues to exist in lucid 2.6.32. I've filed a bug against
ubuntu kernel here:

https://bugs.launchpad.net/oem-priority/+bug/551234

though the Ubuntu kernel team would really like to get upstream's
input on the matter before accepting the patch. Please
let me know what you think. Thanks.

Peter
--
 From e997195a6488753738523b92cbcc97cb2f4bda03 Mon Sep 17 00:00:00 2001
From: Peter M. Petrakis <peter.petrakis@canonical.com>
Date: Fri, 16 Apr 2010 17:56:24 -0400
Subject: [PATCH] Reset the PS/2 port should psmouse_probe fail for any 
reason. This
  is necessary for some PS/2 devices who can't even be identified
  when returning from sleep (S3).

---
  drivers/input/mouse/psmouse-base.c |   29 ++++++++++++++++++++++++++---
  1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/psmouse-base.c 
b/drivers/input/mouse/psmouse-base.c
index d8c0c8d..a51b9a7 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -905,12 +905,12 @@ static const struct psmouse_protocol 
*psmouse_protocol_by_name(const char *name,
  	return NULL;
  }

-
  /*
- * psmouse_probe() probes for a PS/2 mouse.
+ * __psmouse_probe() probes for a PS/2 mouse.
+ * Wrapped by psmouse_probe() for clean reset code.
   */

-static int psmouse_probe(struct psmouse *psmouse)
+static int __psmouse_probe(struct psmouse *psmouse)
  {
  	struct ps2dev *ps2dev = &psmouse->ps2dev;
  	unsigned char param[2];
@@ -941,6 +941,29 @@ static int psmouse_probe(struct psmouse *psmouse)
  }

  /*
+ * Wrapper for probe routine to cleanly reset the device should
+ * the initial probe fail for any reason.
+ */
+static int psmouse_probe(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	int i;
+	int ret = -1;
+
+	for (i=0; i < 3; i++) {
+		ret = __psmouse_probe(psmouse);
+		if (ret == 0)
+			break;
+
+		printk(KERN_ERR "psmouse.c: Error encountered while probing "
+			"PS/2 device on %s, resetting\n", ps2dev->serio->phys);
+		psmouse_reset(psmouse);
+	}
+
+	return ret;
+}
+
+/*
   * Here we set the mouse resolution.
   */

-- 
1.7.0.4

