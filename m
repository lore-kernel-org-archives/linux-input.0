From: Joe Perches <joe@perches.com>
Subject: [PATCH 03/11] aiptek: Fix probable mask then right shift defects
Date: Sun, 26 Oct 2014 22:24:59 -0700
Message-ID: <8c6687a4d568c853ab649ba03d2477ee24bc6ff6.1414387334.git.joe@perches.com>
References: <cover.1414387334.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1414387334.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Precedence of & and >> is not the same and is not left to right.
shift has higher precedence and should be done after the mask.

Here the shifts are unnecessary and a non-zero value can be used
as the test to set 1 or zero.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/input/tablet/aiptek.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index e7f966d..dee2bb9 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -489,9 +489,9 @@ static void aiptek_irq(struct urb *urb)
 			 */
 			jitterable = data[1] & 0x07;
 
-			left = (data[1] & aiptek->curSetting.mouseButtonLeft >> 2) != 0 ? 1 : 0;
-			right = (data[1] & aiptek->curSetting.mouseButtonRight >> 2) != 0 ? 1 : 0;
-			middle = (data[1] & aiptek->curSetting.mouseButtonMiddle >> 2) != 0 ? 1 : 0;
+			left = data[1] & aiptek->curSetting.mouseButtonLeft ? 1 : 0;
+			right = data[1] & aiptek->curSetting.mouseButtonRight ? 1 : 0;
+			middle = data[1] & aiptek->curSetting.mouseButtonMiddle ? 1 : 0;
 
 			input_report_key(inputdev, BTN_LEFT, left);
 			input_report_key(inputdev, BTN_MIDDLE, middle);
-- 
2.1.2
