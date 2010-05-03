From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: [PATCH 2/2] hid/hid-sony: get and set Sixaxis bdaddr via sysfs
Date: Mon,  3 May 2010 22:15:56 +0200
Message-ID: <1272917756-31098-3-git-send-email-ospite@studenti.unina.it>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1272917756-31098-1-git-send-email-ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cbe-oss-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

Expose to userspace a simple way to get device bdaddr, and get/set master
bdaddr on Sixaxis controller.

Right now userspace softwares which manage pairing the controller with a
bluetooth adapter, rely on libusb and hence have to detach and reattach
usbhid, which is not very nice.

Signed-off-by: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
---

As said, ideally this should be done with an interface such as hidraw, but its
limitations prevent us from doing it the right way; and I am not going to
touch hidraw myself anytime soon.

Regards,
   Antonio

 drivers/hid/hid-sony.c |  148 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d61f268..1b611ec 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -47,6 +47,131 @@ static void sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 }
 
 /*
+ * Show and set the master bdaddr for PS3 controller, without disconnecting
+ * the device.
+ */
+static ssize_t show_sixaxis_master_bdaddr(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	__u16 ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+	int ret;
+	unsigned char *mbuf = kmalloc(9, GFP_KERNEL);
+
+	if (!mbuf)
+		return -ENOMEM;
+
+	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				 HID_REQ_GET_REPORT,
+				 USB_DIR_IN | USB_TYPE_CLASS |
+				 USB_RECIP_INTERFACE,
+				 (3 << 8) | 0xf5, ifnum, mbuf, 8,
+				 USB_CTRL_GET_TIMEOUT);
+	if (ret < 0)
+		dev_err(dev, "%s failed to get master bdaddr, ret: %d\n",
+				__func__, ret);
+	else
+		/* 18 is strlen("00:00:00:00:00:00\n") */
+		ret = snprintf(buf, 18, "%02x:%02x:%02x:%02x:%02x:%02x\n",
+				mbuf[2], mbuf[3], mbuf[4],
+				mbuf[5], mbuf[6], mbuf[7]);
+
+	kfree(mbuf);
+
+	return ret;
+}
+
+static ssize_t store_sixaxis_master_bdaddr(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	__u16 ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+	int ret;
+	unsigned char *mbuf = kmalloc(9, GFP_KERNEL);
+
+	mbuf[0] = 0x01;
+	mbuf[1] = 0x00;
+	ret = sscanf(buf, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+			&mbuf[2], &mbuf[3], &mbuf[4],
+			&mbuf[5], &mbuf[6], &mbuf[7]);
+	if (ret != 6) {
+		dev_err(dev, "%s failed, ret: %d\n", __func__, ret);
+		return -EINVAL;
+	}
+
+	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				 HID_REQ_SET_REPORT,
+				 USB_DIR_OUT | USB_TYPE_CLASS |
+				 USB_RECIP_INTERFACE,
+				 (3 << 8) | 0xf5, ifnum, mbuf, 8,
+				 USB_CTRL_GET_TIMEOUT);
+
+	kfree(mbuf);
+
+	if (ret < 0) {
+		dev_err(dev, "%s failed to set master bdaddr, ret: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	return count;
+}
+
+/*
+ * Show the bdaddr for PS3 controller, without disconnecting the device.
+ */
+static ssize_t show_sixaxis_bdaddr(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct usb_interface *intf = to_usb_interface(dev);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	__u16 ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+	int ret;
+	unsigned char *mbuf = kmalloc(18, GFP_KERNEL);
+
+	if (!mbuf)
+		return -ENOMEM;
+
+	ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				 HID_REQ_GET_REPORT,
+				 USB_DIR_IN | USB_TYPE_CLASS |
+				 USB_RECIP_INTERFACE,
+				 (3 << 8) | 0xf2, ifnum, mbuf, 17,
+				 USB_CTRL_GET_TIMEOUT);
+	if (ret < 0)
+		dev_err(dev, "%s failed to get device bdaddr, ret: %d\n",
+				__func__, ret);
+	else
+		/* 18 is strlen("00:00:00:00:00:00\n") */
+		ret = snprintf(buf, 18, "%02x:%02x:%02x:%02x:%02x:%02x\n",
+				mbuf[4], mbuf[5], mbuf[6],
+				mbuf[7], mbuf[8], mbuf[9]);
+
+	kfree(mbuf);
+
+	return ret;
+}
+
+static DEVICE_ATTR(sixaxis_master_bdaddr, S_IWUSR|S_IRUGO,
+		show_sixaxis_master_bdaddr, store_sixaxis_master_bdaddr);
+
+static DEVICE_ATTR(sixaxis_bdaddr, S_IRUGO,
+		show_sixaxis_bdaddr, NULL);
+
+static struct attribute *sixaxis_attributes[] = {
+	&dev_attr_sixaxis_master_bdaddr.attr,
+	&dev_attr_sixaxis_bdaddr.attr,
+	NULL
+};
+
+static const struct attribute_group sixaxis_attr_group = {
+	.attrs = sixaxis_attributes,
+};
+
+
+/*
  * Sending HID_REQ_GET_REPORT changes the operation mode of the ps3 controller
  * to "operational".  Without this, the ps3 controller will not report any
  * events.
@@ -57,8 +182,9 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 	struct usb_device *dev = interface_to_usbdev(intf);
 	__u16 ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
 	int ret;
-	char *buf = kmalloc(18, GFP_KERNEL);
+	unsigned char *buf = kmalloc(18, GFP_KERNEL);
 
+	dev_info(&hdev->dev, "Calling %s\n", __func__);
 	if (!buf)
 		return -ENOMEM;
 
@@ -70,6 +196,9 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 				 USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
 		dev_err(&hdev->dev, "can't set operational mode\n");
+	else
+		dev_info(&hdev->dev, "Sony PS3 Controller bdaddr: %02x:%02x:%02x:%02x:%02x:%02x\n",
+				buf[4], buf[5], buf[6], buf[7], buf[8], buf[9]);
 
 	kfree(buf);
 
@@ -110,9 +239,17 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-	if (sc->quirks & SIXAXIS_CONTROLLER_USB)
+	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+		ret = sysfs_create_group(&intf->dev.kobj, &sixaxis_attr_group);
+		if (ret < 0) {
+			dev_err(&hdev->dev,
+				"cannot register sixaxis sysfs hooks\n");
+			goto err_stop;
+		}
+
 		ret = sixaxis_set_operational_usb(hdev);
-	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
+	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
 	else
 		ret = 0;
@@ -130,6 +267,11 @@ err_free:
 
 static void sony_remove(struct hid_device *hdev)
 {
+	struct sony_sc *sc = hid_get_drvdata(hdev);
+	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
+		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+		sysfs_remove_group(&intf->dev.kobj, &sixaxis_attr_group);
+	}
 	hid_hw_stop(hdev);
 	kfree(hid_get_drvdata(hdev));
 }
-- 
1.7.1
