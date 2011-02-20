From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 2/2] bt hidp: send Output reports using SET_REPORT on the Control channel
Date: Sun, 20 Feb 2011 18:26:46 +0100
Message-ID: <1298222806-19433-3-git-send-email-ospite@studenti.unina.it>
References: <alpine.LNX.2.00.1102180944590.2160@pobox.suse.cz>
 <1298222806-19433-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:43340 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab1BTR1I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Feb 2011 12:27:08 -0500
In-Reply-To: <1298222806-19433-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-bluetooth@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <padovan@profusion.mobi>, Bastien Nocera <hadess@hadess.net>, Alan Ott <alan@signal11.us>, Jim Paris <jim@jtan.com>, "pascal@pabr.org" <pascal@pabr.org>

The current implementation of hidp_output_raw_report() relies only on
the Control channel even for Output reports, and the BT HID
specification [1] does not mention using the DATA message for Output
reports on the Control channel (see section 7.9.1 and also Figure 11:
SET_ Flow Chart), so let us just use SET_REPORT.

This also fixes sending Output reports to some devices (like Sony
Sixaxis) which are not able to handle DATA messages on the Control
channel.

Ideally hidp_output_raw_report() could be improved to use this scheme:
  Feature Report -- SET_REPORT on the Control channel
  Output Report  -- DATA on the Interrupt channel
for more efficiency, but as said above, right now only the Control
channel is used.

[1] http://www.bluetooth.com/Specification%20Documents/HID_SPEC_V10.pdf

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 net/bluetooth/hidp/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 6df8ea1..3c036b0 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -405,7 +405,7 @@ static int hidp_output_raw_report(struct hid_device *hid, unsigned char *data, s
 		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_FEATURE;
 		break;
 	case HID_OUTPUT_REPORT:
-		report_type = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
+		report_type = HIDP_TRANS_SET_REPORT | HIDP_DATA_RTYPE_OUPUT;
 		break;
 	default:
 		return -EINVAL;
-- 
1.7.4.1

