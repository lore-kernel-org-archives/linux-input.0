From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 1/2] mceusb: Timeout unit corrections
Date: Sun,  3 Jul 2011 16:13:52 -0400
Message-ID: <1309724033-27804-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org, linux-input@vger.kernel.org, jarod@redhat.com
Cc: Rafi Rubin <rafi@seas.upenn.edu>
List-Id: linux-input@vger.kernel.org

Unit missmatch in mceusb_handle_command.  It should be converting to us,
not 1/10th of ms.

mceusb_dev_printdata 100us/ms -> 1000us/ms

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>

---

Fixing the interpretation of the timeout corrects buggy behavior,
particularly when using a mceusb reciever in lirc mode for arbitrary
remote controls (the mce remotes actually worked, don't know why).
---
 drivers/media/rc/mceusb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index ad927fc..377f826 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -551,7 +551,7 @@ static void mceusb_dev_printdata(struct mceusb_dev *ir, char *buf,
 		case MCE_CMD_S_TIMEOUT:
 			/* value is in units of 50us, so x*50/100 or x/2 ms */
 			dev_info(dev, "%s receive timeout of %d ms\n",
-				 inout, ((data1 << 8) | data2) / 2);
+				 inout, ((data1 << 8) | data2) / 20);
 			break;
 		case MCE_CMD_G_TIMEOUT:
 			dev_info(dev, "Get receive timeout\n");
@@ -835,7 +835,7 @@ static void mceusb_handle_command(struct mceusb_dev *ir, int index)
 	switch (ir->buf_in[index]) {
 	/* 2-byte return value commands */
 	case MCE_CMD_S_TIMEOUT:
-		ir->rc->timeout = US_TO_NS((hi << 8 | lo) / 2);
+		ir->rc->timeout = US_TO_NS((hi << 8 | lo) * MCE_TIME_UNIT);
 		break;
 
 	/* 1-byte return value commands */
-- 
1.7.5.4
