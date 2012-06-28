From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 2/2] Input: synaptics - add sysfs access to firmware ID & board ID
Date: Thu, 28 Jun 2012 12:51:57 +0800
Message-ID: <1340859117-19654-2-git-send-email-djkurtz@chromium.org>
References: <1340859117-19654-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:55802 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab2F1EwC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 00:52:02 -0400
Received: by vcbfl13 with SMTP id fl13so180602vcb.1
        for <linux-input@vger.kernel.org>; Wed, 27 Jun 2012 21:52:01 -0700 (PDT)
In-Reply-To: <1340859117-19654-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>

Allow userspace to query firmware ID and board ID, which are read and
cached during device initialization.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/mouse/synaptics.c |   41 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 81685c1..985d550 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1258,6 +1258,17 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
 	}
 }
 
+/*****************************************************************************
+ *	sysfs interface
+ ****************************************************************************/
+/* Sysfs entry for board ID */
+static ssize_t synaptics_show_board_id(struct psmouse *psmouse, void *data,
+				       char *buf)
+{
+	struct synaptics_data *priv = psmouse->private;
+	return scnprintf(buf, PAGE_SIZE, "%lu\n", priv->board_id);
+}
+
 static ssize_t synaptics_show_disable_gesture(struct psmouse *psmouse,
 					      void *data, char *buf)
 {
@@ -1296,9 +1307,30 @@ static ssize_t synaptics_set_disable_gesture(struct psmouse *psmouse,
 	return len;
 }
 
+/* Sysfs entry for firmware ID */
+static ssize_t synaptics_show_firmware_id(struct psmouse *psmouse, void *data,
+					  char *buf)
+{
+	struct synaptics_data *priv = psmouse->private;
+	return scnprintf(buf, PAGE_SIZE, "%lu\n", priv->firmware_id);
+}
+
+PSMOUSE_DEFINE_RO_ATTR(board_id, S_IRUGO, NULL, synaptics_show_board_id);
 PSMOUSE_DEFINE_ATTR(disable_gesture, S_IWUSR | S_IRUGO, NULL,
 		    synaptics_show_disable_gesture,
 		    synaptics_set_disable_gesture);
+PSMOUSE_DEFINE_RO_ATTR(firmware_id, S_IRUGO, NULL, synaptics_show_firmware_id);
+
+static struct attribute *synaptics_attrs[] = {
+	&psmouse_attr_board_id.dattr.attr,
+	&psmouse_attr_firmware_id.dattr.attr,
+	NULL
+};
+
+static struct attribute_group synaptics_attr_group = {
+	.attrs = synaptics_attrs,
+};
+
 
 static void synaptics_disconnect(struct psmouse *psmouse)
 {
@@ -1308,6 +1340,9 @@ static void synaptics_disconnect(struct psmouse *psmouse)
 		device_remove_file(&psmouse->ps2dev.serio->dev,
 				   &psmouse_attr_disable_gesture.dattr);
 
+	sysfs_remove_group(&psmouse->ps2dev.serio->dev.kobj,
+			   &synaptics_attr_group);
+
 	synaptics_reset(psmouse);
 	kfree(priv);
 	psmouse->private = NULL;
@@ -1528,6 +1563,12 @@ static int __synaptics_init(struct psmouse *psmouse, bool absolute_mode)
 		}
 	}
 
+	err = sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
+				 &synaptics_attr_group);
+	if (err)
+		psmouse_warn(psmouse,
+			    "Failed to create sysfs attributes (%d)", err);
+
 	return 0;
 
  init_fail:
-- 
1.7.7.3

