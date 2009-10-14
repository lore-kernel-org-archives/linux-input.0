From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] input/misc: new ADXL345/346 driver
Date: Wed, 14 Oct 2009 06:54:40 -0400
Message-ID: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
References: <1255516029-30023-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1255516029-30023-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Chris Verges <chrisv-TDbMi1wZJFNf2ZY+IB7+a9BPR1lH4CV8@public.gmane.org>, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

This is a driver for the ADXL345/346 Three-Axis Digital Accelerometers.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Chris Verges <chrisv-TDbMi1wZJFNf2ZY+IB7+a9BPR1lH4CV8@public.gmane.org>
Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
v2
	- fixed a few typos

 drivers/input/misc/Kconfig       |   37 ++
 drivers/input/misc/Makefile      |    3 +
 drivers/input/misc/adxl34x-i2c.c |  136 ++++++
 drivers/input/misc/adxl34x-spi.c |  127 ++++++
 drivers/input/misc/adxl34x.c     |  875 ++++++++++++++++++++++++++++++++++++++
 drivers/input/misc/adxl34x.h     |   26 ++
 include/linux/input/adxl34x.h    |  295 +++++++++++++
 7 files changed, 1499 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/adxl34x-i2c.c
 create mode 100644 drivers/input/misc/adxl34x-spi.c
 create mode 100644 drivers/input/misc/adxl34x.c
 create mode 100644 drivers/input/misc/adxl34x.h
 create mode 100644 include/linux/input/adxl34x.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 02f4f8f..9e1e42f 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -316,4 +316,41 @@ config INPUT_PCAP
 	  To compile this driver as a module, choose M here: the
 	  module will be called pcap_keys.
 
+config INPUT_ADXL34X
+	tristate "Analog Devices ADXL34x Three-Axis Digital Accelerometer"
+	default n
+	help
+	  Say Y here if you have a Accelerometer interface using the
+	  ADXL345/6 controller, and your board-specific initialization
+	  code includes that in its table of devices.
+
+	  This driver can use either I2C or SPI communication to the
+	  ADXL345/6 controller.  Select the appropriate method for
+	  your system.
+
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl34x.
+
+config INPUT_ADXL34X_I2C
+	tristate "support I2C bus connection"
+	depends on INPUT_ADXL34X && I2C
+	default y
+	help
+	  Say Y here if you have ADXL345/6 hooked to an I2C bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl34x-i2c.
+
+config INPUT_ADXL34X_SPI
+	tristate "support SPI bus connection"
+	depends on INPUT_ADXL34X && SPI
+	default y
+	help
+	  Say Y here if you have ADXL345/6 hooked to a SPI bus.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adxl34x-spi.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index a8b8485..c39629e 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -4,6 +4,9 @@
 
 # Each configuration option enables a list of files.
 
+obj-$(CONFIG_INPUT_ADXL34X)		+= adxl34x.o
+obj-$(CONFIG_INPUT_ADXL34X_I2C)		+= adxl34x-i2c.o
+obj-$(CONFIG_INPUT_ADXL34X_SPI)		+= adxl34x-spi.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_ATI_REMOTE)		+= ati_remote.o
 obj-$(CONFIG_INPUT_ATI_REMOTE2)		+= ati_remote2.o
