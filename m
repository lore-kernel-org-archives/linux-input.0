From: Peter Wu <peter@lekensteyn.nl>
Subject: [PATCH 3/3] HID: logitech-hidpp: avoid unintended fall-through
Date: Tue, 16 Dec 2014 01:50:16 +0100
Message-ID: <1418691016-30681-4-git-send-email-peter@lekensteyn.nl>
References: <1418691016-30681-1-git-send-email-peter@lekensteyn.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:46594 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbaLPAud (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Dec 2014 19:50:33 -0500
In-Reply-To: <1418691016-30681-1-git-send-email-peter@lekensteyn.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Add a return to avoid a fall-through. Introduced in commit
57ac86cf52e903d9e3e0f12b34c814cce6b65550 ("HID: logitech-hidpp: add
support of the first Logitech Wireless Touchpad").

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 drivers/hid/hid-logitech-hidpp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2315358..09eee17 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -811,6 +811,7 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 			input_event(wd->input, EV_KEY, BTN_RIGHT,
 					!!(data[1] & 0x02));
 			input_sync(wd->input);
+			return 0;
 		} else {
 			if (size < 21)
 				return 1;
-- 
2.1.3

