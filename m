From: IHARA Hiroka <ihara_h@live.jp>
Subject: [PATCH] Input: elan_i2c: add ELAN0605 to the ACPI table
Date: Sun, 12 Feb 2017 07:55:23 +0000
Message-ID: <PS1PR0401MB1961607122C29ADFF8F54A539C460@PS1PR0401MB1961.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from blu004-omc1s15.hotmail.com ([65.55.116.26]:61232 "EHLO
        BLU004-OMC1S15.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750915AbdBLIAe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 03:00:34 -0500
Content-Language: en-US
Content-ID: <125B7C050F9A904093AE23244C5B6CD7@apcprd04.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

ELAN0605 has been confirmed to be a variant of ELAN0600,
which is blacklisted in the hid-core to be managed by elan_i2c.

Signed-off-by: Hiroka IHARA <ihara_h@live.jp>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fa598f7..1e1d0ad 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1231,6 +1231,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN0605", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.9.3

