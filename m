From: <gregkh@linuxfoundation.org>
Subject: patch "input: gameport: convert bus code to use dev_groups" added to driver-core tree
Date: Sat, 19 Oct 2013 20:06:05 -0700
Message-ID: <13822383653330@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:36823 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab3JTHit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Oct 2013 03:38:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    input: gameport: convert bus code to use dev_groups

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 0cba7de7f6cdcf84c9b75d29041c475aedeb45c9 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 7 Oct 2013 18:27:37 -0700
Subject: input: gameport: convert bus code to use dev_groups

The dev_attrs field of struct bus_type is going away soon, dev_groups
should be used instead.  This converts the gameport bus code to use the
correct field.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/gameport/gameport.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
index 922a7fe..24c41ba 100644
--- a/drivers/input/gameport/gameport.c
+++ b/drivers/input/gameport/gameport.c
@@ -422,14 +422,15 @@ static struct gameport *gameport_get_pending_child(struct gameport *parent)
  * Gameport port operations
  */
 
-static ssize_t gameport_show_description(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t gameport_description_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct gameport *gameport = to_gameport_port(dev);
 
 	return sprintf(buf, "%s\n", gameport->name);
 }
+static DEVICE_ATTR(description, S_IRUGO, gameport_description_show, NULL);
 
-static ssize_t gameport_rebind_driver(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t drvctl_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct gameport *gameport = to_gameport_port(dev);
 	struct device_driver *drv;
@@ -457,12 +458,14 @@ static ssize_t gameport_rebind_driver(struct device *dev, struct device_attribut
 
 	return error ? error : count;
 }
+static DEVICE_ATTR_WO(drvctl);
 
-static struct device_attribute gameport_device_attrs[] = {
-	__ATTR(description, S_IRUGO, gameport_show_description, NULL),
-	__ATTR(drvctl, S_IWUSR, NULL, gameport_rebind_driver),
-	__ATTR_NULL
+static struct attribute *gameport_device_attrs[] = {
+	&dev_attr_description.attr,
+	&dev_attr_drvctl.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(gameport_device);
 
 static void gameport_release_port(struct device *dev)
 {
@@ -750,7 +753,7 @@ static int gameport_bus_match(struct device *dev, struct device_driver *drv)
 
 static struct bus_type gameport_bus = {
 	.name		= "gameport",
-	.dev_attrs	= gameport_device_attrs,
+	.dev_groups	= gameport_device_groups,
 	.drv_groups	= gameport_driver_groups,
 	.match		= gameport_bus_match,
 	.probe		= gameport_driver_probe,
-- 
1.8.4.6.g82e253f.dirty


