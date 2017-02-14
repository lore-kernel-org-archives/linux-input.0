From: Tomasz Kramkowski <tk@the-tk.com>
Subject: [PATCH v2 1/2] HID: reject input outside logical range only if null state is set
Date: Tue, 14 Feb 2017 23:14:32 +0000
Message-ID: <20170214231433.27060-2-tk@the-tk.com>
References: <20170214231433.27060-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170214231433.27060-1-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Valtteri=20Heikkil=C3=A4?= <rnd@nic.fi>, Tomasz Kramkowski <tk@the-tk.com>
List-Id: linux-input@vger.kernel.org

From: Valtteri Heikkilä <rnd@nic.fi>

This patch fixes an issue in drivers/hid/hid-input.c where USB HID
control null state flag is not checked upon rejecting inputs outside
logical minimum-maximum range. The check should be made according to USB
HID specification 1.11, section 6.2.2.5, p.31. The fix will resolve
issues with some game controllers, such as:
https://bugzilla.kernel.org/show_bug.cgi?id=68621

[tk@the-tk.com: shortened and fixed spelling in commit message]
Signed-off-by: Valtteri Heikkilä <rnd@nic.fi>
Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d05f903c7614..cf8256aac2bd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1157,6 +1157,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	 * don't specify logical min and max.
 	 */
 	if ((field->flags & HID_MAIN_ITEM_VARIABLE) &&
+	    (field->flags & HID_MAIN_ITEM_NULL_STATE) &&
 	    (field->logical_minimum < field->logical_maximum) &&
 	    (value < field->logical_minimum ||
 	     value > field->logical_maximum)) {
-- 
2.11.0
