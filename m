From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 1/2] HID: ntrig don't dereference unclaimed hidinput
Date: Mon,  7 Mar 2011 21:13:27 -0500
Message-ID: <1299550408-11457-1-git-send-email-rafi@seas.upenn.edu>
References: <alpine.LNX.2.00.1102261156480.2160@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fox.seas.upenn.edu ([158.130.68.12]:46191 "EHLO
	fox.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab1CHCNy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 21:13:54 -0500
In-Reply-To: <alpine.LNX.2.00.1102261156480.2160@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: rydberg@euromail.se, chatty@enac.fr, peter.hutterer@who-t.net, Rafi Rubin <rafi@seas.upenn.edu>

Check before dereferencing field->hidinput to fix a reported invalid
deference bug.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index beb4034..56a88d9 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -539,8 +539,14 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 			struct hid_usage *usage, __s32 value)
 {
-	struct input_dev *input = field->hidinput->input;
 	struct ntrig_data *nd = hid_get_drvdata(hid);
+	struct input_dev *input;
+
+	/* Skip processing if not a claimed input */
+	if (!(hid->claimed & HID_CLAIMED_INPUT))
+		goto not_claimed_input;
+
+	input = field->hidinput->input;
 
 	/* No special handling needed for the pen */
 	if (field->application == HID_DG_PEN)
@@ -810,6 +816,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
 		}
 	}
 
+not_claimed_input:
+
 	/* we have handled the hidinput part, now remains hiddev */
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_hid_event)
 		hid->hiddev_hid_event(hid, field, usage, value);
-- 
1.7.2.3

