From: Aaron Ma <aaron.ma@canonical.com>
Subject: [PATCH 2/2] Input: synaptics-rmi4 - export nosleep of f01 via sysfs
Date: Wed, 20 Feb 2019 17:42:00 +0100
Message-ID: <20190220164200.31044-2-aaron.ma@canonical.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190220164200.31044-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cheiny@synaptics.com, aduggan@synaptics.com, benjamin.tissoires@redhat.com, aaron.ma@canonical.com
List-Id: linux-input@vger.kernel.org

Some of ThinkPad X1C6 touchpads didn't wakeup after resume.
Forcing enable nosleep make touchpad back.
Add nosleep via sysfs, so user can control it to workaround issue.

/sys/devices/rmi4-00/nosleep can be written non-zero will enable
nosleep mode.

BugLink: https://bugs.launchpad.net/bugs/1791427
Cc: <stable@vger.kernel.org>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/input/rmi4/rmi_f01.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 4edaa14fe878..e41d1ec625d9 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -325,12 +325,57 @@ static ssize_t rmi_driver_package_id_show(struct device *dev,
 
 static DEVICE_ATTR(package_id, 0444, rmi_driver_package_id_show, NULL);
 
+static ssize_t rmi_driver_nosleep_show(struct device *dev,
+					  struct device_attribute *dattr,
+					  char *buf)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);
+	int f01_nosleep;
+
+	f01_nosleep = ((f01->device_control.ctrl0 & RMI_F01_CTRL0_NOSLEEP_BIT)
+		 ? 1 : 0);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", f01_nosleep);
+}
+
+static ssize_t rmi_driver_nosleep_store(struct device *dev,
+					  struct device_attribute *dattr,
+					  const char *buf, size_t count)
+{
+	struct rmi_driver_data *data = dev_get_drvdata(dev);
+	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);
+	int error;
+
+	if (count <= 0)
+		return count;
+
+	if ('0' == *buf) {
+		f01->device_control.ctrl0 &= ~RMI_F01_CTRL0_NOSLEEP_BIT;
+	} else {
+		f01->device_control.ctrl0 |= RMI_F01_CTRL0_NOSLEEP_BIT;
+	}
+
+	error = rmi_write(data->rmi_dev,
+			data->f01_container->fd.control_base_addr,
+			  f01->device_control.ctrl0);
+	if (error) {
+		dev_err(dev, "Failed to write nosleep mode: %d.\n", error);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(nosleep, 0644,
+		rmi_driver_nosleep_show, rmi_driver_nosleep_store);
+
 static struct attribute *rmi_f01_attrs[] = {
 	&dev_attr_manufacturer_id.attr,
 	&dev_attr_date_of_manufacture.attr,
 	&dev_attr_product_id.attr,
 	&dev_attr_firmware_id.attr,
 	&dev_attr_package_id.attr,
+	&dev_attr_nosleep.attr,
 	NULL
 };
 
-- 
2.17.1
