From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: serio - fix sysfs layout
Date: Sat, 7 Dec 2013 07:41:19 -0800
Message-ID: <20131207154116.GA9902@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:51764 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038Ab3LGPl0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Dec 2013 10:41:26 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Hellstrom <thellstrom@vmware.com>, linux-kernel@vger.kernel.org

Restore previous layout of sysfs attributes that was broken by commit
3778a2129bcce84f684cc0017ed20d2524afd289 (input: serio: remove bus usage of
dev_attrs) which moved all serio device attributes into 'id' group, when
only 'type', 'proto', 'id', and 'extra' should be in 'id' group and the
rest of attributes should be attached directly to the device.

Reported-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/serio.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 98707fb..8f4c4ab 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -455,16 +455,26 @@ static DEVICE_ATTR_RO(type);
 static DEVICE_ATTR_RO(proto);
 static DEVICE_ATTR_RO(id);
 static DEVICE_ATTR_RO(extra);
-static DEVICE_ATTR_RO(modalias);
-static DEVICE_ATTR_WO(drvctl);
-static DEVICE_ATTR(description, S_IRUGO, serio_show_description, NULL);
-static DEVICE_ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode);
 
 static struct attribute *serio_device_id_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_proto.attr,
 	&dev_attr_id.attr,
 	&dev_attr_extra.attr,
+	NULL
+};
+
+static struct attribute_group serio_id_attr_group = {
+	.name	= "id",
+	.attrs	= serio_device_id_attrs,
+};
+
+static DEVICE_ATTR_RO(modalias);
+static DEVICE_ATTR_WO(drvctl);
+static DEVICE_ATTR(description, S_IRUGO, serio_show_description, NULL);
+static DEVICE_ATTR(bind_mode, S_IWUSR | S_IRUGO, serio_show_bind_mode, serio_set_bind_mode);
+
+static struct attribute *serio_device_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_description.attr,
 	&dev_attr_drvctl.attr,
@@ -472,13 +482,13 @@ static struct attribute *serio_device_id_attrs[] = {
 	NULL
 };
 
-static struct attribute_group serio_id_attr_group = {
-	.name	= "id",
-	.attrs	= serio_device_id_attrs,
+static struct attribute_group serio_device_attr_group = {
+	.attrs	= serio_device_attrs,
 };
 
 static const struct attribute_group *serio_device_attr_groups[] = {
 	&serio_id_attr_group,
+	&serio_device_attr_group,
 	NULL
 };
 
-- 
1.8.3.1


-- 
Dmitry
