From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH v2  2/3] Input: elantech - provide a sysfs knob for crc_enabled
Date: Sun,  9 Nov 2014 22:38:36 +0100
Message-ID: <1415569117-29461-3-git-send-email-ulrik.debie-os@e2big.org>
References: <1415569117-29461-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:41429 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbaKIVjK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Nov 2014 16:39:10 -0500
In-Reply-To: <1415569117-29461-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

The detection of crc_enabled is known to fail for Fujitsu H730. A DMI
blacklist is added for that, but it can be expected that other laptops
will pop up with this.

Here a sysfs knob is provided to alter the behaviour of crc_enabled.
Writing 0 or 1 to it sets the variable to 0 or 1.
Reading it will show the crc_enabled variable (0 or 1).

Reported-by: Stefan Valouch <stefan@valouch.com>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 8b04b71..3fcb6b3 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1330,6 +1330,7 @@ ELANTECH_INT_ATTR(reg_25, 0x25);
 ELANTECH_INT_ATTR(reg_26, 0x26);
 ELANTECH_INT_ATTR(debug, 0);
 ELANTECH_INT_ATTR(paritycheck, 0);
+ELANTECH_INT_ATTR(crc_enabled, 0);
 
 static struct attribute *elantech_attrs[] = {
 	&psmouse_attr_reg_07.dattr.attr,
@@ -1344,6 +1345,7 @@ static struct attribute *elantech_attrs[] = {
 	&psmouse_attr_reg_26.dattr.attr,
 	&psmouse_attr_debug.dattr.attr,
 	&psmouse_attr_paritycheck.dattr.attr,
+	&psmouse_attr_crc_enabled.dattr.attr,
 	NULL
 };
 
@@ -1485,7 +1487,6 @@ static const struct dmi_system_id elantech_dmi_force_crc_enabled[] = {
 	{ }
 };
 
-
 /*
  * Some hw_version 3 models go into error state when we try to set
  * bit 3 and/or bit 1 of r10.
-- 
2.1.1

