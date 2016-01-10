From: Edwin Velds <e.velds@gmail.com>
Subject: [PATCH-V2 1/1] HID: Force feedback support for the Logitech G920
Date: Mon, 11 Jan 2016 00:25:15 +0100
Message-ID: <1452468315-8978-1-git-send-email-e.velds@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33948 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757777AbcAJXZd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2016 18:25:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simon Wood <simon@mungewell.org>, Jiri Kosina <jkosina@suse.cz>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Edwin Velds <e.velds@gmail.com>

This patch implements force feedback support for the Logitech
G920 Driving Force Racing Wheel. It is a generic implementation
of feature 0x8123 of the Logitech HID++ protocol and should be
usable for any future devices that implement this feature.

This patch should be applied after the basic G920 support patch
by Simon Wood:
http://www.spinics.net/lists/linux-input/msg42174.html

The driving supports everything that is supported by the G920
firmware:
    FF_CONSTANT
    FF_PERIODIC
    FF_SINE
    FF_SQUARE
    FF_SAW_UP
    FF_SAW_DOWN
    FF_TRIANGLE
    FF_SPRING
    FF_DAMPER
    FF_AUTOCENTER
    FF_GAIN
and for version 2 firmware also:
    FF_FRICTION
    FF_INERTIA
    FF_RAMP

Both envelopes and replay values are supported as well, but some
problems may occur when using firmware release 1. There is also a
small residual clockwise damper in the wheel when using the first
firmware release. All problems are fixed in the soon te be released
firmware version 2.

The default spring is disabled by permanently placing a spring
force in the wheel. This spring is also used as the autocenter
spring.

Signed-off-by: Edwin Velds <e.velds@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 704 +++++++++++++++++++++++++++++++++------
 1 file changed, 594 insertions(+), 110 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f2a4811..35205f0 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -15,13 +15,19 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/device.h>
+#include <linux/input.h>
+#include <linux/usb.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/kfifo.h>
 #include <linux/input/mt.h>
+#include <linux/workqueue.h>
+#include <linux/atomic.h>
+#include <linux/fixp-arith.h>
 #include <asm/unaligned.h>
+#include "usbhid/usbhid.h"
 #include "hid-ids.h"
 
 MODULE_LICENSE("GPL");
