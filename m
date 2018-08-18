From: Faisal Mehmood <f.m3hm00d@gmail.com>
Subject: [PATCH] hid: hid-logitech-hidpp: Fix spelling of 'length'
Date: Sat, 18 Aug 2018 23:21:59 +0500
Message-ID: <20180818182159.GA10389@Fulcrum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

'length' was misspelled as 'lenth'. Fixed it. It is a coding style
change which should have no impact on runtime execution of code.

Signed-off-by: Faisal Mehmood <f.m3hm00d@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19cc980eebce..b89c0f5b8895 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -81,7 +81,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
  * where as most newer devices use the FAP protocol. Both protocols are
  * compatible with the underlying transport, which could be usb, Unifiying, or
  * bluetooth. The message lengths are defined by the hid vendor specific report
- * descriptor for the HIDPP_SHORT report type (total message lenth 7 bytes) and
+ * descriptor for the HIDPP_SHORT report type (total message length 7 bytes) and
  * the HIDPP_LONG report type (total message length 20 bytes)
  *
  * The RAP protocol uses both report types, whereas the FAP only uses HIDPP_LONG
-- 
2.18.0
