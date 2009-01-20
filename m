From: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH 2/3] ati_remote2: Add per device attrs
Date: Tue, 20 Jan 2009 21:00:34 +0200
Message-ID: <1232478035-20172-2-git-send-email-syrjala@sci.fi>
References: <1232478035-20172-1-git-send-email-syrjala@sci.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1232478035-20172-1-git-send-email-syrjala-ORSVBvAovxo@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add per device channel_mask and mode_mask attributes. They inherit
the values from the module parameters when the device is registered.
One additional benefit is that now runtime changes to channel_mask
can actually affect the hardware channel setup like they should.

Signed-off-by: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
---
 drivers/input/misc/ati_remote2.c |  140 ++++++++++++++++++++++++++++++++++----
 1 files changed, 126 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 351eb90..39e0ecd 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -31,11 +31,16 @@ MODULE_LICENSE("GPL");
  * newly configured "channel".
  */
 
-static unsigned int channel_mask = 0xFFFF;
+enum {
+	ATI_REMOTE2_MAX_CHANNEL_MASK = 0xFFFF,
+	ATI_REMOTE2_MAX_MODE_MASK = 0x1F,
+};
+
+static unsigned int channel_mask = ATI_REMOTE2_MAX_CHANNEL_MASK;
 module_param(channel_mask, uint, 0644);
 MODULE_PARM_DESC(channel_mask, "Bitmask of channels to accept <15:Channel16>...<1:Channel2><0:Channel1>");
 
-static unsigned int mode_mask = 0x1F;
+static unsigned int mode_mask = ATI_REMOTE2_MAX_MODE_MASK;
 module_param(mode_mask, uint, 0644);
 MODULE_PARM_DESC(mode_mask, "Bitmask of modes to accept <4:PC><3:AUX4><2:AUX3><1:AUX2><0:AUX1>");
 
@@ -133,6 +138,9 @@ struct ati_remote2 {
 	u16 keycode[ATI_REMOTE2_MODES][ARRAY_SIZE(ati_remote2_key_table)];
 
 	unsigned int flags;
+
+	unsigned int channel_mask;
+	unsigned int mode_mask;
 };
 
 static int ati_remote2_probe(struct usb_interface *interface, const struct usb_device_id *id);
@@ -244,7 +252,7 @@ static void ati_remote2_input_mouse(struct ati_remote2 *ar2)
 
 	channel = data[0] >> 4;
 
-	if (!((1 << channel) & channel_mask))
+	if (!((1 << channel) & ar2->channel_mask))
 		return;
 
 	mode = data[0] & 0x0F;
@@ -256,7 +264,7 @@ static void ati_remote2_input_mouse(struct ati_remote2 *ar2)
 		return;
 	}
 
-	if (!((1 << mode) & mode_mask))
+	if (!((1 << mode) & ar2->mode_mask))
 		return;
 
 	input_event(idev, EV_REL, REL_X, (s8) data[1]);
@@ -283,7 +291,7 @@ static void ati_remote2_input_key(struct ati_remote2 *ar2)
 
 	channel = data[0] >> 4;
 
-	if (!((1 << channel) & channel_mask))
+	if (!((1 << channel) & ar2->channel_mask))
 		return;
 
 	mode = data[0] & 0x0F;
@@ -311,7 +319,7 @@ static void ati_remote2_input_key(struct ati_remote2 *ar2)
 			ar2->mode = mode;
 	}
 
-	if (!((1 << mode) & mode_mask))
+	if (!((1 << mode) & ar2->mode_mask))
 		return;
 
 	index = ati_remote2_lookup(hw_code);
@@ -416,7 +424,7 @@ static int ati_remote2_getkeycode(struct input_dev *idev,
 	int index, mode;
 
 	mode = scancode >> 8;
-	if (mode > ATI_REMOTE2_PC || !((1 << mode) & mode_mask))
+	if (mode > ATI_REMOTE2_PC || !((1 << mode) & ar2->mode_mask))
 		return -EINVAL;
 
 	index = ati_remote2_lookup(scancode & 0xFF);
@@ -433,7 +441,7 @@ static int ati_remote2_setkeycode(struct input_dev *idev, int scancode, int keyc
 	int index, mode, old_keycode;
 
 	mode = scancode >> 8;
-	if (mode > ATI_REMOTE2_PC || !((1 << mode) & mode_mask))
+	if (mode > ATI_REMOTE2_PC || !((1 << mode) & ar2->mode_mask))
 		return -EINVAL;
 
 	index = ati_remote2_lookup(scancode & 0xFF);
@@ -556,7 +564,7 @@ static void ati_remote2_urb_cleanup(struct ati_remote2 *ar2)
 	}
 }
 
