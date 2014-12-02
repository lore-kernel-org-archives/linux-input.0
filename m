From: Todor Minchev <todor.minchev@intel.com>
Subject: [PATCH] i8042: prevent the loading of the i8042 driver on Intel NUC D54250WYK
Date: Tue,  2 Dec 2014 08:27:02 +0000
Message-ID: <1417508822-8243-1-git-send-email-todor.minchev@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52142 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbaLBI1J (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Dec 2014 03:27:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Todor Minchev <todor.minchev@intel.com>

The Intel NUC D54250WYK has no PS/2 controller, however the DSDT declares
PS/2 devices which trigger the loading of the i8042 driver.

Signed-off-by: Todor Minchev <todor.minchev@intel.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index faeeb13..5182008 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -579,6 +579,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
 		},
 	},
 	{
+		/* Intel NUC D54250WYK */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+		},
+	},
+	{
 		/* MSI Wind U-100 */
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
-- 
2.1.3

