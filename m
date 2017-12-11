From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] HID: sony: Print reversed MAC address via %pMR
Date: Mon, 11 Dec 2017 15:06:12 +0200
Message-ID: <20171211130612.34715-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36544 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751956AbdLKNHP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Dec 2017 08:07:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reversed MAC addresses can be printed directly using %pMR specifier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-sony.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index b9dc3ac4d4aa..138fd44d3c91 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2399,10 +2399,7 @@ static int sony_check_add(struct sony_sc *sc)
 		memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
 
 		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
-			"%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
-			sc->mac_address[5], sc->mac_address[4],
-			sc->mac_address[3], sc->mac_address[2],
-			sc->mac_address[1], sc->mac_address[0]);
+			 "%pMR", sc->mac_address);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
 			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
 		buf = kmalloc(SIXAXIS_REPORT_0xF2_SIZE, GFP_KERNEL);
@@ -2432,10 +2429,7 @@ static int sony_check_add(struct sony_sc *sc)
 			sc->mac_address[5-n] = buf[4+n];
 
 		snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
-			"%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
-			sc->mac_address[5], sc->mac_address[4],
-			sc->mac_address[3], sc->mac_address[2],
-			sc->mac_address[1], sc->mac_address[0]);
+			 "%pMR", sc->mac_address);
 	} else {
 		return 0;
 	}
-- 
2.15.0

