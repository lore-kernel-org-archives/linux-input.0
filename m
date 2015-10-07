From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/2] HID: wacom: Expect 'touch_max' touches if HID_DG_CONTACTCOUNT not present
Date: Wed,  7 Oct 2015 16:54:22 -0700
Message-ID: <1444262062-19247-2-git-send-email-killertofu@gmail.com>
References: <1444262062-19247-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34928 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbbJGXyz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 19:54:55 -0400
Received: by pacfv12 with SMTP id fv12so35934096pac.2
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2015 16:54:54 -0700 (PDT)
In-Reply-To: <1444262062-19247-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, expiredpopsicle@gmail.com, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

When introduced in commit 1b5d514, the check 'if (hid_data->cc_index >= 0)'
in 'wacom_wac_finger_pre_report' was intended to switch where the driver
got the expected number of contacts from: HID_DG_CONTACTCOUNT if the usage
was present, or 'touch_max' otherwise. Unfortunately, an oversight worthy
of a brown paper bag (specifically, that 'cc_index' could never be negative)
meant that the latter 'else' clause would never be entered.

The patch prior to this one introduced a way for 'cc_index' to be negative,
but only if HID_DG_CONTACTCOUNT is present in some report _other_ than the
one being processed. To ensure the 'else' clause is also entered for devices
which don't have HID_DG_CONTACTCOUNT on _any_ report, we add the additional
constraint that 'cc_report' be non-zero (which is true only if the usage is
present in some report).

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
Jiri,

Could you please queue this patch and the prior for 4.3? They fix issues
with the implementation of my "Ignore contacts in excess of declared
contact count" patch which was pulled in as part of the 4.3 merge window.

Thanks :)

 drivers/hid/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 4140b1d..46bd02b 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1740,8 +1740,8 @@ static void wacom_wac_finger_pre_report(struct hid_device *hdev,
 			}
 		}
 	}
-
-	if (hid_data->cc_index >= 0) {
+	if (hid_data->cc_report != 0 &&
+	    hid_data->cc_index >= 0) {
 		struct hid_field *field = report->field[hid_data->cc_index];
 		int value = field->value[hid_data->cc_value_index];
 		if (value)
-- 
2.6.1

