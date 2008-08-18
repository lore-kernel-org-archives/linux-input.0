From: "=?UTF-8?B?0KHQtdGA0LPQtdC5INCR0LXQu9GP0YjQvtCy?="
	<sergey.belyashov@gmail.com>
Subject: Re: [PATCH] Autocentering support for Logitech MOMO Racing Wheel (force feedback)
Date: Mon, 18 Aug 2008 22:30:28 +0400
Message-ID: <bb829a0b0808181130r4c45403al45fffb356f321f9@mail.gmail.com>
References: <bb829a0b0808180217t2bd3ed49q4cf5734dcc756311@mail.gmail.com>
	 <20080818110815.ZZRA012@mailhub.coreip.homeip.net>
	 <bb829a0b0808180916l1d2ca72fj689edcf5b8c156e5@mail.gmail.com>
	 <20080818131807.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:2345 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbYHRSa3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 14:30:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3256514wfd.4
        for <linux-input@vger.kernel.org>; Mon, 18 Aug 2008 11:30:28 -0700 (PDT)
In-Reply-To: <20080818131807.ZZRA012@mailhub.coreip.homeip.net>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

2008/8/18 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>
>>
>>       error = input_ff_create_memless(dev, NULL, hid_lgff_play);
>>       if (error)
>>               return error;
>>
>> +     if (autocenter && dev->ff && (!dev->ff->set_autocenter))
>> +             dev->ff->set_autocenter = hid_lgff_set_autocenter;
>> +
>
> You can just do "if (test_bit(FF_AUTOCENTER, dev->ffbit))" and you
> won't need a temp variable. Also why do you need the rest of the check?
>
> --
> Dmitry
>
>>
>> Yes. This checks are redundant.
>> Do I need to recreate patch and resend it?
>
> Yes, please. Also send it to Jiri Kosina <jkosina@suse.cz> since the
> patch will go through his HID tree.


=========================================================================
Logitech MOMO Recing Wheel Force Feedback autocenter setting support
(also may be work on G25 etc. but I cann't check):

--- linux-source-2.6.24/drivers/hid/usbhid/hid-lgff.c   2008-02-11
08:51:11.000000000 +0300
+++ linux-source-2.6.24.n/drivers/hid/usbhid/hid-lgff.c 2008-08-18
22:16:04.000000000 +0400
@@ -48,6 +48,12 @@
 	-1
 };

+static const signed short ff_momo_wheel[] = {
+	FF_CONSTANT,
+	FF_AUTOCENTER,
+	-1
+};
+
 static const struct dev_type devices[] = {
 	{ 0x046d, 0xc211, ff_rumble },
 	{ 0x046d, 0xc219, ff_rumble },
@@ -55,7 +61,7 @@
 	{ 0x046d, 0xc286, ff_joystick },
 	{ 0x046d, 0xc294, ff_joystick },
 	{ 0x046d, 0xc295, ff_joystick },
-	{ 0x046d, 0xca03, ff_joystick },
+	{ 0x046d, 0xca03, ff_momo_wheel },
 };

 static int hid_lgff_play(struct input_dev *dev, void *data, struct
ff_effect *effect)
@@ -100,6 +106,23 @@
 	return 0;
 }

+static void hid_lgff_set_autocenter(struct input_dev *dev, u16 magnitude)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct list_head *report_list =
&hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	struct hid_report *report = list_entry(report_list->next, struct
hid_report, list);
+	__s32 *value = report->field[0]->value;
+	magnitude = (magnitude >> 12) & 0xf;
+	*value++ = 0xfe;
+	*value++ = 0x0d;
+	*value++ = magnitude;   /* clockwise strength */
+	*value++ = magnitude;   /* counter-clockwise strength */
+	*value++ = 0x80;
+	*value++ = 0x00;
+	*value = 0x00;
+	usbhid_submit_report(hid, report, USB_DIR_OUT);
+}
+
 int hid_lgff_init(struct hid_device* hid)
 {
 	struct hid_input *hidinput = list_entry(hid->inputs.next, struct
hid_input, list);
@@ -145,6 +168,9 @@
 	if (error)
 		return error;

+	if ( test_bit(FF_AUTOCENTER, dev->ffbit) )
+		dev->ff->set_autocenter = hid_lgff_set_autocenter;
+
 	printk(KERN_INFO "Force feedback for Logitech force feedback devices
by Johann Deneux <johann.deneux@it.uu.se>\n");

 	return 0;
====================================================================
note: all formating spaces are tabs (if need I can send patch as attachement)

Best regards,
Sergey Belyashov
