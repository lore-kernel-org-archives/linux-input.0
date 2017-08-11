From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add antoher Lenovo ACPI ID for upcoming Lenovo NB Add 2 ACPI IC ELAN0609, ELAN060B in the ACPI mapping table Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Fri, 11 Aug 2017 15:10:04 +0800
Message-ID: <1502435404-20549-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:40421 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdHKHJT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2017 03:09:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw

---
 drivers/input/mouse/elan_i2c_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3b616cb..0d111322 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1248,6 +1248,8 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
 	{ "ELAN0605", 0 },
+	{ "ELAN0609", 0 },
+	{ "ELAN060B", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.7.4

