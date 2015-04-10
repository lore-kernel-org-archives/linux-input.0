From: Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: Driver for Logitech M560
Date: Fri, 10 Apr 2015 20:56:44 +0200
Message-ID: <55281CEC.4040201@inwind.it>
References: <5404C6F4.1000800@inwind.it>	<CAN+gG=HMUJBWQj65OKRfoPiyzzRPXLVveA6V2S_a1dSJXKJc3g@mail.gmail.com>	<5409F740.9000706@inwind.it>	<20150409144154.36fbce15dcdf4556544ee8a7@ao2.it> <CAN+gG=Hhp8AiUgnDAC3Nda-rdVgJHg7Rgs1e9HajAws-_-L+Cw@mail.gmail.com>
Reply-To: kreijack@inwind.it
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-18.italiaonline.it ([212.48.25.146]:59196 "EHLO libero.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751951AbbDJS4n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Apr 2015 14:56:43 -0400
In-Reply-To: <CAN+gG=Hhp8AiUgnDAC3Nda-rdVgJHg7Rgs1e9HajAws-_-L+Cw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Antonio Ospite <ao2@ao2.it>
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Dario Righelli <drighelli@gmail.com>

Hi,

after the Antonio's mail, I updated my work on the latest kernel (3.19.3); this work for me, but I am sure that I made some mistakes, so please consider this a beta.
I added a new device class (M560), and I put some hooks to process the raw data.

I used the following "quirks":
- HIDPP_QUIRK_DELAYED_INIT
- HIDPP_QUIRK_MULTI_INPUT

these work (when the mouse is connected, the configuration message is sent), but I am not sure if this is correct.
Anyway in the past I noticed some false spurious reconnections, and re-sending the configuration time to time made the mouse not-responsive for few tens of second (it seems a low value, but I noticed it); so I am not sure if I will leave the "reconfiguration" on reconnection.

Comments are welcome.

BR
G.Baroncelli


diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index a93cefe..4d907d6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -35,6 +35,7 @@ MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
 #define HIDPP_REPORT_LONG_LENGTH		20
 
 #define HIDPP_QUIRK_CLASS_WTP			BIT(0)
+#define HIDPP_QUIRK_CLASS_M560			BIT(1)
 
 /* bits 1..20 are reserved for classes */
 #define HIDPP_QUIRK_DELAYED_INIT		BIT(21)
@@ -925,6 +926,225 @@ static void wtp_connect(struct hid_device *hdev, bool connected)
 }
 
 /* -------------------------------------------------------------------------- */
