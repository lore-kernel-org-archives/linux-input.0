From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 01/20] Input: iforce - remove "being used" silliness
Date: Mon, 17 Sep 2018 17:47:13 -0700
Message-ID: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The kernel is supposed to handle multiple devices, static flags
in packet handling code will never work.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This is a random assortment of iforce patches that I made a few weeks back.

Tim, I do not have hardware, so I was bound to screw it up, but if you
have some time I'd appreciate if you try them out (and if I indeed broke
things if you could identify issues that would be even more awesome).

Thanks!


 drivers/input/joystick/iforce/iforce-packets.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index c10169f4554e..91893c751524 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -149,12 +149,6 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 {
 	struct input_dev *dev = iforce->dev;
 	int i;
-	static int being_used = 0;
-
-	if (being_used)
-		dev_warn(&iforce->dev->dev,
-			 "re-entrant call to iforce_process %d\n", being_used);
-	being_used++;
 
 #ifdef CONFIG_JOYSTICK_IFORCE_232
 	if (HI(iforce->expect_packet) == HI(cmd)) {
@@ -165,10 +159,8 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 #endif
 	wake_up(&iforce->wait);
 
-	if (!iforce->type) {
-		being_used--;
+	if (!iforce->type)
 		return;
-	}
 
 	switch (HI(cmd)) {
 
@@ -233,7 +225,6 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			}
 			break;
 	}
-	being_used--;
 }
 
 int iforce_get_id_packet(struct iforce *iforce, char *packet)
-- 
2.19.0.397.gdd90340f6a-goog
