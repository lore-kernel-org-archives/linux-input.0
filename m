From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Input: i8042 - add noloop quirk for Dell Embedded Box PC 3000
Date: Mon,  6 Mar 2017 18:03:06 +0800
Message-ID: <20170306100306.8900-1-kai.heng.feng@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38317 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753022AbdCFKDQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Mar 2017 05:03:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>

The aux port does not get detected without noloop quirk, so external PS/2
mouse cannot work as result.

The PS/2 mouse can work with this quirk.

BugLink: https://bugs.launchpad.net/bugs/1591053
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 05afd16ea9c9..e856b073d533 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -120,6 +120,13 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
 		},
 	},
 	{
+		/* Dell Embedded Box PC 3000 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
+		},
+	},
+	{
 		/* OQO Model 01 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
-- 
2.12.0