diff --git a/drivers/input/misc/adxl34x-i2c.c b/drivers/input/misc/adxl34x-i2c.c
new file mode 100644
index 0000000..13141f4
--- /dev/null
+++ b/drivers/input/misc/adxl34x-i2c.c
@@ -0,0 +1,136 @@
+/*
+ * ADLX345/346 Three-Axis Digital Accelerometers (I2C Interface)
+ *
+ * Enter bugs at http://blackfin.uclinux.org/
+ *
+ * Copyright (C) 2009 Michael Hennerich, Analog Devices Inc.
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/input.h>	/* BUS_I2C */
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include "adxl34x.h"
+
+static int adxl34x_smbus_read(struct device *dev, unsigned char reg)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static int adxl34x_smbus_write(struct device *dev,
+			       unsigned char reg, unsigned char val)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return i2c_smbus_write_byte_data(client, reg, val);
+}
+
+static int adxl34x_smbus_read_block(struct device *dev,
+				    unsigned char reg, int count,
+				    unsigned char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return i2c_smbus_read_i2c_block_data(client, reg, count, buf);
+}
+
+static int adxl34x_i2c_read_block(struct device *dev,
+				  unsigned char reg, int count,
+				  unsigned char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	int ret;
+
+	ret = i2c_master_send(client, &reg, 1);
+	if (ret < 0)
+		return ret;
+	ret = i2c_master_recv(client, buf, count);
+	if (ret < 0)
+		return ret;
+	if (ret != count)
+		return -EIO;
+
+	return 0;
+}
+
+static int __devinit adxl34x_i2c_probe(struct i2c_client *client,
+				       const struct i2c_device_id *id)
+{
+	struct adxl34x *ac;
+	int error;
+
+	error = i2c_check_functionality(client->adapter,
+			I2C_FUNC_SMBUS_BYTE_DATA);
+	if (!error) {
+		dev_err(&client->dev, "SMBUS Byte Data not Supported\n");
+		return -EIO;
+	}
+
+	error = adxl34x_probe(&ac, &client->dev, BUS_I2C, client->irq, 0,
+		adxl34x_smbus_read,
+		i2c_check_functionality(client->adapter,
+				I2C_FUNC_SMBUS_READ_I2C_BLOCK) ?
+			adxl34x_smbus_read_block :
+			adxl34x_i2c_read_block,
+		adxl34x_smbus_write);
+	i2c_set_clientdata(client, ac);
+
+	return error;
+}
+
+static int __devexit adxl34x_i2c_remove(struct i2c_client *client)
+{
+	return adxl34x_remove(i2c_get_clientdata(client));
+}
+
+#ifdef CONFIG_PM
+static int adxl34x_suspend(struct i2c_client *client, pm_message_t message)
+{
+	adxl34x_disable(i2c_get_clientdata(client));
+	return 0;
+}
+
+static int adxl34x_resume(struct i2c_client *client)
+{
+	adxl34x_enable(i2c_get_clientdata(client));
+	return 0;
+}
+#else
+# define adxl34x_suspend NULL
+# define adxl34x_resume  NULL
+#endif
+
+static const struct i2c_device_id adxl34x_id[] = {
+	{ "adxl34x", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, adxl34x_id);
+
+static struct i2c_driver adxl34x_driver = {
+	.driver = {
+		.name = "adxl34x",
+		.owner = THIS_MODULE,
+	},
+	.probe    = adxl34x_i2c_probe,
+	.remove   = __devexit_p(adxl34x_i2c_remove),
+	.suspend  = adxl34x_suspend,
+	.resume   = adxl34x_resume,
+	.id_table = adxl34x_id,
+};
+
+static int __init adxl34x_i2c_init(void)
+{
+	return i2c_add_driver(&adxl34x_driver);
+}
+module_init(adxl34x_i2c_init);
+
+static void __exit adxl34x_i2c_exit(void)
+{
+	i2c_del_driver(&adxl34x_driver);
+}
+module_exit(adxl34x_i2c_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>");
+MODULE_DESCRIPTION("ADXL345/346 Three-Axis Digital Accelerometer I2C Bus Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/adxl34x-spi.c b/drivers/input/misc/adxl34x-spi.c
new file mode 100644
index 0000000..c02e332
--- /dev/null
+++ b/drivers/input/misc/adxl34x-spi.c
@@ -0,0 +1,127 @@
+/*
+ * ADLX345/346 Three-Axis Digital Accelerometers (SPI Interface)
+ *
+ * Enter bugs at http://blackfin.uclinux.org/
+ *
+ * Copyright (C) 2009 Michael Hennerich, Analog Devices Inc.
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/input.h>	/* BUS_SPI */
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include "adxl34x.h"
+
+#define MAX_SPI_FREQ_HZ		5000000
+#define MAX_FREQ_NO_FIFODELAY	1500000
+#define ADXL34X_CMD_MULTB	(1 << 6)
+#define ADXL34X_CMD_READ	(1 << 7)
+#define ADXL34X_WRITECMD(reg)	(reg & 0x3F)
+#define ADXL34X_READCMD(reg)	(ADXL34X_CMD_READ | (reg & 0x3F))
+#define ADXL34X_READMB_CMD(reg) (ADXL34X_CMD_READ | ADXL34X_CMD_MULTB \
+					| (reg & 0x3F))
+
+static int adxl34x_spi_read(struct device *dev, unsigned char reg)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char cmd;
+
+	cmd = ADXL34X_READCMD(reg);
+
+	return spi_w8r8(spi, cmd);
+}
+
+static int adxl34x_spi_write(struct device *dev,
+			     unsigned char reg, unsigned char val)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned char buf[2];
+
+	buf[0] = ADXL34X_WRITECMD(reg);
+	buf[1] = val;
+
+	return spi_write(spi, buf, sizeof(buf));
+}
+
+static int adxl34x_spi_read_block(struct device *dev,
+				  unsigned char reg, int count,
+				  unsigned char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	ssize_t status;
+
+	reg = ADXL34X_READMB_CMD(reg);
+	status = spi_write_then_read(spi, &reg, 1, buf, count);
+
+	return (status < 0) ? status : 0;
+}
+
+static int __devinit adxl34x_spi_probe(struct spi_device *spi)
+{
+	struct adxl34x *ac;
+	int error;
+
+	/* don't exceed max specified SPI CLK frequency */
+	if (spi->max_speed_hz > MAX_SPI_FREQ_HZ) {
+		dev_err(&spi->dev, "SPI CLK %d Hz too fast\n", spi->max_speed_hz);
+		return -EINVAL;
+	}
+
+	error = adxl34x_probe(&ac, &spi->dev, BUS_SPI, spi->irq,
+		spi->max_speed_hz > MAX_FREQ_NO_FIFODELAY,
+		adxl34x_spi_read, adxl34x_spi_read_block, adxl34x_spi_write);
+	spi_set_drvdata(spi, ac);
+
+	return error;
+}
+
+static int __devexit adxl34x_spi_remove(struct spi_device *spi)
+{
+	return adxl34x_remove(dev_get_drvdata(&spi->dev));
+}
+
+#ifdef CONFIG_PM
+static int adxl34x_suspend(struct spi_device *spi, pm_message_t message)
+{
+	adxl34x_disable(spi_get_drvdata(spi));
+	return 0;
+}
+
+static int adxl34x_resume(struct spi_device *spi)
+{
+	adxl34x_enable(spi_get_drvdata(spi));
+	return 0;
+}
+#else
+# define adxl34x_suspend NULL
+# define adxl34x_resume  NULL
+#endif
+
+static struct spi_driver adxl34x_driver = {
+	.driver = {
+		.name = "adxl34x",
+		.bus = &spi_bus_type,
+		.owner = THIS_MODULE,
+	},
+	.probe   = adxl34x_spi_probe,
+	.remove  = __devexit_p(adxl34x_spi_remove),
+	.suspend = adxl34x_suspend,
+	.resume  = adxl34x_resume,
+};
+
+static int __init adxl34x_spi_init(void)
+{
+	return spi_register_driver(&adxl34x_driver);
+}
+module_init(adxl34x_spi_init);
+
+static void __exit adxl34x_spi_exit(void)
+{
+	spi_unregister_driver(&adxl34x_driver);
+}
+module_exit(adxl34x_spi_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>");
+MODULE_DESCRIPTION("ADXL345/346 Three-Axis Digital Accelerometer SPI Bus Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
new file mode 100644
index 0000000..7e28360
--- /dev/null
+++ b/drivers/input/misc/adxl34x.c
@@ -0,0 +1,875 @@
+/*
+ * ADXL345/346 Three-Axis Digital Accelerometers
+ *
+ * Enter bugs at http://blackfin.uclinux.org/
+ *
+ * Copyright (C) 2009 Michael Hennerich, Analog Devices Inc.
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c.h>
+
+#include <linux/input/adxl34x.h>
+
+#include "adxl34x.h"
+
+/* ADXL345/6 Register Map */
+#define DEVID		0x00	/* R   Device ID */
+#define THRESH_TAP	0x1D	/* R/W Tap threshold */
+#define OFSX		0x1E	/* R/W X-axis offset */
+#define OFSY		0x1F	/* R/W Y-axis offset */
+#define OFSZ		0x20	/* R/W Z-axis offset */
+#define DUR		0x21	/* R/W Tap duration */
+#define LATENT		0x22	/* R/W Tap latency */
+#define WINDOW		0x23	/* R/W Tap window */
+#define THRESH_ACT	0x24	/* R/W Activity threshold */
+#define THRESH_INACT	0x25	/* R/W Inactivity threshold */
+#define TIME_INACT	0x26	/* R/W Inactivity time */
+#define ACT_INACT_CTL	0x27	/* R/W Axis enable control for activity and */
+				/* inactivity detection */
+#define THRESH_FF	0x28	/* R/W Free-fall threshold */
+#define TIME_FF		0x29	/* R/W Free-fall time */
+#define TAP_AXES	0x2A	/* R/W Axis control for tap/double tap */
+#define ACT_TAP_STATUS	0x2B	/* R   Source of tap/double tap */
+#define BW_RATE		0x2C	/* R/W Data rate and power mode control */
+#define POWER_CTL	0x2D	/* R/W Power saving features control */
+#define INT_ENABLE	0x2E	/* R/W Interrupt enable control */
+#define INT_MAP		0x2F	/* R/W Interrupt mapping control */
+#define INT_SOURCE	0x30	/* R   Source of interrupts */
+#define DATA_FORMAT	0x31	/* R/W Data format control */
+#define DATAX0		0x32	/* R   X-Axis Data 0 */
+#define DATAX1		0x33	/* R   X-Axis Data 1 */
+#define DATAY0		0x34	/* R   Y-Axis Data 0 */
+#define DATAY1		0x35	/* R   Y-Axis Data 1 */
+#define DATAZ0		0x36	/* R   Z-Axis Data 0 */
+#define DATAZ1		0x37	/* R   Z-Axis Data 1 */
+#define FIFO_CTL	0x38	/* R/W FIFO control */
+#define FIFO_STATUS	0x39	/* R   FIFO status */
+#define TAP_SIGN	0x3A	/* R   Sign and source for tap/double tap */
+/* Orientation ADXL346 only */
+#define ORIENT_CONF	0x3B	/* R/W Orientation configuration */
+#define ORIENT		0x3C	/* R   Orientation status */
+
+/* DEVIDs */
+#define ID_ADXL345	0xE5
+#define ID_ADXL346	0xE6
+
+/* INT_ENABLE/INT_MAP/INT_SOURCE Bits */
+#define DATA_READY	(1 << 7)
+#define SINGLE_TAP	(1 << 6)
+#define DOUBLE_TAP	(1 << 5)
+#define ACTIVITY	(1 << 4)
+#define INACTIVITY	(1 << 3)
+#define FREE_FALL	(1 << 2)
+#define WATERMARK	(1 << 1)
+#define OVERRUN		(1 << 0)
+
+/* ACT_INACT_CONTROL Bits */
+#define ACT_ACDC	(1 << 7)
+#define ACT_X_EN	(1 << 6)
+#define ACT_Y_EN	(1 << 5)
+#define ACT_Z_EN	(1 << 4)
+#define INACT_ACDC	(1 << 3)
+#define INACT_X_EN	(1 << 2)
+#define INACT_Y_EN	(1 << 1)
+#define INACT_Z_EN	(1 << 0)
+
+/* TAP_AXES Bits */
+#define SUPPRESS	(1 << 3)
+#define TAP_X_EN	(1 << 2)
+#define TAP_Y_EN	(1 << 1)
+#define TAP_Z_EN	(1 << 0)
+
+/* ACT_TAP_STATUS Bits */
+#define ACT_X_SRC	(1 << 6)
+#define ACT_Y_SRC	(1 << 5)
+#define ACT_Z_SRC	(1 << 4)
+#define ASLEEP		(1 << 3)
+#define TAP_X_SRC	(1 << 2)
+#define TAP_Y_SRC	(1 << 1)
+#define TAP_Z_SRC	(1 << 0)
+
+/* BW_RATE Bits */
+#define LOW_POWER	(1 << 4)
+#define RATE(x)		((x) & 0xF)
+
+/* POWER_CTL Bits */
+#define PCTL_LINK	(1 << 5)
+#define PCTL_AUTO_SLEEP (1 << 4)
+#define PCTL_MEASURE	(1 << 3)
+#define PCTL_SLEEP	(1 << 2)
+#define PCTL_WAKEUP(x)	((x) & 0x3)
+
+/* DATA_FORMAT Bits */
+#define SELF_TEST	(1 << 7)
+#define SPI		(1 << 6)
+#define INT_INVERT	(1 << 5)
+#define FULL_RES	(1 << 3)
+#define JUSTIFY		(1 << 2)
+#define RANGE(x)	((x) & 0x3)
+#define RANGE_PM_2g	0
+#define RANGE_PM_4g	1
+#define RANGE_PM_8g	2
+#define RANGE_PM_16g	3
+
+/*
+ * Maximum value our axis may get in full res mode for the input device
+ * (signed 13 bits)
+ */
+#define ADXL_FULLRES_MAX_VAL 4096
+
+/*
+ * Maximum value our axis may get in fixed res mode for the input device
+ * (signed 10 bits)
+ */
+#define ADXL_FIXEDRES_MAX_VAL 512
+
+/* FIFO_CTL Bits */
+#define FIFO_MODE(x)	(((x) & 0x3) << 6)
+#define FIFO_BYPASS	0
+#define FIFO_FIFO	1
+#define FIFO_STREAM	2
+#define FIFO_TRIGGER	3
+#define TRIGGER		(1 << 5)
+#define SAMPLES(x)	((x) & 0x1F)
+
+/* FIFO_STATUS Bits */
+#define FIFO_TRIG	(1 << 7)
+#define ENTRIES(x)	((x) & 0x3F)
+
+/* TAP_SIGN Bits ADXL346 only */
+#define XSIGN		(1 << 6)
+#define YSIGN		(1 << 5)
+#define ZSIGN		(1 << 4)
+#define XTAP		(1 << 3)
+#define YTAP		(1 << 2)
+#define ZTAP		(1 << 1)
+
+/* ORIENT_CONF ADXL346 only */
+#define ORIENT_DEADZONE(x)	(((x) & 0x7) << 4)
+#define ORIENT_DIVISOR(x)	((x) & 0x7)
+
+/* ORIENT ADXL346 only */
+#define ADXL346_2D_VALID		(1 << 6)
+#define ADXL346_2D_ORIENT(x)		(((x) & 0x3) >> 4)
+#define ADXL346_3D_VALID		(1 << 3)
+#define ADXL346_3D_ORIENT(x)		((x) & 0x7)
+#define ADXL346_2D_PORTRAIT_POS		0	/* +X */
+#define ADXL346_2D_PORTRAIT_NEG		1	/* -X */
+#define ADXL346_2D_LANDSCAPE_POS	2	/* +Y */
+#define ADXL346_2D_LANDSCAPE_NEG	3	/* -Y */
+
+#define ADXL346_3D_FRONT		3	/* +X */
+#define ADXL346_3D_BACK			4	/* -X */
+#define ADXL346_3D_RIGHT		2	/* +Y */
+#define ADXL346_3D_LEFT			5	/* -Y */
+#define ADXL346_3D_TOP			1	/* +Z */
+#define ADXL346_3D_BOTTOM		6	/* -Z */
+
+#undef ADXL_DEBUG
+
+#define AC_READ(ac, reg)	((ac)->read((ac)->dev, reg))
+#define AC_WRITE(ac, reg, val)	((ac)->write((ac)->dev, reg, val))
+
+struct axis_triple {
+	int x;
+	int y;
+	int z;
+};
+
+struct adxl34x {
+	struct device *dev;
+	int irq;
+	struct input_dev *input;
+	struct work_struct work;
+	struct mutex mutex;	/* reentrant protection for struct */
+	struct adxl34x_platform_data pdata;
+	struct axis_triple swcal;
+	struct axis_triple hwcal;
+	struct axis_triple saved;
+	char phys[32];
+	unsigned disabled:1;	/* P: mutex */
+	unsigned opened:1;	/* P: mutex */
+	unsigned fifo_delay:1;
+	unsigned model;
+	unsigned int_mask;
+
+	adxl34x_read_t *read;
+	adxl34x_read_block_t *read_block;
+	adxl34x_write_t *write;
+};
+
+static const struct adxl34x_platform_data adxl34x_default_init = {
+	.tap_threshold = 35,
+	.tap_duration = 3,
+	.tap_latency = 20,
+	.tap_window = 20,
+	.tap_axis_control = ADXL_TAP_X_EN | ADXL_TAP_Y_EN | ADXL_TAP_Z_EN,
+	.act_axis_control = 0xFF,
+	.activity_threshold = 6,
+	.inactivity_threshold = 4,
+	.inactivity_time = 3,
+	.free_fall_threshold = 8,
+	.free_fall_time = 0x20,
+	.data_rate = 8,
+	.data_range = ADXL_FULL_RES,
+
+	.ev_type = EV_ABS,
+	.ev_code_x = ABS_X,	/* EV_REL */
+	.ev_code_y = ABS_Y,	/* EV_REL */
+	.ev_code_z = ABS_Z,	/* EV_REL */
+
+	.ev_code_tap_x = BTN_TOUCH,	/* EV_KEY */
+	.ev_code_tap_y = BTN_TOUCH,	/* EV_KEY */
+	.ev_code_tap_z = BTN_TOUCH,	/* EV_KEY */
+	.power_mode = ADXL_AUTO_SLEEP | ADXL_LINK,
+	.fifo_mode = FIFO_STREAM,
+	.watermark = 0,
+};
+
+static void adxl34x_get_triple(struct adxl34x *ac, struct axis_triple *axis)
+{
+	short buf[3];
+
+	ac->read_block(ac->dev, DATAX0, DATAZ1 - DATAX0 + 1,
+		       (unsigned char *)buf);
+
+	mutex_lock(&ac->mutex);
+	ac->saved.x = (s16) le16_to_cpu(buf[0]);
+	axis->x = ac->saved.x;
+
+	ac->saved.y = (s16) le16_to_cpu(buf[1]);
+	axis->y = ac->saved.y;
+
+	ac->saved.z = (s16) le16_to_cpu(buf[2]);
+	axis->z = ac->saved.z;
+	mutex_unlock(&ac->mutex);
+}
+
+static void adxl34x_service_ev_fifo(struct adxl34x *ac)
+{
+	struct adxl34x_platform_data *pdata = &ac->pdata;
+	struct axis_triple axis;
+
+	adxl34x_get_triple(ac, &axis);
+
+	input_event(ac->input, pdata->ev_type, pdata->ev_code_x,
+		    axis.x - ac->swcal.x);
+	input_event(ac->input, pdata->ev_type, pdata->ev_code_y,
+		    axis.y - ac->swcal.y);
+	input_event(ac->input, pdata->ev_type, pdata->ev_code_z,
+		    axis.z - ac->swcal.z);
+}
+
+static void adxl34x_report_key_single(struct input_dev *input, int key)
+{
+	input_report_key(input, key, 1);
+	input_sync(input);
+	input_report_key(input, key, 0);
+}
+
+static void adxl34x_report_key_double(struct input_dev *input, int key)
+{
+	input_report_key(input, key, 1);
+	input_sync(input);
+	input_report_key(input, key, 0);
+	input_sync(input);
+	input_report_key(input, key, 1);
+	input_sync(input);
+	input_report_key(input, key, 0);
+}
+
+static void adxl34x_work(struct work_struct *work)
+{
+	struct adxl34x *ac = container_of(work, struct adxl34x, work);
+	struct adxl34x_platform_data *pdata = &ac->pdata;
+	int int_stat, tap_stat, samples;
+
+	/*
+	 * ACT_TAP_STATUS should be read before clearing the interrupt
+	 * Avoid reading ACT_TAP_STATUS in case TAP detection is disabled
+	 */
+
+	if (pdata->tap_axis_control & (TAP_X_EN | TAP_Y_EN | TAP_Z_EN))
+		tap_stat = AC_READ(ac, ACT_TAP_STATUS);
+	else
+		tap_stat = 0;
+
+	int_stat = AC_READ(ac, INT_SOURCE);
+
+	if (int_stat & FREE_FALL)
+		adxl34x_report_key_single(ac->input, pdata->ev_code_ff);
+
+	if (int_stat & OVERRUN)
+		dev_dbg(ac->dev, "OVERRUN\n");
+
+	if (int_stat & SINGLE_TAP) {
+		if (tap_stat & TAP_X_SRC)
+			adxl34x_report_key_single(ac->input,
+						  pdata->ev_code_tap_x);
+		if (tap_stat & TAP_Y_SRC)
+			adxl34x_report_key_single(ac->input,
+						  pdata->ev_code_tap_y);
+		if (tap_stat & TAP_Z_SRC)
+			adxl34x_report_key_single(ac->input,
+						  pdata->ev_code_tap_z);
+	}
+
+	if (int_stat & DOUBLE_TAP) {
+		if (tap_stat & TAP_X_SRC)
+			adxl34x_report_key_double(ac->input,
+						  pdata->ev_code_tap_x);
+		if (tap_stat & TAP_Y_SRC)
+			adxl34x_report_key_double(ac->input,
+						  pdata->ev_code_tap_y);
+		if (tap_stat & TAP_Z_SRC)
+			adxl34x_report_key_double(ac->input,
+						  pdata->ev_code_tap_z);
+	}
+
+	if (pdata->ev_code_act_inactivity) {
+		if (int_stat & ACTIVITY)
+			input_report_key(ac->input,
+					 pdata->ev_code_act_inactivity, 1);
+		if (int_stat & INACTIVITY)
+			input_report_key(ac->input,
+					 pdata->ev_code_act_inactivity, 0);
+	}
+
+	if (int_stat & (DATA_READY | WATERMARK)) {
+
+		if (pdata->fifo_mode)
+			samples = ENTRIES(AC_READ(ac, FIFO_STATUS)) + 1;
+		else
+			samples = 1;
+
+		for (; samples > 0; samples--) {
+			adxl34x_service_ev_fifo(ac);
+			/*
+			 * To ensure that the FIFO has
+			 * completely popped, there must be at least 5 us between
+			 * the end of reading the data registers, signified by the
+			 * transition to register 0x38 from 0x37 or the CS pin
+			 * going high, and the start of new reads of the FIFO or
+			 * reading the FIFO_STATUS register. For SPI operation at
+			 * 1.5 MHz or lower, the register addressing portion of the
+			 * transmission is sufficient delay to ensure the FIFO has
+			 * completely popped. It is necessary for SPI operation
+			 * greater than 1.5 MHz to de-assert the CS pin to ensure a
+			 * total of 5 us, which is at most 3.4 us at 5 MHz
+			 * operation.
+			 */
+			if (ac->fifo_delay && (samples > 1))
+				udelay(3);
+		}
+	}
+
+	input_sync(ac->input);
+	enable_irq(ac->irq);
+}
+
+static irqreturn_t adxl34x_irq(int irq, void *handle)
+{
+	struct adxl34x *ac = handle;
+
+	disable_irq_nosync(irq);
+	schedule_work(&ac->work);
+
+	return IRQ_HANDLED;
+}
+
+void adxl34x_disable(struct adxl34x *ac)
+{
+	mutex_lock(&ac->mutex);
+	if (!ac->disabled && ac->opened) {
+		ac->disabled = 1;
+		cancel_work_sync(&ac->work);
+		/*
+		 * A '0' places the ADXL34x into standby mode
+		 * with minimum power consumption.
+		 */
+		AC_WRITE(ac, POWER_CTL, 0);
+	}
+	mutex_unlock(&ac->mutex);
+}
+EXPORT_SYMBOL_GPL(adxl34x_disable);
+
+void adxl34x_enable(struct adxl34x *ac)
+{
+	mutex_lock(&ac->mutex);
+	if (ac->disabled && ac->opened) {
+		AC_WRITE(ac, POWER_CTL, ac->pdata.power_mode | PCTL_MEASURE);
+		ac->disabled = 0;
+	}
+	mutex_unlock(&ac->mutex);
+}
+EXPORT_SYMBOL_GPL(adxl34x_enable);
+
+static ssize_t adxl34x_disable_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", ac->disabled);
+}
+
+static ssize_t adxl34x_disable_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	unsigned long val;
+	int error;
+
+	error = strict_strtoul(buf, 10, &val);
+	if (error)
+		return error;
+
+	if (val)
+		adxl34x_disable(ac);
+	else
+		adxl34x_enable(ac);
+
+	return count;
+}
+
+static DEVICE_ATTR(disable, 0664, adxl34x_disable_show, adxl34x_disable_store);
+
+static ssize_t adxl34x_calibrate_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	ssize_t count;
+
+	mutex_lock(&ac->mutex);
+	count = sprintf(buf, "%d,%d,%d\n", ac->hwcal.x * 4 + ac->swcal.x,
+			ac->hwcal.y * 4 + ac->swcal.y,
+			ac->hwcal.z * 4 + ac->swcal.z);
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static ssize_t adxl34x_calibrate_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+
+	/*
+	 * Hardware offset calibration has a resolution of 15.6 mg/LSB.
+	 * We use HW calibration and handle the remaining bits in SW. (4mg/LSB)
+	 */
+
+	mutex_lock(&ac->mutex);
+	ac->hwcal.x -= (ac->saved.x / 4);
+	ac->swcal.x = ac->saved.x % 4;
+
+	ac->hwcal.y -= (ac->saved.y / 4);
+	ac->swcal.y = ac->saved.y % 4;
+
+	ac->hwcal.z -= (ac->saved.z / 4);
+	ac->swcal.z = ac->saved.z % 4;
+
+	AC_WRITE(ac, OFSX, (s8) ac->hwcal.x);
+	AC_WRITE(ac, OFSY, (s8) ac->hwcal.y);
+	AC_WRITE(ac, OFSZ, (s8) ac->hwcal.z);
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(calibrate, 0664, adxl34x_calibrate_show,
+		   adxl34x_calibrate_store);
+
+static ssize_t adxl34x_rate_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	ssize_t count;
+
+	mutex_lock(&ac->mutex);
+	count = sprintf(buf, "%u\n", RATE(ac->pdata.data_rate));
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static ssize_t adxl34x_rate_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	unsigned long val;
+	int error;
+
+	mutex_lock(&ac->mutex);
+	error = strict_strtoul(buf, 10, &val);
+	if (error)
+		return error;
+
+	ac->pdata.data_rate = RATE(val);
+
+	AC_WRITE(ac, BW_RATE, ac->pdata.data_rate |
+		 (ac->pdata.low_power_mode ? LOW_POWER : 0));
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(rate, 0664, adxl34x_rate_show, adxl34x_rate_store);
+
+static ssize_t adxl34x_autosleep_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	ssize_t count;
+
+	mutex_lock(&ac->mutex);
+	count = sprintf(buf, "%u\n", ac->pdata.power_mode &
+		(PCTL_AUTO_SLEEP | PCTL_LINK) ? 1 : 0);
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static ssize_t adxl34x_autosleep_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	unsigned long val;
+	int error;
+
+	mutex_lock(&ac->mutex);
+	error = strict_strtoul(buf, 10, &val);
+	if (error)
+		return error;
+
+	if (val)
+		ac->pdata.power_mode |= (PCTL_AUTO_SLEEP | PCTL_LINK);
+	else
+		ac->pdata.power_mode &= ~(PCTL_AUTO_SLEEP | PCTL_LINK);
+
+	if (!ac->disabled && ac->opened)
+		AC_WRITE(ac, POWER_CTL, ac->pdata.power_mode | PCTL_MEASURE);
+
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(autosleep, 0664, adxl34x_autosleep_show,
+		   adxl34x_autosleep_store);
+
+static ssize_t adxl34x_position_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	ssize_t count;
+
+	mutex_lock(&ac->mutex);
+
+	count = sprintf(buf, "(%d, %d, %d)\n",
+			ac->saved.x, ac->saved.y, ac->saved.z);
+
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(position, 0444, adxl34x_position_show, NULL);
+
+#ifdef ADXL_DEBUG
+static ssize_t adxl34x_write_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct adxl34x *ac = dev_get_drvdata(dev);
+	unsigned long val;
+	int error;
+
+	/*
+	 * This allows basic ADXL register write access for debug purposes.
+	 */
+	mutex_lock(&ac->mutex);
+	error = strict_strtoul(buf, 16, &val);
+	if (error)
+		return error;
+
+	AC_WRITE(ac, val >> 8, val & 0xFF);
+	mutex_unlock(&ac->mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR(write, 0664, NULL, adxl34x_write_store);
+#endif
+
+static struct attribute *adxl34x_attributes[] = {
+	&dev_attr_disable.attr,
+	&dev_attr_calibrate.attr,
+	&dev_attr_rate.attr,
+	&dev_attr_autosleep.attr,
+	&dev_attr_position.attr,
+#ifdef ADXL_DEBUG
+	&dev_attr_write.attr,
+#endif
+	NULL
+};
+
+static const struct attribute_group adxl34x_attr_group = {
+	.attrs = adxl34x_attributes,
+};
+
+static int adxl34x_input_open(struct input_dev *input)
+{
+	struct adxl34x *ac = input_get_drvdata(input);
+
+	mutex_lock(&ac->mutex);
+	ac->opened = 1;
+	mutex_unlock(&ac->mutex);
+
+	adxl34x_enable(ac);
+
+	return 0;
+}
+
+static void adxl34x_input_close(struct input_dev *input)
+{
+	struct adxl34x *ac = input_get_drvdata(input);
+
+	adxl34x_disable(ac);
+
+	mutex_lock(&ac->mutex);
+	ac->opened = 0;
+	mutex_unlock(&ac->mutex);
+}
+
+int adxl34x_probe(struct adxl34x **pac, struct device *dev, u16 bus_type,
+	int irq, int fifo_delay_default, adxl34x_read_t read,
+	adxl34x_read_block_t read_block, adxl34x_write_t write)
+{
+	struct adxl34x *ac;
+	struct input_dev *input_dev;
+	struct adxl34x_platform_data *pdata;
+	int err, range;
+	unsigned char revid;
+
+	if (!irq) {
+		dev_err(dev, "no IRQ?\n");
+		return -ENODEV;
+	}
+
+	*pac = ac = kzalloc(sizeof(*ac), GFP_KERNEL);
+	if (!ac)
+		return -ENOMEM;
+	ac->fifo_delay = fifo_delay_default;
+
+	pdata = dev->platform_data;
+	if (!pdata) {
+		dev_dbg(dev,
+			"No platfrom data: Using default initialization\n");
+		pdata = (struct adxl34x_platform_data *)&adxl34x_default_init;
+	}
+	memcpy(&ac->pdata, pdata, sizeof(*pdata));
+	pdata = &ac->pdata;
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		return -ENOMEM;
+
+	ac->input = input_dev;
+	ac->disabled = 1;
+	ac->dev = dev;
+	ac->irq = irq;
+	ac->write = write;
+	ac->read = read;
+	ac->read_block = read_block;
+
+	INIT_WORK(&ac->work, adxl34x_work);
+	mutex_init(&ac->mutex);
+
+	input_dev->name = "ADXL34x accelerometer";
+	revid = ac->read(dev, DEVID);
+
+	switch (revid) {
+	case ID_ADXL345:
+		ac->model = 345;
+		break;
+	case ID_ADXL346:
+		ac->model = 346;
+		break;
+	default:
+		dev_err(dev, "Failed to probe %s\n", input_dev->name);
+		err = -ENODEV;
+		goto err_free_mem;
+	}
+
+	snprintf(ac->phys, sizeof(ac->phys), "%s/input0", dev_name(dev));
+
+	input_dev->phys = ac->phys;
+	input_dev->dev.parent = dev;
+	input_dev->id.product = ac->model;
+	input_dev->id.bustype = bus_type;
+	input_dev->open = adxl34x_input_open;
+	input_dev->close = adxl34x_input_close;
+
+	input_set_drvdata(input_dev, ac);
+
+	__set_bit(ac->pdata.ev_type, input_dev->evbit);
+
+	if (ac->pdata.ev_type == EV_REL) {
+		__set_bit(REL_X, input_dev->relbit);
+		__set_bit(REL_Y, input_dev->relbit);
+		__set_bit(REL_Z, input_dev->relbit);
+	} else {
+		/* EV_ABS */
+		__set_bit(ABS_X, input_dev->absbit);
+		__set_bit(ABS_Y, input_dev->absbit);
+		__set_bit(ABS_Z, input_dev->absbit);
+
+		if (pdata->data_range & FULL_RES)
+			range = ADXL_FULLRES_MAX_VAL;	/* Signed 13-bit */
+		else
+			range = ADXL_FIXEDRES_MAX_VAL;	/* Signed 10-bit */
+
+		input_set_abs_params(input_dev, ABS_X, -range, range, 3, 3);
+		input_set_abs_params(input_dev, ABS_Y, -range, range, 3, 3);
+		input_set_abs_params(input_dev, ABS_Z, -range, range, 3, 3);
+	}
+
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(pdata->ev_code_tap_x, input_dev->keybit);
+	__set_bit(pdata->ev_code_tap_y, input_dev->keybit);
+	__set_bit(pdata->ev_code_tap_z, input_dev->keybit);
+
+	if (pdata->ev_code_ff) {
+		ac->int_mask = FREE_FALL;
+		__set_bit(pdata->ev_code_ff, input_dev->keybit);
+	}
+
+	if (pdata->ev_code_act_inactivity)
+		__set_bit(pdata->ev_code_act_inactivity, input_dev->keybit);
+
+	ac->int_mask |= ACTIVITY | INACTIVITY;
+
+	if (pdata->watermark) {
+		ac->int_mask |= WATERMARK;
+		if (!FIFO_MODE(pdata->fifo_mode))
+			pdata->fifo_mode |= FIFO_STREAM;
+	} else {
+		ac->int_mask |= DATA_READY;
+	}
+
+	if (pdata->tap_axis_control & (TAP_X_EN | TAP_Y_EN | TAP_Z_EN))
+		ac->int_mask |= SINGLE_TAP | DOUBLE_TAP;
+
+	if (FIFO_MODE(pdata->fifo_mode) == FIFO_BYPASS)
+		ac->fifo_delay = 0;
+
+	ac->write(dev, POWER_CTL, 0);
+
+	err = request_irq(ac->irq, adxl34x_irq,
+			  IRQF_TRIGGER_HIGH, dev_name(dev), ac);
+	if (err) {
+		dev_err(dev, "irq %d busy?\n", ac->irq);
+		goto err_free_mem;
+	}
+
+	err = sysfs_create_group(&dev->kobj, &adxl34x_attr_group);
+	if (err)
+		goto err_free_irq;
+
+	err = input_register_device(input_dev);
+	if (err)
+		goto err_remove_attr;
+
+	AC_WRITE(ac, THRESH_TAP, pdata->tap_threshold);
+	AC_WRITE(ac, OFSX, pdata->x_axis_offset);
+	ac->hwcal.x = pdata->x_axis_offset;
+	AC_WRITE(ac, OFSY, pdata->y_axis_offset);
+	ac->hwcal.y = pdata->y_axis_offset;
+	AC_WRITE(ac, OFSZ, pdata->z_axis_offset);
+	ac->hwcal.z = pdata->z_axis_offset;
+	AC_WRITE(ac, THRESH_TAP, pdata->tap_threshold);
+	AC_WRITE(ac, DUR, pdata->tap_duration);
+	AC_WRITE(ac, LATENT, pdata->tap_latency);
+	AC_WRITE(ac, WINDOW, pdata->tap_window);
+	AC_WRITE(ac, THRESH_ACT, pdata->activity_threshold);
+	AC_WRITE(ac, THRESH_INACT, pdata->inactivity_threshold);
+	AC_WRITE(ac, TIME_INACT, pdata->inactivity_time);
+	AC_WRITE(ac, THRESH_FF, pdata->free_fall_threshold);
+	AC_WRITE(ac, TIME_FF, pdata->free_fall_time);
+	AC_WRITE(ac, TAP_AXES, pdata->tap_axis_control);
+	AC_WRITE(ac, ACT_INACT_CTL, pdata->act_axis_control);
+	AC_WRITE(ac, BW_RATE, RATE(ac->pdata.data_rate) |
+		 (pdata->low_power_mode ? LOW_POWER : 0));
+	AC_WRITE(ac, DATA_FORMAT, pdata->data_range);
+	AC_WRITE(ac, FIFO_CTL, FIFO_MODE(pdata->fifo_mode) |
+			SAMPLES(pdata->watermark));
+
+	if (pdata->use_int2)
+		/* Map all INTs to INT2 */
+		AC_WRITE(ac, INT_MAP, ac->int_mask | OVERRUN);
+	else
+		/* Map all INTs to INT1 */
+		AC_WRITE(ac, INT_MAP, 0);
+
+	AC_WRITE(ac, INT_ENABLE, ac->int_mask | OVERRUN);
+
+	pdata->power_mode &= (PCTL_AUTO_SLEEP | PCTL_LINK);
+
+	dev_info(dev, "ADXL%d accelerometer, irq %d\n",
+		 ac->model, ac->irq);
+
+	return 0;
+
+ err_remove_attr:
+	sysfs_remove_group(&dev->kobj, &adxl34x_attr_group);
+ err_free_irq:
+	free_irq(ac->irq, ac);
+ err_free_mem:
+	input_free_device(input_dev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(adxl34x_probe);
+
+int adxl34x_remove(struct adxl34x *ac)
+{
+	adxl34x_disable(ac);
+	sysfs_remove_group(&ac->dev->kobj, &adxl34x_attr_group);
+	free_irq(ac->irq, ac);
+	input_unregister_device(ac->input);
+	dev_dbg(ac->dev, "unregistered accelerometer\n");
+	kfree(ac);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(adxl34x_remove);
+
+/* Stub functions so we can load/unload the module */
+static __init int adxl34x_init(void)
+{
+	return 0;
+}
+module_init(adxl34x_init);
+
+static __exit void adxl34x_exit(void)
+{
+}
+module_exit(adxl34x_exit);
+
+MODULE_AUTHOR("Michael Hennerich <hennerich-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>");
+MODULE_DESCRIPTION("ADXL345/346 Three-Axis Digital Accelerometer Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/input/misc/adxl34x.h b/drivers/input/misc/adxl34x.h
new file mode 100644
index 0000000..92ef77c
--- /dev/null
+++ b/drivers/input/misc/adxl34x.h
@@ -0,0 +1,26 @@
+/*
+ * ADXL345/346 Three-Axis Digital Accelerometers (I2C/SPI Interface)
+ *
+ * Enter bugs at http://blackfin.uclinux.org/
+ *
+ * Copyright (C) 2009 Michael Hennerich, Analog Devices Inc.
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef _ADXL34X_H_
+#define _ADXL34X_H_
+
+struct device;
+struct adxl34x;
+typedef int (adxl34x_read_t) (struct device *, unsigned char);
+typedef int (adxl34x_read_block_t) (struct device *, unsigned char, int, unsigned char *);
+typedef int (adxl34x_write_t) (struct device *, unsigned char, unsigned char);
+
+void adxl34x_disable(struct adxl34x *ac);
+void adxl34x_enable(struct adxl34x *ac);
+int adxl34x_probe(struct adxl34x **pac, struct device *dev, u16 bus_type,
+	int irq, int fifo_delay_default, adxl34x_read_t read,
+	adxl34x_read_block_t read_block, adxl34x_write_t write);
+int adxl34x_remove(struct adxl34x *ac);
+
+#endif
diff --git a/include/linux/input/adxl34x.h b/include/linux/input/adxl34x.h
new file mode 100644
index 0000000..2e7e807
--- /dev/null
+++ b/include/linux/input/adxl34x.h
@@ -0,0 +1,295 @@
+/*
+ * include/linux/input/adxl34x.h
+ *
+ * Digital Accelerometer characteristics are highly application specific
+ * and may vary between boards and models. The platform_data for the
+ * device's "struct device" holds this information.
+ *
+ * Copyright 2009 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#ifndef __LINUX_INPUT_ADXL34X_H__
+#define __LINUX_INPUT_ADXL34X_H__
+
+struct adxl34x_platform_data {
+
+	/*
+	 * X,Y,Z Axis Offset:
+	 * offer user offset adjustments in twoscompliment
+	 * form with a scale factor of 15.6 mg/LSB (i.e. 0x7F = +2 g)
+	 */
+
+	char x_axis_offset;
+	char y_axis_offset;
+	char z_axis_offset;
+
+	/*
+	 * TAP_X/Y/Z Enable: Setting TAP_X, Y, or Z Enable enables X,
+	 * Y, or Z participation in Tap detection. A '0' excludes the
+	 * selected axis from participation in Tap detection.
+	 * Setting the SUPPRESS bit suppresses Double Tap detection if
+	 * acceleration greater than tap_threshold is present between
+	 * taps.
+	 */
+
+#define ADXL_SUPPRESS 	(1 << 3)
+#define ADXL_TAP_X_EN 	(1 << 2)
+#define ADXL_TAP_Y_EN 	(1 << 1)
+#define ADXL_TAP_Z_EN 	(1 << 0)
+
+	unsigned char tap_axis_control;
+
+	/*
+	 * tap_threshold:
+	 * holds the threshold value for tap detection/interrupts.
+	 * The data format is unsigned. The scale factor is 62.5 mg/LSB
+	 * (i.e. 0xFF = +16 g). A zero value may result in undesirable
+	 * behavior if Tap/Double Tap is enabled.
+	 */
+
+	unsigned char tap_threshold;
+
+	/*
+	 * tap_duration:
+	 * is an unsigned time value representing the maximum
+	 * time that an event must be above the tap_threshold threshold
+	 * to qualify as a tap event. The scale factor is 625 us/LSB. A zero
+	 * value will prevent Tap/Double Tap functions from working.
+	 */
+
+	unsigned char tap_duration;
+
+	/*
+	 * tap_latency:
+	 * is an unsigned time value representing the wait time
+	 * from the detection of a tap event to the opening of the time
+	 * window tap_window for a possible second tap event. The scale
+	 * factor is 1.25 ms/LSB. A zero value will disable the Double Tap
+	 * function.
+	 */
+
+	unsigned char tap_latency;
+
+	/*
+	 * tap_window:
+	 * is an unsigned time value representing the amount
+	 * of time after the expiration of tap_latency during which a second
+	 * tap can begin. The scale factor is 1.25 ms/LSB. A zero value will
+	 * disable the Double Tap function.
+	 */
+
+	unsigned char tap_window;
+
+	/*
+	 * act_axis_control:
+	 * X/Y/Z Enable: A '1' enables X, Y, or Z participation in activity
+	 * or inactivity detection. A '0' excludes the selected axis from
+	 * participation. If all of the axes are excluded, the function is
+	 * disabled.
+	 * AC/DC: A '0' = DC coupled operation and a '1' = AC coupled
+	 * operation. In DC coupled operation, the current acceleration is
+	 * compared with activity_threshold and inactivity_threshold directly
+	 * to determine whether activity or inactivity is detected. In AC
+	 * coupled operation for activity detection, the acceleration value
+	 * at the start of activity detection is taken as a reference value.
+	 * New samples of acceleration are then compared to this
+	 * reference value and if the magnitude of the difference exceeds
+	 * activity_threshold the device will trigger an activity interrupt. In
+	 * AC coupled operation for inactivity detection, a reference value
+	 * is used again for comparison and is updated whenever the
+	 * device exceeds the inactivity threshold. Once the reference
+	 * value is selected, the device compares the magnitude of the
+	 * difference between the reference value and the current
+	 * acceleration with inactivity_threshold. If the difference is below
+	 * inactivity_threshold for a total of inactivity_time, the device is
+	 * considered inactive and the inactivity interrupt is triggered.
+	 */
+
+#define ADXL_ACT_ACDC   	(1 << 7)
+#define ADXL_ACT_X_EN   	(1 << 6)
+#define ADXL_ACT_Y_EN   	(1 << 5)
+#define ADXL_ACT_Z_EN   	(1 << 4)
+#define ADXL_INACT_ACDC 	(1 << 3)
+#define ADXL_INACT_X_EN 	(1 << 2)
+#define ADXL_INACT_Y_EN 	(1 << 1)
+#define ADXL_INACT_Z_EN 	(1 << 0)
+
+	unsigned char act_axis_control;
+
+	/*
+	 * activity_threshold:
+	 * holds the threshold value for activity detection.
+	 * The data format is unsigned. The scale factor is
+	 * 62.5 mg/LSB. A zero value may result in undesirable behavior if
+	 * Activity interrupt is enabled.
+	 */
+
+	unsigned char activity_threshold;
+
+	/*
+	 * inactivity_threshold:
+	 * holds the threshold value for inactivity
+	 * detection. The data format is unsigned. The scale
+	 * factor is 62.5 mg/LSB. A zero value may result in undesirable
+	 * behavior if Inactivity interrupt is enabled.
+	 */
+
+	unsigned char inactivity_threshold;
+
+	/*
+	 * inactivity_time:
+	 * is an unsigned time value representing the
+	 * amount of time that acceleration must be below the value in
+	 * inactivity_threshold for inactivity to be declared. The scale factor
+	 * is 1 second/LSB. Unlike the other interrupt functions, which
+	 * operate on unfiltered data, the inactivity function operates on the
+	 * filtered output data. At least one output sample must be
+	 * generated for the inactivity interrupt to be triggered. This will
+	 * result in the function appearing un-responsive if the
+	 * inactivity_time register is set with a value less than the time
+	 * constant of the Output Data Rate. A zero value will result in an
+	 * interrupt when the output data is below inactivity_threshold.
+	 */
+
+	unsigned char inactivity_time;
+
+	/*
+	 * free_fall_threshold:
+	 * holds the threshold value for Free-Fall detection.
+	 * The data format is unsigned. The root-sum-square(RSS) value
+	 * of all axes is calculated and compared to the value in
+	 * free_fall_threshold to determine if a free fall event may be
+	 * occurring.  The scale factor is 62.5 mg/LSB. A zero value may
+	 * result in undesirable behavior if Free-Fall interrupt is
+	 * enabled. Values between 300 and 600 mg (0x05 to 0x09) are
+	 * recommended.
+	 */
+
+	unsigned char free_fall_threshold;
+
+	/*
+	 * free_fall_time:
+	 * is an unsigned time value representing the minimum
+	 * time that the RSS value of all axes must be less than
+	 * free_fall_threshold to generate a Free-Fall interrupt. The
+	 * scale factor is 5 ms/LSB. A zero value may result in
+	 * undesirable behavior if Free-Fall interrupt is enabled.
+	 * Values between 100 to 350 ms (0x14 to 0x46) are recommended.
+	 */
+
+	unsigned char free_fall_time;
+
+	/*
+	 * data_rate:
+	 * Selects device bandwidth and output data rate.
+	 * RATE = 3200 Hz / (2^(15 - x)). Default value is 0x0A, or 100 Hz
+	 * Output Data Rate. An Output Data Rate should be selected that
+	 * is appropriate for the communication protocol and frequency
+	 * selected. Selecting too high of an Output Data Rate with a low
+	 * communication speed will result in samples being discarded.
+	 */
+
+	unsigned char data_rate;
+
+	/*
+	 * data_range:
+	 * FULL_RES: When this bit is set with the device is
+	 * in Full-Resolution Mode, where the output resolution increases
+	 * with RANGE to maintain a 4 mg/LSB scale factor. When this
+	 * bit is cleared the device is in 10-bit Mode and RANGE determine the
+	 * maximum g-Range and scale factor.
+	 */
+
+#define ADXL_FULL_RES    	(1 << 3)
+#define ADXL_RANGE_PM_2g	0
+#define ADXL_RANGE_PM_4g	1
+#define ADXL_RANGE_PM_8g	2
+#define ADXL_RANGE_PM_16g	3
+
+	unsigned char data_range;
+
+	/*
+	 * low_power_mode:
+	 * A '0' = Normal operation and a '1' = Reduced
+	 * power operation with somewhat higher noise.
+	 */
+
+	unsigned char low_power_mode;
+
+	/*
+	 * power_mode:
+	 * LINK: A '1' with both the activity and inactivity functions
+	 * enabled will delay the start of the activity function until
+	 * inactivity is detected. Once activity is detected, inactivity
+	 * detection will begin and prevent the detection of activity. This
+	 * bit serially links the activity and inactivity functions. When '0'
+	 * the inactivity and activity functions are concurrent. Additional
+	 * information can be found in the Application section under Link
+	 * Mode.
+	 * AUTO_SLEEP: A '1' sets the ADXL34x to switch to Sleep Mode
+	 * when inactivity (acceleration has been below inactivity_threshold
+	 * for at least inactivity_time) is detected and the LINK bit is set.
+	 * A '0' disables automatic switching to Sleep Mode. See SLEEP
+	 * for further description.
+	 */
+
+#define ADXL_LINK    	(1 << 5)
+#define ADXL_AUTO_SLEEP (1 << 4)
+
+	unsigned char power_mode;
+
+	/*
+	 * fifo_mode:
+	 * BYPASS The FIFO is bypassed
+	 * FIFO   FIFO collects up to 32 values then stops collecting data
+	 * STREAM FIFO holds the last 32 data values. Once full, the FIFO's
+	 * 	  oldest data is lost as it is replaced with newer data
+	 *
+	 * DEFAULT should be ADXL_FIFO_STREAM
+	 */
+
+#define ADXL_FIFO_BYPASS	0
+#define ADXL_FIFO_FIFO		1
+#define ADXL_FIFO_STREAM	2
+
+	unsigned char fifo_mode;
+
+	/*
+	 * watermark:
+	 * The Watermark feature can be used to reduce the interrupt load
+	 * of the system. The FIFO fills up to the value stored in watermark
+	 * [1..32] and then generates an interrupt.
+	 * A '0' disables the watermark feature.
+	 */
+
+	unsigned char watermark;
+
+	unsigned int ev_type;	/* EV_ABS or EV_REL */
+
+	unsigned int ev_code_x;	/* ABS_X,Y,Z or REL_X,Y,Z */
+	unsigned int ev_code_y;	/* ABS_X,Y,Z or REL_X,Y,Z */
+	unsigned int ev_code_z;	/* ABS_X,Y,Z or REL_X,Y,Z */
+
+	/*
+	 * A valid BTN or KEY Code; use tap_axis_control to disable
+	 * event reporting
+	 */
+
+	unsigned int ev_code_tap_x;	/* EV_KEY */
+	unsigned int ev_code_tap_y;	/* EV_KEY */
+	unsigned int ev_code_tap_z;	/* EV_KEY */
+
+	/*
+	 * A valid BTN or KEY Code for Free-Fall or Activity enables
+	 * input event reporting. A '0' disables the Free-Fall or
+	 * Activity reporting.
+	 */
+
+	unsigned int ev_code_ff;	/* EV_KEY */
+	unsigned int ev_code_act_inactivity;	/* EV_KEY */
+
+	unsigned char use_int2;
+};
+#endif
-- 
1.6.5
