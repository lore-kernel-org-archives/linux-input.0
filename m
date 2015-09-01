From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH] elan_i2c: Add ACPI ID "ELAN1000"
Date: Tue,  1 Sep 2015 15:53:51 -0400
Message-ID: <1441137231-615-1-git-send-email-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34149 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbbIATyT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2015 15:54:19 -0400
Received: by qkct7 with SMTP id t7so57084766qkc.1
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2015 12:54:19 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dusonlin@emc.com.tw, dmitry.torokhov@gmail.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>

This ACPI ID present in the DSDT of the ASUS E202SA laptop.

Signed-off-by: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/=
elan_i2c_core.c
index d4a38ca..5e45402 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1170,6 +1170,7 @@ static const struct acpi_device_id elan_acpi_id[]=
 =3D {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN1000", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
