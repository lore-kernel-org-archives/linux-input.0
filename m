From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] Input: gamecon - mark expected switch fall-throughs
Date: Wed, 8 Nov 2017 21:07:12 -0600
Message-ID: <20171109030712.GA14989@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-input@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114761
Addresses-Coverity-ID: 114762
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/input/joystick/gamecon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/gamecon.c b/drivers/input/joystick/gamecon.c
index c43f087..ca734ea 100644
--- a/drivers/input/joystick/gamecon.c
+++ b/drivers/input/joystick/gamecon.c
@@ -654,6 +654,7 @@ static void gc_psx_report_one(struct gc_pad *pad, unsigned char psx_type,
 
 		input_report_key(dev, BTN_THUMBL, ~data[0] & 0x04);
 		input_report_key(dev, BTN_THUMBR, ~data[0] & 0x02);
+		/* fall through */
 
 	case GC_PSX_NEGCON:
 	case GC_PSX_ANALOG:
@@ -887,6 +888,7 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
 	case GC_SNES:
 		for (i = 4; i < 8; i++)
 			__set_bit(gc_snes_btn[i], input_dev->keybit);
+		/* fall through */
 	case GC_NES:
 		for (i = 0; i < 4; i++)
 			__set_bit(gc_snes_btn[i], input_dev->keybit);
@@ -894,6 +896,7 @@ static int gc_setup_pad(struct gc *gc, int idx, int pad_type)
 
 	case GC_MULTI2:
 		__set_bit(BTN_THUMB, input_dev->keybit);
+		/* fall through */
 	case GC_MULTI:
 		__set_bit(BTN_TRIGGER, input_dev->keybit);
 		break;
-- 
2.7.4
