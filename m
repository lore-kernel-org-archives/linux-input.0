From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: Support for Logitech MX Anywhere 2
Date: Sat, 25 Mar 2017 13:02:10 -0300
Message-ID: <20170325130210.3f798346@vento.lan>
References: <20170322083222.6632f066@vento.lan>
        <20170323105956.GD26316@mail.corp.redhat.com>
        <20170323142900.185da144@vento.lan>
        <20170324052220.GB7307@jelly>
        <20170324065700.313d8019@vento.lan>
        <20170325093618.05324fa8@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:59247
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751286AbdCYQCS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Mar 2017 12:02:18 -0400
In-Reply-To: <20170325093618.05324fa8@vento.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Em Sat, 25 Mar 2017 09:36:18 -0300
Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:

> Em Fri, 24 Mar 2017 06:57:00 -0300
> Mauro Carvalho Chehab <mchehab@s-opensource.com> escreveu:
> 
> > Em Fri, 24 Mar 2017 15:22:20 +1000
> > Peter Hutterer <peter.hutterer@who-t.net> escreveu:
> >   
> > > On Thu, Mar 23, 2017 at 02:29:00PM -0300, Mauro Carvalho Chehab wrote:    
> > > > Em Thu, 23 Mar 2017 11:59:56 +0100
> > > > Benjamin Tissoires <benjamin.tissoires@redhat.com> escreveu:      
> > > > > > With regards to ratchet, it probably makes sense to query its state
> > > > > > when the driver starts, as IMHO, it should work on a way similar to
> > > > > > <CAPS LOCK>. Btw, are there any event already defined for ratchet mode?        
> > > > > 
> > > > > There is not. And that's where the problem goes a little bit beyond just
> > > > > enabling the feature, we need to forward this info to userspace.
> > > > > 
> > > > > There should be some EV_SWITCH SW_RATCHET created IMO. The ratchet has
> > > > > a state, and we should be able to forward this state with such a new
> > > > > event.
> > > > > 
> > > > > The thing I am more worried is how can we report the high-res wheel
> > > > > events. I know Peter has a DB of wheel resolution, but in that case, we
> > > > > can switch to high-res or not, so a static hwdb entry won't help.      
> > > > 
> > > > Yes. In the case of high-res, there are actually two ways for those
> > > > events to arrive:
> > > > 
> > > > In HID mode, it produces standard EV_REL / REL_WHEEL events, but there
> > > > isn't any events reporting if the mode changed, nor the event with
> > > > gets wheel axes movement tell if the mouse is in low or high res.
> > > > 
> > > > So, in HID mode, identifying if the wheel is in low or high res
> > > > is not direct.
> > > > 
> > > > When the device is in HID+ mode, the resolution mode comes together with
> > > > axes changes. So, it should be possible to define a different event
> > > > for high-res wheel.
> > > > 
> > > > E. g. if the event reports high-res, it would be generating:
> > > > EV_REL / REL_HI_RES_WHEEL. If the packet arrives with low-res,
> > > > it will keep generating EV_REL / REL_WHEEL.
> > > > 
> > > > This way, Peter's code (libinput, I guess?) could handle it without
> > > > requiring any DB for the devices that allow switching the mode.      
> > > 
> > > sort-of. The main problem with relative axes is that we don't have a
> > > resolution info. The reason we have a hwdb for wheels is that libinput
> > > converts kernel data to physical dimensions so that callers can use the data
> > > in a reliable manner. Switching to a hi-res-wheel just moves the problem
> > > around a bit.
> > > 
> > > Using ABS events simply gives us the resolution in the inital description.
> > > That's (I suspect) the only reason Benjamin suggested it. This isn't the
> > > first time it has come up, it would be interesting to add something like
> > > EVIOCGREL as equivalent to EVIOCGABS and start augmenting rel data with
> > > resolution. But I also suspect that all but this use-case would have the
> > > kernel return a digital shrug anyway, so I'm not sure it's worth the effort.    
> > 
> > I see. Well, at least in the case of the feature supported by this
> > mouse, there are just two possible resolutions: low-res and high-res.
> > The high-res resolution is fixed[1].
> > 
> > As the multiplier has a fixed value per device, a hwdb could still
> > work, provided that high-res wheel events would produce a different
> > event code than low-res.
> > 
> > [1] there's a USB message that can be used to query the multiplier,
> > with is always equal to 8 for MX Anywhere 2. No idea if other
> > devices with this feature use the same multiplier.  
> 
> What I'm proposing is basically something like what's in the patch
> below (for now, just compile-tested).
> 
> So, for MX Anywhere 2 and MX master, the hid-logitech-hidpp driver should
> switch to the HID++ report mode at device connect and handle the Wheel
> events. If the wheel event is low res, will generate
> REL_WHEEL events. if the wheel is in high resolution, REL_HWHEEL.

Hmm... "H" in HWHEEL is not for "hardware" or "high-res", but,
instead, for "horizontal".

So, if we'd go for the proposal of using a different event for high-res
vertical wheel, instead of adding a new ioctl (EVIOCGREL as equivalent to
EVIOCGABS), we'll need an extra event.

