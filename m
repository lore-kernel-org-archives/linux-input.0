From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: HID vendor access from user space
Date: Wed, 2 Apr 2014 09:05:01 +0200
Message-ID: <CAE7qMrpO_yEtUGQEg5+8k4gU5=7Hxu03_Y0Uov+vJf5pM0ozkA@mail.gmail.com>
References: <CAE7qMrrtyzUy0h-jeC8b6vLRq10w165=JgEJsj6CKyviFZDaSQ@mail.gmail.com>
 <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:43721 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932088AbaDBHFe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Apr 2014 03:05:34 -0400
Received: by mail-vc0-f176.google.com with SMTP id lc6so10916188vcb.7
        for <linux-input@vger.kernel.org>; Wed, 02 Apr 2014 00:05:33 -0700 (PDT)
In-Reply-To: <CANq1E4Sn4QZN4vPzBkv8zxuGD+xcdgHeMS9sTB45ACknmwaxEA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew de los Reyes <adlr@chromium.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Olivier Gay <ogay@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi, let me resuscitate this thread as we will have some resources to
work on this within a few weeks. I suggest re-reading the previous
emails  to refresh the context of this discussion.

On Tue, May 21, 2013 at 3:12 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Fri, May 17, 2013 at 1:47 PM, Nestor Lopez Casado
> <nlopezcasad@logitech.com> wrote:
>> Hi,
>>
>> In today's linux HID subsystem, a HID device can be accessed for
>> control and configuration via dev/hidraw, via a hid-specific driver,
>> as well as /dev/input (setting leds on a kbd for instance)
>>
>> Some HID devices share multiple functionality in the same HID
>> interface, think of a keyboard with a touchpad and a vendor specific
>> collection for configuration, special status, etc.
>>
>> For such device, there will be one hidraw node, and hid-input will
>> take care of parsing the keyboard/mouse collections into the proper
>> input objects.
>>
>> The vendor collection will be ignored.
>>
>> If a user wants to configure/control the device there are two choices,
>> either write a hid-specific driver to deal with the vendor specific
>> collection, or open the corresponding /hidraw node from userspace.
>>
>> But a hidraw node that carries system input data requires root priviledges.
>>
>> I'm interested in hearing your opinions on how to add the capability
>> for a normal user process to control/configure a HID device via
>> reports exchanged with a vendor collection.
>>
>> I have one proposal, which is to create, say  "/dev/hidvendorX", nodes
>> for all top level HID collections which are today ignored by hid-input
>> and/or other subsystems.
>>
>> These nodes would not require root priviledge by default and thus,
>> users could control/reconfigure their devices from a standard
>> application while keeping the "standard" input functionality intact.
>
> Why not write a kernel driver? We have a pretty nice infrastructure
> for all this.
Do you mean a "hid-specific" driver for certain vid & pid devices ?

>
> If it's a license-issue, I recommend using udev rules to change
> permissions on the requested devices directly during setup. You can
> then use hidraw.
It is not a license issue, it is a security issue.

Every hid class interface, (either usb, bluetooth, i2c, etc) has an
associated hidraw node, and that node aggregates all reports sent from
the device.

Say that for example, the device has a keyboard collection and a
vendor collection, then changing permissions on the associated hidraw
node (so as to give any desktop user unrestricted access to the vendor
collection) would open the door to malicious code that could log the
keyboard activity (as both the vendor reports and input reports are
seen on the same hidraw node)

What we really want, is that vendor reports which come from hid vendor
collections not claimed by hid-input,  are made available in separate
device nodes.


> It would also help if you could describe the driver design. Do you run
> it as daemon and feed data back into the kernel? Or do you forward it
> to the xserver? Or what kind of setup do you have? For instance, a
> library design would require dynamic permission setup, while a
> daemon-design would allow static file-system permissions.
> Furthermore, is it still an input driver? Or do you tunnel non-input
> data via HID?

I see this proposal as an extension to hidraw.c.
The functionality offered would be similar to that proposed by hidraw,
but instead of providing access to all device reports, only those
tagged as being "vendor usage" would be exposed.

Let's take a concrete device example based on the following hid
interface descriptor:
0x05 , 0x01,                    // USAGE_PAGE (Generic Desktop)
0x09 , 0x06,                    // USAGE (Keyboard)
0xA1 , 0x01,                    // COLLECTION (Application)
0x85 , 0x01,                    //    REPORT_ID (1)
0x75 , 0x01,                    //    REPORT_SIZE (1)
0x95 , 0x08,                    //    REPORT_COUNT (8)
0x05 , 0x07,                    //    USAGE_PAGE (Keyboard)

[snip]

0x19 , 0x00,                    //    USAGE_MINIMUM (Reserved (no
event indicated))
0x29 , 0xFF,                    //    USAGE_MAXIMUM (Reserved (no
event indicated))
0x81 , 0x00,                    //    INPUT (Data,Ary,Abs)
0xC0,                           // END_COLLECTION
0x06, 0x00, 0xFF,               // Usage Page (Vendor Defined Page 1)
0x09, 0x02,                     //    Usage (Vendor Usage 2)
0xA1, 0x01,                     //    Collection (Application)
0x85, 0x11,                     //      REPORT_ID (17)
0x75, 0x08,                     //      REPORT_SIZE (8)
0x95, 0x13,                     //      REPORT_COUNT (19)
0x15, 0x00,                     //      LOGICAL_MINIMUM (0)
0x26, 0xFF, 0x00,               //      LOGICAL_MAXIMUM (255)
0x09, 0x02,                     //      USAGE (Vendor Usage 2)
0x81, 0x00,                     //      INPUT (data,Ary,Abs)
0x09, 0x02,                     //      USAGE (Vendor Usage 2)
0x91, 0x00,                     //     OUTPUT (data,Ary,Abs)
0xC0,                           // End Collection

In today's context, this would create one device node:
/dev/hidrawX

After the proposal has been implemented, it would create:
/dev/hidrawX   (access to the full hid interface including reports IDs
1 and 17, no change compared to today)
/dev/hidvendorX   (access to reportID 17 only)

Full user rights can be granted to all desktop users for
/dev/hidvendorX while keeping the input reports (report ID 1) secure.

>
> Regards
> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
-nestor
