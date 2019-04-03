From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v8 05/11] mfd: core: document mfd_add_devices()
Date: Wed,  3 Apr 2019 11:01:02 +0200
Message-ID: <20190403090108.24788-6-brgl@bgdev.pl>
References: <20190403090108.24788-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403090108.24788-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a kernel doc for mfd_add_devices().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/mfd/mfd-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..1ade4c8cc91f 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -269,6 +269,19 @@ static int mfd_add_device(struct device *parent, int id,
 	return ret;
 }
 
+/**
+ * mfd_add_devices - register child devices
+ *
+ * @parent:	Pointer to parent device.
+ * @id:		Can be PLATFORM_DEVID_AUTO to let the Platform API take care
+ *		of device numbering, or will be added to a device's cell_id.
+ * @cells:	Array of (struct mfd_cell)s describing child devices.
+ * @n_devs:	Number of child devices to register.
+ * @mem_base:	Parent register range resource for child devices.
+ * @irq_base:	Base of the range of virtual interrupt numbers allocated for
+ *		this MFD device. Unused if @domain is specified.
+ * @domain:	Interrupt domain to create mappings for hardware interrupts.
+ */
 int mfd_add_devices(struct device *parent, int id,
 		    const struct mfd_cell *cells, int n_devs,
 		    struct resource *mem_base,
-- 
2.21.0
