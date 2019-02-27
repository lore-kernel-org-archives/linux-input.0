From: Louis Taylor <louis@kragniz.eu>
Subject: [PATCH v2] HID: quirks: use correct format chars in dbg_hid
Date: Wed, 27 Feb 2019 11:07:20 +0000
Message-ID: <20190227110720.27329-1-louis@kragniz.eu>
References: <20190226234853.20441-1-louis@kragniz.eu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226234853.20441-1-louis@kragniz.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, ndesaulniers@google.com, Louis Taylor <louis@kragniz.eu>
List-Id: linux-input@vger.kernel.org

When building with -Wformat, clang warns:

drivers/hid/hid-quirks.c:1075:27: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  bl_entry->driver_data, bl_entry->vendor,
					 ^~~~~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1076:4: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  bl_entry->product);
		  ^~~~~~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1242:12: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  quirks, hdev->vendor, hdev->product);
			  ^~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
drivers/hid/hid-quirks.c:1242:26: warning: format specifies type
'unsigned short' but the argument has type '__u32' (aka 'unsigned int')
[-Wformat]
		  quirks, hdev->vendor, hdev->product);
					^~~~~~~~~~~~~
./include/linux/hid.h:1170:48: note: expanded from macro 'dbg_hid'
	  printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);      \
				   ~~~~~~              ^~~
4 warnings generated.

This patch fixes the format strings to use the correct format type for unsigned
ints.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Louis Taylor <louis@kragniz.eu>
---

v2: change format string to use %04x instead of %x

 drivers/hid/hid-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 94088c0ed68a..b608a57b7908 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -1071,7 +1071,7 @@ static struct hid_device_id *hid_exists_dquirk(const struct hid_device *hdev)
 	}
 
 	if (bl_entry != NULL)
-		dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%hx:0x%hx\n",
+		dbg_hid("Found dynamic quirk 0x%lx for HID device 0x%04x:0x%04x\n",
 			bl_entry->driver_data, bl_entry->vendor,
 			bl_entry->product);
 
@@ -1238,7 +1238,7 @@ static unsigned long hid_gets_squirk(const struct hid_device *hdev)
 		quirks |= bl_entry->driver_data;
 
 	if (quirks)
-		dbg_hid("Found squirk 0x%lx for HID device 0x%hx:0x%hx\n",
+		dbg_hid("Found squirk 0x%lx for HID device 0x%04x:0x%04x\n",
 			quirks, hdev->vendor, hdev->product);
 	return quirks;
 }
-- 
2.20.1
