From: Stefan Achatz <stefan_achatz@web.de>
Subject: [PATCH] HID: Roccat: Added media key support for Kone
Date: Sun, 07 Apr 2013 07:08:44 +0200
Message-ID: <1365311324.2435.4.camel@neuromancer.tessier-ashpool>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:65008 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3DGFJ2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Apr 2013 01:09:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Kone now reports media key events through it's chardev to userspace.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kone.c |    3 ++-
 drivers/hid/hid-roccat-kone.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 9ce2d0b..7fae070 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -818,8 +818,9 @@ static void kone_report_to_chrdev(struct kone_device const *kone,
 				(uint8_t *)&roccat_report);
 		break;
 	case kone_mouse_event_call_overlong_macro:
+	case kone_mouse_event_multimedia:
 		if (event->value == kone_keystroke_action_press) {
-			roccat_report.event = kone_mouse_event_call_overlong_macro;
+			roccat_report.event = event->event;
 			roccat_report.value = kone->actual_profile;
 			roccat_report.key = event->macro_key;
 			roccat_report_event(kone->chrdev_minor,
diff --git a/drivers/hid/hid-roccat-kone.h b/drivers/hid/hid-roccat-kone.h
index 64abb5b..52c6167 100644
--- a/drivers/hid/hid-roccat-kone.h
+++ b/drivers/hid/hid-roccat-kone.h
@@ -169,6 +169,7 @@ enum kone_mouse_events {
 	/* TODO clarify meaning and occurence of kone_mouse_event_calibration */
 	kone_mouse_event_calibration = 0xc0,
 	kone_mouse_event_call_overlong_macro = 0xe0,
+	kone_mouse_event_multimedia = 0xe1,
 	/* switch events notify if user changed values with mousebutton click */
 	kone_mouse_event_switch_dpi = 0xf0,
 	kone_mouse_event_switch_profile = 0xf1
-- 
1.7.3.4



