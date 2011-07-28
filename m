From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/16] HID: wiimote: Reduce input syncs
Date: Thu, 28 Jul 2011 18:08:25 +0200
Message-ID: <1311869316-17128-6-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab1G1QJK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:10 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400102fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:09 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

To avoid multiple input syncs to be sent when parsing multiple
peripheral inputs from the wiimote in future, we send the input-sync
after handling all input events and not after parsing each value. This avoids
waking up user-space handlers multiple times on a single incoming package.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 859950e..bac4410 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -380,7 +380,6 @@ static void handler_keys(struct wiimote_data *wdata, const __u8 *payload)
 							!!(payload[1] & 0x10));
 	input_report_key(wdata->input, wiiproto_keymap[WIIPROTO_KEY_HOME],
 							!!(payload[1] & 0x80));
-	input_sync(wdata->input);
 }
 
 static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
@@ -440,6 +439,7 @@ static int wiimote_hid_event(struct hid_device *hdev, struct hid_report *report,
 			h->func(wdata, &raw_data[1]);
 	}
 
+	input_sync(wdata->input);
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
 	return 0;
-- 
1.7.6