+/* Logitech M560 devices                                                     */
+/* -------------------------------------------------------------------------- */
+
+/*
+ * Logitech M560 protocol overview
+ *
+ * The Logitech M560 mouse, is designed for windows 8. When the middle and/or
+ * the sides buttons are pressed, it sends some keyboard keys events
+ * instead of buttons ones.
+ * To complicate further the things, the middle button keys sequence
+ * is different from the odd press and the even press.
+ *
+ * forward button -> Super_R
+ * backward button -> Super_L+'d' (press only)
+ * middle button -> 1st time: Alt_L+SuperL+XF86TouchpadOff (press only)
+ *                  2nd time: left-click (press only)
+ * NB: press-only means that when the button is pressed, the
+ * KeyPress/ButtonPress and KeyRelease/ButtonRelease events are generated
+ * together sequentially; instead when the button is released, no event is
+ * generated !
+ *
+ * With the command
+ *	10<xx>0a 3500af03 (where <xx> is the mouse id),
+ * the mouse reacts differently:
+ * - it never send a keyboard key event
+ * - for the three mouse button it sends:
+ *	middle button               press   11<xx>0a 3500af00...
+ *	side 1 button (forward)     press   11<xx>0a 3500b000...
+ *	side 2 button (backward)    press   11<xx>0a 3500ae00...
+ *	middle/side1/side2 button   release 11<xx>0a 35000000...
+ */
+static u8 m560_config_command[] = {0x35, 0x00, 0xaf, 0x03};
+
+struct m560_private_data {
+	u8 prev_data[30]; // FIXME: select a right size
+	int btn_middle:1;
+	int btn_forward:1;
+	int btn_backward:1;
+};
+
+/* how the button are mapped in the report */
+#define MOUSE_BTN_LEFT		0
+#define MOUSE_BTN_RIGHT		1
+#define MOUSE_BTN_MIDDLE	2
+#define MOUSE_BTN_WHEEL_LEFT	3
+#define MOUSE_BTN_WHEEL_RIGHT	4
+#define MOUSE_BTN_FORWARD	5
+#define MOUSE_BTN_BACKWARD	6
+
+/*
+ * m560_priv_data - helper to convert from hidpp_device to m560_private_data
+ *
+ * @hdev: hid device
+ *
+ * @return: return m560_private_data if available, NULL otherwise
+ */
+static inline struct m560_private_data *m560_priv_data(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp_dev = hid_get_drvdata(hdev);
+	return hidpp_dev ? hidpp_dev->private_data : NULL;
+}
+
+/*
+ * m560_send_config_command - send the config_command to the mouse
+ *
+ * @dev: hid device where the mouse belongs
+ *
+ * @return: 0 OK
+ */
+static int m560_send_config_command(struct hid_device *hdev) {
+	struct hidpp_report response;
+	struct hidpp_device *hidpp_dev = hid_get_drvdata(hdev);
+	int ret;
+
+	ret = hidpp_send_rap_command_sync(
+		hidpp_dev,
+		REPORT_ID_HIDPP_SHORT,
+		0x0a,
+		m560_config_command[0],
+		m560_config_command+1,
+		sizeof(m560_config_command)-1,
+		&response
+	);
+
+	return ret;
+}
+
+static int m560_allocate(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct m560_private_data *d;
+
+	d = devm_kzalloc(&hdev->dev, sizeof(struct m560_private_data),
+			GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	hidpp->private_data = d;
+	//d->hidpp_dev = hidpp;
+	//d->hid_dev = hdev;
+
+	return 0;
+};
+
+static inline void set_btn_bit(u8 *data, int bit)
+{
+	int bytenr = bit / 8;
+	int bitmask = 1 << (bit & 0x07);
+
+	data[bytenr] |= bitmask;
+}
+
+static inline int get_btn_bit(u8 *data, int bit)
+{
+	int bytenr = bit / 8;
+	int bitmask = 1 << (bit & 0x07);
+
+	return !!(data[bytenr] & bitmask);
+}
+
+static inline void clear_btn_bit(u8 *data, int bit)
+{
+	int bytenr = bit / 8;
+	int bitmask = 1 << (bit & 0x07);
+
+	data[bytenr] &= ~bitmask;
+}
+
+static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
+{
+	struct m560_private_data *mydata = m560_priv_data(hdev);
+
+	/* check if the data is a mouse related report */
+	if (data[0] != 0x02 && data[2] != 0x0a)
+		return 1;
+
+	/* check if the report is the ack of the config_command */
+	if (data[0] == 0x11 && data[2] == 0x0a &&
+	    size >= (3+sizeof(m560_config_command)) &&
+	    !memcmp(data+3, m560_config_command,
+		sizeof(m560_config_command))) {
+			return true;
+	}
+
+	if (data[0] == 0x11 && data[2] == 0x0a && data[06] == 0x00) {
+		/*
+		 * m560 mouse button report
+		 *
+		 * data[0] = 0x11
+		 * data[1] = deviceid
+		 * data[2] = 0x0a
+		 * data[5] = button (0xaf->middle, 0xb0->forward,
+		 * 		     0xaf ->backward, 0x00->release all)
+		 * data[6] = 0x00
+		 */
+
+		int btn, i, maxsize;
+
+		/* check if the event is a button */
+		btn = data[5];
+		if (btn != 0x00 && btn != 0xb0 && btn != 0xae && btn != 0xaf)
+			return true;
+
+		if (btn == 0xaf)
+			mydata->btn_middle = 1;
+		else if (btn == 0xb0)
+			mydata->btn_forward = 1;
+		else if (btn == 0xae)
+			mydata->btn_backward = 1;
+		else if (btn == 0x00) {
+			mydata->btn_backward = 0;
+			mydata->btn_forward = 0;
+			mydata->btn_middle = 0;
+		}
+
+		/* replace the report with the old one */
+		if (size > sizeof(mydata->prev_data))
+			maxsize = sizeof(mydata->prev_data);
+		else
+			maxsize = size;
+		for (i = 0 ; i < maxsize ; i++)
+			data[i] = mydata->prev_data[i];
+
+	} else if (data[0] == 0x02) {
+		/*
+		 * standard mouse report
+		 *
+		 * data[0] = type (0x02)
+		 * data[1..2] = buttons
+		 * data[3..5] = xy
+		 * data[6] = wheel
+		 * data[7] = horizontal wheel
+		 */
+
+		/* horizontal wheel handling */
+		if (get_btn_bit(data+1,MOUSE_BTN_WHEEL_LEFT))
+			data[1+6] = -1;
+		if (get_btn_bit(data+1,MOUSE_BTN_WHEEL_RIGHT))
+			data[1+6] =  1;
+
+		clear_btn_bit(data+1, MOUSE_BTN_WHEEL_LEFT);
+		clear_btn_bit(data+1, MOUSE_BTN_WHEEL_RIGHT);
+
+		/* copy the type and buttons status */
+		memcpy(mydata->prev_data, data, 3);
+	}
+
+	/* add the extra buttons */
+	if (mydata->btn_middle)
+		set_btn_bit(data+1, MOUSE_BTN_MIDDLE);
+	if (mydata->btn_forward)
+		set_btn_bit(data+1, MOUSE_BTN_FORWARD);
+	if (mydata->btn_backward)
+		set_btn_bit(data+1, MOUSE_BTN_BACKWARD);
+
+	return 1;
+}
+
+/* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
 
@@ -936,6 +1156,9 @@ static int hidpp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_input_mapping(hdev, hi, field, usage, bit, max);
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560 &&
+		field->application != HID_GD_MOUSE)
+		                return -1;
 
 	return 0;
 }
@@ -998,6 +1221,8 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hidpp->hid_dev, data, size);
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
+		return m560_raw_event(hidpp->hid_dev, data, size);
 
 	return 0;
 }
@@ -1026,6 +1251,8 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		return wtp_raw_event(hdev, data, size);
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
+		return m560_raw_event(hidpp->hid_dev, data, size);
 
 	return 0;
 }
@@ -1100,6 +1327,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)
 		wtp_connect(hdev, connected);
+	if ((hidpp->quirks & HIDPP_QUIRK_CLASS_M560) && connected)
+		m560_send_config_command(hdev);
 
 	if (!connected || hidpp->delayed_input)
 		return;
@@ -1164,6 +1393,11 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (ret)
 			goto wtp_allocate_fail;
 	}
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560) {
+		ret = m560_allocate(hdev);
+		if (ret)
+			goto wtp_allocate_fail;
+	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
 	mutex_init(&hidpp->send_mutex);
@@ -1240,6 +1474,7 @@ static void hidpp_remove(struct hid_device *hdev)
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
 	hid_hw_stop(hdev);
+
 }
 
 static const struct hid_device_id hidpp_devices[] = {
@@ -1261,6 +1496,12 @@ static const struct hid_device_id hidpp_devices[] = {
 		USB_VENDOR_ID_LOGITECH, 0x4102),
 	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
 			 HIDPP_QUIRK_CLASS_WTP },
+	{ /* Mouse logitech M560 */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x402d),
+	  .driver_data = HIDPP_QUIRK_CLASS_M560 | HIDPP_QUIRK_DELAYED_INIT |
+			 HIDPP_QUIRK_MULTI_INPUT
+	},
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},



