From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Input: i8042 - add Gigabyte P57 to the keyboard reset table
Date: Wed, 12 Jul 2017 11:39:53 +0800
Message-ID: <20170712033953.16318-1-kai.heng.feng@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58180 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932643AbdGLDj7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Jul 2017 23:39:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>

Similar to other Gigabyte laptops, the touchpad on P57 requires a
keyboard reset to detect Elantech touchpad correctly.

BugLink: https://bugs.launchpad.net/bugs/1594214
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 09720d950686..1c6a49b5b93d 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -833,6 +833,13 @@ static const struct dmi_system_id __initconst i8042_dmi_kbdreset_table[] = {
 		},
 	},
 	{
+		/* Gigabyte P57 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
+		},
+	},
+	{
 		/* Schenker XMG C504 - Elantech touchpad */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
-- 
2.13.2

