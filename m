From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] HID: quirks: make array hid_quirks static
Date: Mon,  4 Dec 2017 11:19:10 +0000
Message-ID: <20171204111910.2840-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43942 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdLDLTO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 4 Dec 2017 06:19:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Array hid_quirks is local to the source and does not need to be in
global scope, so make it static.

Cleans up sparse warning:
drivers/hid/hid-quirks.c:29:28: warning: symbol 'hid_quirks' was not
declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 1cf1e9a0d699..627efb74d1e4 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -26,7 +26,7 @@
  * Alphabetically sorted by vendor then product.
  */
 
-const struct hid_device_id hid_quirks[] = {
+static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016), HID_QUIRK_FULLSPEED_INTERVAL },
-- 
2.14.1

