From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: wacom: do not directly use input_mt_report_pointer_emulation
Date: Tue, 17 Feb 2015 14:19:46 -0500
Message-ID: <1424200786-4009-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

input_mt_sync_frame() calls input_mt_report_pointer_emulation() and do
some internal steps required to keep in sync the state of the touch within
the various reports.

Given that we use input_mt_assign_slot() in this driver, it is better to
use input_mt_sync_frame().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 8627581..de93968 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1093,7 +1093,7 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 			}
 		}
 	}
-	input_mt_report_pointer_emulation(input, true);
+	input_mt_sync_frame(input);
 
 	wacom->num_contacts_left -= contacts_to_send;
 	if (wacom->num_contacts_left <= 0)
@@ -1144,7 +1144,7 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
 			input_report_abs(input, ABS_MT_POSITION_Y, y);
 		}
 	}
-	input_mt_report_pointer_emulation(input, true);
+	input_mt_sync_frame(input);
 
 	wacom->num_contacts_left -= contacts_to_send;
 	if (wacom->num_contacts_left < 0)
@@ -1176,7 +1176,7 @@ static int wacom_tpc_mt_touch(struct wacom_wac *wacom)
 			contact_with_no_pen_down_count++;
 		}
 	}
-	input_mt_report_pointer_emulation(input, true);
+	input_mt_sync_frame(input);
 
 	/* keep touch state for pen event */
 	wacom->shared->touch_down = (contact_with_no_pen_down_count > 0);
@@ -1638,7 +1638,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
 		}
 	}
 
-	input_mt_report_pointer_emulation(input, true);
+	input_mt_sync_frame(input);
 
 	input_report_key(pad_input, BTN_LEFT, (data[1] & 0x08) != 0);
 	input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) != 0);
@@ -1728,7 +1728,7 @@ static int wacom_bpt3_touch(struct wacom_wac *wacom)
 			wacom_bpt3_button_msg(wacom, data + offset);
 
 	}
-	input_mt_report_pointer_emulation(input, true);
+	input_mt_sync_frame(input);
 
 	return 1;
 }
-- 
2.1.0
