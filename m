From: "John L. Preston" <wcerfgba@riseup.net>
Subject: [PATCH] Add model data for Dell Precision 3510 trackpad.
Date: Sun, 19 Feb 2017 13:16:34 +0000
Message-ID: <20170219131634.GA7453@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

---
 drivers/input/mouse/alps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 328edc8c8786..c0a4edefe54d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -139,6 +139,7 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba Tecra A11-11L */
 	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
+	{ { 0x73, 0x03, 0x28 }, 0x13, { ALPS_PROTO_V8, 0x18, 0x18, 0 } },			/* Dell Precision 3510 */
 };
 
 static const struct alps_protocol_info alps_v3_protocol_data = {
-- 
2.11.1
