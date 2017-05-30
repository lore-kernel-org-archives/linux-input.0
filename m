From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Tue, 30 May 2017 13:32:25 +0200
Message-ID: <20170530133225.08b66374@kitsune.suse.cz>
References: <20170509191418.10144-1-msuchanek@suse.de>
        <20170510004327.GA32584@dtor-ws>
        <20170528114758.52b619f2@neko>
        <20170528175540.GA8094@dtor-ws>
        <20170529200325.7855f8a1@kitsune.suse.cz>
        <20170530050606.GA33582@dtor-ws>
        <20170530113412.281bd571@kitsune.suse.cz>
        <20170530103321.GC1293@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750911AbdE3Lc1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 07:32:27 -0400
In-Reply-To: <20170530103321.GC1293@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 30 May 2017 12:33:21 +0200
Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:

> Hi Michal,
> 
> On May 30 2017 or thereabouts, Michal Suchánek wrote:
> > On Mon, 29 May 2017 22:06:06 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >   
> > > On Mon, May 29, 2017 at 08:03:25PM +0200, Michal Suchánek wrote:  
> > > > On Sun, 28 May 2017 10:55:40 -0700
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > >     
> > > > > On Sun, May 28, 2017 at 11:47:58AM +0200, Michal Suchanek
> > > > > wrote:    

> >   
> > >   
> > > > 
> > > > More importantly how is that mapping supposed to be represented
> > > > in a hwdb file?
> > > > 
> > > > The help text in the hwdb file says:
> > > > 
> > > > # Scan codes are specified as:
> > > > #   KEYBOARD_KEY_<hex scan code>=<key code identifier>
> > > > # The scan code should be expressed in hex lowercase. The key
> > > > codes # are retrieved and normalized from the kernel input API
> > > > header.
> > > > 
> > > > So they are converted in some unspecified way.
> > > > 
> > > > The example below defines some mappings, presumably:
> > > > 
> > > > evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pn*
> > > > evdev:atkbd:dmi:bvn*:bvr*:bd*:svnGateway*:pnA0A1*:pvr*
> > > > evdev:atkbd:dmi:bvn*:bvr*:bd*:svneMachines:pneMachines*E725:pvr*
> > > >  KEYBOARD_KEY_a5=help                                   # Fn+F1
> > > >  KEYBOARD_KEY_a6=setup                                  # Fn+F2
> > > >  KEYBOARD_KEY_a7=battery                                # Fn+F3
> > > > 
> > > > /usr/include/linux/input-event-codes.h has occurence of battery
> > > > in
> > > > 
> > > > #define KEY_BATTERY		236
> > > > 
> > > > meaning that the unspecified conversion is probably performed by
> > > > 
> > > > 1) stripping KEY_ prefix
> > > > 2) converting to lowercase
> > > > 
> > > > This is what systemd hwdb check script does in reverse when
> > > > checking the keycode values.
> > > > 
> > > > The BTN_LEFT 0x110 value does not conflict with KEY_* values,
> > > > though. So technically you could include it in the keymap. If
> > > > you had a tool for that.    
> > > 
> > > Hmm, sounds like you want a patch to udev/systemd. For the kernel
> > > there is no difference between keys and buttons, except symbolic
> > > names. They all go into dev->keybit and are reported with
> > > input_report_key().  
> > 
> > So the userspace is not ready for this while the kernel already has
> > the driver for ages and all that is needed is to enable it.  
> 
> The problem is more that you can have your particular issue solved
> here by using this particular driver. But then someone says that the
> mapping for right/middle doesn't fit to his/her keyboard layout, and
> then we will have to maintain an new set of fancy new features in a
> driver that is just legacy.

The mapping is dynamic. You specify which keycode you translate to
which button by writing a sysfs file and if you do not nothing is
translated. So far as plain mouse emulation goes this driver is
perfectly fine. It will probably not emulate a scrollwheel and other
fancy features but that can be solved in later more flexible solution
once it is finished. And once it is finished then is the time for
retiring this driver.

> 
> I concede userspace doesn't have the feature, but you should really
> have a look at libinput (i.e. open a bug on bugs.freedesktop.org) and
> request the feature here.
> 
> >   
> > >   
> > > > And if it is not rejected by the kernel.    
> > > 
> > > It should not. setkeycodes definitely works on atkbd.
> > >   
> > > > And if it does not
> > > > crash your X server which is very picky about receiving pointer
> > > > events from a keyboard or the other way around.    
> > > 
> > > Sounds like you want to make X server more resilient ;)  
> > 
> > This is an inherent design flaw in the X server known for years. It
> > has separate keyboard and pointer devices and while people are
> > trying to patch it up occasionally a bug pops out that crashes the
> > Xserver when an event is received from non-matching device type.
> > 
> > Once X server dies and is replaced be Y server or Z server or
> > whatever it will make life easier in so many ways.  
> 
> We already have libinput that tends to replace the Xorg input part (at
> least everything which is not protocol). 

