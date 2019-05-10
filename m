From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: logitech-dj: make const array template static
Date: Fri, 10 May 2019 14:10:39 +0100
Message-ID: <20190510131039.4675-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array template  on the stack but instead make it
static. Makes the object code smaller by 10 bytes. Also reformat
the declaration.

Before:
   text	   data	    bss	    dec	    hex	filename
  29376	   9360	    128	  38864	   97d0	drivers/hid/hid-logitech-dj.o

After:
   text	   data	    bss	    dec	    hex	filename
  29270	   9456	    128	  38854	   97c6	drivers/hid/hid-logitech-dj.o

(gcc version 8.3.0, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-logitech-dj.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index b1e894618eed..72d0ab05401f 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1111,12 +1111,14 @@ static int logi_dj_recv_send_report(struct dj_receiver_dev *djrcv_dev,
 
 static int logi_dj_recv_query_hidpp_devices(struct dj_receiver_dev *djrcv_dev)
 {
-	const u8 template[] = {REPORT_ID_HIDPP_SHORT,
-			       HIDPP_RECEIVER_INDEX,
-			       HIDPP_SET_REGISTER,
-			       HIDPP_REG_CONNECTION_STATE,
-			       HIDPP_FAKE_DEVICE_ARRIVAL,
-			       0x00, 0x00};
+	static const u8 template[] = {
+		REPORT_ID_HIDPP_SHORT,
+		HIDPP_RECEIVER_INDEX,
+		HIDPP_SET_REGISTER,
+		HIDPP_REG_CONNECTION_STATE,
+		HIDPP_FAKE_DEVICE_ARRIVAL,
+		0x00, 0x00
+	};
 	u8 *hidpp_report;
 	int retval;
 
-- 
2.20.1
