From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] HID: logitech: Handle 0 scroll events for the m560
Date: Wed, 20 Mar 2019 08:48:23 +1000
Message-ID: <20190319224823.GA26366@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Aimo =?iso-8859-1?Q?Mets=E4l=E4?= <aimetsal@outlook.com>, nlopezcasad@logitech.com, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

hidpp_scroll_counter_handle_scroll() doesn't expect a 0-value scroll event, it
gets interpreted as a negative scroll direction event. This can cause scroll
direction resets and thus broken scrolling.

Reported-and-tested-by: Aimo Metsälä <aimetsal@outlook.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/hid/hid-logitech-hidpp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 15ed6177a7a3..f040c8a7f9a9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2608,8 +2608,9 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		hidpp_scroll_counter_handle_scroll(
-				&hidpp->vertical_wheel_counter, v);
+		if (v != 0)
+			hidpp_scroll_counter_handle_scroll(
+					&hidpp->vertical_wheel_counter, v);
 
 		input_sync(mydata->input);
 	}
-- 
2.20.1
