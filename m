From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH  3/3] hid: Multitouch support for the N-Trig touchscreen [v3]
Date: Wed, 20 May 2009 14:30:28 +0200
Message-ID: <9D116766-5CC3-4FF4-8EAE-15398CBBCD97@enac.fr>
References: <3EF4E25A-E606-4056-BBF0-4BC2B31001F1@enac.fr> <alpine.LNX.2.00.0905191646130.22712@wotan.suse.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:38216 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbZETMab (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2009 08:30:31 -0400
In-Reply-To: <alpine.LNX.2.00.0905191646130.22712@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Henrik Rydberg <rydberg@euromail.se>, Rafi Rubin <rafi@seas.upenn.edu>, Jiri Kosina <jkosina@suse.cz>, Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>

Added support for multitouch interaction on the N-Trig touchscreen,  
using the new ABS_MT_* input constants. Single touch support works as  
previously. This code was tested against two versions of the N- Trig  
firmware: one that supports dual pen/finger single touch, and one  
that supports finger multitouch but no pen at all. Copyright notices  
that looked wrong were removed, as it seems that there is only code  
written in 2009 by Rafin Rubin and Stephane Chatty in this file.

Signed-off-by: Stephane Chatty <chatty@enac.fr>

diff -rupN a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
--- a/drivers/hid/hid-ntrig.c	2009-05-09 02:14:14.000000000 +0200
+++ b/drivers/hid/hid-ntrig.c	2009-05-19 22:46:41.000000000 +0200
@@ -1,13 +1,8 @@
  /*
- *  HID driver for some ntrig "special" devices
+ *  HID driver for N-Trig touchscreens
   *
- *  Copyright (c) 1999 Andreas Gal
- *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
- *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for  
Concept2, Inc
- *  Copyright (c) 2006-2007 Jiri Kosina
- *  Copyright (c) 2007 Paul Walmsley
- *  Copyright (c) 2008 Jiri Slaby
   *  Copyright (c) 2008 Rafi Rubin
+ *  Copyright (c) 2009 Stephane Chatty
   *
   */

@@ -29,15 +24,79 @@
  #define nt_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
  					EV_KEY, (c))

+struct ntrig_data {
+	__s32 x, y, id, w, h;
+	char reading_a_point, found_contact_id;
+};
+
+/*
+ * this driver is aimed at two firmware versions in circulation:
+ *  - dual pen/finger single touch
+ *  - finger multitouch, pen not working
+ */
+
  static int ntrig_input_mapping(struct hid_device *hdev, struct  
hid_input *hi,
  		struct hid_field *field, struct hid_usage *usage,
  		unsigned long **bit, int *max)
  {
-	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_DIGITIZER &&
-			(usage->hid & 0xff) == 0x47) {
-		nt_map_key_clear(BTN_TOOL_DOUBLETAP);
-		return 1;
+	switch (usage->hid & HID_USAGE_PAGE) {
+
+	case HID_UP_GENDESK:
+		switch (usage->hid) {
+		case HID_GD_X:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_POSITION_X);
+			input_set_abs_params(hi->input, ABS_X,
+					field->logical_minimum,
+					field->logical_maximum, 0, 0);
+			return 1;
+		case HID_GD_Y:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_POSITION_Y);
+			input_set_abs_params(hi->input, ABS_Y,
+					field->logical_minimum,
+					field->logical_maximum, 0, 0);
+			return 1;
+		}
+		return 0;
+
+	case HID_UP_DIGITIZER:
+		switch (usage->hid) {
+		/* we do not want to map these for now */
+		case HID_DG_INVERT: /* value is always 0 */
+		case HID_DG_ERASER: /* value is always 0 */
+		case HID_DG_CONTACTID: /* value is useless */
+		case HID_DG_BARRELSWITCH:  /* doubtful */
+		case HID_DG_INPUTMODE:
+		case HID_DG_DEVICEINDEX:
+		case HID_DG_CONTACTCOUNT:
+		case HID_DG_CONTACTMAX:
+			return -1;
+
+		/* original mapping by Rafi Rubin */
+		case HID_DG_CONFIDENCE:
+			nt_map_key_clear(BTN_TOOL_DOUBLETAP);
+			return 1;
+
+		/* width/height mapped on TouchMajor/TouchMinor/Orientation */
+		case HID_DG_WIDTH:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TOUCH_MAJOR);
+			return 1;
+		case HID_DG_HEIGHT:
+			hid_map_usage(hi, usage, bit, max,
+					EV_ABS, ABS_MT_TOUCH_MINOR);
+			input_set_abs_params(hi->input, ABS_MT_ORIENTATION,
+					0, 1, 0, 0);
+			return 1;
+		}
+		return 0;
+
+	case 0xff000000:
+		/* we do not want to map these: no input-oriented meaning */
+		return -1;
  	}
+
  	return 0;
  }

@@ -51,6 +110,138 @@ static int ntrig_input_mapped(struct hid

  	return 0;
  }