@@ -773,6 +779,591 @@ static void hidpp_touchpad_raw_xy_event(struct hidpp_device *hidpp_dev,
 	}
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x8123: Force feedback support                                             */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_FF_GET_INFO		0x01
+#define HIDPP_FF_RESET_ALL		0x11
+#define HIDPP_FF_DOWNLOAD_EFFECT	0x21
+#define HIDPP_FF_SET_EFFECT_STATE	0x31
+#define HIDPP_FF_DESTROY_EFFECT		0x41
+#define HIDPP_FF_GET_APERTURE		0x51
+#define HIDPP_FF_SET_APERTURE		0x61
+#define HIDPP_FF_GET_GLOBAL_GAINS	0x71
+#define HIDPP_FF_SET_GLOBAL_GAINS	0x81
+
+#define HIDPP_FF_EFFECT_STATE_GET	0x00
+#define HIDPP_FF_EFFECT_STATE_STOP	0x01
+#define HIDPP_FF_EFFECT_STATE_PLAY	0x02
+#define HIDPP_FF_EFFECT_STATE_PAUSE	0x03
+
+#define HIDPP_FF_EFFECT_CONSTANT	0x00
+#define HIDPP_FF_EFFECT_PERIODIC_SINE		0x01
+#define HIDPP_FF_EFFECT_PERIODIC_SQUARE		0x02
+#define HIDPP_FF_EFFECT_PERIODIC_TRIANGLE	0x03
+#define HIDPP_FF_EFFECT_PERIODIC_SAWTOOTHUP	0x04
+#define HIDPP_FF_EFFECT_PERIODIC_SAWTOOTHDOWN	0x05
+#define HIDPP_FF_EFFECT_SPRING		0x06
+#define HIDPP_FF_EFFECT_DAMPER		0x07
+#define HIDPP_FF_EFFECT_FRICTION	0x08
+#define HIDPP_FF_EFFECT_INERTIA		0x09
+#define HIDPP_FF_EFFECT_RAMP		0x0A
+
+#define HIDPP_FF_EFFECT_AUTOSTART	0x80
+
+#define HIDPP_FF_EFFECTID_NONE		-1
+#define HIDPP_FF_EFFECTID_AUTOCENTER	-2
+
+#define HIDPP_FF_MAX_PARAMS	20
+#define HIDPP_FF_RESERVED_SLOTS	1
+
+#define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
+
+struct hidpp_ff_private_data {
+	struct hidpp_device *hidpp;
+	u8 feature_index;
+	u8 version;
+	u16 gain;
+	s16 range;
+	u8 slot_autocenter;
+	u8 num_effects;
+	int *effect_ids;
+	struct workqueue_struct *wq;
+	atomic_t workqueue_size;
+};
+
+struct hidpp_ff_work_data {
+	struct work_struct work;
+	struct hidpp_ff_private_data *data;
+	int effect_id;
+	u8 command;
+	u8 params[HIDPP_FF_MAX_PARAMS];
+	u8 size;
+};
+
+static const signed short hiddpp_ff_effects[] = {
+	FF_CONSTANT,
+	FF_PERIODIC,
+	FF_SINE,
+	FF_SQUARE,
+	FF_SAW_UP,
+	FF_SAW_DOWN,
+	FF_TRIANGLE,
+	FF_SPRING,
+	FF_DAMPER,
+	FF_AUTOCENTER,
+	FF_GAIN,
+	-1
+};
+
+static const signed short hiddpp_ff_effects_v2[] = {
+	FF_RAMP,
+	FF_FRICTION,
+	FF_INERTIA,
+	-1
+};
+
+static const u8 HIDPP_FF_CONDITION_CMDS[] = { 
+	HIDPP_FF_EFFECT_SPRING,
+	HIDPP_FF_EFFECT_FRICTION,
+	HIDPP_FF_EFFECT_DAMPER,
+	HIDPP_FF_EFFECT_INERTIA
+};
+
+static const char *HIDPP_FF_CONDITION_NAMES[] = { 
+	"spring",
+	"friction",
+	"damper",
+	"inertia"
+};
+
+
+static u8 hidpp_ff_find_effect(struct hidpp_ff_private_data *data, int effect_id)
+{
+	int i;
+
+	for (i = 0; i < data->num_effects; i++)
+		if (data->effect_ids[i] == effect_id)
+			return i+1;
+
+	return 0;
+}
+
+static void hidpp_ff_work_handler(struct work_struct *w)
+{
+	struct hidpp_ff_work_data *wd = container_of(w, struct hidpp_ff_work_data, work);
+	struct hidpp_ff_private_data *data = wd->data;
+	struct hidpp_report response;
+	u8 slot;
+	int ret;
+
+	/* add slot number if needed */
+	switch (wd->effect_id) {
+	case HIDPP_FF_EFFECTID_AUTOCENTER:
+		wd->params[0] = data->slot_autocenter;
+		break;
+	case HIDPP_FF_EFFECTID_NONE:
+		/* leave slot as zero */
+		break;
+	default:
+		/* find current slot for effect */
+		wd->params[0] = hidpp_ff_find_effect(data, wd->effect_id);
+		break;
+	}
+
+	/* send command and wait for reply */
+	ret = hidpp_send_fap_command_sync(data->hidpp, data->feature_index,
+		wd->command, wd->params, wd->size, &response);
+
+	if (ret) {
+		hid_err(data->hidpp->hid_dev, "Failed to send command to device!\n");
+		goto out;
+	}
+
+	/* parse return data */
+	switch (wd->command) {
+	case HIDPP_FF_DOWNLOAD_EFFECT:
+		slot = response.fap.params[0];
+		if (slot > 0 && slot <= data->num_effects) {
+			if (wd->effect_id >= 0)
+				/* regular effect uploaded */
+				data->effect_ids[slot-1] = wd->effect_id;
+			else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
+				/* autocenter spring uploaded */
+				data->slot_autocenter = slot;
+		}
+		break;
+	case HIDPP_FF_DESTROY_EFFECT:
+		if (wd->effect_id >= 0)
+			/* regular effect destroyed */
+			data->effect_ids[wd->params[0]-1] = -1;
+		else if (wd->effect_id >= HIDPP_FF_EFFECTID_AUTOCENTER)
+			/* autocenter spring destoyed */
+			data->slot_autocenter = 0;
+		break;
+	case HIDPP_FF_SET_GLOBAL_GAINS:
+		data->gain = (wd->params[0] << 8) + wd->params[1];
+		break;
+	case HIDPP_FF_SET_APERTURE:
+		data->range = (wd->params[0] << 8) + wd->params[1];
+		break;
+	default:
+		/* no action needed */
+		break;
+	}
+
+out:
+	atomic_dec(&data->workqueue_size);
+	kfree(wd);
+}
+
+static int hidpp_ff_queue_work(struct hidpp_ff_private_data *data, int effect_id, u8 command, u8 *params, u8 size)
+{
+	struct hidpp_ff_work_data *wd = kzalloc(sizeof(*wd), GFP_KERNEL);
+	int s;
+
+	if (!wd)
+		return -ENOMEM;
+
+	INIT_WORK(&wd->work, hidpp_ff_work_handler);
+
+	wd->data = data;
+	wd->effect_id = effect_id;
+	wd->command = command;
+	wd->size = size;
+	memcpy(wd->params, params, size);
+
+	atomic_inc(&data->workqueue_size);
+	queue_work(data->wq, &wd->work);
+
+	/* warn about excessive queue size */
+	s = atomic_read(&data->workqueue_size);
+	if (s >= 20 && s % 20 == 0)
+		hid_warn(data->hidpp->hid_dev, "Force feedback command queue contains %d commands, causing substantial delays!", s);
+
+	return 0;
+}
+
+static int hidpp_ff_upload_effect(struct input_dev *dev, struct ff_effect *effect, struct ff_effect *old)
+{
+	struct hidpp_ff_private_data *data = dev->ff->private;
+	u8 params[20];
+	u8 size;
+	int force;
+
+	/* set common parameters */
+	params[2] = effect->replay.length >> 8;
+	params[3] = effect->replay.length & 255;
+	params[4] = effect->replay.delay >> 8;
+	params[5] = effect->replay.delay & 255;
+
+	switch (effect->type) {
+	case FF_CONSTANT:
+		force = (effect->u.constant.level * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
+		params[1] = HIDPP_FF_EFFECT_CONSTANT;
+		params[6] = force >> 8;
+		params[7] = force & 255;
+		params[8] = effect->u.constant.envelope.attack_level >> 7;
+		params[9] = effect->u.constant.envelope.attack_length >> 8;
+		params[10] = effect->u.constant.envelope.attack_length & 255;
+		params[11] = effect->u.constant.envelope.fade_level >> 7;
+		params[12] = effect->u.constant.envelope.fade_length >> 8;
+		params[13] = effect->u.constant.envelope.fade_length & 255;
+		size = 14;
+		dbg_hid("Uploading constant force level=%d in dir %d = %d\n",
+				effect->u.constant.level,
+				effect->direction, force);
+		dbg_hid("          envelope attack=(%d, %d ms) fade=(%d, %d ms)\n",
+				effect->u.constant.envelope.attack_level,
+				effect->u.constant.envelope.attack_length,
+				effect->u.constant.envelope.fade_level,
+				effect->u.constant.envelope.fade_length);
+		break;
+	case FF_PERIODIC:
+	{
+		switch (effect->u.periodic.waveform) {
+		case FF_SINE:
+			params[1] = HIDPP_FF_EFFECT_PERIODIC_SINE;
+			break;
+		case FF_SQUARE:
+			params[1] = HIDPP_FF_EFFECT_PERIODIC_SQUARE;
+			break;
+		case FF_SAW_UP:
+			params[1] = HIDPP_FF_EFFECT_PERIODIC_SAWTOOTHUP;
+			break;
+		case FF_SAW_DOWN:
+			params[1] = HIDPP_FF_EFFECT_PERIODIC_SAWTOOTHDOWN;
+			break;
+		case FF_TRIANGLE:
+			params[1] = HIDPP_FF_EFFECT_PERIODIC_TRIANGLE;
+			break;
+		default:
+			hid_err(data->hidpp->hid_dev, "Unexpected periodic waveform type %i!\n", effect->u.periodic.waveform);
+			return -EINVAL;
+		}
+		force = (effect->u.periodic.magnitude * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
+		params[6] = effect->u.periodic.magnitude >> 8;
+		params[7] = effect->u.periodic.magnitude & 255;
+		params[8] = effect->u.periodic.offset >> 8;
+		params[9] = effect->u.periodic.offset & 255;
+		params[10] = effect->u.periodic.period >> 8;
+		params[11] = effect->u.periodic.period & 255;
+		params[12] = effect->u.periodic.phase >> 8;
+		params[13] = effect->u.periodic.phase & 255;
+		params[14] = effect->u.periodic.envelope.attack_level >> 7;
+		params[15] = effect->u.periodic.envelope.attack_length >> 8;
+		params[16] = effect->u.periodic.envelope.attack_length & 255;
+		params[17] = effect->u.periodic.envelope.fade_level >> 7;
+		params[18] = effect->u.periodic.envelope.fade_length >> 8;
+		params[19] = effect->u.periodic.envelope.fade_length & 255;
+		size = 20;
+		dbg_hid("Uploading periodic force mag=%d/dir=%d, offset=%d, period=%d ms, phase=%d\n",
+				effect->u.periodic.magnitude, effect->direction,
+				effect->u.periodic.offset,
+				effect->u.periodic.period,
+				effect->u.periodic.phase);
+		dbg_hid("          envelope attack=(%d, %d ms) fade=(%d, %d ms)\n",
+				effect->u.periodic.envelope.attack_level,
+				effect->u.periodic.envelope.attack_length,
+				effect->u.periodic.envelope.fade_level,
+				effect->u.periodic.envelope.fade_length);
+		break;
+	}
+	case FF_RAMP:
+		params[1] = HIDPP_FF_EFFECT_RAMP;
+		force = (effect->u.ramp.start_level * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
+		params[6] = force >> 8;
+		params[7] = force & 255;
+		force = (effect->u.ramp.end_level * fixp_sin16((effect->direction * 360) >> 16)) >> 15;
+		params[8] = force >> 8;
+		params[9] = force & 255;
+		params[10] = effect->u.ramp.envelope.attack_level >> 7;
+		params[11] = effect->u.ramp.envelope.attack_length >> 8;
+		params[12] = effect->u.ramp.envelope.attack_length & 255;
+		params[13] = effect->u.ramp.envelope.fade_level >> 7;
+		params[14] = effect->u.ramp.envelope.fade_length >> 8;
+		params[15] = effect->u.ramp.envelope.fade_length & 255;
+		size = 16;
+		dbg_hid("Uploading ramp force level=%d -> %d in dir %d = %d\n",
+				effect->u.ramp.start_level,
+				effect->u.ramp.end_level,
+				effect->direction, force);
+		dbg_hid("          envelope attack=(%d, %d ms) fade=(%d, %d ms)\n",
+				effect->u.ramp.envelope.attack_level,
+				effect->u.ramp.envelope.attack_length,
+				effect->u.ramp.envelope.fade_level,
+				effect->u.ramp.envelope.fade_length);
+		break;
+	case FF_FRICTION:
+	case FF_INERTIA:
+	case FF_SPRING:
+	case FF_DAMPER:
+		params[1] = HIDPP_FF_CONDITION_CMDS[effect->type - FF_SPRING];
+		params[6] = effect->u.condition[0].left_saturation >> 9;
+		params[7] = (effect->u.condition[0].left_saturation >> 1) & 255;
+		params[8] = effect->u.condition[0].left_coeff >> 8;
+		params[9] = effect->u.condition[0].left_coeff & 255;
+		params[10] = effect->u.condition[0].deadband >> 9;
+		params[11] = (effect->u.condition[0].deadband >> 1) & 255;
+		params[12] = effect->u.condition[0].center >> 8;
+		params[13] = effect->u.condition[0].center & 255;
+		params[14] = effect->u.condition[0].right_coeff >> 8;
+		params[15] = effect->u.condition[0].right_coeff & 255;
+		params[16] = effect->u.condition[0].right_saturation >> 9;
+		params[17] = (effect->u.condition[0].right_saturation >> 1) & 255;
+		size = 18;
+		dbg_hid("Uploading %s force left coeff=%d, left sat=%d, right coeff=%d, right sat=%d\n",
+				HIDPP_FF_CONDITION_NAMES[effect->type - FF_SPRING],
+				effect->u.condition[0].left_coeff,
+				effect->u.condition[0].left_saturation,
+				effect->u.condition[0].right_coeff,
+				effect->u.condition[0].right_saturation);
+		dbg_hid("          deadband=%d, center=%d\n",
+				effect->u.condition[0].deadband,
+				effect->u.condition[0].center);
+		break;
+	default:
+		hid_err(data->hidpp->hid_dev, "Unexpected force type %i!\n", effect->type);
+		return -EINVAL;
+	}
+
+	return hidpp_ff_queue_work(data, effect->id, HIDPP_FF_DOWNLOAD_EFFECT, params, size);
+}
+
+static int hidpp_ff_playback(struct input_dev *dev, int effect_id, int value)
+{
+	struct hidpp_ff_private_data *data = dev->ff->private;
+	u8 params[2];
+
+	params[1] = value ? HIDPP_FF_EFFECT_STATE_PLAY : HIDPP_FF_EFFECT_STATE_STOP;
+
+	dbg_hid("St%sing playback of effect %d.\n", value?"art":"opp", effect_id);
+
+	return hidpp_ff_queue_work(data, effect_id, HIDPP_FF_SET_EFFECT_STATE, params, ARRAY_SIZE(params));
+}
+
+static int hidpp_ff_erase_effect(struct input_dev *dev, int effect_id)
+{
+	struct hidpp_ff_private_data *data = dev->ff->private;
+	u8 slot = 0;
+
+	dbg_hid("Erasing effect %d.\n", effect_id);
+
+	return hidpp_ff_queue_work(data, effect_id, HIDPP_FF_DESTROY_EFFECT, &slot, 1);
+}
+
+static void hidpp_ff_set_autocenter(struct input_dev *dev, u16 magnitude)
+{
+	struct hidpp_ff_private_data *data = dev->ff->private;
+	u8 params[18];
+
+	dbg_hid("Setting autocenter to %d.\n", magnitude);
+
+	/* start a standard spring effect */
+	params[1] = HIDPP_FF_EFFECT_SPRING | HIDPP_FF_EFFECT_AUTOSTART;
+	/* zero delay and duration */
+	params[2] = params[3] = params[4] = params[5] = 0;
+	/* set coeff to 25% of saturation */
+	params[8] = params[14] = magnitude >> 11;
+	params[9] = params[15] = (magnitude >> 3) & 255;
+	params[6] = params[16] = magnitude >> 9;
+	params[7] = params[17] = (magnitude >> 1) & 255;
+	/* zero deadband and center */
+	params[10] = params[11] = params[12] = params[13] = 0;
+
+	hidpp_ff_queue_work(data, HIDPP_FF_EFFECTID_AUTOCENTER, HIDPP_FF_DOWNLOAD_EFFECT, params, ARRAY_SIZE(params));
+}
+
+static void hidpp_ff_set_gain(struct input_dev *dev, u16 gain)
+{
+	struct hidpp_ff_private_data *data = dev->ff->private;
+	u8 params[4];
+
+	dbg_hid("Setting gain to %d.\n", gain);
+
+	params[0] = gain >> 8;
+	params[1] = gain & 255;
+	params[2] = 0; /* no boost */
+	params[3] = 0;
+
+	hidpp_ff_queue_work(data, HIDPP_FF_EFFECTID_NONE, HIDPP_FF_SET_GLOBAL_GAINS, params, ARRAY_SIZE(params));
+}
+
+static ssize_t hidpp_ff_range_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct hid_device *hid = to_hid_device(dev);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	struct input_dev *idev = hidinput->input;
+	struct hidpp_ff_private_data *data = idev->ff->private;
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", data->range);
+}
+
+static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct hid_device *hid = to_hid_device(dev);
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	struct input_dev *idev = hidinput->input;
+	struct hidpp_ff_private_data *data = idev->ff->private;
+	u8 params[2];
+	int range = simple_strtoul(buf, NULL, 10);
+
+	range = clamp(range, 180, 900);
+
+	params[0] = range >> 8;
+	params[1] = range & 0x00FF;
+
+	hidpp_ff_queue_work(data, -1, HIDPP_FF_SET_APERTURE, params, ARRAY_SIZE(params));
+
+	return count;
+}
+
+static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, hidpp_ff_range_show, hidpp_ff_range_store);
+
+static void hidpp_ff_destroy(struct ff_device *ff)
+{
+	struct hidpp_ff_private_data *data = ff->private;
+
+	kfree(data->effect_ids);
+}
+
+int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
+{
+	struct hid_device *hid = hidpp->hid_dev;
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	struct input_dev *dev = hidinput->input;
+	const struct usb_device_descriptor *udesc = &(hid_to_usb_dev(hid)->descriptor);
+	const u16 bcdDevice = le16_to_cpu(udesc->bcdDevice);
+	struct ff_device *ff;
+	struct hidpp_report response;
+	struct hidpp_ff_private_data *data;
+	int error, j, num_slots;
+	u8 version;
+
+	if (!dev) {
+		hid_err(hid, "Struct input_dev not set!\n");
+		return -EINVAL;
+	}
+
+	/* Get firmware release */
+	version = bcdDevice & 255;
+
+	/* Set supported force feedback capabilities */
+	for (j = 0; hiddpp_ff_effects[j] >= 0; j++)
+		set_bit(hiddpp_ff_effects[j], dev->ffbit);
+	if (version > 1)
+		for (j = 0; hiddpp_ff_effects_v2[j] >= 0; j++)
+			set_bit(hiddpp_ff_effects_v2[j], dev->ffbit);
+
+	/* Read number of slots available in device */
+	error = hidpp_send_fap_command_sync(hidpp, feature_index,
+		HIDPP_FF_GET_INFO, NULL, 0, &response);
+	if (error) {
+		if (error < 0)
+			return error;
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, error);
+		return -EPROTO;
+	}
+
+	num_slots = response.fap.params[0] - HIDPP_FF_RESERVED_SLOTS;
+
+	error = input_ff_create(dev, num_slots);
+
+	if (error) {
+		hid_err(dev, "Failed to create FF device!\n");
+		return error;
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->effect_ids = kcalloc(num_slots, sizeof(int), GFP_KERNEL);
+	if (!data->effect_ids) {
+		kfree(data);
+		return -ENOMEM;
+	}
+	data->hidpp = hidpp;
+	data->feature_index = feature_index;
+	data->version = version;
+	data->slot_autocenter = 0;
+	data->num_effects = num_slots;
+	for (j = 0; j < num_slots; j++)
+		data->effect_ids[j] = -1;
+
+	ff = dev->ff;
+	ff->private = data;
+
+	ff->upload = hidpp_ff_upload_effect;
+	ff->erase = hidpp_ff_erase_effect;
+	ff->playback = hidpp_ff_playback;
+	ff->set_gain = hidpp_ff_set_gain;
+	ff->set_autocenter = hidpp_ff_set_autocenter;
+	ff->destroy = hidpp_ff_destroy;
+
+
+	/* reset all forces */
+	error = hidpp_send_fap_command_sync(hidpp, feature_index,
+		HIDPP_FF_RESET_ALL, NULL, 0, &response);
+
+	/* Read current Range */
+	error = hidpp_send_fap_command_sync(hidpp, feature_index,
+		HIDPP_FF_GET_APERTURE, NULL, 0, &response);
+	if (error)
+		hid_warn(hidpp->hid_dev, "Failed to read range from device!\n");
+	data->range = error ? 900 : get_unaligned_be16(&response.fap.params[0]);
+
+	/* Create sysfs interface */
+	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
+	if (error)
+		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d!\n", error);
+
+	/* Read the current gain values */
+	error = hidpp_send_fap_command_sync(hidpp, feature_index,
+		HIDPP_FF_GET_GLOBAL_GAINS, NULL, 0, &response);
+	if (error)
+		hid_warn(hidpp->hid_dev, "Failed to read gain values from device!\n");
+	data->gain = error ? 0xffff : get_unaligned_be16(&response.fap.params[0]);
+	/* ignore boost value at response.fap.params[2] */
+
+	/* init the hardware command queue */
+	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	atomic_set(&data->workqueue_size, 0);
+
+	/* initialize with zero autocenter to get wheel in usable state */
+	hidpp_ff_set_autocenter(dev, 0);
+
+	hid_info(hid, "Force feeback support loaded (firmware release %d).\n", version);
+
+	return 0;
+}
+
+int hidpp_ff_deinit(struct hid_device *hid)
+{
+	struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+	struct input_dev *dev = hidinput->input;
+	struct hidpp_ff_private_data *data;
+
+	if (!dev) {
+		hid_err(hid, "Struct input_dev not found!\n");
+		return -EINVAL;
+	}
+
+	hid_info(hid, "Unloading HID++ force feedback.\n");
+	data = dev->ff->private;
+	if (!data) {
+		hid_err(hid, "Private data not found!\n");
+		return -EINVAL;
+	}
+
+	destroy_workqueue(data->wq);
+	device_remove_file(&hid->dev, &dev_attr_range);
+
+	return 0;
+}
+
+
 /* ************************************************************************** */
 /*                                                                            */
 /* Device Support                                                             */
