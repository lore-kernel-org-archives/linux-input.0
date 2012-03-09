From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 1/2] HID: wacom: Reset stylus buttons - Intuos4 WL
Date: Fri,  9 Mar 2012 13:20:51 +0000
Message-ID: <1331299252-23699-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:34103 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752101Ab2CINVZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Mar 2012 08:21:25 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, pinglinux@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net
Cc: Przemo Firszt <przemo@firszt.eu>

Stylus buttons have to be resetted when going out-of-prox.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 2a440a6..5c25036 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -352,6 +352,8 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
 	case 0x80: /* Out of proximity report */
 		input_report_key(input, BTN_TOUCH, 0);
 		input_report_abs(input, ABS_PRESSURE, 0);
+		input_report_key(input, BTN_STYLUS, 0);
+		input_report_key(input, BTN_STYLUS2, 0);
 		input_report_key(input, wdata->tool, 0);
 		input_report_abs(input, ABS_MISC, 0);
 		input_event(input, EV_MSC, MSC_SERIAL, wdata->serial);
-- 
1.7.6.4

