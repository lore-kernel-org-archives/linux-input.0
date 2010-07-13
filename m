From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] atlas_btns: adds a missing owner field for
	atlas_acpi_driver
Date: Tue, 13 Jul 2010 17:13:24 +0800
Message-ID: <1279012404.28550.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47362 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab0GMJSe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jul 2010 05:18:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Lin Ming <ming.m.lin@intel.com>, linux-input@vger.kernel.org

The owner field provides the link between drivers and modules in sysfs.
After setting the owner field, we can see which module provides which
driver and vice versa by looking at /sys/bus/acpi/drivers/Atlas ACPI/module
and /sys/module/atlas_btns/drivers/acpi:Atlas ACPI

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/input/misc/atlas_btns.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/atlas_btns.c b/drivers/input/misc/atlas_btns.c
index dfaa9a0..7d53608 100644
--- a/drivers/input/misc/atlas_btns.c
+++ b/drivers/input/misc/atlas_btns.c
@@ -145,6 +145,7 @@ MODULE_DEVICE_TABLE(acpi, atlas_device_ids);
 static struct acpi_driver atlas_acpi_driver = {
 	.name	= ACPI_ATLAS_NAME,
 	.class	= ACPI_ATLAS_CLASS,
+	.owner	= THIS_MODULE,
 	.ids	= atlas_device_ids,
 	.ops	= {
 		.add	= atlas_acpi_button_add,
-- 
1.5.4.3