Anyway, the patch below works fine with my mouse. It is against
Kernel 4.10.4.

I didn't implement yet support for the ratchet switch. Will add it on
a separate patch.

Thanks,
Mauro

[PATCH] hid-logitech-hidpp: add support for high res wheel

Some Logitech mouses (MX Anyware 2 and MX Master) have support
for a high-resolution wheel.

This wheel can work in backward-compatible mode, generating
wheel events via HID normal events, or it can use new
HID++ events that report not only the wheel movement, but also
the resolution.

Add support for it.

Tested with a MX Anywere 2 mouse:

     Codename     : Anywhere MX 2
     Kind         : mouse
     Wireless PID : 404A
     Protocol     : HID++ 4.5
     Polling rate : 8 ms (125Hz)
        Bootloader: BOT 23.00.B0007
          Firmware: MPM 02.00.B0007
          Firmware: MPM 02.00.B0007

Tested with both low-res and high-res wheel events, using ir-keytable,
from v4l-utils (upstream).

In Low res mode:

# ir-keytable -t -d /dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse|grep REL_WHEEL

1490457275.635450: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-1
1490457275.653380: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-2
1490457275.667460: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-3
1490457275.683345: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-3
1490457275.693389: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-4
1490457275.701382: event type EV_REL(0x02): REL_WHEEL (0x0008) value=-2

In High res mode:

# ir-keytable -t -d /dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse|grep 0x000a

1490457340.494215: event type EV_REL(0x02):  (0x000a) value=2
1490457340.502223: event type EV_REL(0x02):  (0x000a) value=1
1490457340.510215: event type EV_REL(0x02):  (0x000a) value=1
1490457340.518221: event type EV_REL(0x02):  (0x000a) value=1
1490457340.580217: event type EV_REL(0x02):  (0x000a) value=-2
1490457340.588219: event type EV_REL(0x02):  (0x000a) value=-2
1490457340.596216: event type EV_REL(0x02):  (0x000a) value=-6
1490457340.604204: event type EV_REL(0x02):  (0x000a) value=-6
1490457340.612216: event type EV_REL(0x02):  (0x000a) value=-7
1490457340.620217: event type EV_REL(0x02):  (0x000a) value=-7
1490457340.628216: event type EV_REL(0x02):  (0x000a) value=-6

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 2e2515a4c070..5468a8f81ef6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -62,6 +62,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
+#define HIDPP_QUIRK_HIRES_SCROLL		BIT(25)
 
 #define HIDPP_QUIRK_DELAYED_INIT		(HIDPP_QUIRK_NO_HIDINPUT | \
 						 HIDPP_QUIRK_CONNECT_EVENTS)
@@ -1361,6 +1362,65 @@ static int hidpp_ff_deinit(struct hid_device *hid)
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x2121: High Resolution Wheel                                              */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_HIGH_RES_WHEEL		0x2121
+
+#define CMD_MOUSE_SET_WHEEL_MODE	0x20
+
+struct high_res_wheel_data {
+	u8 feature_index;
+	struct input_dev *input;
+};
+
+/**
+ * hidpp_mouse_set_wheel_mode - Sets high resolution wheel mode
+ *
+ * @invert:	if true, inverts wheel movement
+ * @high_res:	if true, wheel is in high-resolution mode. Otherwise, low res
+ * @hidpp:	if true, report wheel events via HID++ notification. If false,
+ *		use standard HID events
+ */
+static int hidpp_mouse_set_wheel_mode(struct hidpp_device *hidpp,
+				      bool invert,
+				      bool high_res,
+				      bool hidpp_mode)
+{
+	struct high_res_wheel_data *hrd = hidpp->private_data;
+	u8 feature_type;
+	struct hidpp_report response;
+	int ret;
+	u8 params[16] = { 0 };
+
+	params[0] = invert     ? 0x4 : 0  |
+		    high_res   ? 0x2 : 0  |
+		    hidpp_mode ? 0x1 : 0;
+
+	if (!hrd->feature_index) {
+		ret = hidpp_root_get_feature(hidpp,
+					    HIDPP_HIGH_RES_WHEEL,
+					    &hrd->feature_index,
+					    &feature_type);
+		if (ret)
+			/* means that the device is not powered up */
+			return ret;
+	}
+
+	ret = hidpp_send_fap_command_sync(hidpp, hrd->feature_index,
+					  CMD_MOUSE_SET_WHEEL_MODE,
+					  params, 16, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	return 0;
+}
 
 /* ************************************************************************** */
 /*                                                                            */
@@ -1816,6 +1876,121 @@ static int m560_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 }
 
 /* ------------------------------------------------------------------------- */
