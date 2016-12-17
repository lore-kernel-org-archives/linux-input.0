From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH] input: i8042-x86ia64io.h: Add Pegatron touchpad to noloop table
Date: Sat, 17 Dec 2016 00:19:34 -0200
Message-ID: <20161217022031.6073-1-marcos.souza.org@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:32864 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbcLQCUx (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Dec 2016 21:20:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Patrick Scheuring <patrick.scheuring.dev@gmail.com>, =?UTF-8?q?Aur=C3=A9lien=20Francillon?= <aurelien@francillon.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Avoid AUX loopback in Pegatron C15B touchpad, so input subsystem is able
to recognize a synaptics touchpad in the AUX port.

Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=93791
(Touchpad is not detected on DNS 0801480 notebook (PEGATRON C15B))

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index ddd3132..1776dc6 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -211,6 +211,12 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
+		},
+	},
 	{ }
 };
 
-- 
2.9.3

