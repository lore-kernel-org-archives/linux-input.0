From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH] Bluetooth: hidp: Add support for NO_INIT_REPORTS quirk
Date: Fri, 26 Aug 2011 13:27:12 +0200
Message-ID: <1314358032-23513-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45306 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab1HZL1c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Aug 2011 07:27:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, linux-input@vger.kernel.org, David Herrmann <dh.herrmann@googlemail.com>

During setup the host initializes all HID reports. Some devices do not
support this. If this quirk is set, we skip the initialization.
See also usbhid_init_reports() for this quirk.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 net/bluetooth/hidp/core.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 43b4c2d..4423e3a 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -870,6 +870,9 @@ static int hidp_start(struct hid_device *hid)
 	struct hidp_session *session = hid->driver_data;
 	struct hid_report *report;
 
+	if (hid->quirks & HID_QUIRK_NO_INIT_REPORTS)
+		return 0;
+
 	list_for_each_entry(report, &hid->report_enum[HID_INPUT_REPORT].
 			report_list, list)
 		hidp_send_report(session, report);
-- 
1.7.6

