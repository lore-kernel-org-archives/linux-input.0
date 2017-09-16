From: Nik Nyby <nikolas@gnu.org>
Subject: [PATCH] input: elan_i2c - remove duplicate ELAN0605 id
Date: Sat, 16 Sep 2017 17:59:30 -0400
Message-ID: <20170916215930.9539-1-nikolas@gnu.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eggs.gnu.org ([208.118.235.92]:50217 "EHLO eggs.gnu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdIPV7q (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 16 Sep 2017 17:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
        (envelope-from <nikolas@gnu.org>)
        id 1dtL7o-0001db-IS
        for linux-input@vger.kernel.org; Sat, 16 Sep 2017 17:59:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: Nik Nyby <nikolas@gnu.org>

ELAN0605 appears twice here.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
---
 drivers/input/mouse/elan_i2c_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 0e761d079dc4..a2d2077303cb 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1255,7 +1255,6 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },
 	{ "ELAN0608", 0 },
-	{ "ELAN0605", 0 },
 	{ "ELAN0609", 0 },
 	{ "ELAN060B", 0 },
 	{ "ELAN1000", 0 },
-- 
2.14.1

