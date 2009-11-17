From: akpm@linux-foundation.org
Subject: [patch 1/3] wistron_btns.c: add DMI entry for Medion WIM2030 laptop
Date: Tue, 17 Nov 2009 14:44:54 -0800
Message-ID: <200911172244.nAHMis7K032249@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34823 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753977AbZKQWpn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Nov 2009 17:45:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, dr.nop@gmx.net

From: Sebastian Frei <dr.nop@gmx.net>

This patch adds a DMI entry for the Medion WIM2030 laptop.

Signed-off-by: Sebastian Frei <dr.nop@gmx.net>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/misc/wistron_btns.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff -puN drivers/input/misc/wistron_btns.c~wistron_btnsc-add-dmi-entry-for-medion-wim2030-laptop drivers/input/misc/wistron_btns.c
--- a/drivers/input/misc/wistron_btns.c~wistron_btnsc-add-dmi-entry-for-medion-wim2030-laptop
+++ a/drivers/input/misc/wistron_btns.c
@@ -683,6 +683,15 @@ static struct dmi_system_id dmi_ids[] __
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Medion MD 42200",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "WIM 2030"),
+		},
+		.driver_data = keymap_fs_amilo_pro_v2000
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Fujitsu N3510",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
_
