From: Jan-Matthias Braun <jan_braun@gmx.net>
Subject: Re: hid-multitouch: eGalax Touchscreen not resuming after suspend
Date: Sun, 25 Nov 2012 12:23:30 +0100
Message-ID: <1418196.mMF7t2R2GI@orthese>
References: <8159607.SRZZrRIPNF@orthese> <21497580.nGzUhbakZT@orthese> <CAN+gG=HozUiBFMC52m6so60GRU1n4-BRjv6Ob7wVpHf+sWLfPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:38669 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753142Ab2KYLXq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Nov 2012 06:23:46 -0500
In-Reply-To: <CAN+gG=HozUiBFMC52m6so60GRU1n4-BRjv6Ob7wVpHf+sWLfPA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Greg Kroah-Hartman <greg@kroah.com>, linux-input@vger.kernel.org

Hi all,

sorry for the e-mail address hopping. Answers to both addresses are okay.

I have now done a git bisection from 3.0 to 3.1 and have found commit
1e2ef05bb8cf851a694d38e9170c89e7ff052741 PM: Limit race conditions between runtime PM and system sleep (v2)
to be the first one to introduce the necessity of a module reload after resume.

I hope that this helps in finding a solution. As I (again) don't immediatly know how to go on, I kindly ask you to give me some hints for testing/patching or even a possible solution. :-)
In the meat time I would leave out the bisection between kernel versions 3.5 and 3.6, except the case that you think this would be helpful for further diagnoses.

Cheers,

Jan-Matthias Braun

