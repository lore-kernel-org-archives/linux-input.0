From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 2/5] Input: xpad - add init packet for Hori and Titanfall 2 pads
Date: Sat,  4 Feb 2017 16:29:59 -0800
Message-ID: <20170205003002.28160-3-aicommander@gmail.com>
References: <20170205003002.28160-1-aicommander@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170205003002.28160-1-aicommander@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>
List-Id: linux-input@vger.kernel.org

Without sending this packet, the Titanfall 2 pad (0x0e6f:0x0165)
continuously attempts to handshake with the PC and never sends
any input reports.

The Hori gamepad (0x0f0d:0x0067) analog sticks don't work if
this isn't sent, though other buttons do work without it.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6f07b5b..3f19f32b 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -346,6 +346,14 @@ struct xpad_output_packet {
 /* Sequence numbers will be added before the packets are sent */
 static const struct xpad_output_packet xone_init_pkt[] = {
 	/*
+	 * This packet is required for the Titanfall 2 Xbox One pads
+	 * (0x0e6f:0x0165) to finish initialization and for Hori pads
+	 * (0x0f0d:0x0067) to make the analog sticks work.
+	 */
+	{{0x01, 0x20, 0x00, 0x09, 0x00, 0x04, 0x20, 0x3a,
+	  0x00, 0x00, 0x00, 0x80, 0x00}, 13, true},
+
+	/*
 	 * This packet is required for all Xbox One pads with 2015
 	 * or later firmware installed (or present from the factory).
 	 */
-- 
2.9.3
