From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2] hid: remove duplicate ID for D-WAV eGalax 0x7224
Date: Tue,  7 May 2013 17:38:13 +0300
Message-ID: <1367937493-16844-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: =?ISO-8859-1?Q?=20<1367936944-1624?= =?ISO-8859-1?Q?9-2-git-send-ema?=
	=?ISO-8859-1?Q?il-andriy.shevch?= =?ISO-8859-1?Q?enko@linux.intel?=
	=?ISO-8859-1?Q?.com=1B[B=1B[B=1B[B>?=
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39893 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab3EGOiX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 May 2013 10:38:23 -0400
In-Reply-To: =?ISO-8859-1?Q?=20<1367936944-1624?= =?ISO-8859-1?Q?9-2-git-send-ema?=
	=?ISO-8859-1?Q?il-andriy.shevch?= =?ISO-8859-1?Q?enko@linux.intel?=
	=?ISO-8859-1?Q?.com=1B[B=1B[B=1B[B>?=
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-ids.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2378a0b..a5520ba 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -268,7 +268,6 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
-#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
-- 
1.8.2.rc0.22.gb3600c3