@@ -1301,123 +1892,21 @@ static int k400_connect(struct hid_device *hdev, bool connected)
 
 #define HIDPP_PAGE_G920_FORCE_FEEDBACK			0x8123
 
-/* Using session ID = 1 */
-#define CMD_G920_FORCE_GET_APERTURE			0x51
-#define CMD_G920_FORCE_SET_APERTURE			0x61
-
-struct g920_private_data {
-	u8 force_feature;
-	u16 range;
-};
-
-#define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
-
-static ssize_t g920_range_show(struct device *dev, struct device_attribute *attr,
-				char *buf)
-{
-	struct hid_device *hid = to_hid_device(dev);
-	struct hidpp_device *hidpp = hid_get_drvdata(hid);
-	struct g920_private_data *pdata;
-
-	pdata = hidpp->private_data;
-	if (!pdata) {
-		hid_err(hid, "Private driver data not found!\n");
-		return -EINVAL;
-	}
-
-	return scnprintf(buf, PAGE_SIZE, "%u\n", pdata->range);
-}
-
-static ssize_t g920_range_store(struct device *dev, struct device_attribute *attr,
-				 const char *buf, size_t count)
-{
-	struct hid_device *hid = to_hid_device(dev);
-	struct hidpp_device *hidpp = hid_get_drvdata(hid);
-	struct g920_private_data *pdata;
-	struct hidpp_report response;
-	u8 params[2];
-	int ret;
-	u16 range = simple_strtoul(buf, NULL, 10);
-
-	pdata = hidpp->private_data;
-	if (!pdata) {
-		hid_err(hid, "Private driver data not found!\n");
-		return -EINVAL;
-	}
-
-	if (range < 180)
-		range = 180;
-	else if (range > 900)
-		range = 900;
-
-	params[0] = range >> 8;
-	params[1] = range & 0x00FF;
-
-	ret = hidpp_send_fap_command_sync(hidpp, pdata->force_feature,
-		CMD_G920_FORCE_SET_APERTURE, params, 2, &response);
-	if (ret)
-		return ret;
-
-	pdata->range = range;
-	return count;
-}
-
-static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, g920_range_show, g920_range_store);
-
-static int g920_allocate(struct hid_device *hdev)
-{
-	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
-	struct g920_private_data *pdata;
-
-	pdata = devm_kzalloc(&hdev->dev, sizeof(struct g920_private_data),
-			GFP_KERNEL);
-	if (!pdata)
-		return -ENOMEM;
-
-	hidpp->private_data = pdata;
-
-	return 0;
-}
-
 static int g920_get_config(struct hidpp_device *hidpp)
 {
-	struct g920_private_data *pdata = hidpp->private_data;
-	struct hidpp_report response;
 	u8 feature_type;
 	u8 feature_index;
 	int ret;
 
-	pdata = hidpp->private_data;
-	if (!pdata) {
-		hid_err(hidpp->hid_dev, "Private driver data not found!\n");
-		return -EINVAL;
-	}
-
 	/* Find feature and store for later use */
 	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_G920_FORCE_FEEDBACK,
 		&feature_index, &feature_type);
 	if (ret)
 		return ret;
 