+/* Logitech mouse devices with high resolution wheel                         */
+/* ------------------------------------------------------------------------- */
+
+static int high_res_raw_event(struct hid_device *hdev, u8 *data, int size)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct high_res_wheel_data *hrd = hidpp->private_data;
+
+	/* sanity check */
+	if (!hrd || !hrd->feature_index) {
+		hid_err(hdev, "error in parameter\n");
+		return -EINVAL;
+	}
+
+	if (data[0] != REPORT_ID_HIDPP_LONG ||
+	    data[2] != hrd->feature_index)
+		return 1;
+
+	if (size < 8) {
+		hid_err(hdev, "error in report: size = %d: %*ph\n", size,
+			size, data);
+		return 0;
+	}
+
+	/*
+	 * high res wheel mouse events
+	 *
+	 * Wheel movement events are like:
+	 *
+	 * 11 03 0b 00 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
+	 *
+	 * data[0] = 0x11
+	 * data[1] = device-id
+	 * data[2] = feature index (0b)
+	 * data[3] = event type: 0x00 - wheel movement
+	 * data[4] = bitmask:
+	 *		bits 0-3: number of sampling periods combined
+	 *		bit 4:
+	 *			0 = low resolution
+	 *			1 = high resolution
+	 * data[5] - deltaV MSB
+	 * data[6] = deltaV LSB
+	 * Remaining payload is reserved
+	 *
+	 * Ratchet events are like:
+	 * 11 03 0b 10 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+	 *
+	 * data[0] = 0x11
+	 * data[1] = device-id
+	 * data[2] = feature index
+	 * data[3] = event type: 0x10 - ratchet state
+	 * data[4] = bit 0:
+	 *		1 = ratchet
+	 *		0 = free wheel
+	 * Remaining payload is reserved
+	 */
+
+	if (data[3] == 0) {
+		s16 delta = data[6] | data[5] << 8;
+		bool res = data[4] & 0x10;
+
+		/*
+		 * Report high-resolution events as REL_HWHEEL and
+		 * low-resolution events as REL_WHEEL.
+		 */
+		if (res)
+			input_report_rel(hrd->input, REL_HIRES_WHEEL, delta);
+		else
+			input_report_rel(hrd->input, REL_WHEEL, delta);
+	}
+
+	/* FIXME: also report ratchet events to userspace */
+
+	return 1;
+}
+
+static void high_res_populate_input(struct hidpp_device *hidpp,
+		struct input_dev *input_dev, bool origin_is_hid_core)
+{
+	struct high_res_wheel_data *hrd = hidpp->private_data;
+
+	hrd->input = input_dev;
+
+	__set_bit(REL_WHEEL, hrd->input->relbit);
+	__set_bit(REL_HIRES_WHEEL, hrd->input->relbit);
+}
+
+
+static int high_res_allocate(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct high_res_wheel_data *hrd;
+
+	hrd = devm_kzalloc(&hdev->dev, sizeof(struct high_res_wheel_data),
+			GFP_KERNEL);
+	if (!hrd)
+		return -ENOMEM;
+
+	hidpp->private_data = hrd;
+
+	return 0;
+};
+
+static int high_res_connect(struct hid_device *hdev, bool connected)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+
+	if (!connected)
+		return 0;
+
+	/* Enable HID++ wheel event output mode */
+	return hidpp_mouse_set_wheel_mode(hidpp, false, false, true);
+}
+
+/* ------------------------------------------------------------------------- */
 /* Logitech K400 devices                                                     */
 /* ------------------------------------------------------------------------- */
 
@@ -1955,6 +2130,9 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 		wtp_populate_input(hidpp, input, origin_is_hid_core);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		m560_populate_input(hidpp, input, origin_is_hid_core);
+	else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL)
+		high_res_populate_input(hidpp, input, origin_is_hid_core);
+
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -2054,6 +2232,8 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 		return wtp_raw_event(hdev, data, size);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		return m560_raw_event(hdev, data, size);
+	else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL)
+		return high_res_raw_event(hdev, data, size);
 
 	return 0;
 }
@@ -2141,6 +2321,10 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		ret = k400_connect(hdev, connected);
 		if (ret)
 			return;
+	} else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL) {
+		ret = high_res_connect(hdev, connected);
+		if (ret)
+			return;
 	}
 
 	if (!connected || hidpp->delayed_input)
@@ -2229,6 +2413,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = k400_allocate(hdev);
 		if (ret)
 			goto allocate_fail;
+	} else if (hidpp->quirks & HIDPP_QUIRK_HIRES_SCROLL) {
+		ret = high_res_allocate(hdev);
+		if (ret)
+			goto allocate_fail;
 	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
@@ -2354,6 +2542,14 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x402d),
 	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
+	{ /* Logitech MX Master with high resolution scroll */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4041),
+	  .driver_data = HIDPP_QUIRK_CONNECT_EVENTS | HIDPP_QUIRK_HIRES_SCROLL },
+	{ /* Logitech MX Anywhere 2r with high resolution scroll */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x404a),
+	  .driver_data = HIDPP_QUIRK_CONNECT_EVENTS | HIDPP_QUIRK_HIRES_SCROLL },
 	{ /* Keyboard logitech K400 */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4024),
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 3af60ee69053..23b2d377af59 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -703,6 +703,7 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
+#define REL_HIRES_WHEEL		0x0a
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 

