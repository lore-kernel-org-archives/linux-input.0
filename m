From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] input: tsc2005: Add MODULE_ALIAS
Date: Sun, 17 Feb 2013 01:27:52 +0100
Message-ID: <1361060872-11818-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:57692 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab3BQA2Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Feb 2013 19:28:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

* This patch enable autoloading tsc2005 driver when is compiled as modu=
le

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 drivers/input/touchscreen/tsc2005.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchs=
creen/tsc2005.c
index 9c0cdc7..7213e8b 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -753,3 +753,4 @@ module_spi_driver(tsc2005_driver);
 MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
 MODULE_DESCRIPTION("TSC2005 Touchscreen Driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("spi:tsc2005");
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
