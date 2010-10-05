From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Tue, 5 Oct 2010 08:55:52 -0700
Message-ID: <20101005155552.GB19730@core.coreip.homeip.net>
References: <1285844276.26405.26.camel@cookie.hadess.net>
 <201010050802.14271.oliver@neukum.org>
 <20101005060822.GD15355@core.coreip.homeip.net>
 <201010050818.35118.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201010050818.35118.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Oct 05, 2010 at 08:18:35AM +0200, Oliver Neukum wrote:
> Am Dienstag, 5. Oktober 2010, 08:08:22 schrieb Dmitry Torokhov:
> > > But what about the next opener? He'll get a completely spurious
> > > key release event, as the next key is pressed.
> > 
> > How does the opening of a device handle relate to a device state?
> 
> It doesn't.
> 
> > Userspace should expect to see releases without presses (in case they
> > weren't the first client that opened the device).
> 
> Yes, but based on sane timing. From the time stamps user space
> would conclude that the key had been pressed at an unknown time
> before open and released at the time the event indicates. Possibly
> it would compute that the key had been held for at least hours.
> 

I do not understand. If a client never seen the "press" event and only
saw "release" event it can't make any assumptions about timing. Press
could be a millisecond ago or an hour ago, it just does not know. And
such scenario can easily happen if the client is second to open the
device.

I think the only sane behavior for clients is to ignore release events
for keys that they did not see "down" event for.

- 
Dmitry
