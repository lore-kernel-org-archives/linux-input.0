From: Yueyao Zhu <yueyao.zhu@gmail.com>
Subject: [PATCH 1/3] USB: add API for interface driver to vote for autosuspend
Date: Thu,  8 Jun 2017 14:58:26 -0700
Message-ID: <20170608215828.130455-2-yueyao.zhu@gmail.com>
References: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170608215828.130455-1-yueyao.zhu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>, Badhri Jagan Sridharan <badhri@google.com>, Dmitry Torokhov <dtor@google.com>, Yueyao Zhu <yueyao@google.com>
List-Id: linux-input@vger.kernel.org

From: Yueyao Zhu <yueyao@google.com>

An interface driver can allow/disallow autosuspend power control
for an interface, and if all the interfaces of the active configuration
are allowed for autosuspend, autosuspend should be enabled
on the usb device.

Signed-off-by: Yueyao Zhu <yueyao@google.com>
---
 drivers/usb/core/driver.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h       | 10 +++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index eb87a259d55c..c0a20f03ad01 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1545,6 +1545,61 @@ void usb_disable_autosuspend(struct usb_device *udev)
 }
 EXPORT_SYMBOL_GPL(usb_disable_autosuspend);
 
+/**
+ * usb_allow_interface_autosuspend - allow autosuspend for the interface
+ * @intf: the USB interface which may be autosuspended
+ *
+ * This routine votes the interface to allow autosuspend. If all interfaces
+ * of the active configuration of the usb device allow autosuspend, autosuspend
+ * is enabled on the usb device through usb_enable_autosuspend().
+ *
+ * The only interface driver that will enable autosuspend on the
+ * USB device is the last in loop during interface driver probe, or midway
+ * through life if an interface changes its autosuspend status, and all other
+ * interfaces have already said yes.
+ *
+ * The caller must hold @udev's device lock.
+ */
+void usb_allow_interface_autosuspend(struct usb_interface *intf)
+{
+	struct usb_device	*udev = interface_to_usbdev(intf);
+	struct usb_host_config	*actconfig = udev->actconfig;
+	int			i;
+	bool			udev_autosuspend = true;
+
+	intf->autosuspend = 1;
+
+	for (i = 0; i < actconfig->desc.bNumInterfaces; ++i) {
+		if (!actconfig->interface[i]->autosuspend) {
+			udev_autosuspend = false;
+			break;
+		}
+	}
+
+	if (udev_autosuspend)
+		usb_enable_autosuspend(udev);
+}
+EXPORT_SYMBOL_GPL(usb_allow_interface_autosuspend);
+
+/**
+ * usb_disallow_interface_autosuspend - disallow autosuspend for the interface
+ * @intf: the USB interface which may not be autosuspended
+ *
+ * This routine votes the interface to disallow autosuspend. This immediately
+ * disables autosuspend on the usb device through usb_enable_autosuspend().
+ *
+ * The caller must hold @udev's device lock.
+ */
+void usb_disallow_interface_autosuspend(struct usb_interface *intf)
+{
+	struct usb_device	*udev = interface_to_usbdev(intf);
+
+	intf->autosuspend = 0;
+
+	usb_disable_autosuspend(udev);
+}
+EXPORT_SYMBOL_GPL(usb_disallow_interface_autosuspend);
+
 /**
  * usb_autosuspend_device - delayed autosuspend of a USB device and its interfaces
  * @udev: the usb_device to autosuspend
diff --git a/include/linux/usb.h b/include/linux/usb.h
index cb9fbd54386e..723ab9130637 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -253,6 +253,7 @@ struct usb_interface {
 	unsigned needs_binding:1;	/* needs delayed unbind/rebind */
 	unsigned resetting_device:1;	/* true: bandwidth alloc after reset */
 	unsigned authorized:1;		/* used for interface authorization */
+	unsigned autosuspend:1;		/* interface allows autosuspend */
 
 	struct device dev;		/* interface specific device info */
 	struct device *usb_dev;
@@ -741,6 +742,9 @@ static inline bool usb_acpi_power_manageable(struct usb_device *hdev, int index)
 extern void usb_enable_autosuspend(struct usb_device *udev);
 extern void usb_disable_autosuspend(struct usb_device *udev);
 
+extern void usb_allow_interface_autosuspend(struct usb_interface *intf);
+extern void usb_disallow_interface_autosuspend(struct usb_interface *intf);
+
 extern int usb_autopm_get_interface(struct usb_interface *intf);
 extern void usb_autopm_put_interface(struct usb_interface *intf);
 extern int usb_autopm_get_interface_async(struct usb_interface *intf);
@@ -760,6 +764,12 @@ static inline int usb_enable_autosuspend(struct usb_device *udev)
 static inline int usb_disable_autosuspend(struct usb_device *udev)
 { return 0; }
 
+static inline void usb_allow_interface_autosuspend(struct usb_interface *intf)
+{ }
+static inline void usb_disallow_interface_autosuspend(
+		struct usb_interface *intf)
+{ }
+
 static inline int usb_autopm_get_interface(struct usb_interface *intf)
 { return 0; }
 static inline int usb_autopm_get_interface_async(struct usb_interface *intf)
-- 
2.13.0.506.g27d5fe0cd-goog
