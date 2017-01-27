From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/4] TTY: fix Caps Lock LED
Date: Fri, 27 Jan 2017 19:34:36 +0100
Message-ID: <20170127183436.GJ13244@mail.corp.redhat.com>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
 <20170127172332.GW9511@var.bordeaux.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127172332.GW9511@var.bordeaux.inria.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Jan 27 2017 or thereabouts, Samuel Thibault wrote:
> Hello,
> 
> Benjamin Tissoires, on Fri 27 Jan 2017 18:13:14 +0100, wrote:
> > Well, it's quite an old issue, but it looks like no one cared much before :)
> 
> I did, actually.

Yes, sorry, I was more putting it in the way "no one in the Fedora/RHEL
world ever noticed the caps lock led was dead". I knew you made progress
in that direction, but we probably didn't port all the fixes if there was.

> 
> > So by default, on Fedora and RHEL at least*, the Caps Lock LED is broken while
> > in a VT.
> 
> Yes, and in Debian too, see
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=514464
> That was the trigger for my kbd LED work.

Do you have a full working solution? Instead of me trying to reinvent
the wheel?

> 
> > I tracked down the issue to be a change in ckbcomp introduced because
> > the kernel just can't properly handle all keymaps. However, if the keymap now
> > works thanks to the work around in place, the LED just doesn't.
> 
> Yes, and ckbcomp now just has to properly set the LED trigger for
> capslock. Something like:
> 
> echo kbd-ctrlllock > /sys/class/leds/input0::capslock/trigger

Ack, but there are 3 (solvable) issues:
- in Fedora/RHEL, ckbcomp is used statically when creating the kbd
  package, the keymaps are generated and then forgot. So ckbcomp is not
  the component to fix for us
- you need to trigger this for each keyboard that appears on the bus.
  This can be achieved by a udev rule, but...
- ... if you blindly set a udev rule to change the trigger, you just
  break every users who manually call loadkeys with a non-patched caps
  lock (when forcing a legacy keymap).

So indeed, this can be fixed by an elaborate udev rule (dumping the
current keymap, checking whether ctrlllock is used in place of capslock,
and set the correct trigger), but I just felt that exposing the trigger
as ctrlllock for the caps lock LED for a plain install was not OK from
the user point of view. (OK, users don't care about triggers as long as
they work).

> 
> see https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=514464#114
> 
> > This series aims at trying to have a consistent LEDs status while in VT.
> > It detects the ckbcomp workaround (which seems mainline now),
> 
> Urgl.
> 
> > and syncs both caps lock with left control lock when it has to.
> 
> Urgl.
> 
> > This way, we shouldn't
> > break existing user-space if the distribution changes the trigger to
> > kbd-controllllock instead of kbd-capslock.
> 
> Urgl.
> 
> It's ckbcomp's fault for using another trigger. It's up to ckbcomp to
> make sure that keyboard use the right trigger for the capslock led.  The
> kernel shouldn't try to circumvent that.

We agree that it's ckbcomp's fault :)

Cheers,
Benjamin

> 
> Samuel
