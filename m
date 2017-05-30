From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Tue, 30 May 2017 11:34:12 +0200
Message-ID: <20170530113412.281bd571@kitsune.suse.cz>
References: <20170509191418.10144-1-msuchanek@suse.de>
        <20170510004327.GA32584@dtor-ws>
        <20170528114758.52b619f2@neko>
        <20170528175540.GA8094@dtor-ws>
        <20170529200325.7855f8a1@kitsune.suse.cz>
        <20170530050606.GA33582@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750904AbdE3JeO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 05:34:14 -0400
In-Reply-To: <20170530050606.GA33582@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 29 May 2017 22:06:06 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, May 29, 2017 at 08:03:25PM +0200, Michal Suchánek wrote:
> > On Sun, 28 May 2017 10:55:40 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >   
> > > On Sun, May 28, 2017 at 11:47:58AM +0200, Michal Suchanek wrote:  
> > > > On Tue, 9 May 2017 17:43:27 -0700
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:  
> >   
> > > > 
> > > > If not then please do your job as maintainer and accept trivial
> > > > patches for perfectly working drivers we have now.    
> > > 
> > > I am doing my job as a maintainer right now. The driver might have
> > > been beneficial 15 years ago, when we did not have better options,
> > > but I would rather not continue expanding it's use.
> > > 
> > > The main problem with the driver is that the functionality it is
> > > not easily discoverable by end users. And once you plumb it
> > > through userspace to present users with options you might as well
> > > handle it all in userspace.
> > >   
> > ...  
> > >   
> > > >     
> > > > > 
> > > > > What hardware do you believe would benefit from this and
> > > > > why?    
> > > > 
> > > > Any touchpad hardware where you cannot press two buttons at
> > > > once to emulate the third button due to hardware design. And
> > > > any touchpad hardware on which some of the buttons are broken
> > > > when it comes to it.
> > > > 
> > > > It is built into a notebook and works fine for moving the
> > > > cursor but due to lack of usable buttons you still need a mouse
> > > > to use the notebook.    
> > > 
> > > Have you tried simply redefining keymap of your keyboard to emit
> > > BTN_RIGHT/BTN_MIDDLE? Both atkbd and HID keyboards support keymap
> > > updates from userspace/udev/hwdb and if there is a driver that
> > > does not support it I will take patches fixing that.  
> > 
> > How is that more easily discoverable by users?  
> 
> It is not, but the benefit that it does not require a new driver and
> uses standard tools to update the mapping.

The mac mouse emulation is not a new driver. It has been in the kernel
for ages. All I want is patch the Kconfig to make it possible to use
the driver when convenient.

> 
> > 
> > More importantly how is that mapping supposed to be represented in a
> > hwdb file?
> > 
> > The help text in the hwdb file says:
> > 
> > # Scan codes are specified as:
> > #   KEYBOARD_KEY_<hex scan code>=<key code identifier>
> > # The scan code should be expressed in hex lowercase. The key codes
> > # are retrieved and normalized from the kernel input API header.
> > 
> > So they are converted in some unspecified way.
> > 
> > The example below defines some mappings, presumably:
> > 
> > evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pn*
> > evdev:atkbd:dmi:bvn*:bvr*:bd*:svnGateway*:pnA0A1*:pvr*
> > evdev:atkbd:dmi:bvn*:bvr*:bd*:svneMachines:pneMachines*E725:pvr*
> >  KEYBOARD_KEY_a5=help                                   # Fn+F1
> >  KEYBOARD_KEY_a6=setup                                  # Fn+F2
> >  KEYBOARD_KEY_a7=battery                                # Fn+F3
> > 
> > /usr/include/linux/input-event-codes.h has occurence of battery in
> > 
> > #define KEY_BATTERY		236
> > 
> > meaning that the unspecified conversion is probably performed by
> > 
> > 1) stripping KEY_ prefix
> > 2) converting to lowercase
> > 
> > This is what systemd hwdb check script does in reverse when checking
> > the keycode values.
> > 
> > The BTN_LEFT 0x110 value does not conflict with KEY_* values,
> > though. So technically you could include it in the keymap. If you
> > had a tool for that.  
> 
> Hmm, sounds like you want a patch to udev/systemd. For the kernel
> there is no difference between keys and buttons, except symbolic
> names. They all go into dev->keybit and are reported with
> input_report_key().

So the userspace is not ready for this while the kernel already has the
driver for ages and all that is needed is to enable it.

> 
> > And if it is not rejected by the kernel.  
> 
> It should not. setkeycodes definitely works on atkbd.
> 
> > And if it does not
> > crash your X server which is very picky about receiving pointer
> > events from a keyboard or the other way around.  
> 
> Sounds like you want to make X server more resilient ;)

This is an inherent design flaw in the X server known for years. It has
separate keyboard and pointer devices and while people are trying to
patch it up occasionally a bug pops out that crashes the Xserver when
an event is received from non-matching device type.

Once X server dies and is replaced be Y server or Z server or whatever
it will make life easier in so many ways.

> 
> But really, it all is better solved in userspace, where you can
> surface all options to the user. For example Chrome OS uses Alt +
> mouse button (or tap) to do right click, I am sure Gnome or KDE has
> similar support for right and middle buttons.

I do not consider Gnome or KDE more suitable driver for my keyboard
than the Linux kernel. In fact I find both very unsuitable as a driver,
heavyweight, and causing problems with graphical desktop usability. Not
to mention they cannot be used at all when not running a graphical
desktop and often cause system crashes due to stressing the graphics
hardware.

> 
> Solving this at kernel is wrong place, similarly how we avoid parsing
> user gestures (edge scrolling, 2-finger scrolling, pitch/zoom, etc) in
> kernel. Yes, we have legacy drivers (like mousedev) that are artefacts
> of times when userspace support was not there and it made sense to
> covert everything to emulated PS/2, but that time is long gone.

Unlike 2-finger scrolling, pitch/zoom, and whatnot key mapping is
something kernel can do, does, and should do.

The difference between the plain mapping and mac mouse emulation is
that mac mouse emulation probably creates a separate pointer device
which is as compatible with legacy software as it gets. Unlike
application-specific solutions it works in any software that accepts
input events including X. And unlike the systemd solution it works
today.

Given the state of userspace at this point I find using the mac mouse
emulation most sensible thing to do. Improving the keymap support in
systemd is certainly more flexible so it is the way to go long term but
if a patch is written and accepted today it will take years until
support is commonplace. On the other hand, the change required in Linux
is trivial and updating the kernel without breaking the whole system is
much more viable than updating systemd.

Thanks

Michal
