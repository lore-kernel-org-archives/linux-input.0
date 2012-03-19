From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 3/3] HID: wacom: Add battery/ac reporting for Intuos4 WL
Date: Mon, 19 Mar 2012 19:08:34 +0000
Message-ID: <1332184114-30354-3-git-send-email-przemo@firszt.eu>
References: <1332184114-30354-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:52520 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757517Ab2CSTJO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Mar 2012 15:09:14 -0400
In-Reply-To: <1332184114-30354-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: pinglinux@gmail.com, jkosina@suse.cz, chris@cnpbagwell.com
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

This patch adds battery/ac reporting for Intuos4 WL. It uses existing
sysfs code, but the device reports battery capacity in more fine-grained way,
so there has to be a separate lookup table (called batcap_i4).

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/hid/hid-wacom.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 9c15494..43a96d1 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -51,6 +51,8 @@ struct wacom_data {
 /*percent of battery capacity for Graphire
   8th value means AC online and show 100% capacity */
 static unsigned short batcap_gr[8] = { 1, 15, 25, 35, 50, 70, 100, 100 };
+/*percent of battery capacity for Intuos4 WL, AC has a separate bit*/
+static unsigned short batcap_i4[8] = { 1, 15, 30, 45, 60, 70, 85, 100 };
 
 static enum power_supply_property wacom_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
@@ -449,6 +451,7 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct input_dev *input;
 	unsigned char *data = (unsigned char *) raw_data;
 	int i;
+	__u8 power_raw;
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT))
 		return 0;
@@ -476,6 +479,13 @@ static int wacom_raw_event(struct hid_device *hdev, struct hid_report *report,
 			wacom_i4_parse_report(hdev, wdata, input, data + i);
 			i += 10;
 			wacom_i4_parse_report(hdev, wdata, input, data + i);
+			power_raw = data[i+10];
+			if (power_raw != wdata->power_raw) {
+				wdata->power_raw = power_raw;
+				wdata->battery_capacity = batcap_i4[power_raw & 0x07];
+				wdata->ps_connected = power_raw & 0x08;
+			}
+
 			break;
 		default:
 			hid_err(hdev, "Unknown report: %d,%d size:%d\n",
-- 
1.7.6.4

