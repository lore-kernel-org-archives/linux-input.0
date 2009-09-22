From: Jan-Michael Brummer <jan.brummer@tabos.org>
Subject: Input: atkbd - add forced release keys quirk for Samsung P560/P210
Date: Tue, 22 Sep 2009 19:53:33 +0200
Message-ID: <1253642013.11485.8.camel@buzz-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from k-dns.de ([84.38.66.51]:45855 "EHLO k-dns.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbZIVSM4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 14:12:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org

This patch fixes the key repeat issue with the Fn+F? keys on the
Samsung P560 and P210 Notebook, so that the keys can used correctly,
otherwise the keys repeat indefinitely.

Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>

--- linux-source-2.6.31/drivers/input/keyboard/atkbd.c.orig	2009-09-16
02:23:02.000000000 +0200
+++ linux-source-2.6.31/drivers/input/keyboard/atkbd.c	2009-09-22
18:04:47.720622934 +0200
@@ -1607,6 +1607,24 @@ static struct dmi_system_id atkbd_dmi_qu
 		.driver_data = atkbd_samsung_forced_release_keys,
 	},
 	{
+		.ident = "Samsung P560",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P560"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_samsung_forced_release_keys,
+	},
+	{
+		.ident = "Samsung P210",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P210"),
+		},
+		.callback = atkbd_setup_forced_release,
+		.driver_data = atkbd_samsung_forced_release_keys,
+	},
+	{
 		.ident = "Samsung SQ45S70S",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),

