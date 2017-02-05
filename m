From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 3/5] Input: xpad - send rumble on Xbox One init to fix PowerA pads
Date: Sat,  4 Feb 2017 16:30:00 -0800
Message-ID: <20170205003002.28160-4-aicommander@gmail.com>
References: <20170205003002.28160-1-aicommander@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170205003002.28160-1-aicommander@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>
List-Id: linux-input@vger.kernel.org

Some PowerA pads require a rumble packet to start sending
input reports.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3f19f32b..13f298d 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -358,6 +358,13 @@ static const struct xpad_output_packet xone_init_pkt[] = {
 	 * or later firmware installed (or present from the factory).
 	 */
 	{{0x05, 0x20, 0x00, 0x01, 0x00}, 5, true},
+
+	/*
+	 * A rumble packet is required for some PowerA pads to start
+	 * sending input reports. One of those pads is (0x24c6:0x543a).
+	 */
+	{{0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
+	  0x00, 0x00, 0x00, 0x00, 0x00}, 13, true},
 };
 
 #define XPAD_OUT_CMD_IDX	0
-- 
2.9.3