-	pdata->force_feature = feature_index;
-
-	/* Read current Range */
-	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
-		CMD_G920_FORCE_GET_APERTURE, NULL, 0, &response);
-	if (ret > 0) {
-		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
-		return -EPROTO;
-	}
+	ret = hidpp_ff_init(hidpp, feature_index);
 	if (ret)
-		return ret;
-
-	pdata->range = get_unaligned_be16(&response.fap.params[0]);
-
-	/* Create sysfs interface */
-	ret = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
-	if (ret)
-		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d\n", ret);
+		hid_warn(hidpp->hid_dev, "Unable to initialize force feedback support, errno %d\n", ret);
 
 	return 0;
 }
@@ -1741,10 +2230,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = k400_allocate(hdev);
 		if (ret)
 			goto allocate_fail;
-	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		ret = g920_allocate(hdev);
-		if (ret)
-			goto allocate_fail;
 	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
@@ -1827,7 +2312,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_open_failed:
 	hid_device_io_stop(hdev);
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		device_remove_file(&hdev->dev, &dev_attr_range);
 		hid_hw_close(hdev);
 		hid_hw_stop(hdev);
 	}
@@ -1845,7 +2329,7 @@ static void hidpp_remove(struct hid_device *hdev)
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		device_remove_file(&hdev->dev, &dev_attr_range);
+		hidpp_ff_deinit(hdev);
 		hid_hw_close(hdev);
 	}
 	hid_hw_stop(hdev);
-- 
2.5.0

