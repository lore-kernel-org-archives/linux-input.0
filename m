From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: wacom: fix Bamboo ONE oops
Date: Fri, 25 Mar 2016 15:26:55 +0100
Message-ID: <1458916015-27658-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbcCYO1A (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2016 10:27:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Looks like recent changes in the Wacom driver made the Bamboo ONE crashes.
The tablet behaves as if it was a regular Bamboo device with pen, touch
and pad, but there is no physical pad connected to it.
The weird part is that the pad is still sending events and given that
there is no input node connected to it, we get  anull pointer exception.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1317116

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Hi Jiri,

This fixes the oopses we saw on the Bamboo ONE.
The fedora user is fine, and it appears the sourceforge user too, as the
problems were due to misconfigurations on his end.

Cheers,
Benjamin

 drivers/hid/wacom_wac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bd198bb..02c4efe 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2426,6 +2426,17 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 	}
 
 	/*
+	 * Hack for the Bamboo One:
+	 * the device presents a PAD/Touch interface as most Bamboos and even
+	 * sends ghosts PAD data on it. However, later, we must disable this
+	 * ghost interface, and we can not detect it unless we set it here
+	 * to WACOM_DEVICETYPE_PAD or WACOM_DEVICETYPE_TOUCH.
+	 */
+	if (features->type == BAMBOO_PEN &&
+	    features->pktlen == WACOM_PKGLEN_BBTOUCH3)
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+
+	/*
 	 * Raw Wacom-mode pen and touch events both come from interface
 	 * 0, whose HID descriptor has an application usage of 0xFF0D
 	 * (i.e., WACOM_VENDORDEFINED_PEN). We route pen packets back
-- 
2.5.0

