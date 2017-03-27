From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 03/19] HID: logitech-hidpp: make sure we only register one battery per device
Date: Mon, 27 Mar 2017 16:59:23 +0200
Message-ID: <20170327145939.29824-4-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753573AbdC0PAk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:40 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Simple check to add, huge improvement :)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4aaf237..1cda29e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -828,6 +828,9 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 {
 	int ret;
 
+	if (hidpp->battery.ps)
+		return 0;
+
 	if (hidpp->protocol_major >= 2) {
 		ret = hidpp20_initialize_battery(hidpp);
 		if (ret == 0)
-- 
2.9.3

