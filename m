From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] Constify wacom_features for a new missed Bamboo models
Date: Fri, 25 Mar 2011 17:29:05 -0700
Message-ID: <1301099345-5464-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56083 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934148Ab1CZAa4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 20:30:56 -0400
Received: by iyb14 with SMTP id 14so1058562iyb.19
        for <linux-input@vger.kernel.org>; Fri, 25 Mar 2011 17:30:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 5597637..ba6e17c 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1366,23 +1366,23 @@ static const struct wacom_features wacom_features_0xE3 =
 	{ "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG };
 static const struct wacom_features wacom_features_0x47 =
 	{ "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
-static struct wacom_features wacom_features_0xD0 =
+static const struct wacom_features wacom_features_0xD0 =
 	{ "Wacom Bamboo 2FG",     WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
-static struct wacom_features wacom_features_0xD1 =
+static const struct wacom_features wacom_features_0xD1 =
 	{ "Wacom Bamboo 2FG 4x5", WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
-static struct wacom_features wacom_features_0xD2 =
+static const struct wacom_features wacom_features_0xD2 =
 	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
-static struct wacom_features wacom_features_0xD3 =
+static const struct wacom_features wacom_features_0xD3 =
 	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023, 63, BAMBOO_PT };
 static const struct wacom_features wacom_features_0xD4 =
 	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255, 63, BAMBOO_PT };
-static struct wacom_features wacom_features_0xD6 =
+static const struct wacom_features wacom_features_0xD6 =
 	{ "Wacom BambooPT 2FG 4x5", WACOM_PKGLEN_BBFUN,   14720,  9200, 1023, 63, BAMBOO_PT };
-static struct wacom_features wacom_features_0xD7 =
+static const struct wacom_features wacom_features_0xD7 =
 	{ "Wacom BambooPT 2FG Small", WACOM_PKGLEN_BBFUN, 14720,  9200, 1023, 63, BAMBOO_PT };
-static struct wacom_features wacom_features_0xD8 =
+static const struct wacom_features wacom_features_0xD8 =
 	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530, 1023, 63, BAMBOO_PT };
-static struct wacom_features wacom_features_0xDA =
+static const struct wacom_features wacom_features_0xDA =
 	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xDB =
 	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13530, 1023, 63, BAMBOO_PT };
-- 
1.7.4

