From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 1/3] input/alps: Split up ALPS_BUTTONPAD behavior change
Date: Thu, 26 May 2016 10:55:12 +0200
Message-ID: <1464252914-11450-2-git-send-email-ben@smart-cactus.org>
References: <201605251801.45240@pali>
 <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56245 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbcEZI4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 04:56:13 -0400
In-Reply-To: <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Gamari <ben@smart-cactus.org>

It seems that curerntly ALPS_BUTTONPAD is rather overloaded. First, it
disables a number of key events (since presumably buttonpads have only
one button). Secondly, it seems to change the decoding behavior of
position data. In the case of the Latitude 7470's touchpad we need the
modified position decoding but keeping all of the buttons. Introduce a
new flag, ALPS_SS4_V4_ALT_DECODING, to capture this.
---
 drivers/input/mouse/alps.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 936f07a..daf9421 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -104,6 +104,11 @@ static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
 #define ALPS_STICK_BITS		0x100	/* separate stick button bits */
 #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
 
+/*
+ * Button-pad and some other SS4 V2 devices use an alternative position decoding
+*/
+#define ALPS_SS4_V2_ALT_DECODING	0x400
+
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT } },	/* Toshiba Salellite Pro M10 */
 	{ { 0x33, 0x02, 0x0a }, 0x00, { ALPS_PROTO_V1, 0x88, 0xf8, 0 } },				/* UMAX-530T */
@@ -1191,7 +1196,7 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 		break;
 
 	case SS4_PACKET_ID_TWO:
-		if (priv->flags & ALPS_BUTTONPAD) {
+		if (priv->flags & ALPS_SS4_V2_ALT_DECODING) {
 			f->mt[0].x = SS4_BTL_MF_X_V2(p, 0);
 			f->mt[0].y = SS4_BTL_MF_Y_V2(p, 0);
 			f->mt[1].x = SS4_BTL_MF_X_V2(p, 1);
@@ -1215,7 +1220,7 @@ static int alps_decode_ss4_v2(struct alps_fields *f,
 		break;
 
 	case SS4_PACKET_ID_MULTI:
-		if (priv->flags & ALPS_BUTTONPAD) {
+		if (priv->flags & ALPS_SS4_V2_ALT_DECODING) {
 			f->mt[2].x = SS4_BTL_MF_X_V2(p, 0);
 			f->mt[2].y = SS4_BTL_MF_Y_V2(p, 0);
 			f->mt[3].x = SS4_BTL_MF_X_V2(p, 1);
@@ -2429,8 +2434,9 @@ static int alps_update_btn_info_ss4_v2(unsigned char otp[][4],
 
 	is_btnless = (otp[1][1] >> 3) & 0x01;
 
+	/* buttonless devices also use the alternative position decoding */
 	if (is_btnless)
-		priv->flags |= ALPS_BUTTONPAD;
+		priv->flags |= ALPS_BUTTONPAD | ALPS_SS4_V2_ALT_DECODING;
 
 	return 0;
 }
-- 
2.8.1

