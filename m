From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Mon, 29 May 2017 22:06:06 -0700
Message-ID: <20170530050606.GA33582@dtor-ws>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws>
 <20170528114758.52b619f2@neko>
 <20170528175540.GA8094@dtor-ws>
 <20170529200325.7855f8a1@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33101 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbdE3FGK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 01:06:10 -0400
Content-Disposition: inline
In-Reply-To: <20170529200325.7855f8a1@kitsune.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, May 29, 2017 at 08:03:25PM +0200, Michal Suchánek wrote:
> On Sun, 28 May 2017 10:55:40 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Sun, May 28, 2017 at 11:47:58AM +0200, Michal Suchanek wrote:
> > > On Tue, 9 May 2017 17:43:27 -0700
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > > 
> > > If not then please do your job as maintainer and accept trivial
> > > patches for perfectly working drivers we have now.  
> > 
> > I am doing my job as a maintainer right now. The driver might have
> > been beneficial 15 years ago, when we did not have better options,
> > but I would rather not continue expanding it's use.
> > 
> > The main problem with the driver is that the functionality it is not
> > easily discoverable by end users. And once you plumb it through
> > userspace to present users with options you might as well handle it
> > all in userspace.
> > 
> ...
> > 
> > >   
> > > > 
> > > > What hardware do you believe would benefit from this and why?  
> > > 
> > > Any touchpad hardware where you cannot press two buttons at once to
> > > emulate the third button due to hardware design. And any touchpad
> > > hardware on which some of the buttons are broken when it comes to
> > > it.
> > > 
> > > It is built into a notebook and works fine for moving the cursor but
> > > due to lack of usable buttons you still need a mouse to use the
> > > notebook.  
> > 
> > Have you tried simply redefining keymap of your keyboard to emit
> > BTN_RIGHT/BTN_MIDDLE? Both atkbd and HID keyboards support keymap
> > updates from userspace/udev/hwdb and if there is a driver that does
> > not support it I will take patches fixing that.
> 
> How is that more easily discoverable by users?

It is not, but the benefit that it does not require a new driver and
uses standard tools to update the mapping.

> 
> More importantly how is that mapping supposed to be represented in a
> hwdb file?
> 
> The help text in the hwdb file says:
> 
> # Scan codes are specified as:
> #   KEYBOARD_KEY_<hex scan code>=<key code identifier>
> # The scan code should be expressed in hex lowercase. The key codes
> # are retrieved and normalized from the kernel input API header.
> 
> So they are converted in some unspecified way.
> 
> The example below defines some mappings, presumably:
> 
> evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pn*
> evdev:atkbd:dmi:bvn*:bvr*:bd*:svnGateway*:pnA0A1*:pvr*
> evdev:atkbd:dmi:bvn*:bvr*:bd*:svneMachines:pneMachines*E725:pvr*
>  KEYBOARD_KEY_a5=help                                   # Fn+F1
>  KEYBOARD_KEY_a6=setup                                  # Fn+F2
>  KEYBOARD_KEY_a7=battery                                # Fn+F3
> 
> /usr/include/linux/input-event-codes.h has occurence of battery in
> 
> #define KEY_BATTERY		236
> 
> meaning that the unspecified conversion is probably performed by
> 
> 1) stripping KEY_ prefix
> 2) converting to lowercase
> 
> This is what systemd hwdb check script does in reverse when checking
> the keycode values.
> 
> The BTN_LEFT 0x110 value does not conflict with KEY_* values, though.
> So technically you could include it in the keymap. If you had a tool
> for that.

Hmm, sounds like you want a patch to udev/systemd. For the kernel there
is no difference between keys and buttons, except symbolic names. They
all go into dev->keybit and are reported with input_report_key().

> And if it is not rejected by the kernel.

It should not. setkeycodes definitely works on atkbd.

> And if it does not
> crash your X server which is very picky about receiving pointer events
> from a keyboard or the other way around.

Sounds like you want to make X server more resilient ;)

But really, it all is better solved in userspace, where you can surface
all options to the user. For example Chrome OS uses Alt + mouse button
(or tap) to do right click, I am sure Gnome or KDE has similar support
for right and middle buttons.

Solving this at kernel is wrong place, similarly how we avoid parsing
user gestures (edge scrolling, 2-finger scrolling, pitch/zoom, etc) in
kernel. Yes, we have legacy drivers (like mousedev) that are artefacts
of times when userspace support was not there and it made sense to
covert everything to emulated PS/2, but that time is long gone.

Thanks.

-- 
Dmitry
