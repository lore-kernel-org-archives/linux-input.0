From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 1/2] Input: introduce ABS_MAX2/CNT2 and friends
Date: Tue, 27 Sep 2016 16:38:51 -0700
Message-ID: <1475019532-16876-2-git-send-email-roderick@gaikai.com>
References: <1475019532-16876-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33782 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756465AbcI0X5E (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 19:57:04 -0400
Received: by mail-io0-f177.google.com with SMTP id r145so32742601ior.0
        for <linux-input@vger.kernel.org>; Tue, 27 Sep 2016 16:57:03 -0700 (PDT)
In-Reply-To: <1475019532-16876-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>, linux-kernel@vger.kernel.org, Input Tools <input-tools@lists.freedesktop.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

David Herrmann's original patch was ported over to a modern Linux kernel.
In the process, we went over all the feedback to the original patch series
and added various improvements:

- evdev_handle_get_abs2 returns valid_cnt instead of 0 when succesfull
- Updated documentation of EVIOCGABS2/EVIOCSABS2 ioctls based.
- Clarified language around ABS_MAX2 definition, to state the *ABS2 ioctls
  should be used for the full range.

[PATCH 2/4] Input: introduce ABS_MAX2/CNT2 and friends

David Herrmann <dh.herrmann@gmail.com>
Tue Dec 17 07:48:52 PST 2013
Previous message: [PATCH 1/4] Input: uinput: add full absinfo support
Next message: [PATCH 2/4] Input: introduce ABS_MAX2/CNT2 and friends
Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
As we painfully noticed during the 3.12 merge-window our
EVIOCGABS/EVIOCSABS API is limited to ABS_MAX<=0x3f. We tried several
hacks to work around it but if we ever decide to increase ABS_MAX, the
EVIOCSABS ioctl ABI might overflow into the next byte causing horrible
misinterpretations in the kernel that we cannot catch.

Therefore, we decided to go with ABS_MAX2/CNT2 and introduce two new
ioctls to get/set abs-params. They no longer encode the ABS code in the
ioctl number and thus allow up to 4 billion ABS codes.

The new API also allows to query multiple ABS values with one call. To
allow EVIOCSABS2(code = 0, cnt = ABS_CNT2) we need to silently ignore
writes to ABS_MT_SLOT. Furthermore, for better compatibility with
newer user-space, we ignore writes to unknown codes. Hence, if we ever
increase ABS_MAX2, new user-space will work with code=0,cnt=ABS_CNT2 just
fine even on old kernels.

Note that we also need to increase EV_VERSION so user-space can reliably
know whether ABS2 is supported. Unfortunately, we return EINVAL instead of
ENOSYS for unknown evdev ioctls so it's nearly impossible to catch
reliably without EVIOCGVERSION.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-debug.c                  |  2 +-
 drivers/hid/hid-input.c                  |  2 +-
 drivers/input/evdev.c                    | 95 +++++++++++++++++++++++++++++++-
 drivers/input/input.c                    | 14 ++---
 drivers/input/keyboard/goldfish_events.c |  6 +-
 drivers/input/keyboard/hil_kbd.c         |  2 +-
 drivers/input/misc/uinput.c              |  8 +--
 include/linux/hid.h                      |  2 +-
 include/linux/input.h                    |  6 +-
 include/linux/mod_devicetable.h          |  2 +-
 include/uapi/linux/input-event-codes.h   | 14 ++++-
 include/uapi/linux/input.h               | 37 ++++++++++++-
 12 files changed, 165 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index acfb522..7205d4a 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -963,7 +963,7 @@ static const char *relatives[REL_MAX + 1] = {
 	[REL_WHEEL] = "Wheel",		[REL_MISC] = "Misc",
 };
 
-static const char *absolutes[ABS_CNT] = {
+static const char *absolutes[ABS_CNT2] = {
 	[ABS_X] = "X",			[ABS_Y] = "Y",
 	[ABS_Z] = "Z",			[ABS_RX] = "Rx",
 	[ABS_RY] = "Ry",		[ABS_RZ] = "Rz",
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bcfaf32..26b161d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1411,7 +1411,7 @@ static bool hidinput_has_been_populated(struct hid_input *hidinput)
 	for (i = 0; i < BITS_TO_LONGS(REL_CNT); i++)
 		r |= hidinput->input->relbit[i];
 
-	for (i = 0; i < BITS_TO_LONGS(ABS_CNT); i++)
+	for (i = 0; i < BITS_TO_LONGS(ABS_CNT2); i++)
 		r |= hidinput->input->absbit[i];
 
 	for (i = 0; i < BITS_TO_LONGS(MSC_CNT); i++)
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..569e425 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -815,7 +815,7 @@ static int handle_eviocgbit(struct input_dev *dev,
 	case      0: bits = dev->evbit;  len = EV_MAX;  break;
 	case EV_KEY: bits = dev->keybit; len = KEY_MAX; break;
 	case EV_REL: bits = dev->relbit; len = REL_MAX; break;
-	case EV_ABS: bits = dev->absbit; len = ABS_MAX; break;
+	case EV_ABS: bits = dev->absbit; len = ABS_MAX2; break;
 	case EV_MSC: bits = dev->mscbit; len = MSC_MAX; break;
 	case EV_LED: bits = dev->ledbit; len = LED_MAX; break;
 	case EV_SND: bits = dev->sndbit; len = SND_MAX; break;
@@ -827,6 +827,93 @@ static int handle_eviocgbit(struct input_dev *dev,
 	return bits_to_user(bits, len, size, p, compat_mode);
 }
 
+static int evdev_handle_get_abs2(struct input_dev *dev, void __user *p)
+{
+	u32 code, cnt, valid_cnt, i;
+	struct input_absinfo2 __user *pinfo = p;
+	struct input_absinfo abs;
+
+	if (copy_from_user(&code, &pinfo->code, sizeof(code)))
+		return -EFAULT;
+	if (copy_from_user(&cnt, &pinfo->cnt, sizeof(cnt)))
+		return -EFAULT;
+	if (!cnt)
+		return 0;
+
+	if (!dev->absinfo)
+		valid_cnt = 0;
+	else if (code > ABS_MAX2)
+		valid_cnt = 0;
+	else if (code + cnt <= code || code + cnt > ABS_MAX2)
+		valid_cnt = ABS_MAX2 - code + 1;
+	else
+		valid_cnt = cnt;
+
+	for (i = 0; i < valid_cnt; ++i) {
+		/*
+		 * Take event lock to ensure that we are not
+		 * copying data while EVIOCSABS2 changes it.
+		 * Might be inconsistent, otherwise.
+		 */
+		spin_lock_irq(&dev->event_lock);
+		abs = dev->absinfo[code + i];
+		spin_unlock_irq(&dev->event_lock);
+
+		if (copy_to_user(&pinfo->info[i], &abs, sizeof(abs)))
+			return -EFAULT;
+	}
+
+	memset(&abs, 0, sizeof(abs));
+	for (i = valid_cnt; i < cnt; ++i)
+		if (copy_to_user(&pinfo->info[i], &abs, sizeof(abs)))
+			return -EFAULT;
+
+	return valid_cnt;
+}
+
+static int evdev_handle_set_abs2(struct input_dev *dev, void __user *p)
+{
+	struct input_absinfo2 __user *pinfo = p;
+	struct input_absinfo *abs;
+	u32 code, cnt, i;
+	size_t size;
+
+	if (!dev->absinfo)
+		return 0;
+	if (copy_from_user(&code, &pinfo->code, sizeof(code)))
+		return -EFAULT;
+	if (copy_from_user(&cnt, &pinfo->cnt, sizeof(cnt)))
+		return -EFAULT;
+	if (!cnt || code > ABS_MAX2)
+		return 0;
+
+	if (code + cnt <= code || code + cnt > ABS_MAX2)
+		cnt = ABS_MAX2 - code + 1;
+
+	size = cnt * sizeof(*abs);
+	abs = memdup_user(pinfo->info, size);
+	if (IS_ERR(abs))
+		return PTR_ERR(abs);
+
+	/*
+	 * Take event lock to ensure that we are not
+	 * changing device parameters in the middle
+	 * of event.
+	 */
+	spin_lock_irq(&dev->event_lock);
+	for (i = 0; i < cnt; ++i) {
+		/* silently drop ABS_MT_SLOT */
+		if (code + i == ABS_MT_SLOT)
+			continue;
+
+		dev->absinfo[code + i] = abs[i];
+	}
+	spin_unlock_irq(&dev->event_lock);
+
+	kfree(abs);
+	return 0;
+}
+
 static int evdev_handle_get_keycode(struct input_dev *dev, void __user *p)
 {
 	struct input_keymap_entry ke = {
@@ -1155,6 +1242,12 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 
 		return evdev_set_clk_type(client, i);
 
+	case EVIOCGABS2:
+		return evdev_handle_get_abs2(dev, p);
+
+	case EVIOCSABS2:
+		return evdev_handle_set_abs2(dev, p);
+
 	case EVIOCGKEYCODE:
 		return evdev_handle_get_keycode(dev, p);
 
diff --git a/drivers/input/input.c b/drivers/input/input.c
index d95c34e..ecf5aa6 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -310,7 +310,7 @@ static int input_get_disposition(struct input_dev *dev,
 		break;
 
 	case EV_ABS:
-		if (is_event_supported(code, dev->absbit, ABS_MAX))
+		if (is_event_supported(code, dev->absbit, ABS_MAX2))
 			disposition = input_handle_abs_event(dev, code, &value);
 
 		break;
@@ -481,7 +481,7 @@ EXPORT_SYMBOL(input_inject_event);
 void input_alloc_absinfo(struct input_dev *dev)
 {
 	if (!dev->absinfo)
-		dev->absinfo = kcalloc(ABS_CNT, sizeof(struct input_absinfo),
+		dev->absinfo = kcalloc(ABS_CNT2, sizeof(struct input_absinfo),
 					GFP_KERNEL);
 
 	WARN(!dev->absinfo, "%s(): kcalloc() failed?\n", __func__);
@@ -965,7 +965,7 @@ static const struct input_device_id *input_match_device(struct input_handler *ha
 		if (!bitmap_subset(id->relbit, dev->relbit, REL_MAX))
 			continue;
 
-		if (!bitmap_subset(id->absbit, dev->absbit, ABS_MAX))
+		if (!bitmap_subset(id->absbit, dev->absbit, ABS_MAX2))
 			continue;
 
 		if (!bitmap_subset(id->mscbit, dev->mscbit, MSC_MAX))
@@ -1158,7 +1158,7 @@ static int input_devices_seq_show(struct seq_file *seq, void *v)
 	if (test_bit(EV_REL, dev->evbit))
 		input_seq_print_bitmap(seq, "REL", dev->relbit, REL_MAX);
 	if (test_bit(EV_ABS, dev->evbit))
-		input_seq_print_bitmap(seq, "ABS", dev->absbit, ABS_MAX);
+		input_seq_print_bitmap(seq, "ABS", dev->absbit, ABS_MAX2);
 	if (test_bit(EV_MSC, dev->evbit))
 		input_seq_print_bitmap(seq, "MSC", dev->mscbit, MSC_MAX);
 	if (test_bit(EV_LED, dev->evbit))
@@ -1344,7 +1344,7 @@ static int input_print_modalias(char *buf, int size, struct input_dev *id,
 	len += input_print_modalias_bits(buf + len, size - len,
 				'r', id->relbit, 0, REL_MAX);
 	len += input_print_modalias_bits(buf + len, size - len,
-				'a', id->absbit, 0, ABS_MAX);
+				'a', id->absbit, 0, ABS_MAX2);
 	len += input_print_modalias_bits(buf + len, size - len,
 				'm', id->mscbit, 0, MSC_MAX);
 	len += input_print_modalias_bits(buf + len, size - len,
@@ -1603,7 +1603,7 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 	if (test_bit(EV_REL, dev->evbit))
 		INPUT_ADD_HOTPLUG_BM_VAR("REL=", dev->relbit, REL_MAX);
 	if (test_bit(EV_ABS, dev->evbit))
-		INPUT_ADD_HOTPLUG_BM_VAR("ABS=", dev->absbit, ABS_MAX);
+		INPUT_ADD_HOTPLUG_BM_VAR("ABS=", dev->absbit, ABS_MAX2);
 	if (test_bit(EV_MSC, dev->evbit))
 		INPUT_ADD_HOTPLUG_BM_VAR("MSC=", dev->mscbit, MSC_MAX);
 	if (test_bit(EV_LED, dev->evbit))
@@ -1980,7 +1980,7 @@ static unsigned int input_estimate_events_per_packet(struct input_dev *dev)
 	events = mt_slots + 1; /* count SYN_MT_REPORT and SYN_REPORT */
 
 	if (test_bit(EV_ABS, dev->evbit))
-		for_each_set_bit(i, dev->absbit, ABS_CNT)
+		for_each_set_bit(i, dev->absbit, ABS_CNT2)
 			events += input_is_mt_axis(i) ? mt_slots : 1;
 
 	if (test_bit(EV_REL, dev->evbit))
diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index f6e643b..f1b50bc 100644
--- a/drivers/input/keyboard/goldfish_events.c
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -90,8 +90,8 @@ static void events_import_abs_params(struct event_dev *edev)
 	__raw_writel(PAGE_ABSDATA, addr + REG_SET_PAGE);
 
 	count = __raw_readl(addr + REG_LEN) / sizeof(val);
-	if (count > ABS_MAX)
-		count = ABS_MAX;
+	if (count > ABS_MAX2)
+		count = ABS_MAX2;
 
 	for (i = 0; i < count; i++) {
 		if (!test_bit(i, input_dev->absbit))
@@ -158,7 +158,7 @@ static int events_probe(struct platform_device *pdev)
 	events_import_bits(edev, input_dev->evbit, EV_SYN, EV_MAX);
 	events_import_bits(edev, input_dev->keybit, EV_KEY, KEY_MAX);
 	events_import_bits(edev, input_dev->relbit, EV_REL, REL_MAX);
-	events_import_bits(edev, input_dev->absbit, EV_ABS, ABS_MAX);
+	events_import_bits(edev, input_dev->absbit, EV_ABS, ABS_MAX2);
 	events_import_bits(edev, input_dev->mscbit, EV_MSC, MSC_MAX);
 	events_import_bits(edev, input_dev->ledbit, EV_LED, LED_MAX);
 	events_import_bits(edev, input_dev->sndbit, EV_SND, SND_MAX);
diff --git a/drivers/input/keyboard/hil_kbd.c b/drivers/input/keyboard/hil_kbd.c
index 5b152f2..6878f70 100644
--- a/drivers/input/keyboard/hil_kbd.c
+++ b/drivers/input/keyboard/hil_kbd.c
@@ -386,7 +386,7 @@ static void hil_dev_pointer_setup(struct hil_dev *ptr)
 					0, HIL_IDD_AXIS_MAX(idd, i - 3), 0, 0);
 
 #ifdef TABLET_AUTOADJUST
-		for (i = 0; i < ABS_MAX; i++) {
+		for (i = 0; i < ABS_MAX2; i++) {
 			int diff = input_abs_get_max(input_dev, ABS_X + i) / 10;
 			input_abs_set_min(input_dev, ABS_X + i,
 				input_abs_get_min(input_dev, ABS_X + i) + diff);
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 65ebbd1..9816a25 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -361,7 +361,7 @@ static int uinput_validate_absbits(struct input_dev *dev)
 	 * Check if absmin/absmax/absfuzz/absflat are sane.
 	 */
 
-	for_each_set_bit(cnt, dev->absbit, ABS_CNT) {
+	for_each_set_bit(cnt, dev->absbit, ABS_CNT2) {
 		if (!dev->absinfo)
 			return -EINVAL;
 
@@ -429,7 +429,7 @@ static int uinput_abs_setup(struct uinput_device *udev,
 	if (copy_from_user(&setup, arg, size))
 		return -EFAULT;
 
-	if (setup.code > ABS_MAX)
+	if (setup.code > ABS_MAX2)
 		return -ERANGE;
 
 	dev = udev->dev;
@@ -492,7 +492,7 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
 	dev->id.product	= user_dev->id.product;
 	dev->id.version	= user_dev->id.version;
 
-	for (i = 0; i < ABS_CNT; i++) {
+	for (i = 0; i < ABS_CNT2; i++) {
 		input_abs_set_max(dev, i, user_dev->absmax[i]);
 		input_abs_set_min(dev, i, user_dev->absmin[i]);
 		input_abs_set_fuzz(dev, i, user_dev->absfuzz[i]);
@@ -832,7 +832,7 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
 			goto out;
 
 		case UI_SET_ABSBIT:
-			retval = uinput_set_bit(arg, absbit, ABS_MAX);
+			retval = uinput_set_bit(arg, absbit, ABS_MAX2);
 			goto out;
 
 		case UI_SET_MSCBIT:
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75b66ec..8d0e1d8 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -886,7 +886,7 @@ static inline void hid_map_usage(struct hid_input *hidinput,
 	switch (type) {
 	case EV_ABS:
 		*bit = input->absbit;
-		*max = ABS_MAX;
+		*max = ABS_MAX2;
 		break;
 	case EV_REL:
 		*bit = input->relbit;
diff --git a/include/linux/input.h b/include/linux/input.h
index a65e3b2..550e92d 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -129,7 +129,7 @@ struct input_dev {
 	unsigned long evbit[BITS_TO_LONGS(EV_CNT)];
 	unsigned long keybit[BITS_TO_LONGS(KEY_CNT)];
 	unsigned long relbit[BITS_TO_LONGS(REL_CNT)];
-	unsigned long absbit[BITS_TO_LONGS(ABS_CNT)];
+	unsigned long absbit[BITS_TO_LONGS(ABS_CNT2)];
 	unsigned long mscbit[BITS_TO_LONGS(MSC_CNT)];
 	unsigned long ledbit[BITS_TO_LONGS(LED_CNT)];
 	unsigned long sndbit[BITS_TO_LONGS(SND_CNT)];
@@ -210,8 +210,8 @@ struct input_dev {
 #error "REL_MAX and INPUT_DEVICE_ID_REL_MAX do not match"
 #endif
 
-#if ABS_MAX != INPUT_DEVICE_ID_ABS_MAX
-#error "ABS_MAX and INPUT_DEVICE_ID_ABS_MAX do not match"
+#if ABS_MAX2 != INPUT_DEVICE_ID_ABS_MAX
+#error "ABS_MAX2 and INPUT_DEVICE_ID_ABS_MAX do not match"
 #endif
 
 #if MSC_MAX != INPUT_DEVICE_ID_MSC_MAX
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ed84c07..4c426cc 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -286,7 +286,7 @@ struct pcmcia_device_id {
 #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING	0x71
 #define INPUT_DEVICE_ID_KEY_MAX		0x2ff
 #define INPUT_DEVICE_ID_REL_MAX		0x0f
-#define INPUT_DEVICE_ID_ABS_MAX		0x3f
+#define INPUT_DEVICE_ID_ABS_MAX		0x4f
 #define INPUT_DEVICE_ID_MSC_MAX		0x07
 #define INPUT_DEVICE_ID_LED_MAX		0x0f
 #define INPUT_DEVICE_ID_SND_MAX		0x07
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index d6d071f..7bf2a2e 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -755,11 +755,23 @@
 #define ABS_MT_TOOL_X		0x3c	/* Center X tool position */
 #define ABS_MT_TOOL_Y		0x3d	/* Center Y tool position */
 
-
+/*
+ * ABS_MAX/CNT is limited to a maximum of 0x3f due to the design of EVIOCGABS
+ * and EVIOCSABS ioctls. Other kernel APIs like uinput also hardcoded it. Do
+ * not modify this value and instead use the extended ABS_MAX2/CNT2 API.
+ */
 #define ABS_MAX			0x3f
 #define ABS_CNT			(ABS_MAX+1)
 
 /*
+ * Due to API restrictions the legacy evdev API only supports ABS values up to
+ * ABS_MAX/CNT. Use the extended *ABS2 ioctls to operate on the full range of
+ * ABS values supported by the kernel.
+ */
+#define ABS_MAX2		0x4f
+#define ABS_CNT2		(ABS_MAX2+1)
+
+/*
  * Switch events
  */
 
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index c514941..3756af7 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -31,9 +31,12 @@ struct input_event {
 
 /*
  * Protocol version.
+ * 0x010000: original version
+ * 0x010001: support for long scancodes
+ * 0x010002: added ABS_CNT2/ABS_MAX2, EVIOCGABS2, EVIOCSABS2
  */
 
-#define EV_VERSION		0x010001
+#define EV_VERSION		0x010002
 
 /*
  * IOCTLs (0x00 - 0x7f)
@@ -75,6 +78,35 @@ struct input_absinfo {
 };
 
 /**
+ * struct input_absinfo2 - used by EVIOCGABS2/EVIOCSABS2 ioctls
+ * @code: First ABS code to query
+ * @cnt: Number of ABS codes to query starting at @code
+ * @info: #@cnt absinfo structures to get/set abs parameters for all codes
+ *
+ * This structure is used by the EVIOC[G/S]ABS2 ioctls which do the same as
+ * the legacy EVIOC[G/S]ABS ioctls but avoid encoding the ABS code in the ioctl
+ * number. This allows a much wider range of ABS codes. Furthermore, it allows
+ * to query multiple codes with a single call. Applications are discouraged
+ * from using EVIC[G/S]ABS except on older kernels without EVIOC[G/S]ABS2
+ * support.
+ *
+ * For axes not present on the device and for axes exceeding the kernel's
+ * built-in ABS_CNT2 maximum, EVIOCGABS2 sets all values in the struct absinfo
+ * to 0. Applications are recommended to use this API in conjunction with
+ * EVIOCGBIT to determine axes present on the device.
+ * Similar to how EVIOCABS2 returns 0 for axes, which are not present,
+ * EVIOCSABS2 silenty ignores write requests to these axes. In addition,
+ * EVIOCABS2 ignores write requests to ABS_MT_SlOT since it is an immutable
+ * axis and hence cannot be modified, so the respective value is silently
+ * ignored.
+ */
+struct input_absinfo2 {
+	__u32 code;
+	__u32 cnt;
+	struct input_absinfo info[1];
+};
+
+/**
  * struct input_keymap_entry - used by EVIOCGKEYCODE/EVIOCSKEYCODE ioctls
  * @scancode: scancode represented in machine-endian form.
  * @len: length of the scancode that resides in @scancode buffer.
@@ -161,6 +193,9 @@ struct input_mask {
 #define EVIOCGRAB		_IOW('E', 0x90, int)			/* Grab/Release device */
 #define EVIOCREVOKE		_IOW('E', 0x91, int)			/* Revoke device access */
 
+#define EVIOCGABS2		_IOR('E', 0x92, struct input_absinfo2)	/* get abs value/limits */
+#define EVIOCSABS2		_IOW('E', 0x93, struct input_absinfo2)	/* set abs value/limits */
+
 /**
  * EVIOCGMASK - Retrieve current event mask
  *
-- 
2.7.4

