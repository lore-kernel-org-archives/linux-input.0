From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH 4/5] Input: elantech - provide a sysfs knob for crc_enabled
Date: Sat, 30 Aug 2014 16:10:45 +0200
Message-ID: <1409407846-15449-5-git-send-email-ulrik.debie-os@e2big.org>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:47773 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaH3OLm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Aug 2014 10:11:42 -0400
In-Reply-To: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

The detection of crc_enabled is known to fail for Fujitsu H730. A DMI
blacklist is added for that, but it can be expected that other laptops
will pop up with this.

Here a sysfs knob is provided to alter the behaviour of crc_enabled.
Writing 0 or 1 to it sets the variable to 0 or 1.
Writing 2 to it will perform the detection and set the variable to 0
or 1 according to the result of the detection.
Reading it will show the crc_enabled variable (0 or 1).

Reported-by: Stefan Valouch <stefan@valouch.com>
Tested-by: Stefan Valouch <stefan@valouch.com>
Tested-by: Alfredo Gemma <alfredo.gemma@gmail.com>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index e86bbd7..c2fb961 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1305,6 +1305,28 @@ static ssize_t elantech_show_int_attr(struct psmouse *psmouse, void *data,
 	return sprintf(buf, "0x%02x\n", (attr->reg && rc) ? -1 : *reg);
 }
 
+
+/*
+ * Write a register value for crc_enabled.
+ * If "2" is given, perform detect again.
+ */
+static ssize_t elantech_set_int_attr_crc_enabled(struct psmouse *psmouse,
+				     void *data, const char *buf, size_t count)
+{
+	struct elantech_data *etd = psmouse->private;
+	unsigned char value;
+	int err;
+
+	err = kstrtou8(buf, 16, &value);
+	if (err)
+		return err;
+
+	etd->crc_enabled = (value == 2) ? elantech_detect_crc_enabled(etd) :
+		value;
+
+	return count;
+}
+
 /*
  * Write a register value by writing a sysfs entry
  */
@@ -1360,6 +1382,19 @@ ELANTECH_INT_ATTR(reg_26, 0x26);
 ELANTECH_INT_ATTR(debug, 0);
 ELANTECH_INT_ATTR(paritycheck, 0);
 
+#define ELANTECH_INT_ATTR_SETFUNCTION(_name, _register, _setfunction)	\
+	static struct elantech_attr_data elantech_attr_##_name = {	\
+		.field_offset = offsetof(struct elantech_data, _name),	\
+		.reg = _register,					\
+	};								\
+	PSMOUSE_DEFINE_ATTR(_name, S_IWUSR | S_IRUGO,			\
+			    &elantech_attr_##_name,			\
+			    elantech_show_int_attr,			\
+			    _setfunction)
+
+ELANTECH_INT_ATTR_SETFUNCTION(crc_enabled, 0,
+	elantech_set_int_attr_crc_enabled);
+
 static struct attribute *elantech_attrs[] = {
 	&psmouse_attr_reg_07.dattr.attr,
 	&psmouse_attr_reg_10.dattr.attr,
@@ -1373,6 +1408,7 @@ static struct attribute *elantech_attrs[] = {
 	&psmouse_attr_reg_26.dattr.attr,
 	&psmouse_attr_debug.dattr.attr,
 	&psmouse_attr_paritycheck.dattr.attr,
+	&psmouse_attr_crc_enabled.dattr.attr,
 	NULL
 };
 
-- 
2.1.0