-static int ati_remote2_setup(struct ati_remote2 *ar2)
+static int ati_remote2_setup(struct ati_remote2 *ar2, unsigned int ch_mask)
 {
 	int r, i, channel;
 
@@ -571,8 +579,8 @@ static int ati_remote2_setup(struct ati_remote2 *ar2)
 
 	channel = 0;
 	for (i = 0; i < 16; i++) {
-		if ((1 << i) & channel_mask) {
-			if (!(~(1 << i) & 0xFFFF & channel_mask))
+		if ((1 << i) & ch_mask) {
+			if (!(~(1 << i) & ch_mask))
 				channel = i + 1;
 			break;
 		}
@@ -591,6 +599,99 @@ static int ati_remote2_setup(struct ati_remote2 *ar2)
 	return 0;
 }
 
+static ssize_t ati_remote2_show_channel_mask(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
+
+	return sprintf(buf, "0x%04x\n", ar2->channel_mask);
+}
+
+static ssize_t ati_remote2_store_channel_mask(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t count)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
+	unsigned long mask;
+	int r;
+
+	if (strict_strtoul(buf, 0, &mask))
+		return -EINVAL;
+
+	if (mask & ~ATI_REMOTE2_MAX_CHANNEL_MASK)
+		return -EINVAL;
+
+	r = usb_autopm_get_interface(ar2->intf[0]);
+	if (r) {
+		dev_err(&ar2->intf[0]->dev,
+			"%s(): usb_autopm_get_interface() = %d\n", __func__, r);
+		return r;
+	}
+
+	mutex_lock(&ati_remote2_mutex);
+
+	if (mask != ar2->channel_mask && !ati_remote2_setup(ar2, mask))
+		ar2->channel_mask = mask;
+
+	mutex_unlock(&ati_remote2_mutex);
+
+	usb_autopm_put_interface(ar2->intf[0]);
+
+	return count;
+}
+
+static ssize_t ati_remote2_show_mode_mask(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
+
+	return sprintf(buf, "0x%02x\n", ar2->mode_mask);
+}
+
+static ssize_t ati_remote2_store_mode_mask(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct usb_device *udev = to_usb_device(dev);
+	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
+	unsigned long mask;
+
+	if (strict_strtoul(buf, 0, &mask))
+		return -EINVAL;
+
+	if (mask & ~ATI_REMOTE2_MAX_MODE_MASK)
+		return -EINVAL;
+
+	ar2->mode_mask = mask;
+
+	return count;
+}
+
+static DEVICE_ATTR(channel_mask, 0644, ati_remote2_show_channel_mask,
+		   ati_remote2_store_channel_mask);
+
+static DEVICE_ATTR(mode_mask, 0644, ati_remote2_show_mode_mask,
+		   ati_remote2_store_mode_mask);
+
+static struct attribute *ati_remote2_attrs[] = {
+	&dev_attr_channel_mask.attr,
+	&dev_attr_mode_mask.attr,
+	NULL,
+};
+
+static struct attribute_group ati_remote2_attr_group = {
+	.attrs = ati_remote2_attrs,
+};
+
 static int ati_remote2_probe(struct usb_interface *interface, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(interface);
@@ -621,7 +722,10 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 	if (r)
 		goto fail2;
 
-	r = ati_remote2_setup(ar2);
+	ar2->channel_mask = channel_mask & ATI_REMOTE2_MAX_CHANNEL_MASK;
+	ar2->mode_mask = mode_mask & ATI_REMOTE2_MAX_MODE_MASK;
+
+	r = ati_remote2_setup(ar2, ar2->channel_mask);
 	if (r)
 		goto fail2;
 
@@ -630,16 +734,22 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 
 	strlcat(ar2->name, "ATI Remote Wonder II", sizeof(ar2->name));
 
-	r = ati_remote2_input_init(ar2);
+	r = sysfs_create_group(&udev->dev.kobj, &ati_remote2_attr_group);
 	if (r)
 		goto fail2;
 
+	r = ati_remote2_input_init(ar2);
+	if (r)
+		goto fail3;
+
 	usb_set_intfdata(interface, ar2);
 
 	interface->needs_remote_wakeup = 1;
 
 	return 0;
 
+ fail3:
+	sysfs_remove_group(&udev->dev.kobj, &ati_remote2_attr_group);
  fail2:
 	ati_remote2_urb_cleanup(ar2);
 
@@ -663,6 +773,8 @@ static void ati_remote2_disconnect(struct usb_interface *interface)
 
 	input_unregister_device(ar2->idev);
 
+	sysfs_remove_group(&ar2->udev->dev.kobj, &ati_remote2_attr_group);
+
 	ati_remote2_urb_cleanup(ar2);
 
 	usb_driver_release_interface(&ati_remote2_driver, ar2->intf[1]);
@@ -736,7 +848,7 @@ static int ati_remote2_reset_resume(struct usb_interface *interface)
 
 	mutex_lock(&ati_remote2_mutex);
 
-	r = ati_remote2_setup(ar2);
+	r = ati_remote2_setup(ar2, ar2->channel_mask);
 	if (r)
 		goto out;
 
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
