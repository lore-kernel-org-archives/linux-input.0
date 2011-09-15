From: chris@cnpbagwell.com
Subject: [PATCH 3/3] Input: wacom - correct max Y value on medium bamboos
Date: Wed, 14 Sep 2011 20:36:28 -0500
Message-ID: <1316050588-13473-4-git-send-email-chris@cnpbagwell.com>
References: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:41462 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab1IOBgo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 21:36:44 -0400
Received: by gwb17 with SMTP id 17so2688913gwb.1
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2011 18:36:44 -0700 (PDT)
In-Reply-To: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Medium size Bamboo P&T driver reused max X/Y form older Bamboo 1
medium size tablets and never updated to real value. Actual
active area of tablet is slightly larger in Y direction.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Acked-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index d7da1b0..f5641a9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1462,13 +1462,13 @@ static const struct wacom_features wacom_features_0xD2 =
 	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD3 =
-	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023,
+	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13700, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD4 =
 	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD5 =
-	{ "Wacom Bamboo Pen 6x8",     WACOM_PKGLEN_BBFUN, 21648, 13530, 1023,
+	{ "Wacom Bamboo Pen 6x8",     WACOM_PKGLEN_BBFUN, 21648, 13700, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD6 =
 	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023,
@@ -1477,13 +1477,13 @@ static const struct wacom_features wacom_features_0xD7 =
 	{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720,  9200, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xD8 =
-	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530, 1023,
+	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13700, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xDA =
 	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static struct wacom_features wacom_features_0xDB =
-	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13530, 1023,
+	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13700, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x6004 =
 	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
-- 
1.7.6

