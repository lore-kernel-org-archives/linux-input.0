From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH] Input: i8042 - add mux quirk for HP EliteBook 8470p
Date: Tue, 28 Oct 2014 19:48:24 +0000
Message-ID: <1414525704-8409-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59243 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbaJ1Ts1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 15:48:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This laptop requires active multiplexing to be enabled in order to be able
to separate the PS/2 mouse and the touchpad.

Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index a0bcbb64d06d..34b95e4268eb 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -220,6 +220,13 @@ static const struct dmi_system_id __initconst i8042_dmi_mux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "CF-18"),
 		},
 	},
+	{
+		/* HP EliteBook 8470p */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 8470p"),
+		},
+	},
 	{ }
 };
 
-- 
2.1.0

