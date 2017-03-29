From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv5] mfd: cpcap: implement irq sense helper
Date: Wed, 29 Mar 2017 14:18:20 +0200
Message-ID: <20170329121820.14237-1-sre@kernel.org>
References: <20170329080423.ijbl4seczla2s4nm@dell>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170329080423.ijbl4seczla2s4nm@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

CPCAP can sense if IRQ is currently set or not. This
functionality is required for a few subdevices, such
as the power button and usb phy modules.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Changes since PATCHv3:
 - add extern to function definition
 - use BIT macro for mask variable
 - avoid magic numbers
Changes since PATCHv4:
 - rename base to irq_base
---
 drivers/mfd/motorola-cpcap.c       | 28 ++++++++++++++++++++++++++++
 include/linux/mfd/motorola-cpcap.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 6aeada7d7ce5..a9097efcefa5 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -23,6 +23,8 @@
 
 #define CPCAP_NR_IRQ_REG_BANKS	6
 #define CPCAP_NR_IRQ_CHIPS	3
+#define CPCAP_REGISTER_SIZE	4
+#define CPCAP_REGISTER_BITS	16
 
 struct cpcap_ddata {
 	struct spi_device *spi;
@@ -32,6 +34,32 @@ struct cpcap_ddata {
 	struct regmap *regmap;
 };
 
+static int cpcap_sense_irq(struct regmap *regmap, int irq)
+{
+	int regnum = irq / CPCAP_REGISTER_BITS;
+	int mask = BIT(irq % CPCAP_REGISTER_BITS);
+	int reg = CPCAP_REG_INTS1 + (regnum * CPCAP_REGISTER_SIZE);
+	int err, val;
+
+	if (reg < CPCAP_REG_INTS1 || reg > CPCAP_REG_INTS4)
+		return -EINVAL;
+
+	err = regmap_read(regmap, reg, &val);
+	if (err)
+		return err;
+
+	return !!(val & mask);
+}
+
+int cpcap_sense_virq(struct regmap *regmap, int virq)
+{
+	struct regmap_irq_chip_data *d = irq_get_chip_data(virq);
+	int irq_base = regmap_irq_chip_get_base(d);
+
+	return cpcap_sense_irq(regmap, virq - irq_base);
+}
+EXPORT_SYMBOL_GPL(cpcap_sense_virq);
+
 static int cpcap_check_revision(struct cpcap_ddata *cpcap)
 {
 	u16 vendor, rev;
diff --git a/include/linux/mfd/motorola-cpcap.h b/include/linux/mfd/motorola-cpcap.h
index b4031c2b2214..793aa695faa0 100644
--- a/include/linux/mfd/motorola-cpcap.h
+++ b/include/linux/mfd/motorola-cpcap.h
@@ -290,3 +290,5 @@ static inline int cpcap_get_vendor(struct device *dev,
 
 	return 0;
 }
+
+extern int cpcap_sense_virq(struct regmap *regmap, int virq);
-- 
2.11.0
