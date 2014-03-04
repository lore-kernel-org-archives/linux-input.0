From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 0/6] HID: sony: More Sony controller fixes and
 improvements.
Date: Tue, 4 Mar 2014 13:34:26 +0100
Message-ID: <20140304133426.ea711f53198ec62894a630de@ao2.it>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
	<20140301145346.d1b3305ba0b186d452a34beb@ao2.it>
	<53135BA6.9090501@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:56061 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756977AbaCDMed (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2014 07:34:33 -0500
In-Reply-To: <53135BA6.9090501@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, dh.herrmann@gmail.com

On Sun, 02 Mar 2014 11:26:14 -0500
Frank Praznik <frank.praznik@oh.rr.com> wrote:

> On 3/1/2014 08:53, Antonio Ospite wrote:
[...]
> >
> >> Patch #6 initializes the LEDs to a default value of LED 1 on the Sixaxis and
> >> blue on the DualShock 4 so there is some indication that the controller is
> >> powered on and connected in the case of Bluetooth.  The code can be used to set
> >> the LEDs based on the device number, but I'm not sure how to actually retrieve
> >> the controller number from the system.  I saw the xpad patches posted a few
> >> weeks ago where the minor number of the joydev device was used, but I'm under
> >> the impression that doing that is not ideal.  Any suggestions?
> > Setting the controller number is done by the bluez sixaxis plugin[1]
> > (in bluez 5.x) following the X in /dev/input/jsX, this covers the
> > case of a mixed-joypad scenario, IMHO it makes sense that the
> > controller number matches the joystick device number.
> > Imagine js0->Sixaxis1, js1->wiimote, js2->Sixaxis2, I think it make
> > sense to have the LEDs on Sixaxis2 say "controller 3", not 2.
> >
> > This has been done in userspace with libudev for 2 reasons:
> >    1. the hid drivers should not have knowledge of the joystick layer;
> >    2. kernel drivers should be as simple as possible, and try to just
> >       exposing hardware functionalities but with as less "business logic"
> >       as possible in them.
> >
> > The current implementation in the bluez plugin uses hidraw, but support
> > for the sysfs led class could be added in order to avoid conflicts with
> > the rumble; IIRC, currently, setting rumble values could override the
> > LED settings done via hidraw, because the LEDs state is not tracked in
> > the latter case.
> >
> > Ciao,
> >     Antonio
> >
> > [1]
> > http://git.kernel.org/cgit/bluetooth/bluez.git/tree/plugins/sixaxis.c
> >
> This can be done in the driver. See 
> https://www.mail-archive.com/linux-input@vger.kernel.org/msg08103.html
>

xpad is a joystick driver, while hid-sony is a HID driver.

> It seems that the main problem with that patch is that modern systems 
> shouldn't be relying on joydev for this functionality.  I'd like to know 
> what David Herrmann and Greg Kroah-Hartman came up with regarding the 
> solution mentioned in the reply as it would be nice to be able to set 
> the LEDs to the proper default values in the driver without needing to 
> rely on an external daemon. Setting the defaults in the driver doesn't 
> interfere with setting custom values after the device is initialized, so 
> there are no issues if the user wants to use a custom LED daemon.

The way I see it, the problem here is not about joydev itself it's
about:
  1. the layering relationship between HID and joydev
  2. whether or not we consider assigning joypad numbers as a kernel
     job.

The NAK came because of 1.; as 2. is more debatable I guess.

> As far as the behavior of patch #6 (setting the LEDs to the same number 
> or color on every connected device just to indicate that the controller 
> is turned on), the xpad and wiimote drivers both initialize the LEDs to 
> some default value where at least one is on to indicate that the 
> controller is powered on and connected to the system.  The xpad driver 
> increments an atomic counter for assigning values as controllers are 
> connected and the wiimote always sets LED #1 to on.  Not ideal, but it 
> serves it's purpose.
>

For the sixaxis the all-blink pattern is used, it's a really dumb
indicator, but it's still an indicator.

> Personally I don't like the idea of relying on a BlueZ plugin to set the 
> controller LED values as it seems to bring a lot of issues with it: 
> users may not have BlueZ installed or enabled, some distros still use an 
> old version, the plugin relies on joydev to get the device number which 
> is why the patch I linked was NAKed, the current plugin implementation 
> doesn't set them via sysfs so the setting will be lost if force-feedback 
> is used and the plugin could conflict with other user-installed daemons 
> that set the LEDs (unless udev guarantees a notification order?).  In 
> the latter scenario, the user could disable the plugin, but then you 
> lose the Sixaxis pairing functionality that it provides.  I also have to 
> question as to why BlueZ is considered an appropriate place to set 
> controller LEDs, particularly on controllers that aren't connected via 
> Bluetooth.

Let me answer the last question first, the rationale was:

 1. the common use case for the sixaxis is considered to be its use
    via Bluetooth, can we agree on that?
 2. under this assumption BlueZ was chosen as a convenient place to do
    the pairing and association.
 3. Paring requires to access the device via USB in order to retrieve
    its bdaddr and set the master bdaddr.
 4. Once we are accessing the device via USB and BT in the BlueZ plugin
    anyway, just let's set the LEDs here.

A more general "excuse" is that clutter in userspace is slightly more
acceptable than clutter in kernel code.

And to reply to the other questions, yes, the bluez plugin is not
perfect by any means: it enforces dependencies, it's not using the leds
class yet, but it can be improved and IMHO it's still the most
convenient way to have responsibilities separated: the kernel driver
provides access to the hardware functionality and the userspace
software decides what to do with them.

However, since you are the one currently working on things you are
entitled with a stronger voice here, I am just whispering my opinions :)

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
