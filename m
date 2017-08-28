From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH] HID: wacom: leds: Don't try to control the EKR's read-only LEDs
Date: Mon, 28 Aug 2017 14:15:39 -0700
Message-ID: <1503954939-23470-1-git-send-email-skomra@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, jkosina@suse.cz, benjamin.tissoires@redhat.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, "stable # 4 . 9" <stable@vger.kernel.org>, Aaron Armstrong Skomra <aaron.skomra@wacom.com>
List-Id: linux-input@vger.kernel.org

Commit a50aac7193f1 introduces 'led.groups' and adds EKR support
for these groups. However, unlike the other devices with LEDs,
the EKR's LEDs are read-only and we shouldn't attempt to control
them in wacom_led_control().

See bug: https://sourceforge.net/p/linuxwacom/bugs/342/

Fixes: a50aac7193f1 ("HID: wacom: leds: dynamically allocate LED groups")
Cc: stable <stable@vger.kernel.org>     # 4.9
Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 838c1ebfffa9..db1f64dcb9ba 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -766,6 +766,9 @@ static int wacom_led_control(struct wacom *wacom)
 	if (!wacom->led.groups)
 		return -ENOTSUPP;
 
+	if (wacom->wacom_wac.features.type == REMOTE)
+		return -ENOTSUPP;
+
 	if (wacom->wacom_wac.pid) { /* wireless connected */
 		report_id = WAC_CMD_WL_LED_CONTROL;
 		buf_size = 13;
-- 
2.7.4