+
+/*
+ * this function is called upon all reports
+ * so that we can filter contact point information,
+ * decide whether we are in multi or single touch mode
+ * and call input_mt_sync after each point if necessary
+ */
+static int ntrig_event (struct hid_device *hid, struct hid_field  
*field,
+		                        struct hid_usage *usage, __s32 value)
+{
+	struct input_dev *input = field->hidinput->input;
+	struct ntrig_data *nd = hid_get_drvdata(hid);
+
+        if (hid->claimed & HID_CLAIMED_INPUT) {
+		switch (usage->hid) {
+		case HID_GD_X:
+			nd->x = value;
+			nd->reading_a_point = 1;
+			break;
+		case HID_GD_Y:
+			nd->y = value;
+			break;
+		case HID_DG_CONTACTID:
+			nd->id = value;
+			/* we receive this only when in multitouch mode */
+			nd->found_contact_id = 1;
+			break;
+		case HID_DG_WIDTH:
+			nd->w = value;
+			break;
+		case HID_DG_HEIGHT:
+			nd->h = value;
+			/*
+			 * when in single touch mode, this is the last
+			 * report received in a finger event. We want
+			 * to emit a normal (X, Y) position
+			 */
+			if (! nd->found_contact_id) {
+				input_event(input, EV_ABS, ABS_X, nd->x);
+				input_event(input, EV_ABS, ABS_Y, nd->y);
+			}
+			break;
+		case HID_DG_TIPPRESSURE:
+			/*
+			 * when in single touch mode, this is the last
+			 * report received in a pen event. We want
+			 * to emit a normal (X, Y) position
+			 */
+			if (! nd->found_contact_id) {
+				input_event(input, EV_ABS, ABS_X, nd->x);
+				input_event(input, EV_ABS, ABS_Y, nd->y);
+				input_event(input, EV_ABS, ABS_PRESSURE, value);
+			}
+			break;
+		case 0xff000002:
+			/*
+			 * we receive this when the device is in multitouch
+			 * mode. The first of the three values tagged with
+			 * this usage tells if the contact point is real
+			 * or a placeholder
+			 */
+			if (!nd->reading_a_point || value != 1)
+				break;
+			/* emit a normal (X, Y) for the first point only */
+			if (nd->id == 0) {
+				input_event(input, EV_ABS, ABS_X, nd->x);
+				input_event(input, EV_ABS, ABS_Y, nd->y);
+			}
+			input_event(input, EV_ABS, ABS_MT_POSITION_X, nd->x);
+			input_event(input, EV_ABS, ABS_MT_POSITION_Y, nd->y);
+			if (nd->w > nd->h) {
+				input_event(input, EV_ABS,
+						ABS_MT_ORIENTATION, 1);
+				input_event(input, EV_ABS,
+						ABS_MT_TOUCH_MAJOR, nd->w);
+				input_event(input, EV_ABS,
+						ABS_MT_TOUCH_MINOR, nd->h);
+			} else {
+				input_event(input, EV_ABS,
+						ABS_MT_ORIENTATION, 0);
+				input_event(input, EV_ABS,
+						ABS_MT_TOUCH_MAJOR, nd->h);
+				input_event(input, EV_ABS,
+						ABS_MT_TOUCH_MINOR, nd->w);
+			}
+			input_mt_sync(field->hidinput->input);
+			nd->reading_a_point = 0;
+			nd->found_contact_id = 0;
+			break;
+
+		default:
+			/* fallback to the generic hidinput handling */
+			return 0;
+		}
+	}
+
+	/* we have handled the hidinput part, now remains hiddev */
+        if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
+                hid->hiddev_hid_event(hid, field, usage, value);
+
+	return 1;
+}
+
+static int ntrig_probe(struct hid_device *hdev, const struct  
hid_device_id *id)
+{
+	int ret;
+	struct ntrig_data *nd;
+
+	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
+	if (!nd) {
+		dev_err(&hdev->dev, "cannot allocate N-Trig data\n");
+		return -ENOMEM;
+	}
+	nd->reading_a_point = 0;
+	nd->found_contact_id = 0;
+	hid_set_drvdata(hdev, nd);
+
+	ret = hid_parse(hdev);
+	if (!ret)
+		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+
+	if (ret)
+		kfree (nd);
+	return ret;
+}
+
+static void ntrig_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	kfree(hid_get_drvdata(hdev));
+}
+
  static const struct hid_device_id ntrig_devices[] = {
  	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG,  
USB_DEVICE_ID_NTRIG_TOUCH_SCREEN),
  		.driver_data = NTRIG_DUPLICATE_USAGES },
@@ -58,11 +249,20 @@ static const struct hid_device_id ntrig_
  };
  MODULE_DEVICE_TABLE(hid, ntrig_devices);

+static const struct hid_usage_id ntrig_grabbed_usages[] = {
+	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
  static struct hid_driver ntrig_driver = {
  	.name = "ntrig",
  	.id_table = ntrig_devices,
+	.probe = ntrig_probe,
+	.remove = ntrig_remove,
  	.input_mapping = ntrig_input_mapping,
  	.input_mapped = ntrig_input_mapped,
+	.usage_table = ntrig_grabbed_usages,
+	.event = ntrig_event,
  };

  static int ntrig_init(void)

