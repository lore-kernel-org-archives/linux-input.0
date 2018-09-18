From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 14/20] Input: iforce - only call iforce_process_packet() if initialized
Date: Mon, 17 Sep 2018 17:47:26 -0700
Message-ID: <20180918004732.9875-14-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It is excessive to check if device is fully initialized in
iforce_process_packet(), as for USB-conected devices we do not start
collecting reports until the device is fully initialized.

Let's change serio transport code to not call iforce_process_packet()
until device initialization is done.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c | 3 ---
 drivers/input/joystick/iforce/iforce-serio.c   | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index c0a665961c23..976ec1c7cf15 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -172,9 +172,6 @@ void iforce_process_packet(struct iforce *iforce,
 	struct input_dev *dev = iforce->dev;
 	int i, j;
 
-	if (!iforce->type)
-		return;
-
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 0dd95d145e85..8d7eba9c9f0e 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -172,7 +172,7 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 
 			/* Signal that command is done */
 			wake_up(&iforce->wait);
-		} else {
+		} else if (likely(iforce->type)) {
 			iforce_process_packet(iforce, iforce_serio->id,
 					      iforce->data, iforce_serio->len);
 		}
-- 
2.19.0.397.gdd90340f6a-goog
