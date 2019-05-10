From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: logitech-hidpp: HID: make const array consumer_rdesc_start static
Date: Fri, 10 May 2019 14:17:22 +0100
Message-ID: <20190510131722.5023-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array consumer_rdesc_start on the stack but instead
make it static. Makes the object code smaller by 88 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  59155	   9840	    448	  69443	  10f43	drivers/hid/hid-logitech-hidpp.o

After:
   text	   data	    bss	    dec	    hex	filename
  59003	   9904	    448	  69355	  10eeb	drivers/hid/hid-logitech-hidpp.o

(gcc version 8.3.0, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 72fc9c0566db..df960491e473 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2862,7 +2862,7 @@ static u8 *hidpp10_consumer_keys_report_fixup(struct hidpp_device *hidpp,
 					      u8 *_rdesc, unsigned int *rsize)
 {
 	/* Note 0 terminated so we can use strnstr to search for this. */
-	const char consumer_rdesc_start[] = {
+	static const char consumer_rdesc_start[] = {
 		0x05, 0x0C,	/* USAGE_PAGE (Consumer Devices)       */
 		0x09, 0x01,	/* USAGE (Consumer Control)            */
 		0xA1, 0x01,	/* COLLECTION (Application)            */
-- 
2.20.1
