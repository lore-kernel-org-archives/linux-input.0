From: Christopher Heiny <cheiny@synaptics.com>
Subject: =?UTF-8?q?=5BPATCH=2004/05=5D=20input=3A=20RMI4=20F01=20device=20control?=
Date: Fri, 18 Jan 2013 17:12:44 -0800
Message-ID: <1358557965-29065-5-git-send-email-cheiny@synaptics.com>
References: <1358557965-29065-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358557965-29065-1-git-send-email-cheiny@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>
List-Id: linux-input@vger.kernel.org

In addition to the changes described in 0/0 of this patchset, this patc=
h
includes device serialization updated to conform to the latest RMI4
specification.

Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: Joeri de Gram <j.de.gram@gmail.com>
Acked-by: Jean Delvare <khali@linux-fr.org>

---

 drivers/input/rmi4/rmi_f01.c | 1113 ++++++----------------------------=
--------
 drivers/input/rmi4/rmi_f01.h |  138 +++++-
 2 files changed, 250 insertions(+), 1001 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.=
c
index d7461d7..67afdeb 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -2,902 +2,64 @@
  * Copyright (c) 2011-2012 Synaptics Incorporated
  * Copyright (c) 2011 Unixphere
  *
- * This program is free software; you can redistribute it and/or modif=
y
- * it under the terms of the GNU General Public License as published b=
y
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
  */
=20
 #include <linux/kernel.h>
-#include <linux/debugfs.h>
 #include <linux/kconfig.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+
 #include "rmi_driver.h"
 #include "rmi_f01.h"
