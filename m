From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] HID: asus: fix build warning wiht CONFIG_ASUS_WMI disabled
Date: Fri,  2 Nov 2018 16:14:32 +0100
Message-ID: <20181102151443.758229-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Colin Ian King <colin.king@canonical.com>, Peter Hutterer <peter.hutterer@who-t.net>, Mustafa Kuscu <mustafakuscu@gmail.com>, Daniel Drake <drake@endlessm.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

asus_wmi_evaluate_method() is an empty dummy function when CONFIG_ASUS_WMI
is disabled, or not reachable from a built-in device driver. This leads to
a theoretical evaluation of an uninitialized variable that the compiler
complains about, failing to check that the hardcoded return value makes
this an unreachable code path:

In file included from include/linux/printk.h:336,
                 from include/linux/kernel.h:14,
                 from include/linux/list.h:9,
                 from include/linux/dmi.h:5,
                 from drivers/hid/hid-asus.c:29:
drivers/hid/hid-asus.c: In function 'asus_input_configured':
include/linux/dynamic_debug.h:135:3: error: 'value' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   __dynamic_dev_dbg(&descriptor, dev, fmt, \
   ^~~~~~~~~~~~~~~~~
drivers/hid/hid-asus.c:359:6: note: 'value' was declared here
  u32 value;
      ^~~~~

With an extra IS_ENABLED() check, the warning goes away.

Fixes: 3b692c55e58d ("HID: asus: only support backlight when it's not driven by WMI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/hid-asus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index dc6d6477e961..a1fa2fc8c9b5 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -359,6 +359,9 @@ static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
 	u32 value;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_ASUS_WMI))
+		return false;
+
 	ret = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS2,
 				       ASUS_WMI_DEVID_KBD_BACKLIGHT, 0, &value);
 	hid_dbg(hdev, "WMI backlight check: rc %d value %x", ret, value);
-- 
2.18.0
