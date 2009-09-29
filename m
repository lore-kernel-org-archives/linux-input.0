From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] cmpc_acpi: Added support for Classmate PC ACPI devices.
Date: Tue, 29 Sep 2009 17:41:42 +0100
Message-ID: <9b2b86520909290941g6295ba36i907dfda62b968529@mail.gmail.com>
References: <1254188280-29155-1-git-send-email-cascardo@holoscopio.com>
	 <9b2b86520909290220g6b5f6beal6337b17f1bdd339@mail.gmail.com>
	 <20090929141618.GD18847@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:51151 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbZI2Qt0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2009 12:49:26 -0400
In-Reply-To: <20090929141618.GD18847@vespa.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, don@syst.com.br, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, dtor@mail.ru, dmitry.torokhov@gmail.com

On 9/29/09, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com> wrote:
> On Tue, Sep 29, 2009 at 10:20:44AM +0100, Alan Jenkins wrote:
> Hello, Allan.
>
> Thanks for the feedback. I am considering an investigation whether we
> have lots of other ACPI input devices that could share some code like
> {add,remove}_acpi_notify_device. Regarding the driver naming, I will
> send a second version with it and other modifications considering your
> feedback and that of other people too.
>
> I will also ask for some explicit feedback and add linux-input and
> Dmitry to the loop.
>

I'll leave the input questions for the list.  I don't have any
suggestions about your choice of keycode for the house key, or how to
calibrate accelerometers.

>> > +struct device_attribute cmpc_accel_sense_attr = {
>> > +	.attr = { .name = "sense", .mode = 0220 },
>> > +	.store = cmpc_accel_sense_store
>> > +};

> This changes the accelerometer device sensitivity. I will take a look at
> the ACPI tables to get a range. If very much sensitive, the device will
> generate too much ACPI notifications, even when the classmate PC is no a
> table and there seems to be no movement. If not very much sensitive, you
> must throw it spinning into the air to get anything.  :-)
>
> I will pick a default value, although I think we could let it to
> userspace, but a sensible default value will not hurt here. As far as I
> know, there is no ACPI method to do get_sense, but we can mirror the
> last value written and provide a .show.
>
> What do you recommend as a documentation? Something at
> Documentation/ABI/testing/, perhaps? I don't know if there are any other
> devices with something similar, but I would not be surprised if there
> are some of them.

Documentation/ABI seems reasonable; "sysfs-platform-eeepc-laptop" was
accepted there.

You could try (either in place of documentation, or in addition to)
making the interface self-explanatory.  Call the attribute
"sensitivity", and add a "max_sensitivity" attribute.  It would also
make the interface more generic.

>> > +static void cmpc_tablet_idev_init(struct input_dev *inputdev)
>> > +{
>> > +	set_bit(EV_SW, inputdev->evbit);
>> > +	set_bit(SW_TABLET_MODE, inputdev->swbit);
>>
>> Don't you need to initialize the switch value here?
>>
>
> No, input_allocate_device does kzalloc. Otherwise, this would apply to
> the other bitmaps as well.

The other bitmaps aren't for switches though.  Here's what prompted
this comment - a snippet from the old (2.6.29) version of
Documentation/rfkill.txt:

"2. Input device switches (sources of EV_SW events) DO store their current state
(so you *must* initialize it by issuing a gratuitous input layer event on
driver start-up and also when resuming from sleep), and that state CAN be
queried from userspace through IOCTLs."

>> Also, have you tested this with changing the switch value while
>> suspended?  I _think_ you need to update the switch state on resume.
>> This is purely from looking at other acpi drivers and their evolution;
>> I don't have any practical experience with input drivers.
>>
>
> Interesting point. I will do the testing.

Thanks
Alan