And the protocol still has the split to pointer and keyboard. It is
technically possible to map mouse button presses with XKB but it only
works in X and is undocumented and really difficult to do. And it does
not work outside of X.

> So if the feature is in
> libinput, it should be available in X.org directly, and you will be
> saved.

Not everything uses libinput. So no, using libinput is not the answer.

Also libinput people suggest to use hwdb for mapping which is back
to where we were:
https://lists.freedesktop.org/archives/wayland-devel/2015-December/026223.html

> 
> >   
> > > 
> > > But really, it all is better solved in userspace, where you can
> > > surface all options to the user. For example Chrome OS uses Alt +
> > > mouse button (or tap) to do right click, I am sure Gnome or KDE
> > > has similar support for right and middle buttons.  
> > 
> > I do not consider Gnome or KDE more suitable driver for my keyboard
> > than the Linux kernel. In fact I find both very unsuitable as a
> > driver, heavyweight, and causing problems with graphical desktop
> > usability. Not  
> 
> Well, with wayland, the compositor embeds the input stack and part of
> the graphic stack, and it's actually faster than X.

That's pointless when it does not work as a desktop in practice.

And it does not make GNOME or KDE a suitable driver for keyboard, even
if you run Wayland.

> 
> > to mention they cannot be used at all when not running a graphical
> > desktop and often cause system crashes due to stressing the graphics
> > hardware.  
> 
> If you experience crashes, they are probably bugs, and please report
> them to the appropriate project.

And the answer is they know it crashes but it's too much work to fix.
Or that it works for them and you are just unlucky that all of your
half dozen cards crash with their driver and they cannot do anything
about it.
Maybe next year. Or the year after. Or with different piece of
hardware. Who knows?

> 
> >   
> > > 
> > > Solving this at kernel is wrong place, similarly how we avoid
> > > parsing user gestures (edge scrolling, 2-finger scrolling,
> > > pitch/zoom, etc) in kernel. Yes, we have legacy drivers (like
> > > mousedev) that are artefacts of times when userspace support was
> > > not there and it made sense to covert everything to emulated
> > > PS/2, but that time is long gone.  
> > 
> > Unlike 2-finger scrolling, pitch/zoom, and whatnot key mapping is
> > something kernel can do, does, and should do.  
> 
> Looks like we are all on the same page. Kernel does key mapping
> already and doesn't do 2-finger scrolling and other gestures.
> 
> The difference in approach is that you want the kernel to emulate
> devices when userspace has much more information to know how to
> emulate those devices.

Any piece of software has the information when the user tells it. The
thing is the kernel is also able to emulate the device and the
userspace is not. And seriously, this is a hardware problem which is
simple to solve once for good in kernel. Do you advocate that instead
everyone should set up mouse emulation in N application frameworks and
implement it in those that miss it?

> 
> The kernel job is to forward events from the devices to userspace
> without losing information and in a standard way. Anything beyond that
> should be handled in userspace.
 
Then why do you do keycode translation at all? 
I guess because it is the job of the kernel to make the information
usable by the applications as well.

> 
> > 
> > The difference between the plain mapping and mac mouse emulation is
> > that mac mouse emulation probably creates a separate pointer device
> > which is as compatible with legacy software as it gets. Unlike
> > application-specific solutions it works in any software that accepts
> > input events including X. And unlike the systemd solution it works
> > today.  
> 
> And we can argue that the issue with the mac mouse emulation is that
> it filters on all connected keyboard.
> Meaning that if you connect an external keyboard just from time to
> time, those two keys will send the emulated buttons instead of
> sending plain key events.

Well, that's a limitation of simple solution. 

> 
> While on a libinput approach, the filtering will only affect the
> internal keyboard, making the whole experience better.

Unless it happens to crash the X server.

> 
> > 
> > Given the state of userspace at this point I find using the mac
> > mouse emulation most sensible thing to do. Improving the keymap
> > support in systemd is certainly more flexible so it is the way to
> > go long term but if a patch is written and accepted today it will
> > take years until support is commonplace. On the other hand, the
> > change required in Linux is trivial and updating the kernel without
> > breaking the whole system is much more viable than updating
> > systemd.  
> 
> With a libinput approach, the time to distro is much reduced (unless
> you are running a *very* old libinput release that is not ABI
> compatible anymore).

There is no libinput approach. They eschew mapping since there is one
in systemd and one in X already. 

> 
> And we can return the argument for the kernel. The time for a new
> option in the kernel to land in some distribution can also be counted
> in years.
> 

Indeed. However, running own kernel is much more likely to succeed than
running own systemd.

Thanks

Michal
