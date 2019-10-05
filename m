From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH 5.4 regression fix] Input: soc_button_array - partial
 revert of support for newer surface devices
Date: Sat, 5 Oct 2019 14:17:29 +0200
Message-ID: <222c364a-bc2b-5960-3fe4-7d1ce222e3e2@gmail.com>
References: <20191005105551.353273-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191005105551.353273-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andy@infradead.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

sorry for the inconvenience this change has caused.

On 10/5/19 12:55 PM, Hans de Goede wrote:
> Note ideally this seamingly unrelated change would have been made in a
> separate commit, with a message explaining the what and why of this
> change.

Would I have known the impact, then yes. This change was added due to
some reported instances where it seems that soc_button_array would
occasionally load on MSHW0040 before the GPIO controller was ready,
causing power and volume buttons to not work.

> I guess this change may have been added to deal with -EPROBE_DEFER errors,

Correct. After a comment mentioned that gpiod_get() returning
-EPROBE_DEFER would be the proper way to detect this, I decided on this
change.

Might I suggest the following addition:

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
  drivers/input/misc/soc_button_array.c | 25 ++++++++++++++++++++-----
  1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 97e3639e99d0..a0f0c977b790 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -92,11 +92,18 @@ soc_button_device_create(struct platform_device *pdev,
  			continue;
  
  		gpio = soc_button_lookup_gpio(&pdev->dev, info->acpi_index);
-		if (gpio < 0 && gpio != -ENOENT) {
-			error = gpio;
-			goto err_free_mem;
-		} else if (!gpio_is_valid(gpio)) {
-			/* Skip GPIO if not present */
+		if (!gpio_is_valid(gpio)) {
+			/*
+			 * Skip GPIO if not present. Note we deliberately
+			 * ignore -EPROBE_DEFER errors here. On some devices
+			 * Intel is using so called virtual GPIOs which are not
+			 * GPIOs at all but some way for AML code to check some
+			 * random status bits without need a custom opregion.
+			 * In some cases the resources table we parse points to
+			 * such a virtual GPIO, since these are not real GPIOs
+			 * we do not have a driver for these so they will never
+			 * show up, therefor we ignore -EPROBE_DEFER.
+			 */
  			continue;
  		}
  
@@ -429,6 +436,14 @@ static int soc_device_check_MSHW0040(struct device *dev)
  
  	dev_dbg(dev, "OEM Platform Revision %llu\n", oem_platform_rev);
  
+	/*
+	 * Explicitly check if GPIO controller is ready. This check is done here
+	 * to avoid issues with virtual GPIOs on other chips, as elaborated above.
+	 * We are at least expecting one GPIO pin for the power button (index 0).
+	 */
+	if (soc_button_lookup_gpio(dev, 0) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
  	return 0;
  }
  
-- 
2.23.0
