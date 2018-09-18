From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 13/20] Input: iforce - signal command completion from transport code
Date: Mon, 17 Sep 2018 17:47:25 -0700
Message-ID: <20180918004732.9875-13-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signalling command completion from iforce_process_packet() does
not make sense, as not all transport use the same data path for
both commands and motion data form the device, that is why USB
code already has to signal command completion iforce_usb_out().

Let's move signalling completion into individual transport
modules.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c | 2 --
 drivers/input/joystick/iforce/iforce-serio.c   | 9 ++++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 35b7a5206977..c0a665961c23 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -172,8 +172,6 @@ void iforce_process_packet(struct iforce *iforce,
 	struct input_dev *dev = iforce->dev;
 	int i, j;
 
-	wake_up(&iforce->wait);
-
 	if (!iforce->type)
 		return;
 
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index f8bf7d2aa59f..0dd95d145e85 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -169,10 +169,13 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 			iforce->ecmd = (iforce_serio->id << 8) |
 					iforce_serio->idx;
 			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
-		}
 
-		iforce_process_packet(iforce, iforce_serio->id,
-				      iforce->data, iforce_serio->len);
+			/* Signal that command is done */
+			wake_up(&iforce->wait);
+		} else {
+			iforce_process_packet(iforce, iforce_serio->id,
+					      iforce->data, iforce_serio->len);
+		}
 
 		iforce_serio->pkt = 0;
 		iforce_serio->id  = 0;
-- 
2.19.0.397.gdd90340f6a-goog
