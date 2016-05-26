From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 3/3] input/alps: Add device description for Dell Latitude E7470
Date: Thu, 26 May 2016 10:55:14 +0200
Message-ID: <1464252914-11450-4-git-send-email-ben@smart-cactus.org>
References: <201605251801.45240@pali>
 <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56255 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcEZI4V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 04:56:21 -0400
In-Reply-To: <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Gamari <ben@smart-cactus.org>

---
 drivers/input/mouse/alps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 10e6836..eb4bf31 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -143,6 +143,7 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba Tecra A11-11L */
 	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
+	{ { 0x73, 0x03, 0x28 }, 0x00, { ALPS_PROTO_V8, 0x18, 0x18, ALPS_SS4_V2_ALT_DECODING | ALPS_DUALPOINT } }, /* Dell Latitude E7470 */
 };
 
 static const struct alps_protocol_info alps_v3_protocol_data = {
-- 
2.8.1

