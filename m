From: Daniel Walker <dwalker@mvista.com>
Subject: [PATCH] hid: gyration sleep button quirk
Date: Tue,  1 Jul 2008 09:24:12 -0700
Message-ID: <1214929451-14515-2-git-send-email-dwalker@mvista.com>
References: <1214929451-14515-1-git-send-email-dwalker@mvista.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:27458 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751282AbYGAQY6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 12:24:58 -0400
In-Reply-To: <1214929451-14515-1-git-send-email-dwalker@mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Philippe Troin <phil@fifi.org>, "Adolfo R. Brandes" <arbrandes@gmail.com>, linux-input@vger.kernel.org

This patch is based on one provided by Jiri Kosina to handle the sleep
button. I just added some cleanup and integrated it into my series.

Signed-off-by: Daniel Walker <dwalker@mvista.com>
---
 drivers/hid/hid-input-quirks.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-input-quirks.c b/drivers/hid/hid-input-quirks.c
index e6a937a..16feea0 100644
--- a/drivers/hid/hid-input-quirks.c
+++ b/drivers/hid/hid-input-quirks.c
@@ -466,6 +466,18 @@ int hidinput_event_quirks(struct hid_device *hid, struct hid_field *field, struc
 		input_event(input, usage->type, REL_WHEEL, -value);
 		return 1;
 	}
+
+	/* Gyration MCE remote "Sleep" key */
+	if (hid->vendor == VENDOR_ID_GYRATION &&
+	    hid->product == DEVICE_ID_GYRATION_REMOTE &&
+	    (usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK &&
+	    (usage->hid & 0xff) == 0x82) {
+		input_event(input, usage->type, usage->code, 1);
+		input_sync(input);
+		input_event(input, usage->type, usage->code, 0);
+		input_sync(input);
+		return 1;
+	}
 	return 0;
 }
 
-- 
1.5.5.1.1.g0dfaf8

