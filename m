From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Mon, 29 May 2017 20:03:25 +0200
Message-ID: <20170529200325.7855f8a1@kitsune.suse.cz>
References: <20170509191418.10144-1-msuchanek@suse.de>
        <20170510004327.GA32584@dtor-ws>
        <20170528114758.52b619f2@neko>
        <20170528175540.GA8094@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40431 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750891AbdE2SD1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 14:03:27 -0400
In-Reply-To: <20170528175540.GA8094@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, 28 May 2017 10:55:40 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Sun, May 28, 2017 at 11:47:58AM +0200, Michal Suchanek wrote:
> > On Tue, 9 May 2017 17:43:27 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > 
> > If not then please do your job as maintainer and accept trivial
> > patches for perfectly working drivers we have now.  
> 
> I am doing my job as a maintainer right now. The driver might have
> been beneficial 15 years ago, when we did not have better options,
> but I would rather not continue expanding it's use.
> 
> The main problem with the driver is that the functionality it is not
> easily discoverable by end users. And once you plumb it through
> userspace to present users with options you might as well handle it
> all in userspace.
> 
...
> 
> >   
> > > 
> > > What hardware do you believe would benefit from this and why?  
> > 
> > Any touchpad hardware where you cannot press two buttons at once to
> > emulate the third button due to hardware design. And any touchpad
> > hardware on which some of the buttons are broken when it comes to
> > it.
> > 
> > It is built into a notebook and works fine for moving the cursor but
> > due to lack of usable buttons you still need a mouse to use the
> > notebook.  
> 
> Have you tried simply redefining keymap of your keyboard to emit
> BTN_RIGHT/BTN_MIDDLE? Both atkbd and HID keyboards support keymap
> updates from userspace/udev/hwdb and if there is a driver that does
> not support it I will take patches fixing that.

How is that more easily discoverable by users?

More importantly how is that mapping supposed to be represented in a
hwdb file?

The help text in the hwdb file says:

# Scan codes are specified as:
#   KEYBOARD_KEY_<hex scan code>=<key code identifier>
# The scan code should be expressed in hex lowercase. The key codes
# are retrieved and normalized from the kernel input API header.

So they are converted in some unspecified way.

The example below defines some mappings, presumably:

evdev:atkbd:dmi:bvn*:bvr*:bd*:svnAcer*:pn*
evdev:atkbd:dmi:bvn*:bvr*:bd*:svnGateway*:pnA0A1*:pvr*
evdev:atkbd:dmi:bvn*:bvr*:bd*:svneMachines:pneMachines*E725:pvr*
 KEYBOARD_KEY_a5=help                                   # Fn+F1
 KEYBOARD_KEY_a6=setup                                  # Fn+F2
 KEYBOARD_KEY_a7=battery                                # Fn+F3

/usr/include/linux/input-event-codes.h has occurence of battery in

#define KEY_BATTERY		236

meaning that the unspecified conversion is probably performed by

1) stripping KEY_ prefix
2) converting to lowercase

This is what systemd hwdb check script does in reverse when checking
the keycode values.

The BTN_LEFT 0x110 value does not conflict with KEY_* values, though.
So technically you could include it in the keymap. If you had a tool
for that. And if it is not rejected by the kernel. And if it does not
crash your X server which is very picky about receiving pointer events
from a keyboard or the other way around.

Thanks

Michal