On 2015-04-09 19:35, Benjamin Tissoires wrote:
> Hi Antonio,
> 
> On Thu, Apr 9, 2015 at 8:41 AM, Antonio Ospite <ao2@ao2.it> wrote:
>> On Fri, 05 Sep 2014 19:47:44 +0200
>> Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
>>> On 09/03/2014 11:36 PM, Benjamin Tissoires wrote:
>>>> Hi Goffredo,
>>>>
>>>> On Mon, Sep 1, 2014 at 3:20 PM, Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>>>> Hi Benjamin,
>>>>>
>>>>> following the Nestor suggestion, I rewrote the driver for the
>>>>> mouse Logitech M560 on the basis of your work (branch "for-whot").
>>>>
>>>> Just for the record. This branch is located here:
>>>> https://github.com/bentiss/hid-logitech-dj/tree/for-whot and I
>>>> *really* need to finish this work so that everything can go upstream
>>>> :(
>>>
>>
>> Hi Benjamin, any news about upstreaming this work?
> 
> The hidpp / raw touchpad mode is already upstream since the v3.19 kernel. \o/
> 
> We just need to port Goffredo's changes now and push them too.
> There has been some differences since this branch was published. The
> main is that there is no more special subdrivers in several files,
> everything is handled in hidpp. I think the logic behind is somewhat
> the same so it should not be too much a problem to do the work.
> 
> Cheers,
> Benjamin
> 
>>
>>> :-) For me this is not a problem. I solved my issue (I made a dkms
>>> package for this mouse), but I want to share my effort..
>>>
>>
>> Goffredo, is this the latest version of your dkms-enabled external
>> module?
>> https://github.com/kreijack/hid-logitech-dj/tree/m560-dkms
>>
>> Thanks,
>>    Antonio
>>
>> --
>> Antonio Ospite
>> http://ao2.it
>>
>> A: Because it messes up the order in which people normally read text.
>>    See http://en.wikipedia.org/wiki/Posting_style
>> Q: Why is top-posting such a bad thing?
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
