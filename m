From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v4 1/7] HID: sony: Fix cancel_work_sync mismerge
Date: Wed,  2 Apr 2014 12:31:19 -0400
Message-ID: <1396456285-23755-2-git-send-email-frank.praznik@oh.rr.com>
References: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:34623 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932233AbaDBQbw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Apr 2014 12:31:52 -0400
In-Reply-To: <1396456285-23755-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Remove redundant cancel_work_sync() call caused by mismerge.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 Apply against jikos/hid.git/for-linus to fix mismerge code duplication

 drivers/hid/hid-sony.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 69204af..908de27 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1721,8 +1721,6 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(hdev);
 
-	if (sc->worker_initialized)
-		cancel_work_sync(&sc->state_worker);
 	if (sc->quirks & SONY_BATTERY_SUPPORT) {
 		hid_hw_close(hdev);
 		sony_battery_remove(sc);
-- 
1.8.3.2

