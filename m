From: <michael.hennerich@analog.com>
Subject: [PATCH RESEND] input: keyboard: adp5589-keys: Add support for the ADP5585 derivatives
Date: Thu, 13 Oct 2011 08:18:46 +0200
Message-ID: <1318486726-6425-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:40871
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918Ab1JMGSc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 02:18:32 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The ADP5585 family keypad decoder and IO expander is similar to the ADP5589,
however it features less IO pins, and lacks hardware assisted key-lock
functionality. Unfortunately the register addresses are different, as well as
the event codes and bit organization within the port related registers.

Move ADP5589 Register defines from the header file into the main source file.
Add new defines while making sure we don't break existing platform_data.
Add register address translation, and turn device specific defines into variables.
Introduce some helper functions and disable functions that doesn't
exist on the added devices.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/keyboard/Kconfig        |    4 +-
 drivers/input/keyboard/adp5589-keys.c |  607 ++++++++++++++++++++++++++-------
 include/linux/input/adp5589.h         |  157 ++++-----
 3 files changed, 549 insertions(+), 219 deletions(-)

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index b4dee9d..b00574c 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -33,10 +33,10 @@ config KEYBOARD_ADP5588
 	  module will be called adp5588-keys.

 config KEYBOARD_ADP5589
-	tristate "ADP5589 I2C QWERTY Keypad and IO Expander"
+	tristate "ADP5589 ADP5585 I2C QWERTY Keypad and IO Expander"
 	depends on I2C
 	help
-	  Say Y here if you want to use a ADP5589 attached to your
+	  Say Y here if you want to use a ADP5589/ADP5585 attached to your
 	  system I2C bus.

 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/input/keyboard/adp5589-keys.c b/drivers/input/keyboard/adp5589-keys.c
index c770826..e610653 100644
--- a/drivers/input/keyboard/adp5589-keys.c
+++ b/drivers/input/keyboard/adp5589-keys.c
@@ -1,5 +1,5 @@
 /*
- * Description:  keypad driver for ADP5589
+ * Description:  keypad driver for ADP5589, ADP5585
  *		 I2C QWERTY Keypad and IO Expander
  * Bugs: Enter bugs at http://blackfin.uclinux.org/
  *
@@ -22,35 +22,165 @@

 #include <linux/input/adp5589.h>

+/* ADP5589/ADP5585 Common Registers */
+#define ADP5589_5_ID			0x00
+#define ADP5589_5_INT_STATUS		0x01
+#define ADP5589_5_STATUS		0x02
+#define ADP5589_5_FIFO_1		0x03
+#define ADP5589_5_FIFO_2		0x04
+#define ADP5589_5_FIFO_3		0x05
+#define ADP5589_5_FIFO_4		0x06
+#define ADP5589_5_FIFO_5		0x07
+#define ADP5589_5_FIFO_6		0x08
+#define ADP5589_5_FIFO_7		0x09
+#define ADP5589_5_FIFO_8		0x0A
+#define ADP5589_5_FIFO_9		0x0B
+#define ADP5589_5_FIFO_10		0x0C
+#define ADP5589_5_FIFO_11		0x0D
+#define ADP5589_5_FIFO_12		0x0E
+#define ADP5589_5_FIFO_13		0x0F
+#define ADP5589_5_FIFO_14		0x10
+#define ADP5589_5_FIFO_15		0x11
+#define ADP5589_5_FIFO_16		0x12
+#define ADP5589_5_GPI_INT_STAT_A	0x13
+#define ADP5589_5_GPI_INT_STAT_B	0x14
+
+/* ADP5589 Registers */
+#define ADP5589_GPI_INT_STAT_C		0x15
+#define ADP5589_GPI_STATUS_A		0x16
+#define ADP5589_GPI_STATUS_B		0x17
+#define ADP5589_GPI_STATUS_C		0x18
+#define ADP5589_RPULL_CONFIG_A		0x19
+#define ADP5589_RPULL_CONFIG_B		0x1A
+#define ADP5589_RPULL_CONFIG_C		0x1B
+#define ADP5589_RPULL_CONFIG_D		0x1C
+#define ADP5589_RPULL_CONFIG_E		0x1D
+#define ADP5589_GPI_INT_LEVEL_A		0x1E
+#define ADP5589_GPI_INT_LEVEL_B		0x1F
+#define ADP5589_GPI_INT_LEVEL_C		0x20
+#define ADP5589_GPI_EVENT_EN_A		0x21
+#define ADP5589_GPI_EVENT_EN_B		0x22
+#define ADP5589_GPI_EVENT_EN_C		0x23
+#define ADP5589_GPI_INTERRUPT_EN_A	0x24
+#define ADP5589_GPI_INTERRUPT_EN_B	0x25
+#define ADP5589_GPI_INTERRUPT_EN_C	0x26
+#define ADP5589_DEBOUNCE_DIS_A		0x27
+#define ADP5589_DEBOUNCE_DIS_B		0x28
+#define ADP5589_DEBOUNCE_DIS_C		0x29
+#define ADP5589_GPO_DATA_OUT_A		0x2A
+#define ADP5589_GPO_DATA_OUT_B		0x2B
+#define ADP5589_GPO_DATA_OUT_C		0x2C
+#define ADP5589_GPO_OUT_MODE_A		0x2D
+#define ADP5589_GPO_OUT_MODE_B		0x2E
+#define ADP5589_GPO_OUT_MODE_C		0x2F
+#define ADP5589_GPIO_DIRECTION_A	0x30
+#define ADP5589_GPIO_DIRECTION_B	0x31
+#define ADP5589_GPIO_DIRECTION_C	0x32
+#define ADP5589_UNLOCK1			0x33
+#define ADP5589_UNLOCK2			0x34
+#define ADP5589_EXT_LOCK_EVENT		0x35
+#define ADP5589_UNLOCK_TIMERS		0x36
+#define ADP5589_LOCK_CFG		0x37
+#define ADP5589_RESET1_EVENT_A		0x38
+#define ADP5589_RESET1_EVENT_B		0x39
+#define ADP5589_RESET1_EVENT_C		0x3A
+#define ADP5589_RESET2_EVENT_A		0x3B
+#define ADP5589_RESET2_EVENT_B		0x3C
+#define ADP5589_RESET_CFG		0x3D
+#define ADP5589_PWM_OFFT_LOW		0x3E
+#define ADP5589_PWM_OFFT_HIGH		0x3F
+#define ADP5589_PWM_ONT_LOW		0x40
+#define ADP5589_PWM_ONT_HIGH		0x41
+#define ADP5589_PWM_CFG			0x42
+#define ADP5589_CLOCK_DIV_CFG		0x43
+#define ADP5589_LOGIC_1_CFG		0x44
+#define ADP5589_LOGIC_2_CFG		0x45
+#define ADP5589_LOGIC_FF_CFG		0x46
+#define ADP5589_LOGIC_INT_EVENT_EN	0x47
+#define ADP5589_POLL_PTIME_CFG		0x48
+#define ADP5589_PIN_CONFIG_A		0x49
+#define ADP5589_PIN_CONFIG_B		0x4A
+#define ADP5589_PIN_CONFIG_C		0x4B
+#define ADP5589_PIN_CONFIG_D		0x4C
+#define ADP5589_GENERAL_CFG		0x4D
+#define ADP5589_INT_EN			0x4E
+
+/* ADP5585 Registers */
+#define ADP5585_GPI_STATUS_A		0x15
+#define ADP5585_GPI_STATUS_B		0x16
+#define ADP5585_RPULL_CONFIG_A		0x17
+#define ADP5585_RPULL_CONFIG_B		0x18
+#define ADP5585_RPULL_CONFIG_C		0x19
+#define ADP5585_RPULL_CONFIG_D		0x1A
+#define ADP5585_GPI_INT_LEVEL_A		0x1B
+#define ADP5585_GPI_INT_LEVEL_B		0x1C
+#define ADP5585_GPI_EVENT_EN_A		0x1D
+#define ADP5585_GPI_EVENT_EN_B		0x1E
+#define ADP5585_GPI_INTERRUPT_EN_A	0x1F
+#define ADP5585_GPI_INTERRUPT_EN_B	0x20
+#define ADP5585_DEBOUNCE_DIS_A		0x21
+#define ADP5585_DEBOUNCE_DIS_B		0x22
+#define ADP5585_GPO_DATA_OUT_A		0x23
+#define ADP5585_GPO_DATA_OUT_B		0x24
+#define ADP5585_GPO_OUT_MODE_A		0x25
+#define ADP5585_GPO_OUT_MODE_B		0x26
+#define ADP5585_GPIO_DIRECTION_A	0x27
+#define ADP5585_GPIO_DIRECTION_B	0x28
+#define ADP5585_RESET1_EVENT_A		0x29
+#define ADP5585_RESET1_EVENT_B		0x2A
+#define ADP5585_RESET1_EVENT_C		0x2B
+#define ADP5585_RESET2_EVENT_A		0x2C
+#define ADP5585_RESET2_EVENT_B		0x2D
+#define ADP5585_RESET_CFG		0x2E
+#define ADP5585_PWM_OFFT_LOW		0x2F
+#define ADP5585_PWM_OFFT_HIGH		0x30
+#define ADP5585_PWM_ONT_LOW		0x31
+#define ADP5585_PWM_ONT_HIGH		0x32
+#define ADP5585_PWM_CFG			0x33
+#define ADP5585_LOGIC_CFG		0x34
+#define ADP5585_LOGIC_FF_CFG		0x35
+#define ADP5585_LOGIC_INT_EVENT_EN	0x36
+#define ADP5585_POLL_PTIME_CFG		0x37
+#define ADP5585_PIN_CONFIG_A		0x38
+#define ADP5585_PIN_CONFIG_B		0x39
+#define ADP5585_PIN_CONFIG_D		0x3A
+#define ADP5585_GENERAL_CFG		0x3B
+#define ADP5585_INT_EN			0x3C
+
+/* ID Register */
+#define ADP5589_5_DEVICE_ID_MASK	0xF
+#define ADP5589_5_MAN_ID_MASK		0xF
+#define ADP5589_5_MAN_ID_SHIFT		4
+#define ADP5589_5_MAN_ID		0x02
+
 /* GENERAL_CFG Register */
 #define OSC_EN		(1 << 7)
 #define CORE_CLK(x)	(((x) & 0x3) << 5)
