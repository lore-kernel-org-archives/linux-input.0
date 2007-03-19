From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 5/7] usbhid: add hid_quirks modparam docs
Date: Sun, 18 Mar 2007 22:22:05 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703182043240.21893@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

From: Paul Walmsley <paul@booyaka.com>

Add basic documentation for the usbhid.hid_quirks module parameter.


Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  dev/Documentation/kernel-parameters.txt |    9 +++++++++
  1 file changed, 9 insertions(+)

Index: linux/dev/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/dev/Documentation/kernel-parameters.txt
+++ linux/dev/Documentation/kernel-parameters.txt
@@ -1786,6 +1786,15 @@ and is between 256 and 4096 characters.
  	usbhid.mousepoll=
  			[USBHID] The interval which mice are to be polled at.

+	usbhid.hid_quirks=
+			[USBHID] Add, modify, or remove USB HID device quirks.
+			The format is one or more comma-separated strings of
+			vendorID:productID:productMask:quirks format; e.g.,
+			"usbhid.hid_quirks=0xcd4:0x1:0xffff:0x4" will add
+			a quirk 0x4 (or replace an existing quirk) for
+			vendor 0xcd4 product 0x1.  Multiple product IDs can be
+			covered by using other values for the product mask.
+
  	vdso=		[IA-32,SH]
  			vdso=1: enable VDSO (default)
  			vdso=0: disable VDSO mapping
