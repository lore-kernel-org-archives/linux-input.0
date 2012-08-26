From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 05/20] Input: Make sure we follow all EV_KEY events
Date: Sun, 26 Aug 2012 14:57:23 +0200
Message-ID: <1345985858-445-6-git-send-email-rydberg@euromail.se>
References: <1345985858-445-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345985858-445-1-git-send-email-rydberg@euromail.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

For some EV_KEY types, sending a larger-than-one value causes the
input state to oscillate. This patch makes sure this cannot happen,
clearing up the autorepeat bypass logic in the process.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/input.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8ebf116..4d64500 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -239,24 +239,30 @@ static void input_handle_event(struct input_dev *dev,
 		break;
 
 	case EV_KEY:
-		if (is_event_supported(code, dev->keybit, KEY_MAX) &&
-		    !!test_bit(code, dev->key) != value) {
+		if (is_event_supported(code, dev->keybit, KEY_MAX)) {
+
+			/* auto-repeat bypasses state updates */
+			if (value == 2) {
+				disposition = INPUT_PASS_TO_HANDLERS;
+				break;
+			}
+
+			if (!!test_bit(code, dev->key) != !!value) {
 
-			if (value != 2) {
 				__change_bit(code, dev->key);
+				disposition = INPUT_PASS_TO_HANDLERS;
+
 				if (value)
 					input_start_autorepeat(dev, code);
 				else
 					input_stop_autorepeat(dev);
 			}
-
-			disposition = INPUT_PASS_TO_HANDLERS;
 		}
 		break;
 
 	case EV_SW:
 		if (is_event_supported(code, dev->swbit, SW_MAX) &&
-		    !!test_bit(code, dev->sw) != value) {
+		    !!test_bit(code, dev->sw) != !!value) {
 
 			__change_bit(code, dev->sw);
 			disposition = INPUT_PASS_TO_HANDLERS;
@@ -283,7 +289,7 @@ static void input_handle_event(struct input_dev *dev,
 
 	case EV_LED:
 		if (is_event_supported(code, dev->ledbit, LED_MAX) &&
-		    !!test_bit(code, dev->led) != value) {
+		    !!test_bit(code, dev->led) != !!value) {
 
 			__change_bit(code, dev->led);
 			disposition = INPUT_PASS_TO_ALL;
-- 
1.7.12
