From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/4] input - wacom: don't retrieve touch_max when it is predefined
Date: Mon, 25 Jun 2012 14:36:15 -0700
Message-ID: <1340660175-27399-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59790 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab2FYVcN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 17:32:13 -0400
Received: by pbbrp8 with SMTP id rp8so7102210pbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 14:32:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Some models, such as 0xE6, report more fingers than we process.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Tested-by: Nils Kanning <nils@kanning.de>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index c2fb698..2714ce6 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -398,7 +398,9 @@ static int wacom_parse_hid(struct usb_interface *intf,
 				break;
 
 			case HID_USAGE_CONTACTMAX:
-				wacom_retrieve_report_data(intf, features);
+				/* leave touch_max as is if predefined */
+				if (!features->touch_max)
+					wacom_retrieve_report_data(intf, features);
 				i++;
 				break;
 			}
-- 
1.7.7.6

