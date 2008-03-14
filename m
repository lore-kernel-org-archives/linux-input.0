From: "chris guirl" <thelusiv@gmail.com>
Subject: Re: Improving drivers for Logitech Driving Force Pro and G25 wheels
Date: Fri, 14 Mar 2008 15:52:29 -0400
Message-ID: <9ff0fb570803141252m5bd2dfd6wb0bcfd293a9a79bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:43119 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbYCNTwb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2008 15:52:31 -0400
Received: by fk-out-0910.google.com with SMTP id 19so283900fkr.5
        for <linux-input@vger.kernel.org>; Fri, 14 Mar 2008 12:52:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Fri, Mar 14, 2008 at 5:42 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>  thanks for your mail, I have added Jean-Philippe to CC, who has sent me
>  some time ago debugging information for this wheel, but I unfortunately
>  didn't yet had time to look into that in more detail.

Which wheel, the DFP or the G25? Either way they are similar in many
ways so better support for one would improve support for the other.
I'm interested to see this information. There has been some discussion
of the G25 on the forums at vdrift.net.

>  Regarding the HID code -- currently, all device-specific stuff for HID
>  devices is implemented as quirks in hid code -- please see
>  drivers/hid/hid-*quirks* and drivers/hid/usbhid/hid-quirks*. This is not a
>  solution that works well in long-term though, and Jiri Slaby (also added
>  to CC) is currently rewriting the HID core code, so that it will work as a
>  proper bus, so individual drivers could work nicely with that. Once this
>  is done, all the current quirks will be converted to HID-bus drivers.

I've looked through the quirks code and I have some suggestions for
things that can be changed. First, the Vendor/product IDs of the
wheels are not present. When the devices power up they assume VID:PID
0x046d:0xc294 which there is a line for in
drivers/hid/usbhid/hid-quirks.c:

#define USB_DEVICE_ID_LOGITECH_WHEEL	0xc294

This is used by the Logitech Formula Force or Driving Force wheel, and
a legacy mode on the DFP & G25. To use the DFP or G25 in their native
modes, they must be sent a command [0xf8, 0x01] or [0xf8, 0x10]
respectively. Once these wheels receive this command, they simulate a
detach and reattach as 0x046d:0xc298 and 0x046d:0xc299 respectively.
These VID:PID combinations are not handled in the kernel at all. At
the very least they need to be assigned the same quirks as the Driving
Force.

When a Driving Force/Formula Force wheel is detected the device needs
to be probed with the native mode commands to see if it will switch
into DFP or G25 mode. If these modes work, then it is possible to send
the wheels some other commands to enable full rotation of the wheel.
By default only 200 degrees of rotation is available, but both the DFP
and G25 can be switched to allow up to 900 degrees of rotation. I
think there should be a user-land tool to change settings on the wheel
such as this.

>  Depends on how massive your changes are going to be, you could either
>  coordinate with Jiri so that no effort is wasted, or you can just send me
>  a patch with simple quirks addition, and it will get converted into hidbus
>  driver later.

If there is a rewrite due then it may be best to work with Jiri so I
can make my changes work with his, no sense in patching twice.

In addition to HID code, I think I'll need to make some changes to the
joydev driver, as some other things need to be addressed (such as
splitting the gas and brake axis up into separate, independent axes).
Currently I am able to send raw commands to my DFP to make it change
modes, but the /dev/input/jsX device disappears when I do this, so
some other tweaks may be needed on the joystick end of things.

I'll be out of town this weekend so not working on anything yet, but
please send any ideas along as I hope to get started next week.
Thanks.

Chris
