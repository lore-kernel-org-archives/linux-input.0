From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 2/3] Input: alps - warn about unsupported ALPS V9 touchpad
Date: Sat,  4 Mar 2017 12:24:25 +0100
Message-ID: <1488626666-16577-3-git-send-email-pali.rohar@gmail.com>
References: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36680 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdCDLcg (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Mar 2017 06:32:36 -0500
In-Reply-To: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Support for devices with ALPS_PROTO_V9 is not implemented yet but we can
detect these alps touchpads and warn users about it.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |    9 +++++++++
 drivers/input/mouse/alps.h |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index f36de82..9908f18 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -164,6 +164,10 @@
 	ALPS_PROTO_V8, 0x18, 0x18, 0
 };
 
+static const struct alps_protocol_info alps_v9_protocol_data = {
+	ALPS_PROTO_V9, 0xc8, 0xc8, 0
+};
+
 /*
  * Some v2 models report the stick buttons in separate bits
  */
@@ -2838,6 +2842,11 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
 			   e7[2] == 0x28 && ec[1] == 0x01) {
 			protocol = &alps_v8_protocol_data;
+		} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0xc8) {
+			protocol = &alps_v9_protocol_data;
+			psmouse_warn(psmouse,
+				     "Unsupported ALPS V9 touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
+			return -EINVAL;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 6d279aa..54f9f44 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -23,6 +23,7 @@
 #define ALPS_PROTO_V6		0x600
 #define ALPS_PROTO_V7		0x700	/* t3btl t4s */
 #define ALPS_PROTO_V8		0x800	/* SS4btl SS4s */
+#define ALPS_PROTO_V9		0x900	/* ss3btl */
 
 #define MAX_TOUCHES	4
 
-- 
1.7.9.5

