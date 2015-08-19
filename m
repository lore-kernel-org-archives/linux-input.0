From: John Sung <penmount.touch@gmail.com>
Subject: [PATCH 3/3] HID: Device attributes for hid-penmount
Date: Wed, 19 Aug 2015 15:29:59 +0800
Message-ID: <1439969399-11469-3-git-send-email-penmount.touch@gmail.com>
References: <1439969399-11469-1-git-send-email-penmount.touch@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439969399-11469-1-git-send-email-penmount.touch@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penmount.touch@gmail.com
List-Id: linux-input@vger.kernel.org

Add two attributes, ver and cmd, to provide more convenient way to
integrate with shell scripts.

Signed-off-by: John Sung <penmount.touch@gmail.com>
---
 drivers/hid/hid-penmount.c |   87 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/hid/hid-penmount.c b/drivers/hid/hid-penmount.c
index 4fd14c8..a59c0e0 100644
--- a/drivers/hid/hid-penmount.c
+++ b/drivers/hid/hid-penmount.c
@@ -79,6 +79,88 @@ static int penmount_hid_getreport(struct penmount *pm, unsigned char *ack)
 	return ret;
 }
 
+static ssize_t penmount_cmd_store(struct device *dev,
+		struct device_attribute *attr, const char *buffer, size_t count)
+{
+	struct penmount *pm = NULL;
+	struct hid_device *hdev = NULL;
+	unsigned char cmd[PM_HID_REPORT_SIZE] = { 0, 0, 0, 0, 0 };
+
+	hdev = dev_get_drvdata(dev);
+	if (hdev == NULL)
+		return -EINVAL;
+
+	pm = hid_get_drvdata(hdev);
+	if ((pm == NULL) || (buffer == NULL))
+		return -EINVAL;
+
+	count = sscanf(buffer, "%hhX %hhX %hhX %hhX %hhX", &cmd[0], &cmd[1],
+		&cmd[2], &cmd[3], &cmd[4]);
+
+	if (penmount_hid_setreport(pm, cmd) < 0)
+		return 0;
+
+	return count;
+}
+
+static ssize_t penmount_cmd_show(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	struct penmount *pm = NULL;
+	struct hid_device *hdev = NULL;
+	size_t count = 0;
+	unsigned char ack[PM_HID_REPORT_SIZE] = { 0, 0, 0, 0, 0 };
+
+	hdev = dev_get_drvdata(dev);
+	if (hdev == NULL)
+		return -EINVAL;
+
+	pm = hid_get_drvdata(hdev);
+	if ((pm == NULL) || (buffer == NULL))
+		return -EINVAL;
+
+	if (penmount_hid_getreport(pm, ack) < 0)
+		return 0;
+
+	count = sprintf(buffer, "0x%02X 0x%02X 0x%02X 0x%02X 0x%02X\n", ack[0],
+			ack[1], ack[2], ack[3], ack[4]);
+
+	return count;
+}
+
+static ssize_t penmount_ver_show(struct device *dev,
+		struct device_attribute *attr, char *buffer)
+{
+	struct penmount *pm = NULL;
+	struct hid_device *hdev = NULL;
+	size_t count = 0;
+
+	hdev = dev_get_drvdata(dev);
+	if (hdev == NULL)
+		return -EINVAL;
+
+	pm = hid_get_drvdata(hdev);
+	if ((pm == NULL) || (buffer == NULL))
+		return -EINVAL;
+
+	count = sprintf(buffer, "%s\n", pm->version);
+
+	return count;
+}
+
+static DEVICE_ATTR(ver, 0444, penmount_ver_show, NULL);
+static DEVICE_ATTR(cmd, 0644, penmount_cmd_show, penmount_cmd_store);
+
+static struct attribute *penmount_attrs[] = {
+	&dev_attr_cmd.attr,
+	&dev_attr_ver.attr,
+	NULL
+};
+
+static const struct attribute_group penmount_attr_group = {
+	.attrs = penmount_attrs,
+};
+
 static int penmount_get_version(struct penmount *pm)
 {
 	int ret = 0;
@@ -354,6 +436,10 @@ static int penmount_probe(struct hid_device *hdev,
 	if (hidinput != NULL) {
 		pm->input = hidinput->input;
 		set_bit(INPUT_PROP_DIRECT, hidinput->input->propbit);
+		if (sysfs_create_group(&hidinput->input->dev.kobj,
+				&penmount_attr_group)) {
+			hid_warn(hdev, "Failed to create attr group !\n");
+		}
 	}
 
 	penmount_get_version(pm);
@@ -368,6 +454,7 @@ static void penmount_remove(struct hid_device *hdev)
 
 	pm = hid_get_drvdata(hdev);
 	if (pm != NULL) {
+		sysfs_remove_group(&pm->input->dev.kobj, &penmount_attr_group);
 		kfree(pm);
 		hid_set_drvdata(hdev, NULL);
 	}
-- 
1.7.9.5
