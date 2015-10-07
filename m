From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ft6236 - change module license string to match
 copyright notice
Date: Tue, 6 Oct 2015 17:03:33 -0700
Message-ID: <20151007000333.GA36264@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33883 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbbJGADg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Oct 2015 20:03:36 -0400
Received: by padhy16 with SMTP id hy16so1737744pad.1
        for <linux-input@vger.kernel.org>; Tue, 06 Oct 2015 17:03:36 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>

The copyright/license notice says that the code is licensed under GPL v=
2
only (not GPL v2+), so let's use proper string in MODULE_LICENSE().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ft6236.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ft6236.c b/drivers/input/touchsc=
reen/ft6236.c
index a394cd4..d240d2e 100644
--- a/drivers/input/touchscreen/ft6236.c
+++ b/drivers/input/touchscreen/ft6236.c
@@ -323,4 +323,4 @@ module_i2c_driver(ft6236_driver);
 MODULE_AUTHOR("Sean Cross <xobs@kosagi.com>");
 MODULE_AUTHOR("Noralf Tr=F8nnes <noralf@tronnes.org>");
 MODULE_DESCRIPTION("FocalTech FT6236 TouchScreen driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
--=20
2.6.0.rc2.230.g3dd15c0


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
