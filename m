From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: elo: clear BTN_LEFT mapping
Date: Fri, 24 Nov 2017 14:43:00 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711241435100.11505@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

ELO devices have one Button usage in GenDesk field, which makes hid-input 
map it to BTN_LEFT; that confuses userspace, which then considers the 
device to be a mouse/touchpad instead of touchscreen.

Fix that by unmapping BTN_LEFT and keeping only BTN_TOUCH in place.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Now queued in for-4.16/elo

 drivers/hid/hid-elo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 0cd4f7216239..595fe25a92fa 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -42,6 +42,12 @@ static int elo_input_configured(struct hid_device *hdev,
 {
 	struct input_dev *input = hidinput->input;
 
+	/*
+	 * ELO devices have one Button usage in GenDesk field, which makes
+	 * hid-input map it to BTN_LEFT; that confuses userspace, which then
+	 * considers the device to be a mouse/touchpad instead of touchscreen.
+	 */
+	clear_bit(BTN_LEFT, input->keybit);
 	set_bit(BTN_TOUCH, input->keybit);
 	set_bit(ABS_PRESSURE, input->absbit);
 	input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);

-- 
Jiri Kosina
SUSE Labs
