From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Input: elan_i2c - add ELAN060C to the ACPI table
Date: Tue,  7 Nov 2017 04:12:54 -0500
Message-ID: <20171107091254.16747-1-kai.heng.feng@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751268AbdKGJM7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Nov 2017 04:12:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>

ELAN060C touchpad uses elan_i2c as its driver. It can be
found on Lenovo ideapad 320-14AST.

BugLink: https://bugs.launchpad.net/bugs/1727544
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 6d6b092e2da9..d6135900da64 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1258,6 +1258,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0605", 0 },
 	{ "ELAN0609", 0 },
 	{ "ELAN060B", 0 },
+	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN1000", 0 },
 	{ }
-- 
2.14.1

