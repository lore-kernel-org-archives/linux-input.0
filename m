From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Sun, 27 May 2007 15:10:23 -0300
Message-ID: <20070527181023.GB4507@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <11802006652058-git-send-email-hmh@hmh.eng.br> <1180200665989-git-send-email-hmh@hmh.eng.br> <200705262340.28219.dtor@insightbb.com> <20070527121513.GC19562@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070527121513.GC19562@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sun, 27 May 2007, Henrique de Moraes Holschuh wrote:
> On Sat, 26 May 2007, Dmitry Torokhov wrote:
> > On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> > > Add hotkeys available in almost all ThinkPads manufactured in the last five
> > > years (more than one million machines given the ammount of batteries
> > > recalled) to input.h, and make thinkpad-acpi use those instead of issuing
> > > KEY_UNKNOWN.
> > > 
> > > KEY_FN_PAGEDOWN is not ever reported by the ThinkPad firmware due to random
> > > bogon-induced stupidity at IBM some years ago, but it is provided because
> > > it doesn't make sense to define KEY_FN_PAGEUP and not define
> > > KEY_FN_PAGEDOWN at the same time.
> > > 
> > 
> > I am unconvinced that we need new keycodes. Isn't there a better default
> > keycodes for these keys? You mentioned that fn+f5 controls radio on many
> > thinkpads, why don't you use KEY_WLAN in your keymap?
> 
> No can do the KEY-WLAN thing, sorry.  I *don't* have a way to know, unless I
> add a model-specific map table to the kernel, and I have been told by
> numerous people to don't even try, unless it is for quirks, etc.
> 
> Really, what are we to do with that input.h scancode map?  It *IS* supposed
> to be absolute, i.e. one is not supposed to reuse keys in there if the
> functionality *or* the generic description is not an exact match.  This is
> extremely clear, and it makes complete sense from the point of view of
> userland: HAL and others can properly assign functions to all scan codes and
> it will be always correct.
> 
> But then, it is expensive memory-wise, so it is near the current KEY_MAX,
> and people are very, very relutant to add another bit to it.
> 
> This is definately a ridiculous and aggravating situation, that deserves a
> proper fix.  If increasing the scancode table cannot be done (why?), it is
> time to stop denying reality, and remove everything after KEY_FN (0x1d0),
> and instead give us a block of KEY_HOSTSPECIFIC_* scancodes, from 0x1d0 to
> at least 0x1ef.
> 
> Given the way that scancode table is being used, it is one way or the other.
> Either increase it to KEY_MAX=0x3ff, or do exactly what UNICODE did, give us
> a decently sized block of host-specific scancodes, and shunt the problem to
> userspace to clean up after.

I can come up with a patch that converts all the keycodes after KEY_FN to
host-specific keycodes, and fix all in-tree drivers to use them (without
modifying any of the scancodes they will generate, i.e. maintaining the ABI
to userspace).  Is there any chance of such a patch being accepted?
Otherwise, I'd rather waste my time doing something else :-)

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
