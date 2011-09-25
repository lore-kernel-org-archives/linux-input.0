From: chris@cnpbagwell.com
Subject: [PATCH v2 3/3] Input: wacom - correct max Y value on medium bamboos
Date: Sun, 25 Sep 2011 14:09:28 -0500
Message-ID: <1316977768-823-4-git-send-email-chris@cnpbagwell.com>
References: <1316977768-823-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42950 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab1IYTJz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Sep 2011 15:09:55 -0400
Received: by gwb15 with SMTP id 15so4825571gwb.19
        for <linux-input@vger.kernel.org>; Sun, 25 Sep 2011 12:09:54 -0700 (PDT)
In-Reply-To: <1316977768-823-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Medium size Bamboo P&T driver reused max X/Y form older Bamboo 1
medium size tablets and never updated to real value. Actual
active area of tablet is slightly larger in Y direction.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
Acked-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/tablet/wacom_wac.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index e572b46..15e108c 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1460,13 +1460,13 @@ static const struct wacom_features wacom_features_0xD2 =
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
@@ -1475,13 +1475,13 @@ static const struct wacom_features wacom_features_0xD7 =
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

