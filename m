From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH] HID: wacom: Force new name for Wacom Intuos4 WL PTK-540WL
Date: Fri, 17 Feb 2012 17:47:10 +0000
Message-ID: <1329500830-16767-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:34077 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751410Ab2BQRr6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Feb 2012 12:47:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, pinglinux@gmail.com, peter.hutterer@who-t.net
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

The name reported by Inutos4 WL connected by bluetooth is "PTK-540WL" and
to make it consistent with other Wacom devices it has to be converted to
"Wacom Intuos4 WL". It also makes userland applications aware that it's
a Wacom device.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
---
 drivers/hid/hid-wacom.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index acab74c..0621047 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -518,6 +518,7 @@ static int wacom_probe(struct hid_device *hdev,
 		wacom_poke(hdev, 1);
 		break;
 	case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
+		sprintf(hdev->name, "%s", "Wacom Intuos4 WL");
 		wdata->features = 0;
 		wacom_set_features(hdev);
 		break;
-- 
1.7.6.4