=20
-/**
- * @reset - set this bit to force a firmware reset of the sensor.
- */
-struct f01_device_commands {
-	u8 reset:1;
-	u8 reserved:7;
-};
-
-/**
- * @ctrl0 - see documentation in rmi_f01.h.
- * @interrupt_enable - A mask of per-function interrupts on the touch =
sensor.
- * @doze_interval - controls the interval between checks for finger pr=
esence
- * when the touch sensor is in doze mode, in units of 10ms.
- * @wakeup_threshold - controls the capacitance threshold at which the=
 touch
- * sensor will decide to wake up from that low power state.
- * @doze_holdoff - controls how long the touch sensor waits after the =
last
- * finger lifts before entering the doze state, in units of 100ms.
- */
-struct f01_device_control {
-	struct f01_device_control_0 ctrl0;
-	u8 *interrupt_enable;
-	u8 doze_interval;
-	u8 wakeup_threshold;
-	u8 doze_holdoff;
-};
-
-/**
- * @has_ds4_queries - if true, the query registers relating to Design =
Studio 4
- * features are present.
- * @has_multi_phy - if true, multiple physical communications interfac=
es are
- * supported.
- * @has_guest - if true, a "guest" device is supported.
- */
-struct f01_query_42 {
-	u8 has_ds4_queries:1;
-	u8 has_multi_phy:1;
-	u8 has_guest:1;
-	u8 reserved:5;
-} __attribute__((__packed__));
-
-/**
- * @length - the length of the remaining Query43.* register block, not
- * including the first register.
- * @has_package_id_query -  the package ID query data will be accessib=
le from
- * inside the ProductID query registers.
- * @has_packrat_query -  the packrat query data will be accessible fro=
m inside
- * the ProductID query registers.
- * @has_reset_query - the reset pin related registers are valid.
- * @has_maskrev_query - the silicon mask revision number will be repor=
ted.
- * @has_i2c_control - the register F01_RMI_Ctrl6 will exist.
- * @has_spi_control - the register F01_RMI_Ctrl7 will exist.
- * @has_attn_control - the register F01_RMI_Ctrl8 will exist.
- * @reset_enabled - the hardware reset pin functionality has been enab=
led
- * for this device.
- * @reset_polarity - If this bit reports as =E2=80=980=E2=80=99, it me=
ans that the reset state
- * is active low. A =E2=80=981=E2=80=99 means that the reset state is =
active high.
- * @pullup_enabled - If set, it indicates that a built-in weak pull up=
 has
- * been enabled on the Reset pin; clear means that no pull-up is prese=
nt.
- * @reset_pin_number - This field represents which GPIO pin number has=
 been
- * assigned the reset functionality.
- */
-struct f01_ds4_queries {
-	u8 length:4;
-	u8 reserved_1:4;
-
-	u8 has_package_id_query:1;
-	u8 has_packrat_query:1;
-	u8 has_reset_query:1;
-	u8 has_maskrev_query:1;
-	u8 reserved_2:4;
-
-	u8 has_i2c_control:1;
-	u8 has_spi_control:1;
-	u8 has_attn_control:1;
-	u8 reserved_3:5;
-
-	u8 reset_enabled:1;
-	u8 reset_polarity:1;
-	u8 pullup_enabled:1;
-	u8 reserved_4:1;
-	u8 reset_pin_number:4;
-} __attribute__((__packed__));
-
-struct f01_data {
-	struct f01_device_control device_control;
-	struct f01_basic_queries basic_queries;
-	struct f01_device_status device_status;
-	u8 product_id[RMI_PRODUCT_ID_LENGTH + 1];
-
-	u16 interrupt_enable_addr;
-	u16 doze_interval_addr;
-	u16 wakeup_threshold_addr;
-	u16 doze_holdoff_addr;
-
-	int irq_count;
-	int num_of_irq_regs;
-
-#ifdef CONFIG_PM
-	bool suspended;
-	bool old_nosleep;
-#endif
-
-#ifdef CONFIG_RMI4_DEBUG
-	struct dentry *debugfs_interrupt_enable;
-#endif
-};
-
-#ifdef CONFIG_RMI4_DEBUG
-struct f01_debugfs_data {
-	bool done;
-	struct rmi_function *fn;
-};
-
-static int f01_debug_open(struct inode *inodep, struct file *filp)
-{
-	struct f01_debugfs_data *data;
-	struct rmi_function *fn =3D inodep->i_private;
-
-	data =3D kzalloc(sizeof(struct f01_debugfs_data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->fn =3D fn;
-	filp->private_data =3D data;
-	return 0;
-}
-
-static int f01_debug_release(struct inode *inodep, struct file *filp)
-{
-	kfree(filp->private_data);
-	return 0;
-}
-
-static ssize_t interrupt_enable_read(struct file *filp, char __user *b=
uffer,
-				     size_t size, loff_t *offset) {
-	int i;
-	int len;
-	int total_len =3D 0;
-	char local_buf[size];
-	char *current_buf =3D local_buf;
-	struct f01_debugfs_data *data =3D filp->private_data;
-	struct f01_data *f01 =3D data->fn->data;
-
-	if (data->done)
-		return 0;
-
-	data->done =3D 1;
-
-	/* loop through each irq value and copy its
-	 * string representation into buf */
-	for (i =3D 0; i < f01->irq_count; i++) {
-		int irq_reg;
-		int irq_shift;
-		int interrupt_enable;
-
-		irq_reg =3D i / 8;
-		irq_shift =3D i % 8;
-		interrupt_enable =3D
-		    ((f01->device_control.interrupt_enable[irq_reg]
-			>> irq_shift) & 0x01);
-
-		/* get next irq value and write it to buf */
-		len =3D snprintf(current_buf, size - total_len,
-			"%u ", interrupt_enable);
-		/* bump up ptr to next location in buf if the
-		 * snprintf was valid.  Otherwise issue an error
-		 * and return. */
-		if (len > 0) {
-			current_buf +=3D len;
-			total_len +=3D len;
-		} else {
-			dev_err(&data->fn->dev, "Failed to build interrupt_enable buffer, c=
ode =3D %d.\n",
-						len);
-			return snprintf(local_buf, size, "unknown\n");
-		}
-	}
-	len =3D snprintf(current_buf, size - total_len, "\n");
-	if (len > 0)
-		total_len +=3D len;
-	else
-		dev_warn(&data->fn->dev, "%s: Failed to append carriage return.\n",
-			 __func__);
-
-	if (copy_to_user(buffer, local_buf, total_len))
-		return -EFAULT;
-
-	return total_len;
-}
-
-static ssize_t interrupt_enable_write(struct file *filp,
-		const char __user *buffer, size_t size, loff_t *offset) {
-	int retval;
-	char buf[size];
-	char *local_buf =3D buf;
-	int i;
-	int irq_count =3D 0;
-	int irq_reg =3D 0;
-	struct f01_debugfs_data *data =3D filp->private_data;
-	struct f01_data *f01 =3D data->fn->data;
-
-	retval =3D copy_from_user(buf, buffer, size);
-	if (retval)
-		return -EFAULT;
-
-	for (i =3D 0; i < f01->irq_count && *local_buf !=3D 0;
-	     i++, local_buf +=3D 2) {
-		int irq_shift;
-		int interrupt_enable;
-		int result;
-
-		irq_reg =3D i / 8;
-		irq_shift =3D i % 8;
-
-		/* get next interrupt mapping value and store and bump up to
-		 * point to next item in local_buf */
-		result =3D sscanf(local_buf, "%u", &interrupt_enable);
-		if ((result !=3D 1) ||
-			(interrupt_enable !=3D 0 && interrupt_enable !=3D 1)) {
-			dev_err(&data->fn->dev, "Interrupt enable[%d] is not a valid value =
0x%x.\n",
-				i, interrupt_enable);
-			return -EINVAL;
-		}
-		if (interrupt_enable =3D=3D 0) {
-			f01->device_control.interrupt_enable[irq_reg] &=3D
-				(1 << irq_shift) ^ 0xFF;
-		} else
-			f01->device_control.interrupt_enable[irq_reg] |=3D
-				(1 << irq_shift);
-		irq_count++;
-	}
-
-	/* Make sure the irq count matches */
-	if (irq_count !=3D f01->irq_count) {
-		dev_err(&data->fn->dev, "Interrupt enable count of %d doesn't match =
device count of %d.\n",
-			 irq_count, f01->irq_count);
-		return -EINVAL;
-	}
-
-	/* write back to the control register */
-	retval =3D rmi_write_block(data->fn->rmi_dev, f01->interrupt_enable_a=
ddr,
-			f01->device_control.interrupt_enable,
-			f01->num_of_irq_regs);
-	if (retval < 0) {
-		dev_err(&data->fn->dev, "Could not write interrupt_enable mask to %#=
06x\n",
-			f01->interrupt_enable_addr);
-		return retval;
-	}
-
-	return size;
-}
-
-static const struct file_operations interrupt_enable_fops =3D {
-	.owner =3D THIS_MODULE,
-	.open =3D f01_debug_open,
-	.release =3D f01_debug_release,
-	.read =3D interrupt_enable_read,
-	.write =3D interrupt_enable_write,
-};
-
-static int setup_debugfs(struct rmi_function *fn)
-{
-	struct f01_data *data =3D fn->data;
-
-	if (!fn->debugfs_root)
-		return -ENODEV;
-
-	data->debugfs_interrupt_enable =3D debugfs_create_file("interrupt_ena=
ble",
-		RMI_RW_ATTR, fn->debugfs_root, fn, &interrupt_enable_fops);
-	if (!data->debugfs_interrupt_enable)
-		dev_warn(&fn->dev,
-			 "Failed to create debugfs interrupt_enable.\n");
-
-	return 0;
-}
-
-static void teardown_debugfs(struct f01_data *f01)
-{
-	if (f01->debugfs_interrupt_enable)
-		debugfs_remove(f01->debugfs_interrupt_enable);
-}
-
-#else
+#define FUNCTION_NUMBER 0x01
=20
-static inline int setup_debugfs(struct rmi_function *fn)
-{
-	return 0;
-}
-
-static inline void teardown_debugfs(struct f01_data *f01)
-{
-}
-
-#endif
-
-static ssize_t rmi_fn_01_productinfo_show(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "0x%02x 0x%02x\n",
-			data->basic_queries.productinfo_1,
-			data->basic_queries.productinfo_2);
-}
-
-static ssize_t rmi_fn_01_productid_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", data->product_id);
-}
-
-static ssize_t rmi_fn_01_manufacturer_show(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "0x%02x\n",
-			data->basic_queries.manufacturer_id);
-}
-
-static ssize_t rmi_fn_01_datecode_show(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "20%02u-%02u-%02u\n",
-			data->basic_queries.year,
-			data->basic_queries.month,
-			data->basic_queries.day);
-}
-
-static ssize_t rmi_fn_01_reset_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	unsigned int reset;
-	int retval =3D 0;
-
-
-	if (sscanf(buf, "%u", &reset) !=3D 1)
-		return -EINVAL;
-	if (reset < 0 || reset > 1)
-		return -EINVAL;
-
-	/* Per spec, 0 has no effect, so we skip it entirely. */
-	if (reset) {
-		/* Command register always reads as 0, so just use a local. */
-		struct f01_device_commands commands =3D {
-			.reset =3D 1
-		};
-		retval =3D rmi_write_block(fn->rmi_dev, fn->fd.command_base_addr,
-				&commands, sizeof(commands));
-		if (retval < 0) {
-			dev_err(dev, "Failed to issue reset command, code =3D %d.",
-						retval);
-			return retval;
-		}
-	}
-
-	return count;
-}
-
-static ssize_t rmi_fn_01_sleepmode_show(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE,
-			"%d\n", data->device_control.ctrl0.sleep_mode);
-}
-
-static ssize_t rmi_fn_01_sleepmode_store(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval =3D strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || !RMI_IS_VALID_SLEEPMODE(new_value)) {
-		dev_err(dev, "%s: Invalid sleep mode %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	dev_dbg(dev, "Setting sleep mode to %ld.", new_value);
-	data->device_control.ctrl0.sleep_mode =3D new_value;
-	retval =3D rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-			&data->device_control.ctrl0,
-			sizeof(data->device_control.ctrl0));
-	if (retval >=3D 0)
-		retval =3D count;
-	else
-		dev_err(dev, "Failed to write sleep mode, code %d.\n", retval);
-	return retval;
-}
-
-static ssize_t rmi_fn_01_nosleep_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.ctrl0.nosleep);
-}
-
-static ssize_t rmi_fn_01_nosleep_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval =3D strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 1) {
-		dev_err(dev, "%s: Invalid nosleep bit %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	data->device_control.ctrl0.nosleep =3D new_value;
-	retval =3D rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-			&data->device_control.ctrl0,
-			sizeof(data->device_control.ctrl0));
-	if (retval >=3D 0)
-		retval =3D count;
-	else
-		dev_err(dev, "Failed to write nosleep bit.\n");
-
-	return retval;
-}
-
-static ssize_t rmi_fn_01_chargerinput_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.ctrl0.charger_input);
-}
-
-static ssize_t rmi_fn_01_chargerinput_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval =3D strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 1) {
-		dev_err(dev, "%s: Invalid chargerinput bit %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	data->device_control.ctrl0.charger_input =3D new_value;
-	retval =3D rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-			&data->device_control.ctrl0,
-			sizeof(data->device_control.ctrl0));
-	if (retval >=3D 0)
-		retval =3D count;
-	else
-		dev_err(dev, "Failed to write chargerinput bit.\n");
-
-	return retval;
-}
-
-static ssize_t rmi_fn_01_reportrate_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.ctrl0.report_rate);
-}
-
-static ssize_t rmi_fn_01_reportrate_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval =3D strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 1) {
-		dev_err(dev, "%s: Invalid reportrate bit %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	data->device_control.ctrl0.report_rate =3D new_value;
-	retval =3D rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
-			&data->device_control.ctrl0,
-			sizeof(data->device_control.ctrl0));
-	if (retval >=3D 0)
-		retval =3D count;
-	else
-		dev_err(dev, "Failed to write reportrate bit.\n");
-
-	return retval;
-}
-
-static ssize_t rmi_fn_01_interrupt_enable_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	int i, len, total_len =3D 0;
-	char *current_buf =3D buf;
-
-	/* loop through each irq value and copy its
-	 * string representation into buf */
-	for (i =3D 0; i < data->irq_count; i++) {
-		int irq_reg;
-		int irq_shift;
-		int interrupt_enable;
-
-		irq_reg =3D i / 8;
-		irq_shift =3D i % 8;
-		interrupt_enable =3D
-		    ((data->device_control.interrupt_enable[irq_reg]
-			>> irq_shift) & 0x01);
-
-		/* get next irq value and write it to buf */
-		len =3D snprintf(current_buf, PAGE_SIZE - total_len,
-			"%u ", interrupt_enable);
-		/* bump up ptr to next location in buf if the
-		 * snprintf was valid.  Otherwise issue an error
-		 * and return. */
-		if (len > 0) {
-			current_buf +=3D len;
-			total_len +=3D len;
-		} else {
-			dev_err(dev, "Failed to build interrupt_enable buffer, code =3D %d.=
\n",
-						len);
-			return snprintf(buf, PAGE_SIZE, "unknown\n");
-		}
-	}
-	len =3D snprintf(current_buf, PAGE_SIZE - total_len, "\n");
-	if (len > 0)
-		total_len +=3D len;
-	else
-		dev_warn(dev, "%s: Failed to append carriage return.\n",
-			 __func__);
-	return total_len;
-
-}
-
-static ssize_t rmi_fn_01_doze_interval_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.doze_interval);
-
-}
-
-static ssize_t rmi_fn_01_doze_interval_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	unsigned long new_value;
-	int retval;
-	u16 ctrl_base_addr;
-
-	retval =3D strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 255) {
-		dev_err(dev, "%s: Invalid doze interval %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	data->device_control.doze_interval =3D new_value;
-	ctrl_base_addr =3D fn->fd.control_base_addr + sizeof(u8) +
-			(sizeof(u8)*(data->num_of_irq_regs));
-	dev_dbg(dev, "doze_interval store address %x, value %d",
-		ctrl_base_addr, data->device_control.doze_interval);
-
-	retval =3D rmi_write_block(fn->rmi_dev, data->doze_interval_addr,
-			&data->device_control.doze_interval,
-			sizeof(u8));
-	if (retval >=3D 0)
-		retval =3D count;
-	else
-		dev_err(dev, "Failed to write doze interval.\n");
-
-	return retval;
-
-}
-
-static ssize_t rmi_fn_01_wakeup_threshold_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.wakeup_threshold);
-}
-
-static ssize_t rmi_fn_01_wakeup_threshold_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval =3D strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 255) {
-		dev_err(dev, "%s: Invalid wakeup threshold %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	data->device_control.doze_interval =3D new_value;
-	retval =3D rmi_write_block(fn->rmi_dev, data->wakeup_threshold_addr,
-			&data->device_control.wakeup_threshold,
-			sizeof(u8));
-	if (retval >=3D 0)
-		retval =3D count;
-	else
-		dev_err(dev, "Failed to write wakeup threshold.\n");
-	return retval;
-
-}
-
-static ssize_t rmi_fn_01_doze_holdoff_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.doze_holdoff);
-
-}
-
-
-static ssize_t rmi_fn_01_doze_holdoff_store(struct device *dev,
-					  struct device_attribute *attr,
-					  const char *buf, size_t count)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	unsigned long new_value;
-	int retval;
-
-	retval =3D strict_strtoul(buf, 10, &new_value);
-	if (retval < 0 || new_value > 255) {
-		dev_err(dev, "%s: Invalid doze holdoff %s.", __func__, buf);
-		return -EINVAL;
-	}
-
-	data->device_control.doze_interval =3D new_value;
-	retval =3D rmi_write_block(fn->rmi_dev, data->doze_holdoff_addr,
-			&data->device_control.doze_holdoff,
-			sizeof(u8));
-	if (retval >=3D 0)
-		retval =3D count;
-	else
-		dev_err(dev, "Failed to write doze holdoff.\n");
-
-	return retval;
-
-}
-
-static ssize_t rmi_fn_01_configured_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_control.ctrl0.configured);
-}
-
-static ssize_t rmi_fn_01_unconfigured_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_status.unconfigured);
-}
-
-static ssize_t rmi_fn_01_flashprog_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			data->device_status.flash_prog);
-}
-
-static ssize_t rmi_fn_01_statuscode_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-
-	return snprintf(buf, PAGE_SIZE, "0x%02x\n",
-			data->device_status.status_code);
-}
-
-#define RMI_F01_ATTR(_name)			\
-	DEVICE_ATTR(_name, RMI_RW_ATTR,		\
-		    rmi_fn_01_##_name##_show,	\
-		    rmi_fn_01_##_name##_store)
-
-#define RMI_F01_RO_ATTR(_name)			\
-	DEVICE_ATTR(_name, RMI_RO_ATTR,		\
-		    rmi_fn_01_##_name##_show,	\
-		    NULL)
-
-#define RMI_F01_WO_ATTR(_name)			\
-	DEVICE_ATTR(_name, RMI_RO_ATTR,		\
-		    NULL,			\
-		    rmi_fn_01_##_name##_store)
-
-
-static RMI_F01_RO_ATTR(productinfo);
-static RMI_F01_RO_ATTR(productid);
-static RMI_F01_RO_ATTR(manufacturer);
-static RMI_F01_RO_ATTR(datecode);
-
-/* Control register access */
-static RMI_F01_ATTR(sleepmode);
-static RMI_F01_ATTR(nosleep);
-static RMI_F01_ATTR(chargerinput);
-static RMI_F01_ATTR(reportrate);
-
-/*
- * We don't want arbitrary callers changing the interrupt enable mask,
- * so it's read only.
- */
-static RMI_F01_RO_ATTR(interrupt_enable);
-static RMI_F01_ATTR(doze_interval);
-static RMI_F01_ATTR(wakeup_threshold);
-static RMI_F01_ATTR(doze_holdoff);
-
-/*
- * We make report rate RO, since the driver uses that to look for
- * resets.  We don't want someone faking us out by changing that
- * bit.
- */
-static RMI_F01_RO_ATTR(configured);
-
-/* Command register access. */
-static RMI_F01_WO_ATTR(reset);
-
-/* Status register access. */
-static RMI_F01_RO_ATTR(unconfigured);
-static RMI_F01_RO_ATTR(flashprog);
-static RMI_F01_RO_ATTR(statuscode);
-
-static struct attribute *rmi_fn_01_attrs[] =3D {
-	&dev_attr_productinfo.attr,
-	&dev_attr_productid.attr,
-	&dev_attr_manufacturer.attr,
-	&dev_attr_datecode.attr,
-	&dev_attr_sleepmode.attr,
-	&dev_attr_nosleep.attr,
-	&dev_attr_chargerinput.attr,
-	&dev_attr_reportrate.attr,
-	&dev_attr_interrupt_enable.attr,
-	&dev_attr_doze_interval.attr,
-	&dev_attr_wakeup_threshold.attr,
-	&dev_attr_doze_holdoff.attr,
-	&dev_attr_configured.attr,
-	&dev_attr_reset.attr,
-	&dev_attr_unconfigured.attr,
-	&dev_attr_flashprog.attr,
-	&dev_attr_statuscode.attr,
-	NULL
-};
-
-static umode_t rmi_fn_01_attr_visible(struct kobject *kobj,
-				      struct attribute *attr, int n)
-{
-	struct device *dev =3D kobj_to_dev(kobj);=20
-	struct rmi_function *fn =3D to_rmi_function(dev);
-	struct f01_data *data =3D fn->data;
-	umode_t mode =3D attr->mode;
-
-	if (attr =3D=3D &dev_attr_doze_interval.attr) {
-		if (!data->basic_queries.has_lts)
-			mode =3D 0;
-	} else if (attr =3D=3D &dev_attr_wakeup_threshold.attr) {
-		if (!data->basic_queries.has_adjustable_doze)
-			mode =3D 0;
-	} else if (attr =3D=3D &dev_attr_doze_holdoff.attr) {
-		if (!data->basic_queries.has_adjustable_doze_holdoff)
-			mode =3D 0;
-	}
-
-	return mode;
-}
-
-static struct attribute_group rmi_fn_01_attr_group =3D {
-	.is_visible	=3D rmi_fn_01_attr_visible,
-	.attrs		=3D rmi_fn_01_attrs,
-};
-
-static int rmi_f01_alloc_memory(struct rmi_function *fn,
-				int num_of_irq_regs)
+static int rmi_f01_alloc_memory(struct rmi_function_dev *fn_dev,
+	int num_of_irq_regs)
 {
 	struct f01_data *f01;
=20
-	f01 =3D devm_kzalloc(&fn->dev, sizeof(struct f01_data), GFP_KERNEL);
+	f01 =3D devm_kzalloc(&fn_dev->dev, sizeof(struct f01_data), GFP_KERNE=
L);
 	if (!f01) {
-		dev_err(&fn->dev, "Failed to allocate fn_01_data.\n");
+		dev_err(&fn_dev->dev, "Failed to allocate fn_01_data.\n");
 		return -ENOMEM;
 	}
=20
-	f01->device_control.interrupt_enable =3D devm_kzalloc(&fn->dev,
+	f01->device_control.interrupt_enable =3D devm_kzalloc(&fn_dev->dev,
 			sizeof(u8)*(num_of_irq_regs),
 			GFP_KERNEL);
 	if (!f01->device_control.interrupt_enable) {
-		dev_err(&fn->dev, "Failed to allocate interrupt enable.\n");
+		dev_err(&fn_dev->dev, "Failed to allocate interrupt enable.\n");
 		return -ENOMEM;
 	}
-	fn->data =3D f01;
+	fn_dev->data =3D f01;
=20
 	return 0;
 }
=20
-static int rmi_f01_initialize(struct rmi_function *fn)
+static int rmi_f01_initialize(struct rmi_function_dev *fn_dev)
 {
 	u8 temp;
-	int error;
-	u16 ctrl_base_addr;
-	struct rmi_device *rmi_dev =3D fn->rmi_dev;
+	int retval;
+	u16 query_addr =3D fn_dev->fd.query_base_addr;
+	u16 ctrl_addr =3D fn_dev->fd.control_base_addr;
+	struct rmi_device *rmi_dev =3D fn_dev->rmi_dev;
 	struct rmi_driver_data *driver_data =3D dev_get_drvdata(&rmi_dev->dev=
);
-	struct f01_data *data =3D fn->data;
+	struct f01_data *data =3D fn_dev->data;
 	struct rmi_device_platform_data *pdata =3D to_rmi_platform_data(rmi_d=
ev);
=20
 	/* Set the configured bit and (optionally) other important stuff
 	 * in the device control register. */
-	ctrl_base_addr =3D fn->fd.control_base_addr;
-	error =3D rmi_read_block(rmi_dev, fn->fd.control_base_addr,
+	retval =3D rmi_read_block(rmi_dev, fn_dev->fd.control_base_addr,
 			&data->device_control.ctrl0,
 			sizeof(data->device_control.ctrl0));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read F01 control.\n");
-		return error;
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to read F01 control.\n");
+		return retval;
 	}
 	switch (pdata->power_management.nosleep) {
 	case RMI_F01_NOSLEEP_DEFAULT:
@@ -914,242 +76,237 @@ static int rmi_f01_initialize(struct rmi_functio=
n *fn)
 	 * is certain to function.
 	 */
 	if (data->device_control.ctrl0.sleep_mode !=3D RMI_SLEEP_MODE_NORMAL)=
 {
-		dev_warn(&fn->dev,
+		dev_warn(&fn_dev->dev,
 			 "WARNING: Non-zero sleep mode found. Clearing...\n");
 		data->device_control.ctrl0.sleep_mode =3D RMI_SLEEP_MODE_NORMAL;
 	}
=20
 	data->device_control.ctrl0.configured =3D 1;
-	error =3D rmi_write_block(rmi_dev, fn->fd.control_base_addr,
+	retval =3D rmi_write_block(rmi_dev, fn_dev->fd.control_base_addr,
 			&data->device_control.ctrl0,
 			sizeof(data->device_control.ctrl0));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to write F01 control.\n");
-		return error;
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to write F01 control.\n");
+		return retval;
 	}
=20
 	data->irq_count =3D driver_data->irq_count;
 	data->num_of_irq_regs =3D driver_data->num_of_irq_regs;
-	ctrl_base_addr +=3D sizeof(struct f01_device_control_0);
+	ctrl_addr +=3D sizeof(struct f01_device_control_0);
=20
-	data->interrupt_enable_addr =3D ctrl_base_addr;
-	error =3D rmi_read_block(rmi_dev, ctrl_base_addr,
+	data->interrupt_enable_addr =3D ctrl_addr;
+	retval =3D rmi_read_block(rmi_dev, ctrl_addr,
 			data->device_control.interrupt_enable,
 			sizeof(u8)*(data->num_of_irq_regs));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read F01 control interrupt enable regis=
ter.\n");
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to read F01 control interrupt enable r=
egister.\n");
 		goto error_exit;
 	}
-	ctrl_base_addr +=3D data->num_of_irq_regs;
+	ctrl_addr +=3D data->num_of_irq_regs;
=20
 	/* dummy read in order to clear irqs */
-	error =3D rmi_read(rmi_dev, fn->fd.data_base_addr + 1, &temp);
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read Interrupt Status.\n");
-		return error;
+	retval =3D rmi_read(rmi_dev, fn_dev->fd.data_base_addr + 1, &temp);
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to read Interrupt Status.\n");
+		return retval;
 	}
=20
-	error =3D rmi_read_block(rmi_dev, fn->fd.query_base_addr,
-				&data->basic_queries,
+	/* read queries */
+	retval =3D rmi_read_block(rmi_dev, query_addr, &data->basic_queries,
 				sizeof(data->basic_queries));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read device query registers.\n");
-		return error;
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to read device query registers.\n");
+		return retval;
 	}
+	query_addr +=3D sizeof(data->basic_queries);
=20
-	error =3D rmi_read_block(rmi_dev,
-		fn->fd.query_base_addr + sizeof(data->basic_queries),
-		data->product_id, RMI_PRODUCT_ID_LENGTH);
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read product ID.\n");
-		return error;
+	retval =3D rmi_read_block(rmi_dev, query_addr, data->serialization,
+				F01_SERIALIZATION_SIZE);
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to read device serialization.\n");
+		return retval;
+	}
+	query_addr +=3D F01_SERIALIZATION_SIZE;
+
+	retval =3D rmi_read_block(rmi_dev, query_addr, data->product_id,
+				RMI_PRODUCT_ID_LENGTH);
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to read product ID.\n");
+		return retval;
 	}
 	data->product_id[RMI_PRODUCT_ID_LENGTH] =3D '\0';
-	dev_info(&fn->dev, "found RMI device, manufacturer: %s, product: %s\n=
",
+	dev_info(&fn_dev->dev, "found RMI device, manufacturer: %s, product: =
%s\n",
 		 data->basic_queries.manufacturer_id =3D=3D 1 ?
 							"synaptics" : "unknown",
 		 data->product_id);
=20
 	/* read control register */
 	if (data->basic_queries.has_adjustable_doze) {
-		data->doze_interval_addr =3D ctrl_base_addr;
-		ctrl_base_addr++;
+		data->doze_interval_addr =3D ctrl_addr;
+		ctrl_addr++;
=20
 		if (pdata->power_management.doze_interval) {
 			data->device_control.doze_interval =3D
 				pdata->power_management.doze_interval;
-			error =3D rmi_write(rmi_dev, data->doze_interval_addr,
+			retval =3D rmi_write(rmi_dev, data->doze_interval_addr,
 					data->device_control.doze_interval);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 doze interval register.=
\n");
+			if (retval < 0) {
+				dev_err(&fn_dev->dev, "Failed to configure F01 doze interval regis=
ter.\n");
 				goto error_exit;
 			}
 		} else {
-			error =3D rmi_read(rmi_dev, data->doze_interval_addr,
+			retval =3D rmi_read(rmi_dev, data->doze_interval_addr,
 					&data->device_control.doze_interval);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to read F01 doze interval register.\n");
+			if (retval < 0) {
+				dev_err(&fn_dev->dev, "Failed to read F01 doze interval register.\=
n");
 				goto error_exit;
 			}
 		}
=20
-		data->wakeup_threshold_addr =3D ctrl_base_addr;
-		ctrl_base_addr++;
+		data->wakeup_threshold_addr =3D ctrl_addr;
+		ctrl_addr++;
=20
 		if (pdata->power_management.wakeup_threshold) {
 			data->device_control.wakeup_threshold =3D
 				pdata->power_management.wakeup_threshold;
-			error =3D rmi_write(rmi_dev, data->wakeup_threshold_addr,
+			retval =3D rmi_write(rmi_dev, data->wakeup_threshold_addr,
 					data->device_control.wakeup_threshold);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 wakeup threshold regist=
er.\n");
+			if (retval < 0) {
+				dev_err(&fn_dev->dev, "Failed to configure F01 wakeup threshold re=
gister.\n");
 				goto error_exit;
 			}
 		} else {
-			error =3D rmi_read(rmi_dev, data->wakeup_threshold_addr,
+			retval =3D rmi_read(rmi_dev, data->wakeup_threshold_addr,
 					&data->device_control.wakeup_threshold);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to read F01 wakeup threshold register.\n=
");
+			if (retval < 0) {
+				dev_err(&fn_dev->dev, "Failed to read F01 wakeup threshold registe=
r.\n");
 				goto error_exit;
 			}
 		}
 	}
=20
 	if (data->basic_queries.has_adjustable_doze_holdoff) {
-		data->doze_holdoff_addr =3D ctrl_base_addr;
-		ctrl_base_addr++;
+		data->doze_holdoff_addr =3D ctrl_addr;
+		ctrl_addr++;
=20
 		if (pdata->power_management.doze_holdoff) {
 			data->device_control.doze_holdoff =3D
 				pdata->power_management.doze_holdoff;
-			error =3D rmi_write(rmi_dev, data->doze_holdoff_addr,
+			retval =3D rmi_write(rmi_dev, data->doze_holdoff_addr,
 					data->device_control.doze_holdoff);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to configure F01 doze holdoff register.\=
n");
+			if (retval < 0) {
+				dev_err(&fn_dev->dev, "Failed to configure F01 doze holdoff regist=
er.\n");
 				goto error_exit;
 			}
 		} else {
-			error =3D rmi_read(rmi_dev, data->doze_holdoff_addr,
+			retval =3D rmi_read(rmi_dev, data->doze_holdoff_addr,
 					&data->device_control.doze_holdoff);
-			if (error < 0) {
-				dev_err(&fn->dev, "Failed to read F01 doze holdoff register.\n");
+			if (retval < 0) {
+				dev_err(&fn_dev->dev, "Failed to read F01 doze holdoff register.\n=
");
 				goto error_exit;
 			}
 		}
 	}
=20
-	error =3D rmi_read_block(rmi_dev, fn->fd.data_base_addr,
+	retval =3D rmi_read_block(rmi_dev, fn_dev->fd.data_base_addr,
 		&data->device_status, sizeof(data->device_status));
-	if (error < 0) {
-		dev_err(&fn->dev, "Failed to read device status.\n");
+	if (retval < 0) {
+		dev_err(&fn_dev->dev, "Failed to read device status.\n");
 		goto error_exit;
 	}
=20
 	if (data->device_status.unconfigured) {
-		dev_err(&fn->dev, "Device reset during configuration process, status=
: %#02x!\n",
+		dev_err(&fn_dev->dev, "Device reset during configuration process, st=
atus: %#02x!\n",
 				data->device_status.status_code);
-		error =3D -EINVAL;
+		retval =3D -EINVAL;
 		goto error_exit;
 	}
=20
-	error =3D setup_debugfs(fn);
-	if (error)
-		dev_warn(&fn->dev, "Failed to setup debugfs, error: %d.\n",
-			 error);
-
-	return 0;
+	return retval;
=20
  error_exit:
 	kfree(data);
-	return error;
+	return retval;
 }
=20
-static int rmi_f01_config(struct rmi_function *fn)
+static int rmi_f01_config(struct rmi_function_dev *fn_dev)
 {
-	struct f01_data *data =3D fn->data;
+	struct f01_data *data =3D fn_dev->data;
 	int retval;
=20
-	retval =3D rmi_write_block(fn->rmi_dev, fn->fd.control_base_addr,
+	retval =3D rmi_write_block(fn_dev->rmi_dev, fn_dev->fd.control_base_a=
ddr,
 			&data->device_control.ctrl0,
 			sizeof(data->device_control.ctrl0));
 	if (retval < 0) {
-		dev_err(&fn->dev, "Failed to write device_control.reg.\n");
+		dev_err(&fn_dev->dev, "Failed to write device_control.reg.\n");
 		return retval;
 	}
=20
-	retval =3D rmi_write_block(fn->rmi_dev, data->interrupt_enable_addr,
+	retval =3D rmi_write_block(fn_dev->rmi_dev, data->interrupt_enable_ad=
dr,
 			data->device_control.interrupt_enable,
 			sizeof(u8)*(data->num_of_irq_regs));
=20
 	if (retval < 0) {
-		dev_err(&fn->dev, "Failed to write interrupt enable.\n");
+		dev_err(&fn_dev->dev, "Failed to write interrupt enable.\n");
 		return retval;
 	}
 	if (data->basic_queries.has_lts) {
-		retval =3D rmi_write_block(fn->rmi_dev, data->doze_interval_addr,
-				&data->device_control.doze_interval,
-				sizeof(u8));
+		retval =3D rmi_write_block(fn_dev->rmi_dev,
+					data->doze_interval_addr,
+					&data->device_control.doze_interval,
+					sizeof(u8));
 		if (retval < 0) {
-			dev_err(&fn->dev, "Failed to write doze interval.\n");
+			dev_err(&fn_dev->dev, "Failed to write doze interval.\n");
 			return retval;
 		}
 	}
=20
 	if (data->basic_queries.has_adjustable_doze) {
 		retval =3D rmi_write_block(
-				fn->rmi_dev, data->wakeup_threshold_addr,
+				fn_dev->rmi_dev, data->wakeup_threshold_addr,
 				&data->device_control.wakeup_threshold,
 				sizeof(u8));
 		if (retval < 0) {
-			dev_err(&fn->dev, "Failed to write wakeup threshold.\n");
+			dev_err(&fn_dev->dev, "Failed to write wakeup threshold.\n");
 			return retval;
 		}
 	}
=20
 	if (data->basic_queries.has_adjustable_doze_holdoff) {
-		retval =3D rmi_write_block(fn->rmi_dev, data->doze_holdoff_addr,
-				&data->device_control.doze_holdoff,
-				sizeof(u8));
+		retval =3D rmi_write_block(fn_dev->rmi_dev,
+					data->doze_holdoff_addr,
+					&data->device_control.doze_holdoff,
+					sizeof(u8));
 		if (retval < 0) {
-			dev_err(&fn->dev, "Failed to write doze holdoff.\n");
+			dev_err(&fn_dev->dev, "Failed to write doze holdoff.\n");
 			return retval;
 		}
 	}
 	return 0;
 }
=20
-static int rmi_f01_probe(struct rmi_function *fn)
+static int rmi_f01_probe(struct rmi_function_dev *fn_dev)
 {
 	struct rmi_driver_data *driver_data =3D
-			dev_get_drvdata(&fn->rmi_dev->dev);
+			dev_get_drvdata(&fn_dev->rmi_dev->dev);
 	int error;
=20
-	error =3D rmi_f01_alloc_memory(fn, driver_data->num_of_irq_regs);
-	if (error)
-		return error;
-
-	error =3D rmi_f01_initialize(fn);
-	if (error)
+	error =3D rmi_f01_alloc_memory(fn_dev, driver_data->num_of_irq_regs);
+	if (error < 0)
 		return error;
=20
-	error =3D sysfs_create_group(&fn->dev.kobj, &rmi_fn_01_attr_group);
-	if (error)
+	error =3D rmi_f01_initialize(fn_dev);
+	if (error < 0)
 		return error;
=20
 	return 0;
 }
=20
-static void rmi_f01_remove(struct rmi_function *fn)
-{
-	teardown_debugfs(fn->data);
-	sysfs_remove_group(&fn->dev.kobj, &rmi_fn_01_attr_group);
-}
-
 #ifdef CONFIG_PM
-static int rmi_f01_suspend(struct rmi_function *fn)
+static int rmi_f01_suspend(struct rmi_function_dev *fn_dev)
 {
-	struct rmi_device *rmi_dev =3D fn->rmi_dev;
-	struct f01_data *data =3D fn->data;
+	struct rmi_device *rmi_dev =3D fn_dev->rmi_dev;
+	struct f01_data *data =3D fn_dev->data;
 	int retval =3D 0;
=20
 	if (data->suspended)
@@ -1160,11 +317,11 @@ static int rmi_f01_suspend(struct rmi_function *=
fn)
 	data->device_control.ctrl0.sleep_mode =3D RMI_SLEEP_MODE_SENSOR_SLEEP=
;
=20
 	retval =3D rmi_write_block(rmi_dev,
-			fn->fd.control_base_addr,
+			fn_dev->fd.control_base_addr,
 			&data->device_control.ctrl0,
 			sizeof(data->device_control.ctrl0));
 	if (retval < 0) {
-		dev_err(&fn->dev, "Failed to write sleep mode. Code: %d.\n",
+		dev_err(&fn_dev->dev, "Failed to write sleep mode. Code: %d.\n",
 			retval);
 		data->device_control.ctrl0.nosleep =3D data->old_nosleep;
 		data->device_control.ctrl0.sleep_mode =3D RMI_SLEEP_MODE_NORMAL;
@@ -1176,10 +333,10 @@ static int rmi_f01_suspend(struct rmi_function *=
fn)
 	return retval;
 }
=20
-static int rmi_f01_resume(struct rmi_function *fn)
+static int rmi_f01_resume(struct rmi_function_dev *fn_dev)
 {
-	struct rmi_device *rmi_dev =3D fn->rmi_dev;
-	struct f01_data *data =3D fn->data;
+	struct rmi_device *rmi_dev =3D fn_dev->rmi_dev;
+	struct f01_data *data =3D fn_dev->data;
 	int retval =3D 0;
=20
 	if (!data->suspended)
@@ -1188,11 +345,11 @@ static int rmi_f01_resume(struct rmi_function *f=
n)
 	data->device_control.ctrl0.nosleep =3D data->old_nosleep;
 	data->device_control.ctrl0.sleep_mode =3D RMI_SLEEP_MODE_NORMAL;
=20
-	retval =3D rmi_write_block(rmi_dev, fn->fd.control_base_addr,
+	retval =3D rmi_write_block(rmi_dev, fn_dev->fd.control_base_addr,
 			&data->device_control.ctrl0,
 			sizeof(data->device_control.ctrl0));
 	if (retval < 0)
-		dev_err(&fn->dev,
+		dev_err(&fn_dev->dev,
 			"Failed to restore normal operation. Code: %d.\n",
 			retval);
 	else {
@@ -1204,22 +361,27 @@ static int rmi_f01_resume(struct rmi_function *f=
n)
 }
 #endif /* CONFIG_PM */
=20
-static int rmi_f01_attention(struct rmi_function *fn,
-			     unsigned long *irq_bits)
+static int rmi_f01_remove(struct rmi_function_dev *fn_dev)
 {
-	struct rmi_device *rmi_dev =3D fn->rmi_dev;
-	struct f01_data *data =3D fn->data;
+	return 0;
+}
+
+static int rmi_f01_attention(struct rmi_function_dev *fn_dev,
+						unsigned long *irq_bits)
+{
+	struct rmi_device *rmi_dev =3D fn_dev->rmi_dev;
+	struct f01_data *data =3D fn_dev->data;
 	int retval;
=20
-	retval =3D rmi_read_block(rmi_dev, fn->fd.data_base_addr,
+	retval =3D rmi_read_block(rmi_dev, fn_dev->fd.data_base_addr,
 		&data->device_status, sizeof(data->device_status));
 	if (retval < 0) {
-		dev_err(&fn->dev, "Failed to read device status, code: %d.\n",
+		dev_err(&fn_dev->dev, "Failed to read device status, code: %d.\n",
 			retval);
 		return retval;
 	}
 	if (data->device_status.unconfigured) {
-		dev_warn(&fn->dev, "Device reset detected.\n");
+		dev_warn(&fn_dev->dev, "Device reset detected.\n");
 		retval =3D rmi_dev->driver->reset_handler(rmi_dev);
 		if (retval < 0)
 			return retval;
@@ -1227,16 +389,17 @@ static int rmi_f01_attention(struct rmi_function=
 *fn,
 	return 0;
 }
=20
-struct rmi_function_handler rmi_f01_handler =3D {
+struct rmi_function_driver rmi_f01_driver =3D {
 	.driver =3D {
 		.name =3D "rmi_f01",
 	},
-	.func =3D 0x01,
+	.func =3D FUNCTION_NUMBER,
 	.probe =3D rmi_f01_probe,
 	.remove =3D rmi_f01_remove,
 	.config =3D rmi_f01_config,
 	.attention =3D rmi_f01_attention,
-#ifdef CONFIG_PM
+
+#ifdef	CONFIG_PM
 	.suspend =3D rmi_f01_suspend,
 	.resume =3D rmi_f01_resume,
 #endif  /* CONFIG_PM */
diff --git a/drivers/input/rmi4/rmi_f01.h b/drivers/input/rmi4/rmi_f01.=
h
index 8092b7f..d388c63 100644
--- a/drivers/input/rmi4/rmi_f01.h
+++ b/drivers/input/rmi4/rmi_f01.h
@@ -30,6 +30,8 @@
=20
 #define F01_RESET_MASK 0x01
=20
+#define F01_SERIALIZATION_SIZE 7
+
 /**
  * @manufacturer_id - reports the identity of the manufacturer of the =
RMI
  * device. Synaptics RMI devices report a Manufacturer ID of $01.
@@ -49,19 +51,6 @@
  * product spec sheet.
  * @productinfo_2 - meaning varies from product to product, consult yo=
ur
  * product spec sheet.
- * @year - year of manufacture MOD 2000.
- * @month - month of manufacture
- * @day - day of manufacture
- * @wafer_id1_lsb - The wafer-lot ID registers record the lot number o=
f the
- * wafer from which the module=E2=80=99s touch controller was produced=
=2E
- * @wafer_id1_msb - The wafer-lot ID registers record the lot number o=
f the
- * wafer from which the module=E2=80=99s touch controller was produced=
=2E
- * @wafer_id2_lsb - The wafer-lot ID registers record the lot number o=
f the
- * wafer from which the module=E2=80=99s touch controller was produced=
=2E
- * @wafer_id2_msb - The wafer-lot ID registers record the lot number o=
f the
- * wafer from which the module=E2=80=99s touch controller was produced=
=2E
- * @wafer_id3_lsb - The wafer-lot ID registers record the lot number o=
f the
- * wafer from which the module=E2=80=99s touch controller was produced=
=2E
  */
 struct f01_basic_queries {
 	u8 manufacturer_id:8;
@@ -77,21 +66,9 @@ struct f01_basic_queries {
=20
 	u8 productinfo_1:7;
 	u8 q2_bit_7:1;
-
 	u8 productinfo_2:7;
 	u8 q3_bit_7:1;
=20
-	u8 year:5;
-	u8 month:4;
-	u8 day:5;
-	u8 cp1:1;
-	u8 cp2:1;
-
-	u8 wafer_id1_lsb:8;
-	u8 wafer_id1_msb:8;
-	u8 wafer_id2_lsb:8;
-	u8 wafer_id2_msb:8;
-	u8 wafer_id3_lsb:8;
 } __attribute__((__packed__));
=20
 /** The status code field reports the most recent device status event.
@@ -120,7 +97,7 @@ enum rmi_device_status {
  * @unconfigured - the device has lost its configuration for some reas=
on.
  */
 struct f01_device_status {
-	u8 status_code:4;
+	enum rmi_device_status status_code:4;
 	u8 reserved:2;
 	u8 flash_prog:1;
 	u8 unconfigured:1;
@@ -159,4 +136,113 @@ struct f01_device_control_0 {
 	u8 configured:1;
 } __attribute__((__packed__));
=20
+/**
+ * @reset - set this bit to force a firmware reset of the sensor.
+ */
+struct f01_device_commands {
+	u8 reset:1;
+	u8 reserved:7;
+};
+
+/**
+ * @ctrl0 - see documentation in rmi_f01.h.
+ * @interrupt_enable - A mask of per-function interrupts on the touch =
sensor.
+ * @doze_interval - controls the interval between checks for finger pr=
esence
+ * when the touch sensor is in doze mode, in units of 10ms.
+ * @wakeup_threshold - controls the capacitance threshold at which the=
 touch
+ * sensor will decide to wake up from that low power state.
+ * @doze_holdoff - controls how long the touch sensor waits after the =
last
+ * finger lifts before entering the doze state, in units of 100ms.
+ */
+struct f01_device_control {
+	struct f01_device_control_0 ctrl0;
+	u8 *interrupt_enable;
+	u8 doze_interval;
+	u8 wakeup_threshold;
+	u8 doze_holdoff;
+};
+
+/**
+ * @has_ds4_queries - if true, the query registers relating to Design =
Studio 4
+ * features are present.
+ * @has_multi_phy - if true, multiple physical communications interfac=
es are
+ * supported.
+ * @has_guest - if true, a "guest" device is supported.
+ */
+struct f01_query_42 {
+		u8 has_ds4_queries:1;
+		u8 has_multi_phy:1;
+		u8 has_guest:1;
+		u8 reserved:5;
+} __attribute__((__packed__));
+
+/**
+ * @length - the length of the remaining Query43.* register block, not
+ * including the first register.
+ * @has_package_id_query -  the package ID query data will be accessib=
le from
+ * inside the ProductID query registers.
+ * @has_packrat_query -  the packrat query data will be accessible fro=
m inside
+ * the ProductID query registers.
+ * @has_reset_query - the reset pin related registers are valid.
+ * @has_maskrev_query - the silicon mask revision number will be repor=
ted.
+ * @has_i2c_control - the register F01_RMI_Ctrl6 will exist.
+ * @has_spi_control - the register F01_RMI_Ctrl7 will exist.
+ * @has_attn_control - the register F01_RMI_Ctrl8 will exist.
+ * @reset_enabled - the hardware reset pin functionality has been enab=
led
+ * for this device.
+ * @reset_polarity - If this bit reports as =E2=80=980=E2=80=99, it me=
ans that the reset state
+ * is active low. A =E2=80=981=E2=80=99 means that the reset state is =
active high.
+ * @pullup_enabled - If set, it indicates that a built-in weak pull up=
 has
+ * been enabled on the Reset pin; clear means that no pull-up is prese=
nt.
+ * @reset_pin_number - This field represents which GPIO pin number has=
 been
+ * assigned the reset functionality.
+ */
+struct f01_ds4_queries {
+	u8 length:4;
+	u8 reserved_1:4;
+
+	u8 has_package_id_query:1;
+	u8 has_packrat_query:1;
+	u8 has_reset_query:1;
+	u8 has_maskrev_query:1;
+	u8 reserved_2:4;
+
+	u8 has_i2c_control:1;
+	u8 has_spi_control:1;
+	u8 has_attn_control:1;
+	u8 reserved_3:5;
+
+	u8 reset_enabled:1;
+	u8 reset_polarity:1;
+	u8 pullup_enabled:1;
+	u8 reserved_4:1;
+	u8 reset_pin_number:4;
+} __attribute__((__packed__));
+
+/*
+ *
+ * @serialization - 7 bytes of device serialization data.  The meaning=
 of
+ * these bytes varies from product to product, consult your product sp=
ec sheet.
+ */
+struct f01_data {
+	struct f01_device_control device_control;
+	struct f01_basic_queries basic_queries;
+	struct f01_device_status device_status;
+	u8 serialization[F01_SERIALIZATION_SIZE];
+	u8 product_id[RMI_PRODUCT_ID_LENGTH+1];
+
+	u16 interrupt_enable_addr;
+	u16 doze_interval_addr;
+	u16 wakeup_threshold_addr;
+	u16 doze_holdoff_addr;
+
+	int irq_count;
+	int num_of_irq_regs;
+
+#ifdef	CONFIG_PM
+	bool suspended;
+	bool old_nosleep;
+#endif
+};
+
 #endif
