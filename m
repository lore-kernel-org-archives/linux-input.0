From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] Input: spaceball - mark expected switch fall-throughs
Date: Wed, 8 Nov 2017 20:55:59 -0600
Message-ID: <20171109025559.GA12406@embeddedor.com>
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

Addresses-Coverity-ID: 114767
Addresses-Coverity-ID: 114768
Addresses-Coverity-ID: 114769
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/input/joystick/spaceball.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
index e9712a1..bb3faef 100644
--- a/drivers/input/joystick/spaceball.c
+++ b/drivers/input/joystick/spaceball.c
@@ -162,6 +162,7 @@ static irqreturn_t spaceball_interrupt(struct serio *serio,
 				break;
 			}
 			spaceball->escape = 0;
+			/* fall through */
 		case 'M':
 		case 'Q':
 		case 'S':
@@ -169,6 +170,7 @@ static irqreturn_t spaceball_interrupt(struct serio *serio,
 				spaceball->escape = 0;
 				data &= 0x1f;
 			}
+			/* fall through */
 		default:
 			if (spaceball->escape)
 				spaceball->escape = 0;
@@ -234,11 +236,13 @@ static int spaceball_connect(struct serio *serio, struct serio_driver *drv)
 			input_dev->keybit[BIT_WORD(BTN_A)] |= BIT_MASK(BTN_A) |
 				BIT_MASK(BTN_B) | BIT_MASK(BTN_C) |
 				BIT_MASK(BTN_MODE);
+			/* fall through */
 		default:
 			input_dev->keybit[BIT_WORD(BTN_0)] |= BIT_MASK(BTN_2) |
 				BIT_MASK(BTN_3) | BIT_MASK(BTN_4) |
 				BIT_MASK(BTN_5) | BIT_MASK(BTN_6) |
 				BIT_MASK(BTN_7) | BIT_MASK(BTN_8);
+			/* fall through */
 		case SPACEBALL_3003C:
 			input_dev->keybit[BIT_WORD(BTN_0)] |= BIT_MASK(BTN_1) |
 				BIT_MASK(BTN_8);
-- 
2.7.4
