From: "kevin.granade@gmail.com" <azmodean@gmail.com>
Subject: [PATCH] Add support for Wacom Bamboo Pen (CTL460, Product ID
 0xD4).
Date: Fri, 10 Dec 2010 20:10:36 -0600 (CST)
Message-ID: <alpine.DEB.1.10.1012101914290.2131@fakemat>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53581 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855Ab0LKCLL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Dec 2010 21:11:11 -0500
Received: by iwn9 with SMTP id 9so6480983iwn.5
        for <linux-input@vger.kernel.org>; Fri, 10 Dec 2010 18:11:10 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, chris@cnpbagwell.com, pingc@wacom.com

Add the features struct and device table entry to enable the Wacom Bamboo 
Pen.

Generated against input/for-linus since that seems to be the most recent 
input branch.

Signed-off-by: Kevin Granade <kevin.granade@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 4852b44..435b0af 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1436,6 +1436,8 @@ static struct wacom_features wacom_features_0xD2 =
 	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xD3 =
 	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023, 63, BAMBOO_PT };
+static const struct wacom_features wacom_features_0xD4 =
+	{ "Wacom Bamboo Pen",     WACOM_PKGLEN_BBFUN,     14720,  9200,  255, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xD8 =
 	{ "Wacom Bamboo Comic 2FG", WACOM_PKGLEN_BBFUN,   21648, 13530, 1023, 63, BAMBOO_PT };
 static struct wacom_features wacom_features_0xDA =
@@ -1510,6 +1512,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xD1) },
 	{ USB_DEVICE_WACOM(0xD2) },
 	{ USB_DEVICE_WACOM(0xD3) },
+	{ USB_DEVICE_WACOM(0xD4) },
 	{ USB_DEVICE_WACOM(0xD8) },
 	{ USB_DEVICE_WACOM(0xDA) },
 	{ USB_DEVICE_WACOM(0xDB) },
-- 
1.5.6.5
