From: Manoj Iyer <manoj.iyer@canonical.com>
Subject: [PATCH] Input: atkbd - Add force relese key quirk for HP ProBook
Date: Tue, 28 Feb 2012 18:36:10 -0600
Message-ID: <1330475770-4153-2-git-send-email-manoj.iyer@canonical.com>
References: <1330475770-4153-1-git-send-email-manoj.iyer@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330475770-4153-1-git-send-email-manoj.iyer@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

HP ProBooks do not send a key release for brightness keys, as a
result, brightness does not move up/down when the brightness key
is held down. This quirk makes the brightness keys on HP ProBooks
typematic.

Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
---
 drivers/input/keyboard/atkbd.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index e05a2e7..b910822 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -951,6 +951,14 @@ static unsigned int atkbd_volume_forced_release_keys[] = {
 };
 
 /*
+ * Perform fixup for systems that do not generate key release event
+ * for brightness up/down keys.
+ */
+static unsigned int atkbd_brightness_forced_release_keys[] = {
+	0x92, 0x97, -1U
+};
+
+/*
  * OQO 01+ multimedia keys (64--66) generate e0 6x upon release whereas
  * they should be generating e4-e6 (0x80 | code).
  */
@@ -1666,6 +1674,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		.driver_data = atkbd_volume_forced_release_keys,
 	},
 	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_brightness_forced_release_keys,
+	},
+	{
 		/* Inventec Symphony */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "INVENTEC"),
-- 
1.7.9
