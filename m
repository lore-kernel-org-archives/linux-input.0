From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] input: wacom - Wacom Bamboo Pen D4 has 1024 pressure level
Date: Fri, 24 Jun 2011 17:14:58 -0700
Message-ID: <1308960898-20435-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65424 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab1FYANc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 20:13:32 -0400
Received: by pvg12 with SMTP id 12so1985887pvg.19
        for <linux-input@vger.kernel.org>; Fri, 24 Jun 2011 17:13:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Instead of 512.

Reported-by: David Foley <favux.is@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 2ea0d2e..1cbb9a8 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1462,7 +1462,7 @@ static const struct wacom_features wacom_features_0xD3 =
 	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023,
 	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD4 =
-	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255,
+	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
 	  63, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD6 =
 	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
-- 
1.7.5.4

