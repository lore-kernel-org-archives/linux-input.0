From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: i8042 - add TUXEDO BU1406 (N24_25BU) to the nomux list
Date: Tue, 28 Feb 2017 17:20:57 -0800
Message-ID: <20170301012057.GA5402@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35262 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdCAB3Y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 28 Feb 2017 20:29:24 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org

TUXEDO BU1406 does not implement active multiplexing mode properly,
and takes around 550 ms in i8042_set_mux_mode(). Given that the
device does not have external AUX port, there is no downside in
disabling the MUX mode.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Suggested-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 0b9b9997fa4c..77c8f574f286 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -521,6 +521,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "V1.31"),
 		},
 	},
+	{
+		/* TUXEDO BU1406 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
+		},
+	},
 	{ }
 };
 
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
