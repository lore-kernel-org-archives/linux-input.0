From: Alan <alan@linux.intel.com>
Subject: [PATCH 2/3] goldfish: Enable ACPI-based enumeration for goldfish
 events
Date: Fri, 26 Feb 2016 18:49:56 +0000
Message-ID: <20160226184944.3539.14655.stgit@localhost.localdomain>
References: <20160226184908.3539.48691.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54654 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422842AbcBZSuF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Feb 2016 13:50:05 -0500
In-Reply-To: <20160226184908.3539.48691.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

From: Jason Hu <jia-cheng.hu@intel.com>

Add ACPI binding to the goldfish events driver.

Signed-off-by: Jason Hu <jia-cheng.hu@intel.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan <alan@linux.intel.com>
---
 drivers/input/keyboard/goldfish_events.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index b11d218..c7e308a 100644
--- a/drivers/input/keyboard/goldfish_events.c
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/acpi.h>
 
 enum {
 	REG_READ        = 0x00,
@@ -184,11 +185,18 @@ static const struct of_device_id goldfish_events_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, goldfish_events_of_match);
 
+static const struct acpi_device_id goldfish_events_acpi_match[] = {
+	{ "GFSH0002", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, goldfish_events_acpi_match);
+
 static struct platform_driver events_driver = {
 	.probe	= events_probe,
 	.driver	= {
 		.name	= "goldfish_events",
 		.of_match_table = goldfish_events_of_match,
+		.acpi_match_table = ACPI_PTR(goldfish_events_acpi_match),
 	},
 };
 