Am Samstag, 24. November 2012, 20:27:38 schrieb Benjamin Tissoires:
> Hi Jan-Matthias,
> 
> On Sat, Nov 24, 2012 at 7:01 PM, Jan-Matthias Braun
> <jbraun@physik3.gwdg.de> wrote:
> > Hi Benjamin,
> >
> > I have tested some more kernel versions. The first version, I could use the hid-multitouch module after adding my device to the blacklist of usb-core.c, was 2.6.38. Using the new_id mechanism I have then triggered hid-multitouch to use my device. I tested every version from 2.6.38 over 2.6.39 to 3.6.
> >
> > commit 5519cab477b61326963c8d523520db0342862b63: Driver crashes at the moment I use the new_id mechanism.
> > 2.6.38-3.0: The device is responsive after reboot, without any additional action on my side.
> > 3.1-3.5: After unloading/reloading the module, the device is working again.
> > 3.6: Even unloading/reloading doesn't help, the device is lost up to the next reboot.
> 
> I suspect the root of it comes either from usb or usbhid (I'm adding
> Jiri and Greg in CC so that they can confirm or not).
> 
> The only changes in the suspend/resume code in hid-multitouch are:
> - one in kernel 3.3 (I just send a feature at resume).
> - one in kernel 3.7, that you tested as not functional (and not in the
> range of your targets).
> 
> >
> > Now I am going to do a bit of bisection testing on both regressions. If you have some hints, on how I could speed testing up, I would welcome them.
> 
> I hope that Greg or Jiri will help on that. I made a short git blame
> on drivers/hid/usbhid/hid-core.c, and I did not found anything either.
> 
> Cheers,
> Benjamin
> 
> >
> > Cheers,
> >
> > Jan
> >
> > Am Donnerstag, 22. November 2012, 20:00:25 schrieb Jan-Matthias Braun:
> >> Hi Benjamin,
> >>
> >> Am Mittwoch, 21. November 2012, 14:36:33 schrieb Benjamin Tissoires:
> >> > On 11/21/2012 10:33 AM, Jan-Matthias Braun wrote:
> >> > > Am Dienstag, 20. November 2012, 13:47:23 schrieben Sie:
> >> > >> On Mon, Nov 19, 2012 at 12:58 PM, Jan-Matthias Braun <jan_braun@gmx.net> wrote:
> >> > >>> using the current (Linux v2.6.7) hid-multitouch driver I have the problem, that the touchscreen works fine after a fresh boot, but after a suspend the touchscreen does not come back to live and I am asking for assistance to get this working. As I can reproduce this problem on a standard tty device without X (see below) I am suspecting a driver problem, but I might as well be wrong.
> >> > >>
> >> > >> I assume you are talking about v3.6.7...
> >> > >
> >> > > You are right, of course. Sorry for the distraction.
> >> > >
> >> > >>> The device in question is the Touchscreen of a Dell Inspron Duo convertable, a USB device with id 0eef:725e (D-WAV Scientific Co., Ltd), found and registered as an input device by the kernel as
> >> > >>> [    6.931638] usb 4-1: Manufacturer: eGalax Inc.
> >> > >>> [   16.186272] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input/input10
> >> > >>> [   16.187162] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer
> >> > >>>                   [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0
> >> > >>>
> >> > >>> I have tested the behaviour with and without X11. Without X11 I was using a standard tty and using cat on the input device.
> >> > >>> After boot the input device gives lot of output while touching the screen, after resume the device stays silent.
> >> > >>
> >> > >> strange. I have tested the procedure with the eGalax 0x72FA I got, and
> >> > >> I'm not seeing this problem on a 3.6 kernel.
> >> > >>
> >> > >> Is the config symbol CONFIG_PM set to "y" in your .config file?
> >> > >
> >> > > Yes.
> >> > >
> >> > >> Also, can you try to rmmod / modprobe hid-multitouch when the device
> >> > >> is not responding and see if this solves things.
> >> > >
> >> > > This is not working for me. On modprobe the Kernel log says
> >> > >
> >> > > [12537.335946] input: eGalax Inc. USB TouchController as /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/input
> >> > > /input13
> >> > > [12537.336875] hid-multitouch 0003:0EEF:725E.0001: input,hiddev0,hidraw0: USB HID v2.10 Pointer [eGalax Inc. USB TouchController] on usb-0000:00:1d.2-1/input0
> >> > >
> >> > > but /dev/input/event13 is not created. To be honest, I don't even know, if it should be created.
> >> >
> >> > no, the input13 here has nothing to do with the device node /dev/input/eventX
> >> >
> >> > > What happens is, that /dev/input/event10 vanishes on removal of the hid-multitouch module and then reappears after modprobe. But a cat on it wont show a reaction while touching the screen's surface.
> >> >
> >> > the event10 vanishing is normal, you removed the driver, so the device is not here outside of the kernel.
> >> > When you modprobe, it's back!
> >> > However events should come from this node.
> >> >
> >> > >
> >> > >>> I have this problem since moving to hid-multitouch for handling this device.
> >> > >>
> >> > >> What kind of driver did you use before?
> >> > >
> >> > > I think, there was a separate usb touchscreen driver for egalax devices before something like kernel version 3.2. This one I used. Long story short: I have never used the vendor supplied drivers, but those coming with the kernel.
> >> >
> >> > Ok, so either you must have patched hid-egalax to handle your device, either you used an other usb driver (it would be great if you can find out which).
> >> > The weird thing is that hid-egalax does not do anything at resume, so I doubt we should look there.
> >>
> >> Okay, I think it has been the driver for generic usb hid devices, I have been using.
> >> I have been testing some more kernel versions and found out, that a module reload after resume will solve the problem at least for kernel versions 3.4, 3.5.0, and 3.5.4. For the current stable series this doesn't hold true and the problem arises as described.
> >> Nevertheless, even the 3.4 and 3.5 series need a module reload, for the device to work after a resume.
> >>
> >> I could do a bisection search to find the commit that caused the secondary problem of module reload being uneffictive after resume, although this could take quite some time to complete, atm. I am trying to test commit 5519cab477b61326963c8d523520db0342862b63 now, to find out, how the first version behaves with my device.
> >>
> >> > Anyway, can you try the following patch which is already include in the next 3.7 release?
> >>
> >> This patch doesn't change the behaviour I am experiencing after resume.
> >>
> >> Cheers,
> >>
> >> Jan-Matthias Braun
