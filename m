From: Seth Forshee <seth.forshee@canonical.com>
Subject: [PATCH v2 2/2] Input: sparse-keymap - report KEY_UNKNOWN for unknown scan codes
Date: Fri, 25 Mar 2011 08:40:03 -0500
Message-ID: <1301060403-19229-3-git-send-email-seth.forshee@canonical.com>
References: <20110325073554.GD2590@core.coreip.homeip.net>
 <1301060403-19229-1-git-send-email-seth.forshee@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301060403-19229-1-git-send-email-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This allows for debugging non-functional keys easily from
userspace.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 drivers/input/sparse-keymap.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
index 74bca5d..fdb6a39 100644
--- a/drivers/input/sparse-keymap.c
+++ b/drivers/input/sparse-keymap.c
@@ -209,6 +209,7 @@ int sparse_keymap_setup(struct input_dev *dev,
 	}
 
 	if (test_bit(EV_KEY, dev->evbit)) {
+		__set_bit(KEY_UNKNOWN, dev->keybit);
 		__set_bit(EV_MSC, dev->evbit);
 		__set_bit(MSC_SCAN, dev->mscbit);
 	}
@@ -311,12 +312,19 @@ bool sparse_keymap_report_event(struct input_dev *dev, unsigned int code,
 {
 	const struct key_entry *ke =
 		sparse_keymap_entry_from_scancode(dev, code);
+	struct key_entry unknown_ke;
 
 	if (ke) {
 		sparse_keymap_report_entry(dev, ke, value, autorelease);
 		return true;
 	}
 
+	/* Report an unknown key event as a debugging aid */
+	unknown_ke.type = KE_KEY;
+	unknown_ke.code = code;
+	unknown_ke.keycode = KEY_UNKNOWN;
+	sparse_keymap_report_entry(dev, &unknown_ke, value, true);
+
 	return false;
 }
 EXPORT_SYMBOL(sparse_keymap_report_event);
-- 
1.7.4.1
