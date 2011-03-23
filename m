From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH 1/2] Input: sparse-keymap - report scancodes with key events
Date: Wed, 23 Mar 2011 16:13:42 -0500
Message-ID: <1300914823-9440-2-git-send-email-seth.forshee@canonical.com>
References: <1300914823-9440-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300914823-9440-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Scancodes are useful debugging aids when incorrect keycodes
are being sent, as is common with laptop hotkeys.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/input/sparse-keymap.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index 337bf51..74bca5d 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -208,6 +208,11 @@ int sparse_keymap_setup(struct input_dev *dev,
 		}
 	}
 
+	if (test_bit(EV_KEY, dev->evbit)) {
+		__set_bit(EV_MSC, dev->evbit);
+		__set_bit(MSC_SCAN, dev->mscbit);
+	}
+
 	dev->keycode = map;
 	dev->keycodemax = map_size;
 	dev->getkeycode = sparse_keymap_getkeycode;
@@ -268,6 +273,7 @@ void sparse_keymap_report_entry(struct input_dev *dev, const struct key_entry *k
 {
 	switch (ke->type) {
 	case KE_KEY:
+		input_event(dev, EV_MSC, MSC_SCAN, ke->code);
 		input_report_key(dev, ke->keycode, value);
 		input_sync(dev);
 		if (value && autorelease) {
-- 
1.7.4.1
