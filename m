From: David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH 05/26] HID: wiimote: use cached battery values on I/O failure
Date: Sun,  5 May 2013 23:12:49 +0200
Message-ID: <1367788390-29835-6-git-send-email-dh.herrmann@gmail.com>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:63484 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3EEVNu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 May 2013 17:13:50 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so1355419bkc.30
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 14:13:49 -0700 (PDT)
In-Reply-To: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

Battery reports are sent along every status report of the Wii Remote.
So chances are pretty high that we have an up-to-date battery
cache at any time. Therefore, initialize the battery-cache to 100% and
then return battery values from the cache if the query fails.

This works around a power_supply limitation in that it requires us to be
able to query the device during power_supply registration and
removal. Otherwise, "add" or "remove" udev events are not sent. If
we answer these requests from our cache instead, we avoid dropping these
events and no longer cause warnings printed.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 76d2c73..00a9b6f 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -461,12 +461,12 @@ static int wiimote_battery_get_property(struct power_supply *psy,
 	wiiproto_req_status(wdata);
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
-	ret = wiimote_cmd_wait(wdata);
-	state = wdata->state.cmd_battery;
+	wiimote_cmd_wait(wdata);
 	wiimote_cmd_release(wdata);
 
-	if (ret)
-		return ret;
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	state = wdata->state.cmd_battery;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
 	switch (psp) {
 		case POWER_SUPPLY_PROP_CAPACITY:
@@ -923,10 +923,9 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 		wiiext_event(wdata, false);
 	}
 
-	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_SREQ, 0)) {
-		wdata->state.cmd_battery = payload[5];
+	wdata->state.cmd_battery = payload[5];
+	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_SREQ, 0))
 		wiimote_cmd_complete(wdata);
-	}
 }
 
 /* reduced generic report with "BB BB" key data only */
@@ -1279,6 +1278,7 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	init_completion(&wdata->state.ready);
 	mutex_init(&wdata->state.sync);
 	wdata->state.drm = WIIPROTO_REQ_DRM_K;
+	wdata->state.cmd_battery = 0xff;
 
 	INIT_WORK(&wdata->init_worker, wiimote_init_worker);
 
-- 
1.8.2.2

