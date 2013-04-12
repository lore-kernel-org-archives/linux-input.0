From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom: Correct reported resolution for Intuos4 Wireless
Date: Fri, 12 Apr 2013 09:43:02 -0700
Message-ID: <1365784982-10721-1-git-send-email-killertofu@gmail.com>
References: <1365780680.4605.9.camel@localhost>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:42106 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab3DLQne (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Apr 2013 12:43:34 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so1506939pdd.17
        for <linux-input@vger.kernel.org>; Fri, 12 Apr 2013 09:43:33 -0700 (PDT)
In-Reply-To: <1365780680.4605.9.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net
Cc: pinglinux@gmail.com, dmitry.torokhov@gmail.com, przemo@firszt.eu, Jason Gerecke <killertofu@gmail.com>

Reported-by: Przemo Firszt <przemo@firszt.eu>
Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 1daa979..1e0031d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1912,7 +1912,7 @@ static const struct wacom_features wacom_features_0xBB =
 	{ "Wacom Intuos4 12x19",  WACOM_PKGLEN_INTUOS,    97536, 60960, 2047,
 	  63, INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xBC =
-	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40840, 25400, 2047,
+	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40640, 25400, 2047,
 	  63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x26 =
 	{ "Wacom Intuos5 touch S", WACOM_PKGLEN_INTUOS,  31496, 19685, 2047,
-- 
1.8.2

