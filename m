From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 04/20] Input: iforce - move command completion handling to serio code
Date: Mon, 17 Sep 2018 17:47:16 -0700
Message-ID: <20180918004732.9875-4-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Continue teasing apart protocol-specific bits from core into transport
modules. This time move RS232-specific command completion handling
from core to iforce-serio module.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c |  7 -------
 drivers/input/joystick/iforce/iforce-serio.c   | 12 +++++++++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index e677562efc9a..8a9a152bb595 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -134,13 +134,6 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 	struct input_dev *dev = iforce->dev;
 	int i;
 
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	if (HI(iforce->expect_packet) == HI(cmd)) {
-		iforce->expect_packet = 0;
-		iforce->ecmd = cmd;
-		memcpy(iforce->edata, data, IFORCE_MAX_LENGTH);
-	}
-#endif
 	wake_up(&iforce->wait);
 
 	if (!iforce->type)
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index fa45ce425d47..eca2f6eca7f0 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -130,7 +130,17 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 	}
 
 	if (iforce->idx == iforce->len) {
-		iforce_process_packet(iforce, (iforce->id << 8) | iforce->idx, iforce->data);
+		u16 cmd = (iforce->id << 8) | iforce->idx;
+
+		/* Handle command completion */
+		if (HI(iforce->expect_packet) == HI(cmd)) {
+			iforce->expect_packet = 0;
+			iforce->ecmd = cmd;
+			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
+		}
+
+		iforce_process_packet(iforce, cmd, iforce->data);
+
 		iforce->pkt = 0;
 		iforce->id  = 0;
 		iforce->len = 0;
-- 
2.19.0.397.gdd90340f6a-goog
