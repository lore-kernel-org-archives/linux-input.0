From: Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 3/3] HID: google: whiskers: mask out extra flags in EC event_type
Date: Sat,  5 Oct 2019 18:16:29 +0800
Message-ID: <20191005101629.146710-1-ikjn@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@google.com>, Ting Shen <phoenixshen@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>, Ikjoon Jang <ikjn@chromium.org>
List-Id: linux-input@vger.kernel.org

Whiskers needs to get notifications from EC for getting current base
attached state. EC sends extra bits in event_type field that receiver
should mask out.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index bf2b6c6c9787..91cb62afbc2b 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -96,8 +96,9 @@ static int cbas_ec_notify(struct notifier_block *nb,
 	struct cros_ec_device *ec = _notify;
 	unsigned long flags;
 	bool base_present;
+	const u8 event_type = ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK;
 
-	if (ec->event_data.event_type == EC_MKBP_EVENT_SWITCH) {
+	if (event_type == EC_MKBP_EVENT_SWITCH) {
 		base_present = cbas_parse_base_state(
 					&ec->event_data.data.switches);
 		dev_dbg(cbas_ec.dev,
-- 
2.23.0.581.g78d2f28ef7-goog
