From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v6 05/11] mfd: core: document mfd_add_devices()
Date: Mon, 18 Mar 2019 18:42:22 +0100
Message-ID: <20190318174228.18194-6-brgl@bgdev.pl>
References: <20190318174228.18194-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318174228.18194-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a kernel doc for mfd_add_devices().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mfd/mfd-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 94e3f32ce935..0898a8db1747 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -269,6 +269,20 @@ static int mfd_add_device(struct device *parent, int id,
 	return ret;
 }
 
+/**
+ * mfd_add_devices - register a set of child devices
+ *
+ * @parent: Parent device for all sub-nodes.
+ * @id: Platform device id. If >= 0, each sub-device will have its cell_id
+ *      added to this number and use it as the platform device id.
+ * @cells: Array of mfd cells describing sub-devices.
+ * @n_devs: Number of sub-devices to register.
+ * @mem_base: Parent register range resource for sub-devices.
+ * @irq_base: Base of the range of virtual interrupt numbers allocated for
+ *            this MFD device. Unused if @domain is specified.
+ * @domain: Interrupt domain used to create mappings for HW interrupt numbers
+ *          specificed in sub-devices' IRQ resources.
+ */
 int mfd_add_devices(struct device *parent, int id,
 		    const struct mfd_cell *cells, int n_devs,
 		    struct resource *mem_base,
-- 
2.20.1
