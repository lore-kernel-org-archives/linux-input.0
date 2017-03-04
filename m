From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v2 1/3] Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
Date: Sat,  4 Mar 2017 12:24:24 +0100
Message-ID: <1488626666-16577-2-git-send-email-pali.rohar@gmail.com>
References: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33784 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdCDLce (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Mar 2017 06:32:34 -0500
In-Reply-To: <1488626666-16577-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Like for other protocols create alps_v4_protocol_data and use it in
alps_identify() function.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 drivers/input/mouse/alps.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 72b28eb..f36de82 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -138,7 +138,6 @@
 	{ { 0x73, 0x02, 0x50 }, 0x00, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },	/* Dell Vostro 1400 */
 	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba Tecra A11-11L */
-	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
 };
 
 static const struct alps_protocol_info alps_v3_protocol_data = {
@@ -149,6 +148,10 @@
 	ALPS_PROTO_V3_RUSHMORE, 0x8f, 0x8f, ALPS_DUALPOINT
 };
 
+static const struct alps_protocol_info alps_v4_protocol_data = {
+	ALPS_PROTO_V4, 0x8f, 0x8f, 0
+};
+
 static const struct alps_protocol_info alps_v5_protocol_data = {
 	ALPS_PROTO_V5, 0xc8, 0xd8, 0
 };
@@ -2815,7 +2818,10 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 
 	protocol = alps_match_table(e7, ec);
 	if (!protocol) {
-		if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
+		if (e7[0] == 0x73 && e7[1] == 0x02 && e7[2] == 0x64 &&
+			   ec[2] == 0x8a) {
+			protocol = &alps_v4_protocol_data;
+		} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
 			   ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
 			protocol = &alps_v5_protocol_data;
 		} else if (ec[0] == 0x88 &&
-- 
1.7.9.5

