From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: i8042 - add Clevo P650RS to the i8042 reset list
Date: Thu, 13 Apr 2017 15:51:52 -0700
Message-ID: <20170413225152.GA19947@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33283 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdDMWv4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Apr 2017 18:51:56 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, =?utf-8?B?UGF3ZcWC?= Bylica <chfast@gmail.com>, Michele Bissacco <mirh@protonmail.ch>, Santi Villalba <sdvillal@gmail.com>, Ed Bordin <edbordin@gmail.com>, linux-kernel@vger.kernel.org

Clevo P650RS and other similar devices require i8042 to be reset in order
to detect Synaptics touchpad.

Reported-by: Paweł Bylica <chfast@gmail.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=190301
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 8da340043611..df52665a7583 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -628,6 +628,13 @@ static const struct dmi_system_id __initconst i8042_dmi_reset_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
 		},
 	},
+	{
+		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
+		},
+	},
 	{ }
 };
 
-- 
2.12.2.762.g0e3151a226-goog


-- 
Dmitry
