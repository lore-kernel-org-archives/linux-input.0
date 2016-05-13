From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/6] Input - soc_button_array: make sure one GPIO is not assigned twice
Date: Fri, 13 May 2016 18:05:51 +0200
Message-ID: <1463155554-11747-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>
List-Id: linux-input@vger.kernel.org

The Surface 3 declares twice the GPIO as GpioInt and GpioIo in its
ACPI table. Given that we do not keep the gpiod around, but the actual
number associated to, there is a chance while enumerating the GPIOs that
one gets assigned twice. Make sure a previous button has not been mapped
already to the current button to prevent such failure.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
changes in v2:
- no changes

 drivers/input/misc/soc_button_array.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 5467d04..cb5cce3 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -77,7 +77,7 @@ soc_button_device_create(struct platform_device *pdev,
 	struct gpio_keys_platform_data *gpio_keys_pdata;
 	int n_buttons = 0;
 	int gpio;
-	int error;
+	int i, error;
 
 	gpio_keys_pdata = devm_kzalloc(&pdev->dev,
 				       sizeof(*gpio_keys_pdata) +
@@ -96,6 +96,13 @@ soc_button_device_create(struct platform_device *pdev,
 		if (!gpio_is_valid(gpio))
 			continue;
 
+		for (i = 0; i < n_buttons; i++) {
+			if (gpio_keys[i].gpio == gpio)
+				break;
+		}
+		if (i < n_buttons)
+			continue; /* the GPIO has already been assigned */
+
 		gpio_keys[n_buttons].type = info->event_type;
 		gpio_keys[n_buttons].code = info->event_code;
 		gpio_keys[n_buttons].gpio = gpio;
-- 
2.5.0
