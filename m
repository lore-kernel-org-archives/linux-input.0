From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: atmel_mxt_ts - add generic platform data for
 Chromebooks
Date: Tue, 24 Nov 2015 10:58:10 -0800
Message-ID: <20151124185810.GA18357@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35698 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbbKXS6O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 13:58:14 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Javier Martinez Canillas <javier@osg.samsung.com>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org

Apparently people are installing generic Linux distributions not only on
Pixels but also on other Chromebooks. Unfortunately on all of them Atmel
parts assigned names ATML0000 and ATML0001, and do not carry any other
configuration data. So let's create generic instance of platform data that
should cover most of them (we assume that they will not be using T100
objects, since with those Google mapped BTN_LEFT onto a different GPIO, so
slightly different keymap would be needed, but I think we used parts with
T100 on ARM devices where we thankfully have DTS and can describe the
devices better).

Tested-by: Rich K <rgkirch@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c562205..159120b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2487,6 +2487,31 @@ static struct mxt_acpi_platform_data samus_platform_data[] = {
 	{ }
 };
 
+static unsigned int chromebook_tp_buttons[] = {
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED,
+	KEY_RESERVED,
+	BTN_LEFT
+};
+
+static struct mxt_acpi_platform_data chromebook_platform_data[] = {
+	{
+		/* Touchpad */
+		.hid	= "ATML0000",
+		.pdata	= {
+			.t19_num_keys	= ARRAY_SIZE(chromebook_tp_buttons),
+			.t19_keymap	= chromebook_tp_buttons,
+		},
+	},
+	{
+		/* Touchscreen */
+		.hid	= "ATML0001",
+	},
+	{ }
+};
+
 static const struct dmi_system_id mxt_dmi_table[] = {
 	{
 		/* 2015 Google Pixel */
@@ -2497,6 +2522,14 @@ static const struct dmi_system_id mxt_dmi_table[] = {
 		},
 		.driver_data = samus_platform_data,
 	},
+	{
+		/* Other Google Chromebooks */
+		.ident = "Chromebook",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+		},
+		.driver_data = chromebook_platform_data,
+	},
 	{ }
 };
 
-- 
2.6.0.rc2.230.g3dd15c0


-- 
Dmitry
