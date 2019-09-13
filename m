From: Dmitry Torokhov <dtor@chromium.org>
Subject: [PATCH 3/3] HID: google: whiskers: signal tablet mode on connect
Date: Fri, 13 Sep 2019 15:03:17 -0700
Message-ID: <20190913220317.58289-3-dtor@chromium.org>
References: <20190913220317.58289-1-dtor@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913220317.58289-1-dtor@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When we receive "keyboard position" event from Whiskers we can
conclude that the base is attached, even if we did not get EC event
for that. We may miss EC event because there are some units which
have a lot of leakage on the ADC pins that the EC uses to determine
whether or not a base is attached.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 3dc6116c8f76..31e4a39946f5 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -402,16 +402,16 @@ static int hammer_event(struct hid_device *hid, struct hid_field *field,
 	    usage->hid == WHISKERS_KBD_FOLDED) {
 		spin_lock_irqsave(&cbas_ec_lock, flags);
 
+		/*
+		 * If we are getting events from Whiskers that means that it
+		 * is attached to the lid.
+		 */
+		cbas_ec.base_present = true;
 		cbas_ec.base_folded = value;
 		hid_dbg(hid, "%s: base: %d, folded: %d\n", __func__,
 			cbas_ec.base_present, cbas_ec.base_folded);
 
-		/*
-		 * We should not get event if base is detached, but in case
-		 * we happen to service HID and EC notifications out of order
-		 * let's still check the "base present" flag.
-		 */
-		if (cbas_ec.input && cbas_ec.base_present) {
+		if (cbas_ec.input) {
 			input_report_switch(cbas_ec.input,
 					    SW_TABLET_MODE, value);
 			input_sync(cbas_ec.input);
-- 
2.23.0.237.gc6a4ce50a0-goog