-#define LCK_TRK_LOGIC	(1 << 4)
-#define LCK_TRK_GPI	(1 << 3)
+#define LCK_TRK_LOGIC	(1 << 4)	/* ADP5589 only */
+#define LCK_TRK_GPI	(1 << 3)	/* ADP5589 only */
 #define INT_CFG		(1 << 1)
 #define RST_CFG		(1 << 0)

 /* INT_EN Register */
-#define LOGIC2_IEN	(1 << 5)
+#define LOGIC2_IEN	(1 << 5)	/* ADP5589 only */
 #define LOGIC1_IEN	(1 << 4)
-#define LOCK_IEN	(1 << 3)
+#define LOCK_IEN	(1 << 3)	/* ADP5589 only */
 #define OVRFLOW_IEN	(1 << 2)
 #define GPI_IEN		(1 << 1)
 #define EVENT_IEN	(1 << 0)

 /* Interrupt Status Register */
-#define LOGIC2_INT	(1 << 5)
+#define LOGIC2_INT	(1 << 5)	/* ADP5589 only */
 #define LOGIC1_INT	(1 << 4)
-#define LOCK_INT	(1 << 3)
+#define LOCK_INT	(1 << 3)	/* ADP5589 only */
 #define OVRFLOW_INT	(1 << 2)
 #define GPI_INT		(1 << 1)
 #define EVENT_INT	(1 << 0)

 /* STATUS Register */
-
-#define LOGIC2_STAT	(1 << 7)
+#define LOGIC2_STAT	(1 << 7)	/* ADP5589 only */
 #define LOGIC1_STAT	(1 << 6)
-#define LOCK_STAT	(1 << 5)
+#define LOCK_STAT	(1 << 5)	/* ADP5589 only */
 #define KEC		0xF

 /* PIN_CONFIG_D Register */
@@ -61,27 +191,54 @@
 #define LOCK_EN		(1 << 0)

 #define PTIME_MASK	0x3
-#define LTIME_MASK	0x3
+#define LTIME_MASK	0x3		/* ADP5589 only */

 /* Key Event Register xy */
 #define KEY_EV_PRESSED		(1 << 7)
 #define KEY_EV_MASK		(0x7F)

 #define KEYP_MAX_EVENT		16
+#define ADP5589_MAXGPIO		19
+#define ADP5585_MAXGPIO		11 /* 10 on the ADP5585-01, 11 on ADP5585-02 */

