From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] Input: i8042 - add Dell Vostro 1520 and 1720 to the reset
 list
Date: Tue, 24 Nov 2009 15:12:50 +0100
Message-ID: <20091124151250.03e185d1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933006AbZKXOOF@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These laptops may have i8042 in a bad state at very first boot or if you plug
in a non-Dell power supply.
Thus this patch is needed for proper keyboard and touchpad function.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/input/serio/i8042-x86ia64io.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index a537925..7d1cebc 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -447,6 +447,20 @@ static struct dmi_system_id __initdata i8042_dmi_reset_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
 		},
 	},
+	{
+		.ident = "Dell Vostro 1520",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
+		},
+	},
+	{
+		.ident = "Dell Vostro 1720",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
+		},
+	},
 	{ }
 };
 
-- 
1.6.5.2
