From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add support for the Bamboo Touch trackpad
Date: Mon, 30 Aug 2010 11:10:45 +0200
Message-ID: <4C7B7595.6060904@euromail.se>
References: <1282486241-8855-1-git-send-email-rydberg@euromail.se> <AANLkTikvQdxzRm_rWHHz=m4=fpRSTZbMJhVUji2KVmKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:59378 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754618Ab0H3JLU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Aug 2010 05:11:20 -0400
In-Reply-To: <AANLkTikvQdxzRm_rWHHz=m4=fpRSTZbMJhVUji2KVmKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

Hi Chris,

>> 1) It uses the MT slot protocol
>> 2) It creates two input devices, but only one is useful
> 
> No biggy to userspace.  I'm assuming for unused input device that
> hardware is still reporting a HID_USAGE_STYLUS and probably you could
> catch that and not register that input device.


The initial idea was to only use the trackpad usb endnode, but the device does
not work at all after boot unless the silent endnode is somehow taken into
account. I am not sure what your statement refers to.

>> 3) It works well with the synaptics and multitouch X drivers
>> 4) It does not work well with the wacom X driver (!)
> 
> Once we finalize input events sent, I'm sure we could get
> xf86-input-wacom to play nice with this synaptic-style input events.
> The harder part is to develop userspace rules to assign this "wacom"
> input device to something other than xf86-input-wacom; especially in
> case were tablet has pen and touch input devices.


Using udev rules, the pen device is picked up by the wacom X driver and the
touch device is picked up by the synaptics X driver. It does not seem anything
extra is needed here.

[...]

> +static int wacom_bbt_irq(struct wacom_wac *wacom, size_t len)

> 
> We need a generic name to represent this family of devices since this
> code will eventually be extended for those as well.  You've chosen
> BBTOUCH.  There are some devices in family that support pen-only as
> well as pen&touch.

>
> I'm personally fine with bbt/BBTOUCH/BAMBO_TOUCH but some may prefer

> BBPT/BBPTOUCH/BAMBOO_PT to show super-set of features in family.
> 
> This is a generic comment that I'll not mention any more below.


All irq handlers seem pretty codified, anyways.


[...]

>> +

>> +       input_report_key(input, BTN_TOUCH, count > 0);
>> +       input_report_key(input, BTN_TOOL_FINGER, count == 1);
>> +       input_report_key(input, BTN_TOOL_DOUBLETAP, count == 2);
>> +
>> +       input_report_abs(input, ABS_PRESSURE, sp);
>> +       input_report_abs(input, ABS_X, sx);
>> +       input_report_abs(input, ABS_Y, sy);
>> +
>> +       input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
> 
> This is hardest part were xf86-input-wacom will not want to play nice
> (reporting button presses and touch events together).


I am not sure what you are referring to here. I know of no confusion between the
touch events and actually clicking a button.

[...]

>> +       input_report_key(input, BTN_MIDDLE, (data[1] & 0x06) != 0);
>> +       input_report_key(input, BTN_RIGHT, (data[1] & 0x01) != 0);
> 
> There are 4 buttons on your tablet, right?  Why did you map middle 2
> buttons to  single BTN_MIDDLE?  Thats better for userspace I think.


Because of the similarity with a three-button mouse. Clicking the "I am a
leftie" option will also revert the buttons properly.

> If we wanted to be close to windows mappings then probably
> BTN_RIGHT=0x1, BTN_LEFT=0x2, BTN_MIDDLE=0x4, BTN_4=0x8.... or
> something like that.  The 2 button split layout makes it awkward for
> user to guess what button order is though so not sure windows default
> layout is required.


Right.

>> @@ -1213,11 +1279,19 @@ static const struct wacom_features wacom_features_0xE3 =
>>        { "Wacom ISDv4 E3",       WACOM_PKGLEN_TPC2FG,    26202, 16325,  255,  0, TABLETPC2FG };
>>  static const struct wacom_features wacom_features_0x47 =
>>        { "Wacom Intuos2 6x8",    WACOM_PKGLEN_INTUOS,    20320, 16240, 1023, 31, INTUOS };
>> +static const struct wacom_features wacom_features_0xD0_0 =
>> +       { "Wacom Bamboo Touch",   WACOM_PKGLEN_BBTOUCH,   480,  320, 255, 0, BAMBOO_TOUCH };
>> +static const struct wacom_features wacom_features_0xD0_2 =
>> +       { "Wacom Bamboo Boot",   WACOM_PKGLEN_BBFUN,     480,  320, 255, 0, BAMBOO_BOOT };
> 
> I'm curious why your breaking these out into 2 lines (not that its a
> bad idea, I'm just curious)?  Other wacom devices with similar issue
> would just define it a single time still.


In the hope that it would work to register only the active endnode, plus getting
a natural definition of every endnode of the usb device. Since Ping had issues
with this too, I will change it to the read-and-modify-later approach used in
the rest of the driver.

> Also, what does BOOT mean?  In Bamboo Pen&Touch device, this would be
> the pen input.  So at minimum BAMBOO_PEN is more accurate name.


For the Bamboo Touch, pen is not accurate. Boot comes from the HID specification
(boot interface, mouse protocol), but no name seems appropriate since the node
should not even be there.

Henrik
