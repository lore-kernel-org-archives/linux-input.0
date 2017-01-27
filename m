From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 0/4] TTY: fix Caps Lock LED
Date: Fri, 27 Jan 2017 18:23:32 +0100
Message-ID: <20170127172332.GW9511@var.bordeaux.inria.fr>
References: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127171318.2596-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

Benjamin Tissoires, on Fri 27 Jan 2017 18:13:14 +0100, wrote:
> Well, it's quite an old issue, but it looks like no one cared much before :)

I did, actually.

> So by default, on Fedora and RHEL at least*, the Caps Lock LED is broken while
> in a VT.

Yes, and in Debian too, see
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=514464
That was the trigger for my kbd LED work.

> I tracked down the issue to be a change in ckbcomp introduced because
> the kernel just can't properly handle all keymaps. However, if the keymap now
> works thanks to the work around in place, the LED just doesn't.

Yes, and ckbcomp now just has to properly set the LED trigger for
capslock. Something like:

echo kbd-ctrlllock > /sys/class/leds/input0::capslock/trigger

see https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=514464#114

> This series aims at trying to have a consistent LEDs status while in VT.
> It detects the ckbcomp workaround (which seems mainline now),

Urgl.

> and syncs both caps lock with left control lock when it has to.

Urgl.

> This way, we shouldn't
> break existing user-space if the distribution changes the trigger to
> kbd-controllllock instead of kbd-capslock.

Urgl.

It's ckbcomp's fault for using another trigger. It's up to ckbcomp to
make sure that keyboard use the right trigger for the capslock led.  The
kernel shouldn't try to circumvent that.

Samuel
