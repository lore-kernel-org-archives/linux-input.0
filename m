From: djkurtz@chromium.org
Subject: [PATCH 8/9 v2] Input: add BTN_TOOL_QUINTTAP for reporting 5 fingers on touchpad
Date: Wed, 20 Jul 2011 21:39:05 +0800
Message-ID: <1311169146-20066-9-git-send-email-djkurtz@chromium.org>
References: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311169146-20066-1-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@euromail.se, chase.douglas@canonical.com, rubini@cvml.unipv.it
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

From: Daniel Kurtz <djkurtz@chromium.org>

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/input-mt.c |    1 +
 include/linux/input.h    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index c48c81f..9150ee7 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -117,6 +117,7 @@ void input_mt_report_finger_count(struct input_dev *dev, int count)
 	input_event(dev, EV_KEY, BTN_TOOL_DOUBLETAP, count == 2);
 	input_event(dev, EV_KEY, BTN_TOOL_TRIPLETAP, count == 3);
 	input_event(dev, EV_KEY, BTN_TOOL_QUADTAP, count == 4);
+	input_event(dev, EV_KEY, BTN_TOOL_QUINTTAP, count == 5);
 }
 EXPORT_SYMBOL(input_mt_report_finger_count);
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 068784e..4de4b46 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -503,6 +503,7 @@ struct input_keymap_entry {
 #define BTN_TOOL_FINGER		0x145
 #define BTN_TOOL_MOUSE		0x146
 #define BTN_TOOL_LENS		0x147
+#define BTN_TOOL_QUINTTAP	0x148	/* Five fingers on trackpad */
 #define BTN_TOUCH		0x14a
 #define BTN_STYLUS		0x14b
 #define BTN_STYLUS2		0x14c
-- 
1.7.3.1
