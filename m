From: <gregkh@linuxfoundation.org>
Subject: patch "hid: intel-ish-hid: use dev_groups and not dev_attrs for bus_type" added to driver-core-next
Date: Fri, 09 Jun 2017 20:08:18 +0200
Message-ID: <1497031698239119@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdFISJR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2017 14:09:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org, benjamin.tissoires@redhat.com, bhumirks@gmail.com, jikos@kernel.org, linux-input@vger.kernel.org, linux@rasmusvillemoes.dk, srinivas.pandruvada@linux.intel.com, weiyj.lk@gmail.com


This is a note to let you know that I've just added the patch titled

    hid: intel-ish-hid: use dev_groups and not dev_attrs for bus_type

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From 480104b778876bbf02df972d0bf89266fab82e93 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 6 Jun 2017 14:17:37 +0200
Subject: hid: intel-ish-hid: use dev_groups and not dev_attrs for bus_type

The dev_attrs field has long been "depreciated" and is finally being
removed, so move the driver to use the "correct" dev_groups field
instead for struct bus_type.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Bhumika Goyal <bhumirks@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 5f382fedc2ab..f272cdd9bd55 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -321,11 +321,13 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
 	len = snprintf(buf, PAGE_SIZE, "ishtp:%s\n", dev_name(dev));
 	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
 }
+static DEVICE_ATTR_RO(modalias);
 
-static struct device_attribute ishtp_cl_dev_attrs[] = {
-	__ATTR_RO(modalias),
-	__ATTR_NULL,
+static struct attribute *ishtp_cl_dev_attrs[] = {
+	&dev_attr_modalias.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(ishtp_cl_dev);
 
 static int ishtp_cl_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
@@ -346,7 +348,7 @@ static const struct dev_pm_ops ishtp_cl_bus_dev_pm_ops = {
 
 static struct bus_type ishtp_cl_bus_type = {
 	.name		= "ishtp",
-	.dev_attrs	= ishtp_cl_dev_attrs,
+	.dev_groups	= ishtp_cl_dev_groups,
 	.probe		= ishtp_cl_device_probe,
 	.remove		= ishtp_cl_device_remove,
 	.pm		= &ishtp_cl_bus_dev_pm_ops,
-- 
2.13.1