-#define MAXGPIO			19
-#define ADP_BANK(offs)		((offs) >> 3)
-#define ADP_BIT(offs)		(1u << ((offs) & 0x7))
+enum {
+	ADP5589,
+	ADP5585_01,
+	ADP5585_02
+};
+
+struct adp_constants {
+	u8 maxgpio;
+	u8 keymapsize;
+	u8 gpi_pin_row_base;
+	u8 gpi_pin_row_end;
+	u8 gpi_pin_col_base;
+	u8 gpi_pin_base;
+	u8 gpi_pin_end;
+	u8 gpimapsize_max;
+	u8 max_row_num;
+	u8 max_col_num;
+	u8 row_mask;
+	u8 col_mask;
+	u8 col_shift;
+	u8 c4_extend_cfg;
+	u8 (*bank) (u8 offset);
+	u8 (*bit) (u8 offset);
+	u8 (*reg) (u8 reg);
+};

 struct adp5589_kpad {
 	struct i2c_client *client;
 	struct input_dev *input;
+	const struct adp_constants *var;
 	unsigned short keycode[ADP5589_KEYMAPSIZE];
 	const struct adp5589_gpi_map *gpimap;
 	unsigned short gpimapsize;
 	unsigned extend_cfg;
+	bool is_adp5585;
+	bool adp5585_support_row5;
 #ifdef CONFIG_GPIOLIB
-	unsigned char gpiomap[MAXGPIO];
+	unsigned char gpiomap[ADP5589_MAXGPIO];
 	bool export_gpio;
 	struct gpio_chip gc;
 	struct mutex gpio_lock;	/* Protect cached dir, dat_out */
@@ -90,6 +247,129 @@ struct adp5589_kpad {
 #endif
 };

+/*
+ *  ADP5589 / ADP5585 derivative / varinat handling
+ */
+
+
+/* ADP5589 */
+
+static unsigned char adp5589_bank(unsigned char offset)
+{
+	return offset >> 3;
+}
+
+static unsigned char adp5589_bit(unsigned char offset)
+{
+	return 1u << (offset & 0x7);
+}
+
+static unsigned char adp5589_reg(unsigned char reg)
+{
+	return reg;
+}
+
+static const struct adp_constants const_adp5589 = {
+	.maxgpio		= ADP5589_MAXGPIO,
+	.keymapsize		= ADP5589_KEYMAPSIZE,
+	.gpi_pin_row_base	= ADP5589_GPI_PIN_ROW_BASE,
+	.gpi_pin_row_end	= ADP5589_GPI_PIN_ROW_END,
+	.gpi_pin_col_base	= ADP5589_GPI_PIN_COL_BASE,
+	.gpi_pin_base		= ADP5589_GPI_PIN_BASE,
+	.gpi_pin_end		= ADP5589_GPI_PIN_END,
+	.gpimapsize_max		= ADP5589_GPIMAPSIZE_MAX,
+	.c4_extend_cfg		= 12,
+	.max_row_num		= ADP5589_MAX_ROW_NUM,
+	.max_col_num		= ADP5589_MAX_COL_NUM,
+	.row_mask		= ADP5589_ROW_MASK,
+	.col_mask		= ADP5589_COL_MASK,
+	.col_shift		= ADP5589_COL_SHIFT,
+	.bank			= adp5589_bank,
+	.bit			= adp5589_bit,
+	.reg			= adp5589_reg,
+};
+
+/* ADP5585 */
+
+static unsigned char adp5585_bank(unsigned char offset)
+{
+	return offset > ADP5585_MAX_ROW_NUM;
+}
+
+static unsigned char adp5585_bit(unsigned char offset)
+{
+	return (offset > ADP5585_MAX_ROW_NUM) ?
+		1u << (offset - ADP5585_COL_SHIFT) : 1u << offset;
+}
+
+static const unsigned char adp5585_reg_lut[] = {
+	[ADP5589_GPI_STATUS_A]		= ADP5585_GPI_STATUS_A,
+	[ADP5589_GPI_STATUS_B]		= ADP5585_GPI_STATUS_B,
+	[ADP5589_RPULL_CONFIG_A]	= ADP5585_RPULL_CONFIG_A,
+	[ADP5589_RPULL_CONFIG_B]	= ADP5585_RPULL_CONFIG_B,
+	[ADP5589_RPULL_CONFIG_C]	= ADP5585_RPULL_CONFIG_C,
+	[ADP5589_RPULL_CONFIG_D]	= ADP5585_RPULL_CONFIG_D,
+	[ADP5589_GPI_INT_LEVEL_A]	= ADP5585_GPI_INT_LEVEL_A,
+	[ADP5589_GPI_INT_LEVEL_B]	= ADP5585_GPI_INT_LEVEL_B,
+	[ADP5589_GPI_EVENT_EN_A]	= ADP5585_GPI_EVENT_EN_A,
+	[ADP5589_GPI_EVENT_EN_B]	= ADP5585_GPI_EVENT_EN_B,
+	[ADP5589_GPI_INTERRUPT_EN_A]	= ADP5585_GPI_INTERRUPT_EN_A,
+	[ADP5589_GPI_INTERRUPT_EN_B]	= ADP5585_GPI_INTERRUPT_EN_B,
+	[ADP5589_DEBOUNCE_DIS_A]	= ADP5585_DEBOUNCE_DIS_A,
+	[ADP5589_DEBOUNCE_DIS_B]	= ADP5585_DEBOUNCE_DIS_B,
+	[ADP5589_GPO_DATA_OUT_A]	= ADP5585_GPO_DATA_OUT_A,
+	[ADP5589_GPO_DATA_OUT_B]	= ADP5585_GPO_DATA_OUT_B,
+	[ADP5589_GPO_OUT_MODE_A]	= ADP5585_GPO_OUT_MODE_A,
+	[ADP5589_GPO_OUT_MODE_B]	= ADP5585_GPO_OUT_MODE_B,
+	[ADP5589_GPIO_DIRECTION_A]	= ADP5585_GPIO_DIRECTION_A,
+	[ADP5589_GPIO_DIRECTION_B]	= ADP5585_GPIO_DIRECTION_B,
+	[ADP5589_RESET1_EVENT_A]	= ADP5585_RESET1_EVENT_A,
+	[ADP5589_RESET1_EVENT_B]	= ADP5585_RESET1_EVENT_B,
+	[ADP5589_RESET1_EVENT_C]	= ADP5585_RESET1_EVENT_C,
+	[ADP5589_RESET2_EVENT_A]	= ADP5585_RESET2_EVENT_A,
+	[ADP5589_RESET2_EVENT_B]	= ADP5585_RESET2_EVENT_B,
+	[ADP5589_RESET_CFG]		= ADP5585_RESET_CFG,
+	[ADP5589_PWM_OFFT_LOW]		= ADP5585_PWM_OFFT_LOW,
+	[ADP5589_PWM_OFFT_HIGH]		= ADP5585_PWM_OFFT_HIGH,
+	[ADP5589_PWM_ONT_LOW]		= ADP5585_PWM_ONT_LOW,
+	[ADP5589_PWM_ONT_HIGH]		= ADP5585_PWM_ONT_HIGH,
+	[ADP5589_PWM_CFG]		= ADP5585_PWM_CFG,
+	[ADP5589_LOGIC_1_CFG]		= ADP5585_LOGIC_CFG,
+	[ADP5589_LOGIC_FF_CFG]		= ADP5585_LOGIC_FF_CFG,
+	[ADP5589_LOGIC_INT_EVENT_EN]	= ADP5585_LOGIC_INT_EVENT_EN,
+	[ADP5589_POLL_PTIME_CFG]	= ADP5585_POLL_PTIME_CFG,
+	[ADP5589_PIN_CONFIG_A]		= ADP5585_PIN_CONFIG_A,
+	[ADP5589_PIN_CONFIG_B]		= ADP5585_PIN_CONFIG_B,
+	[ADP5589_PIN_CONFIG_D]		= ADP5585_PIN_CONFIG_D,
+	[ADP5589_GENERAL_CFG]		= ADP5585_GENERAL_CFG,
+	[ADP5589_INT_EN]		= ADP5585_INT_EN,
+};
+
+static unsigned char adp5585_reg(unsigned char reg)
+{
+	return adp5585_reg_lut[reg];
+}
+
+static const struct adp_constants const_adp5585 = {
+	.maxgpio		= ADP5585_MAXGPIO,
+	.keymapsize		= ADP5585_KEYMAPSIZE,
+	.gpi_pin_row_base	= ADP5585_GPI_PIN_ROW_BASE,
+	.gpi_pin_row_end	= ADP5585_GPI_PIN_ROW_END,
+	.gpi_pin_col_base	= ADP5585_GPI_PIN_COL_BASE,
+	.gpi_pin_base		= ADP5585_GPI_PIN_BASE,
+	.gpi_pin_end		= ADP5585_GPI_PIN_END,
+	.gpimapsize_max		= ADP5585_GPIMAPSIZE_MAX,
+	.c4_extend_cfg		= 10,
+	.max_row_num		= ADP5585_MAX_ROW_NUM,
+	.max_col_num		= ADP5585_MAX_COL_NUM,
+	.row_mask		= ADP5585_ROW_MASK,
+	.col_mask		= ADP5585_COL_MASK,
+	.col_shift		= ADP5585_COL_SHIFT,
+	.bank			= adp5585_bank,
+	.bit			= adp5585_bit,
+	.reg			= adp5585_reg,
+};
+
 static int adp5589_read(struct i2c_client *client, u8 reg)
 {
 	int ret = i2c_smbus_read_byte_data(client, reg);
@@ -109,19 +389,20 @@ static int adp5589_write(struct i2c_client *client, u8 reg, u8 val)
 static int adp5589_gpio_get_value(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = kpad->var->bank(kpad->gpiomap[off]);
+	unsigned int bit = kpad->var->bit(kpad->gpiomap[off]);

-	return !!(adp5589_read(kpad->client, ADP5589_GPI_STATUS_A + bank) &
-		  bit);
+	return !!(adp5589_read(kpad->client,
+			       kpad->var->reg(ADP5589_GPI_STATUS_A) + bank) &
+			       bit);
 }

 static void adp5589_gpio_set_value(struct gpio_chip *chip,
 				   unsigned off, int val)
 {
 	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = kpad->var->bank(kpad->gpiomap[off]);
+	unsigned int bit = kpad->var->bit(kpad->gpiomap[off]);

 	mutex_lock(&kpad->gpio_lock);

@@ -130,8 +411,8 @@ static void adp5589_gpio_set_value(struct gpio_chip *chip,
 	else
 		kpad->dat_out[bank] &= ~bit;

-	adp5589_write(kpad->client, ADP5589_GPO_DATA_OUT_A + bank,
-		      kpad->dat_out[bank]);
+	adp5589_write(kpad->client, kpad->var->reg(ADP5589_GPO_DATA_OUT_A) +
+		      bank, kpad->dat_out[bank]);

 	mutex_unlock(&kpad->gpio_lock);
 }
@@ -139,14 +420,15 @@ static void adp5589_gpio_set_value(struct gpio_chip *chip,
 static int adp5589_gpio_direction_input(struct gpio_chip *chip, unsigned off)
 {
 	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = kpad->var->bank(kpad->gpiomap[off]);
+	unsigned int bit = kpad->var->bit(kpad->gpiomap[off]);
 	int ret;

 	mutex_lock(&kpad->gpio_lock);

 	kpad->dir[bank] &= ~bit;
-	ret = adp5589_write(kpad->client, ADP5589_GPIO_DIRECTION_A + bank,
+	ret = adp5589_write(kpad->client,
+			    kpad->var->reg(ADP5589_GPIO_DIRECTION_A) + bank,
 			    kpad->dir[bank]);

 	mutex_unlock(&kpad->gpio_lock);
@@ -158,8 +440,8 @@ static int adp5589_gpio_direction_output(struct gpio_chip *chip,
 					 unsigned off, int val)
 {
 	struct adp5589_kpad *kpad = container_of(chip, struct adp5589_kpad, gc);
-	unsigned int bank = ADP_BANK(kpad->gpiomap[off]);
-	unsigned int bit = ADP_BIT(kpad->gpiomap[off]);
+	unsigned int bank = kpad->var->bank(kpad->gpiomap[off]);
+	unsigned int bit = kpad->var->bit(kpad->gpiomap[off]);
 	int ret;

 	mutex_lock(&kpad->gpio_lock);
@@ -171,9 +453,10 @@ static int adp5589_gpio_direction_output(struct gpio_chip *chip,
 	else
 		kpad->dat_out[bank] &= ~bit;

-	ret = adp5589_write(kpad->client, ADP5589_GPO_DATA_OUT_A + bank,
-			    kpad->dat_out[bank]);
-	ret |= adp5589_write(kpad->client, ADP5589_GPIO_DIRECTION_A + bank,
+	ret = adp5589_write(kpad->client, kpad->var->reg(ADP5589_GPO_DATA_OUT_A)
+			    + bank, kpad->dat_out[bank]);
+	ret |= adp5589_write(kpad->client,
+			     kpad->var->reg(ADP5589_GPIO_DIRECTION_A) + bank,
 			     kpad->dir[bank]);

 	mutex_unlock(&kpad->gpio_lock);
@@ -184,26 +467,29 @@ static int adp5589_gpio_direction_output(struct gpio_chip *chip,
 static int __devinit adp5589_build_gpiomap(struct adp5589_kpad *kpad,
 				const struct adp5589_kpad_platform_data *pdata)
 {
-	bool pin_used[MAXGPIO];
+	bool pin_used[ADP5589_MAXGPIO];
 	int n_unused = 0;
 	int i;

 	memset(pin_used, false, sizeof(pin_used));

-	for (i = 0; i < MAXGPIO; i++)
+	for (i = 0; i < kpad->var->maxgpio; i++)
 		if (pdata->keypad_en_mask & (1 << i))
 			pin_used[i] = true;

 	for (i = 0; i < kpad->gpimapsize; i++)
-		pin_used[kpad->gpimap[i].pin - ADP5589_GPI_PIN_BASE] = true;
+		pin_used[kpad->gpimap[i].pin - kpad->var->gpi_pin_base] = true;

 	if (kpad->extend_cfg & R4_EXTEND_CFG)
 		pin_used[4] = true;

 	if (kpad->extend_cfg & C4_EXTEND_CFG)
-		pin_used[12] = true;
+		pin_used[kpad->var->c4_extend_cfg] = true;
+
+	if (!kpad->adp5585_support_row5)
+		pin_used[5] = true;

-	for (i = 0; i < MAXGPIO; i++)
+	for (i = 0; i < kpad->var->maxgpio; i++)
 		if (!pin_used[i])
 			kpad->gpiomap[n_unused++] = i;

@@ -246,11 +532,11 @@ static int __devinit adp5589_gpio_add(struct adp5589_kpad *kpad)
 		return error;
 	}

-	for (i = 0; i <= ADP_BANK(MAXGPIO); i++) {
-		kpad->dat_out[i] = adp5589_read(kpad->client,
-						ADP5589_GPO_DATA_OUT_A + i);
-		kpad->dir[i] = adp5589_read(kpad->client,
-					    ADP5589_GPIO_DIRECTION_A + i);
+	for (i = 0; i <= kpad->var->bank(kpad->var->maxgpio); i++) {
+		kpad->dat_out[i] = adp5589_read(kpad->client, kpad->var->reg(
+						ADP5589_GPO_DATA_OUT_A) + i);
+		kpad->dir[i] = adp5589_read(kpad->client, kpad->var->reg(
+					    ADP5589_GPIO_DIRECTION_A) + i);
 	}

 	if (gpio_data->setup) {
@@ -317,11 +603,11 @@ static void adp5589_report_events(struct adp5589_kpad *kpad, int ev_cnt)
 	int i;

 	for (i = 0; i < ev_cnt; i++) {
-		int key = adp5589_read(kpad->client, ADP5589_FIFO_1 + i);
+		int key = adp5589_read(kpad->client, ADP5589_5_FIFO_1 + i);
 		int key_val = key & KEY_EV_MASK;

-		if (key_val >= ADP5589_GPI_PIN_BASE &&
-		    key_val <= ADP5589_GPI_PIN_END) {
+		if (key_val >= kpad->var->gpi_pin_base &&
+		    key_val <= kpad->var->gpi_pin_end) {
 			adp5589_report_switches(kpad, key, key_val);
 		} else {
 			input_report_key(kpad->input,
@@ -337,29 +623,30 @@ static irqreturn_t adp5589_irq(int irq, void *handle)
 	struct i2c_client *client = kpad->client;
 	int status, ev_cnt;

-	status = adp5589_read(client, ADP5589_INT_STATUS);
+	status = adp5589_read(client, ADP5589_5_INT_STATUS);

 	if (status & OVRFLOW_INT)	/* Unlikely and should never happen */
 		dev_err(&client->dev, "Event Overflow Error\n");

 	if (status & EVENT_INT) {
-		ev_cnt = adp5589_read(client, ADP5589_STATUS) & KEC;
+		ev_cnt = adp5589_read(client, ADP5589_5_STATUS) & KEC;
 		if (ev_cnt) {
 			adp5589_report_events(kpad, ev_cnt);
 			input_sync(kpad->input);
 		}
 	}

-	adp5589_write(client, ADP5589_INT_STATUS, status);	/* Status is W1C */
+	adp5589_write(client, ADP5589_5_INT_STATUS, status); /* Status is W1C */

 	return IRQ_HANDLED;
 }

-static int __devinit adp5589_get_evcode(struct adp5589_kpad *kpad, unsigned short key)
+static int __devinit adp5589_get_evcode(struct adp5589_kpad *kpad,
+					unsigned short key)
 {
 	int i;

-	for (i = 0; i < ADP5589_KEYMAPSIZE; i++)
+	for (i = 0; i < kpad->var->keymapsize; i++)
 		if (key == kpad->keycode[i])
 			return (i + 1) | KEY_EV_PRESSED;

@@ -372,19 +659,23 @@ static int __devinit adp5589_setup(struct adp5589_kpad *kpad)
 {
 	struct i2c_client *client = kpad->client;
 	const struct adp5589_kpad_platform_data *pdata =
-	    client->dev.platform_data;
-	int i, ret;
+		client->dev.platform_data;
+	u8 (*reg) (u8) = kpad->var->reg;
 	unsigned char evt_mode1 = 0, evt_mode2 = 0, evt_mode3 = 0;
 	unsigned char pull_mask = 0;
+	int i, ret;
+
+	ret = adp5589_write(client, reg(ADP5589_PIN_CONFIG_A),
+			    pdata->keypad_en_mask & kpad->var->row_mask);
+	ret |= adp5589_write(client, reg(ADP5589_PIN_CONFIG_B),
+			     (pdata->keypad_en_mask >> kpad->var->col_shift) &
+			     kpad->var->col_mask);

-	ret = adp5589_write(client, ADP5589_PIN_CONFIG_A,
-			    pdata->keypad_en_mask & 0xFF);
-	ret |= adp5589_write(client, ADP5589_PIN_CONFIG_B,
-			     (pdata->keypad_en_mask >> 8) & 0xFF);
-	ret |= adp5589_write(client, ADP5589_PIN_CONFIG_C,
-			     (pdata->keypad_en_mask >> 16) & 0xFF);
+	if (!kpad->is_adp5585)
+		ret |= adp5589_write(client, ADP5589_PIN_CONFIG_C,
+				     (pdata->keypad_en_mask >> 16) & 0xFF);

-	if (pdata->en_keylock) {
+	if (!kpad->is_adp5585 && pdata->en_keylock) {
 		ret |= adp5589_write(client, ADP5589_UNLOCK1,
 				     pdata->unlock_key1);
 		ret |= adp5589_write(client, ADP5589_UNLOCK2,
@@ -395,96 +686,130 @@ static int __devinit adp5589_setup(struct adp5589_kpad *kpad)
 	}

 	for (i = 0; i < KEYP_MAX_EVENT; i++)
-		ret |= adp5589_read(client, ADP5589_FIFO_1 + i);
+		ret |= adp5589_read(client, ADP5589_5_FIFO_1 + i);

 	for (i = 0; i < pdata->gpimapsize; i++) {
 		unsigned short pin = pdata->gpimap[i].pin;

-		if (pin <= ADP5589_GPI_PIN_ROW_END) {
-			evt_mode1 |= (1 << (pin - ADP5589_GPI_PIN_ROW_BASE));
+		if (pin <= kpad->var->gpi_pin_row_end) {
+			evt_mode1 |= (1 << (pin - kpad->var->gpi_pin_row_base));
 		} else {
 			evt_mode2 |=
-			    ((1 << (pin - ADP5589_GPI_PIN_COL_BASE)) & 0xFF);
-			evt_mode3 |=
-			    ((1 << (pin - ADP5589_GPI_PIN_COL_BASE)) >> 8);
+			    ((1 << (pin - kpad->var->gpi_pin_col_base)) & 0xFF);
+			if (!kpad->is_adp5585)
+				evt_mode3 |= ((1 << (pin -
+					kpad->var->gpi_pin_col_base)) >> 8);
 		}
 	}

 	if (pdata->gpimapsize) {
-		ret |= adp5589_write(client, ADP5589_GPI_EVENT_EN_A, evt_mode1);
-		ret |= adp5589_write(client, ADP5589_GPI_EVENT_EN_B, evt_mode2);
-		ret |= adp5589_write(client, ADP5589_GPI_EVENT_EN_C, evt_mode3);
+		ret |= adp5589_write(client, reg(ADP5589_GPI_EVENT_EN_A),
+				     evt_mode1);
+		ret |= adp5589_write(client, reg(ADP5589_GPI_EVENT_EN_B),
+				     evt_mode2);
+		if (!kpad->is_adp5585)
+			ret |= adp5589_write(client,
+					     reg(ADP5589_GPI_EVENT_EN_C),
+					     evt_mode3);
 	}

 	if (pdata->pull_dis_mask & pdata->pullup_en_100k &
-	    pdata->pullup_en_300k & pdata->pulldown_en_300k)
+		pdata->pullup_en_300k & pdata->pulldown_en_300k)
 		dev_warn(&client->dev, "Conflicting pull resistor config\n");

-	for (i = 0; i < MAXGPIO; i++) {
-		unsigned val = 0;
+	for (i = 0; i <= kpad->var->max_row_num; i++) {
+		unsigned val = 0, bit = (1 << i);
+		if (pdata->pullup_en_300k & bit)
+			val = 0;
+		else if (pdata->pulldown_en_300k & bit)
+			val = 1;
+		else if (pdata->pullup_en_100k & bit)
+			val = 2;
+		else if (pdata->pull_dis_mask & bit)
+			val = 3;
+
+		pull_mask |= val << (2 * (i & 0x3));
+
+		if (i == 3 || i == kpad->var->max_row_num) {
+			ret |= adp5589_write(client, reg(ADP5585_RPULL_CONFIG_A)
+					     + (i >> 2), pull_mask);
+			pull_mask = 0;
+		}
+	}

-		if (pdata->pullup_en_300k & (1 << i))
+	for (i = 0; i <= kpad->var->max_col_num; i++) {
+		unsigned val = 0, bit = 1 << (i + kpad->var->col_shift);
+		if (pdata->pullup_en_300k & bit)
 			val = 0;
-		else if (pdata->pulldown_en_300k & (1 << i))
+		else if (pdata->pulldown_en_300k & bit)
 			val = 1;
-		else if (pdata->pullup_en_100k & (1 << i))
+		else if (pdata->pullup_en_100k & bit)
 			val = 2;
-		else if (pdata->pull_dis_mask & (1 << i))
+		else if (pdata->pull_dis_mask & bit)
 			val = 3;

 		pull_mask |= val << (2 * (i & 0x3));

-		if ((i & 0x3) == 0x3 || i == MAXGPIO - 1) {
+		if (i == 3 || i == kpad->var->max_col_num) {
 			ret |= adp5589_write(client,
-					     ADP5589_RPULL_CONFIG_A + (i >> 2),
-					     pull_mask);
+					     reg(ADP5585_RPULL_CONFIG_C) +
+					     (i >> 2), pull_mask);
 			pull_mask = 0;
 		}
 	}

 	if (pdata->reset1_key_1 && pdata->reset1_key_2 && pdata->reset1_key_3) {
-		ret |= adp5589_write(client, ADP5589_RESET1_EVENT_A,
+		ret |= adp5589_write(client, reg(ADP5589_RESET1_EVENT_A),
 				     adp5589_get_evcode(kpad,
 							pdata->reset1_key_1));
-		ret |= adp5589_write(client, ADP5589_RESET1_EVENT_B,
+		ret |= adp5589_write(client, reg(ADP5589_RESET1_EVENT_B),
 				     adp5589_get_evcode(kpad,
 							pdata->reset1_key_2));
-		ret |= adp5589_write(client, ADP5589_RESET1_EVENT_C,
+		ret |= adp5589_write(client, reg(ADP5589_RESET1_EVENT_C),
 				     adp5589_get_evcode(kpad,
 							pdata->reset1_key_3));
 		kpad->extend_cfg |= R4_EXTEND_CFG;
 	}

 	if (pdata->reset2_key_1 && pdata->reset2_key_2) {
-		ret |= adp5589_write(client, ADP5589_RESET2_EVENT_A,
+		ret |= adp5589_write(client, reg(ADP5589_RESET2_EVENT_A),
 				     adp5589_get_evcode(kpad,
 							pdata->reset2_key_1));
-		ret |= adp5589_write(client, ADP5589_RESET2_EVENT_B,
+		ret |= adp5589_write(client, reg(ADP5589_RESET2_EVENT_B),
 				     adp5589_get_evcode(kpad,
 							pdata->reset2_key_2));
 		kpad->extend_cfg |= C4_EXTEND_CFG;
 	}

 	if (kpad->extend_cfg) {
-		ret |= adp5589_write(client, ADP5589_RESET_CFG,
+		ret |= adp5589_write(client, reg(ADP5589_RESET_CFG),
 				     pdata->reset_cfg);
-		ret |= adp5589_write(client, ADP5589_PIN_CONFIG_D,
+		ret |= adp5589_write(client, reg(ADP5589_PIN_CONFIG_D),
 				     kpad->extend_cfg);
 	}

-	for (i = 0; i <= ADP_BANK(MAXGPIO); i++)
-		ret |= adp5589_write(client, ADP5589_DEBOUNCE_DIS_A + i,
-				     pdata->debounce_dis_mask >> (i * 8));
+	ret |= adp5589_write(client, reg(ADP5589_DEBOUNCE_DIS_A),
+			    pdata->debounce_dis_mask & kpad->var->row_mask);

-	ret |= adp5589_write(client, ADP5589_POLL_PTIME_CFG,
+	ret |= adp5589_write(client, reg(ADP5589_DEBOUNCE_DIS_B),
+			     (pdata->debounce_dis_mask >> kpad->var->col_shift)
+			     & kpad->var->col_mask);
+
+	if (!kpad->is_adp5585)
+		ret |= adp5589_write(client, reg(ADP5589_DEBOUNCE_DIS_C),
+				     (pdata->debounce_dis_mask >> 16) & 0xFF);
+
+	ret |= adp5589_write(client, reg(ADP5589_POLL_PTIME_CFG),
 			     pdata->scan_cycle_time & PTIME_MASK);
-	ret |= adp5589_write(client, ADP5589_INT_STATUS, LOGIC2_INT |
-			     LOGIC1_INT | OVRFLOW_INT | LOCK_INT |
+	ret |= adp5589_write(client, ADP5589_5_INT_STATUS,
+			     (kpad->is_adp5585 ? 0 : LOGIC2_INT) |
+			     LOGIC1_INT | OVRFLOW_INT |
+			     (kpad->is_adp5585 ? 0 : LOCK_INT) |
 			     GPI_INT | EVENT_INT);	/* Status is W1C */

-	ret |= adp5589_write(client, ADP5589_GENERAL_CFG,
+	ret |= adp5589_write(client, reg(ADP5589_GENERAL_CFG),
 			     INT_CFG | OSC_EN | CORE_CLK(3));
-	ret |= adp5589_write(client, ADP5589_INT_EN,
+	ret |= adp5589_write(client, reg(ADP5589_INT_EN),
 			     OVRFLOW_IEN | GPI_IEN | EVENT_IEN);

 	if (ret < 0) {
@@ -497,24 +822,27 @@ static int __devinit adp5589_setup(struct adp5589_kpad *kpad)

 static void __devinit adp5589_report_switch_state(struct adp5589_kpad *kpad)
 {
-	int gpi_stat1 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_A);
-	int gpi_stat2 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_B);
-	int gpi_stat3 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_C);
-	int gpi_stat_tmp, pin_loc;
+	int gpi_stat_tmp, pin_loc, gpi_stat3;
 	int i;
+	int gpi_stat1 = adp5589_read(kpad->client,
+				     kpad->var->reg(ADP5589_GPI_STATUS_A));
+	int gpi_stat2 = adp5589_read(kpad->client,
+				     kpad->var->reg(ADP5589_GPI_STATUS_B));
+	if (!kpad->is_adp5585)
+		gpi_stat3 = adp5589_read(kpad->client, ADP5589_GPI_STATUS_C);

 	for (i = 0; i < kpad->gpimapsize; i++) {
 		unsigned short pin = kpad->gpimap[i].pin;

-		if (pin <= ADP5589_GPI_PIN_ROW_END) {
+		if (pin <= kpad->var->gpi_pin_row_end) {
 			gpi_stat_tmp = gpi_stat1;
-			pin_loc = pin - ADP5589_GPI_PIN_ROW_BASE;
-		} else if ((pin - ADP5589_GPI_PIN_COL_BASE) < 8) {
+			pin_loc = pin - kpad->var->gpi_pin_row_base;
+		} else if ((pin - kpad->var->gpi_pin_col_base) < 8) {
 			gpi_stat_tmp = gpi_stat2;
-			pin_loc = pin - ADP5589_GPI_PIN_COL_BASE;
+			pin_loc = pin - kpad->var->gpi_pin_col_base;
 		} else {
 			gpi_stat_tmp = gpi_stat3;
-			pin_loc = pin - ADP5589_GPI_PIN_COL_BASE - 8;
+			pin_loc = pin - kpad->var->gpi_pin_col_base - 8;
 		}

 		if (gpi_stat_tmp < 0) {
@@ -536,7 +864,8 @@ static int __devinit adp5589_probe(struct i2c_client *client,
 				   const struct i2c_device_id *id)
 {
 	struct adp5589_kpad *kpad;
-	const struct adp5589_kpad_platform_data *pdata;
+	const struct adp5589_kpad_platform_data *pdata =
+		client->dev.platform_data;
 	struct input_dev *input;
 	unsigned int revid;
 	int ret, i;
@@ -548,56 +877,79 @@ static int __devinit adp5589_probe(struct i2c_client *client,
 		return -EIO;
 	}

-	pdata = client->dev.platform_data;
 	if (!pdata) {
 		dev_err(&client->dev, "no platform data?\n");
 		return -EINVAL;
 	}

-	if (!((pdata->keypad_en_mask & 0xFF) &&
-			(pdata->keypad_en_mask >> 8)) || !pdata->keymap) {
+	kpad = kzalloc(sizeof(*kpad), GFP_KERNEL);
+	if (!kpad)
+		return -ENOMEM;
+
+	switch (id->driver_data) {
+	case ADP5585_02:
+		kpad->adp5585_support_row5 = true;
+	case ADP5585_01:
+		kpad->is_adp5585 = true;
+		kpad->var = &const_adp5585;
+		break;
+	case ADP5589:
+		kpad->var = &const_adp5589;
+		break;
+	}
+
+	if (!((pdata->keypad_en_mask & kpad->var->row_mask) &&
+			(pdata->keypad_en_mask >> kpad->var->col_shift)) ||
+			!pdata->keymap) {
 		dev_err(&client->dev, "no rows, cols or keymap from pdata\n");
-		return -EINVAL;
+		error = -EINVAL;
+		goto err_free_mem;
 	}

-	if (pdata->keymapsize != ADP5589_KEYMAPSIZE) {
+	if (pdata->keymapsize != kpad->var->keymapsize) {
 		dev_err(&client->dev, "invalid keymapsize\n");
-		return -EINVAL;
+		error = -EINVAL;
+		goto err_free_mem;
 	}

 	if (!pdata->gpimap && pdata->gpimapsize) {
 		dev_err(&client->dev, "invalid gpimap from pdata\n");
-		return -EINVAL;
+		error = -EINVAL;
+		goto err_free_mem;
 	}

-	if (pdata->gpimapsize > ADP5589_GPIMAPSIZE_MAX) {
+	if (pdata->gpimapsize > kpad->var->gpimapsize_max) {
 		dev_err(&client->dev, "invalid gpimapsize\n");
-		return -EINVAL;
+		error = -EINVAL;
+		goto err_free_mem;
 	}

 	for (i = 0; i < pdata->gpimapsize; i++) {
 		unsigned short pin = pdata->gpimap[i].pin;

-		if (pin < ADP5589_GPI_PIN_BASE || pin > ADP5589_GPI_PIN_END) {
+		if (pin < kpad->var->gpi_pin_base ||
+				pin > kpad->var->gpi_pin_end) {
 			dev_err(&client->dev, "invalid gpi pin data\n");
-			return -EINVAL;
+			error = -EINVAL;
+			goto err_free_mem;
 		}

-		if ((1 << (pin - ADP5589_GPI_PIN_ROW_BASE)) &
+		if ((1 << (pin - kpad->var->gpi_pin_row_base)) &
 				pdata->keypad_en_mask) {
 			dev_err(&client->dev, "invalid gpi row/col data\n");
-			return -EINVAL;
+			error = -EINVAL;
+			goto err_free_mem;
 		}
 	}

 	if (!client->irq) {
 		dev_err(&client->dev, "no IRQ?\n");
-		return -EINVAL;
+		error = -EINVAL;
+		goto err_free_mem;
 	}

-	kpad = kzalloc(sizeof(*kpad), GFP_KERNEL);
 	input = input_allocate_device();
-	if (!kpad || !input) {
+	if (!input) {
 		error = -ENOMEM;
 		goto err_free_mem;
 	}
@@ -605,13 +957,13 @@ static int __devinit adp5589_probe(struct i2c_client *client,
 	kpad->client = client;
 	kpad->input = input;

-	ret = adp5589_read(client, ADP5589_ID);
+	ret = adp5589_read(client, ADP5589_5_ID);
 	if (ret < 0) {
 		error = ret;
-		goto err_free_mem;
+		goto err_free_input;
 	}

-	revid = (u8) ret & ADP5589_DEVICE_ID_MASK;
+	revid = (u8) ret & ADP5589_5_DEVICE_ID_MASK;

 	input->name = client->name;
 	input->phys = "adp5589-keys/input0";
@@ -652,7 +1004,7 @@ static int __devinit adp5589_probe(struct i2c_client *client,
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&client->dev, "unable to register input device\n");
-		goto err_free_mem;
+		goto err_free_input;
 	}

 	error = request_threaded_irq(client->irq, NULL, adp5589_irq,
@@ -685,8 +1037,9 @@ err_free_irq:
 err_unreg_dev:
 	input_unregister_device(input);
 	input = NULL;
-err_free_mem:
+err_free_input:
 	input_free_device(input);
+err_free_mem:
 	kfree(kpad);

 	return error;
@@ -696,7 +1049,7 @@ static int __devexit adp5589_remove(struct i2c_client *client)
 {
 	struct adp5589_kpad *kpad = i2c_get_clientdata(client);

-	adp5589_write(client, ADP5589_GENERAL_CFG, 0);
+	adp5589_write(client, kpad->var->reg(ADP5589_GENERAL_CFG), 0);
 	free_irq(client->irq, kpad);
 	input_unregister_device(kpad->input);
 	adp5589_gpio_remove(kpad);
@@ -736,7 +1089,9 @@ static int adp5589_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(adp5589_dev_pm_ops, adp5589_suspend, adp5589_resume);

 static const struct i2c_device_id adp5589_id[] = {
-	{"adp5589-keys", 0},
+	{"adp5589-keys", ADP5589},
+	{"adp5585-keys", ADP5585_01},
+	{"adp5585-02-keys", ADP5585_02}, /* Adds ROW5 to ADP5585 */
 	{}
 };

@@ -767,4 +1122,4 @@ module_exit(adp5589_exit);

 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("ADP5589 Keypad driver");
+MODULE_DESCRIPTION("ADP5589/ADP5585 Keypad driver");
diff --git a/include/linux/input/adp5589.h b/include/linux/input/adp5589.h
index ef792ec..1a05eee 100644
--- a/include/linux/input/adp5589.h
+++ b/include/linux/input/adp5589.h
@@ -1,5 +1,5 @@
 /*
- * Analog Devices ADP5589 I/O Expander and QWERTY Keypad Controller
+ * Analog Devices ADP5589/ADP5585 I/O Expander and QWERTY Keypad Controller
  *
  * Copyright 2010-2011 Analog Devices Inc.
  *
@@ -9,89 +9,9 @@
 #ifndef _ADP5589_H
 #define _ADP5589_H

-#define ADP5589_ID			0x00
-#define ADP5589_INT_STATUS		0x01
-#define ADP5589_STATUS			0x02
-#define ADP5589_FIFO_1			0x03
-#define ADP5589_FIFO_2			0x04
-#define ADP5589_FIFO_3			0x05
-#define ADP5589_FIFO_4			0x06
-#define ADP5589_FIFO_5			0x07
-#define ADP5589_FIFO_6			0x08
-#define ADP5589_FIFO_7			0x09
-#define ADP5589_FIFO_8			0x0A
-#define ADP5589_FIFO_9			0x0B
-#define ADP5589_FIFO_10			0x0C
-#define ADP5589_FIFO_11			0x0D
-#define ADP5589_FIFO_12			0x0E
-#define ADP5589_FIFO_13			0x0F
-#define ADP5589_FIFO_14			0x10
-#define ADP5589_FIFO_15			0x11
-#define ADP5589_FIFO_16			0x12
-#define ADP5589_GPI_INT_STAT_A		0x13
-#define ADP5589_GPI_INT_STAT_B		0x14
-#define ADP5589_GPI_INT_STAT_C		0x15
-#define ADP5589_GPI_STATUS_A		0x16
-#define ADP5589_GPI_STATUS_B		0x17
-#define ADP5589_GPI_STATUS_C		0x18
-#define ADP5589_RPULL_CONFIG_A		0x19
-#define ADP5589_RPULL_CONFIG_B		0x1A
-#define ADP5589_RPULL_CONFIG_C		0x1B
-#define ADP5589_RPULL_CONFIG_D		0x1C
-#define ADP5589_RPULL_CONFIG_E		0x1D
-#define ADP5589_GPI_INT_LEVEL_A		0x1E
-#define ADP5589_GPI_INT_LEVEL_B		0x1F
-#define ADP5589_GPI_INT_LEVEL_C		0x20
-#define ADP5589_GPI_EVENT_EN_A		0x21
-#define ADP5589_GPI_EVENT_EN_B		0x22
-#define ADP5589_GPI_EVENT_EN_C		0x23
-#define ADP5589_GPI_INTERRUPT_EN_A	0x24
-#define ADP5589_GPI_INTERRUPT_EN_B	0x25
-#define ADP5589_GPI_INTERRUPT_EN_C	0x26
-#define ADP5589_DEBOUNCE_DIS_A		0x27
-#define ADP5589_DEBOUNCE_DIS_B		0x28
-#define ADP5589_DEBOUNCE_DIS_C		0x29
-#define ADP5589_GPO_DATA_OUT_A		0x2A
-#define ADP5589_GPO_DATA_OUT_B		0x2B
-#define ADP5589_GPO_DATA_OUT_C		0x2C
-#define ADP5589_GPO_OUT_MODE_A		0x2D
-#define ADP5589_GPO_OUT_MODE_B		0x2E
-#define ADP5589_GPO_OUT_MODE_C		0x2F
-#define ADP5589_GPIO_DIRECTION_A	0x30
-#define ADP5589_GPIO_DIRECTION_B	0x31
-#define ADP5589_GPIO_DIRECTION_C	0x32
-#define ADP5589_UNLOCK1			0x33
-#define ADP5589_UNLOCK2			0x34
-#define ADP5589_EXT_LOCK_EVENT		0x35
-#define ADP5589_UNLOCK_TIMERS		0x36
-#define ADP5589_LOCK_CFG		0x37
-#define ADP5589_RESET1_EVENT_A		0x38
-#define ADP5589_RESET1_EVENT_B		0x39
-#define ADP5589_RESET1_EVENT_C		0x3A
-#define ADP5589_RESET2_EVENT_A		0x3B
-#define ADP5589_RESET2_EVENT_B		0x3C
-#define ADP5589_RESET_CFG		0x3D
-#define ADP5589_PWM_OFFT_LOW		0x3E
-#define ADP5589_PWM_OFFT_HIGH		0x3F
-#define ADP5589_PWM_ONT_LOW		0x40
-#define ADP5589_PWM_ONT_HIGH		0x41
-#define ADP5589_PWM_CFG			0x42
-#define ADP5589_CLOCK_DIV_CFG		0x43
-#define ADP5589_LOGIC_1_CFG		0x44
-#define ADP5589_LOGIC_2_CFG		0x45
-#define ADP5589_LOGIC_FF_CFG		0x46
-#define ADP5589_LOGIC_INT_EVENT_EN	0x47
-#define ADP5589_POLL_PTIME_CFG		0x48
-#define ADP5589_PIN_CONFIG_A		0x49
-#define ADP5589_PIN_CONFIG_B		0x4A
-#define ADP5589_PIN_CONFIG_C		0x4B
-#define ADP5589_PIN_CONFIG_D		0x4C
-#define ADP5589_GENERAL_CFG		0x4D
-#define ADP5589_INT_EN			0x4E
-
-#define ADP5589_DEVICE_ID_MASK	0xF
-
-/* Put one of these structures in i2c_board_info platform_data */
+/*
+ * ADP5589 specific GPI and Keymap defines
+ */

 #define ADP5589_KEYMAPSIZE	88

@@ -127,6 +47,35 @@

 #define ADP5589_GPIMAPSIZE_MAX (ADP5589_GPI_PIN_END - ADP5589_GPI_PIN_BASE + 1)

+/*
+ * ADP5585 specific GPI and Keymap defines
+ */
+
+#define ADP5585_KEYMAPSIZE	30
+
+#define ADP5585_GPI_PIN_ROW0 37
+#define ADP5585_GPI_PIN_ROW1 38
+#define ADP5585_GPI_PIN_ROW2 39
+#define ADP5585_GPI_PIN_ROW3 40
+#define ADP5585_GPI_PIN_ROW4 41
+#define ADP5585_GPI_PIN_ROW5 42
+#define ADP5585_GPI_PIN_COL0 43
+#define ADP5585_GPI_PIN_COL1 44
+#define ADP5585_GPI_PIN_COL2 45
+#define ADP5585_GPI_PIN_COL3 46
+#define ADP5585_GPI_PIN_COL4 47
+#define GPI_LOGIC 48
+
+#define ADP5585_GPI_PIN_ROW_BASE ADP5585_GPI_PIN_ROW0
+#define ADP5585_GPI_PIN_ROW_END ADP5585_GPI_PIN_ROW5
+#define ADP5585_GPI_PIN_COL_BASE ADP5585_GPI_PIN_COL0
+#define ADP5585_GPI_PIN_COL_END ADP5585_GPI_PIN_COL4
+
+#define ADP5585_GPI_PIN_BASE ADP5585_GPI_PIN_ROW_BASE
+#define ADP5585_GPI_PIN_END ADP5585_GPI_PIN_COL_END
+
+#define ADP5585_GPIMAPSIZE_MAX (ADP5585_GPI_PIN_END - ADP5585_GPI_PIN_BASE + 1)
+
 struct adp5589_gpi_map {
 	unsigned short pin;
 	unsigned short sw_evt;
@@ -159,7 +108,7 @@ struct adp5589_gpi_map {
 #define RESET2_POL_HIGH			(1 << 7)
 #define RESET2_POL_LOW			(0 << 7)

-/* Mask Bits:
+/* ADP5589 Mask Bits:
  * C C C C C C C C C C C | R R R R R R R R
  * 1 9 8 7 6 5 4 3 2 1 0 | 7 6 5 4 3 2 1 0
  * 0
@@ -168,18 +117,44 @@ struct adp5589_gpi_map {
  * 8 7 6 5 4 3 2 1 0 9 8 | 7 6 5 4 3 2 1 0
  */

-#define ADP_ROW(x)			(1 << (x))
-#define ADP_COL(x)			(1 << (x + 8))
+#define ADP_ROW(x)	(1 << (x))
+#define ADP_COL(x)	(1 << (x + 8))
+#define ADP5589_ROW_MASK		0xFF
+#define ADP5589_COL_MASK		0xFF
+#define ADP5589_COL_SHIFT		8
+#define ADP5589_MAX_ROW_NUM		7
+#define ADP5589_MAX_COL_NUM		10
+
+/* ADP5585 Mask Bits:
+ * C C C C C | R R R R R R
+ * 4 3 2 1 0 | 5 4 3 2 1 0
+ *
+ * ---- BIT -- -----------
+ * 1 0 0 0 0 | 0 0 0 0 0 0
+ * 0 9 8 7 6 | 5 4 3 2 1 0
+ */
+
+#define ADP5585_ROW_MASK		0x3F
+#define ADP5585_COL_MASK		0x1F
+#define ADP5585_ROW_SHIFT		0
+#define ADP5585_COL_SHIFT		6
+#define ADP5585_MAX_ROW_NUM		5
+#define ADP5585_MAX_COL_NUM		4
+
+#define ADP5585_ROW(x)	(1 << ((x) & ADP5585_ROW_MASK))
+#define ADP5585_COL(x)	(1 << (((x) & ADP5585_COL_MASK) + ADP5585_COL_SHIFT))
+
+/* Put one of these structures in i2c_board_info platform_data */

 struct adp5589_kpad_platform_data {
 	unsigned keypad_en_mask;	/* Keypad (Rows/Columns) enable mask */
 	const unsigned short *keymap;	/* Pointer to keymap */
 	unsigned short keymapsize;	/* Keymap size */
 	bool repeat;			/* Enable key repeat */
-	bool en_keylock;		/* Enable key lock feature */
-	unsigned char unlock_key1;	/* Unlock Key 1 */
-	unsigned char unlock_key2;	/* Unlock Key 2 */
-	unsigned char unlock_timer;	/* Time in seconds [0..7] between the two unlock keys 0=disable */
+	bool en_keylock;		/* Enable key lock feature (ADP5589 only)*/
+	unsigned char unlock_key1;	/* Unlock Key 1 (ADP5589 only) */
+	unsigned char unlock_key2;	/* Unlock Key 2 (ADP5589 only) */
+	unsigned char unlock_timer;	/* Time in seconds [0..7] between the two unlock keys 0=disable (ADP5589 only) */
 	unsigned char scan_cycle_time;	/* Time between consecutive scan cycles */
 	unsigned char reset_cfg;	/* Reset config */
 	unsigned short reset1_key_1;	/* Reset Key 1 */
--
1.7.0.4


