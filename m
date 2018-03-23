From: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Subject: [PATCH] Input: ALPS - add support for 73 03 28 devices (Thinkpad
 L570)
Date: Fri, 23 Mar 2018 15:23:55 +0100
Message-ID: <7d5077ef-c185-c6b1-d602-df8d9f7dade3@secunet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, Takashi Iwai <tiwai@suse.de>, Kees Cook <keescook@chromium.org>, Nir Perry <nirperry@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Lenovo Thinkpad L570 uses V8 protocol.
Add 0x73 0x03 0x28 devices to use V8 protovol which makes
trackstick and mouse buttons work with Lenovo Thinkpad L570.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
---
 drivers/input/mouse/alps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index dbe57da..5523d4e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -136,6 +136,8 @@
 	{ { 0x73, 0x02, 0x0a }, { ALPS_PROTO_V2, 0xf8, 0xf8, 0 } },
 	{ { 0x73, 0x02, 0x14 }, { ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_FW_BK_2 } },			/* Ahtec Laptop */
 	{ { 0x73, 0x02, 0x50 }, { ALPS_PROTO_V2, 0xcf, 0xcf, ALPS_FOUR_BUTTONS } },		/* Dell Vostro 1400 */
+	{ { 0x73, 0x03, 0x28 }, { ALPS_PROTO_V8, 0x18, 0x18,
+		ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE | ALPS_BUTTONPAD } },		/* Lenovo L570 */
 };
 
 static const struct alps_protocol_info alps_v3_protocol_data = {
-- 
1.9.1
