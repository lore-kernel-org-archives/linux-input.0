From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 0/4] TTY: fix Caps Lock LED
Date: Fri, 27 Jan 2017 19:47:58 +0100
Message-ID: <20170127184758.GB3298@var.home>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
 <20170127172332.GW9511@var.bordeaux.inria.fr>
 <20170127183436.GJ13244@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127183436.GJ13244@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Benjamin Tissoires, on Fri 27 Jan 2017 19:34:36 +0100, wrote:
> On Jan 27 2017 or thereabouts, Samuel Thibault wrote:
> > > So by default, on Fedora and RHEL at least*, the Caps Lock LED is broken while
> > > in a VT.
> > 
> > Yes, and in Debian too, see
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=514464
> > That was the trigger for my kbd LED work.
> 
> Do you have a full working solution? Instead of me trying to reinvent
> the wheel?

The one described in comment

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=514464#114

Anton hasn't implemented it in console-setup yet, but I don't think his
code would be reusable as such by ckbcomp anyway.

> > > I tracked down the issue to be a change in ckbcomp introduced because
> > > the kernel just can't properly handle all keymaps. However, if the keymap now
> > > works thanks to the work around in place, the LED just doesn't.
> > 
> > Yes, and ckbcomp now just has to properly set the LED trigger for
> > capslock. Something like:
> > 
> > echo kbd-ctrlllock > /sys/class/leds/input0::capslock/trigger
> 
> Ack, but there are 3 (solvable) issues:
> - in Fedora/RHEL, ckbcomp is used statically when creating the kbd
>   package, the keymaps are generated and then forgot. So ckbcomp is not
>   the component to fix for us

But it can emit a file which says which modifier is used for capslock.

> - you need to trigger this for each keyboard that appears on the bus.
>   This can be achieved by a udev rule, but...
> - ... if you blindly set a udev rule to change the trigger, you just
>   break every users who manually call loadkeys with a non-patched caps
>   lock (when forcing a legacy keymap).

The file I mentioned above could be actually inlined in what loadkeys
eats.

Samuel
