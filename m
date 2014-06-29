From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: [PATCH] HID: cp2112: fix gpio value in gpio_direction_output
Date: Sun, 29 Jun 2014 14:13:48 +0800
Message-ID: <1404022428-2816-1-git-send-email-borneo.antonio@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, David Barksdale <dbarksdale@uplogix.com>
Cc: linux-kernel@vger.kernel.org, Antonio Borneo <borneo.antonio@gmail.com>
List-Id: linux-input@vger.kernel.org

CP2112 does not offer an atomic method to set both gpio
direction and value.
Also it does not permit to set gpio value before putting
gpio in output. In fact, accordingly to Silicon Labs
AN495, Rev. 0.2, cpt. 4.4, the HID report to set gpio
values "does not affect any pins that are not configured
as outputs".

This is confirmed on evaluation board CP2112-EK.
With current driver, after execute:
	echo in > /sys/class/gpio/gpio248/direction
	echo low > /sys/class/gpio/gpio248/direction
gpio output is still high. Only after a following
	echo low > /sys/class/gpio/gpio248/direction
gpio output gets low.

Fix driver by changing order of operations; first set
direction then set value.

The drawback of this new sequence is that we can have
a pulse on gpio pin when direction is changed from
input to output-low, but this cannot be avoided on
current CP2112.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
 drivers/hid/hid-cp2112.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 56be85a..3952d90 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -240,8 +240,6 @@ static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 	u8 buf[5];
 	int ret;
 
-	cp2112_gpio_set(chip, offset, value);
-
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
 				       sizeof(buf), HID_FEATURE_REPORT,
 				       HID_REQ_GET_REPORT);
@@ -260,6 +258,12 @@ static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 		return ret;
 	}
 
+	/*
+	 * Set gpio value when output direction is already set,
+	 * as specified in AN495, Rev. 0.2, cpt. 4.4
+	 */
+	cp2112_gpio_set(chip, offset, value);
+
 	return 0;
 }
 
-- 
2.0.1
