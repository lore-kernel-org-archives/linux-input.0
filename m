From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] Input: document the proper usage of EV_KEY and KEY_UNKNOWN
Date: Thu, 31 May 2007 23:11:04 -0300
Message-ID: <20070601021104.GA14387@khazad-dum.debian.net>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <d120d5000705301325yf76d062vefbc79873d23e602@mail.gmail.com> <20070531005305.GC6883@khazad-dum.debian.net> <200705310033.51230.dtor@insightbb.com> <20070531222814.GB4076@khazad-dum.debian.net> <20070531233326.GA1947@srcf.ucam.org> <20070601001304.GB5407@khazad-dum.debian.net> <20070601002435.GA2621@srcf.ucam.org> <20070601012928.GD5407@khazad-dum.debian.net> <20070601014453.GA3711@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070601014453.GA3711@srcf.ucam.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 01 Jun 2007, Matthew Garrett wrote:
> On Thu, May 31, 2007 at 10:29:28PM -0300, Henrique de Moraes Holschuh wrote:
> > On Fri, 01 Jun 2007, Matthew Garrett wrote:
> > > Given existing userspace, it's never useful to generate KEY_UNKNOWN. 
> > > Adding extra information to the event doesn't alter that.
> > 
> > It will not break anything, and it is trivial to write an application to
> > intelligently handle KEY_UNKNOWN+scancode events.  This really is not a
> > reason to not do it, at all.
> 
> It's not trivial at all. You need to introduce a mechanism for noting a 
> KEY_UNKNOWN keypress. It then needs to signal the user (dbus is probably 

That would be trivial, but...

> the best layer for this), but you need to ensure that you only signal 
> the user who is currently at the keyboard. This needs to be presented to 
> the user via some sort of UI, which will then need to signal some sort 
> of privileged process to actually change the keymap. When the user logs 
> out, you'll then need to unmap the key again and repeat as necessary for 
> any new user who logs in.

... this is not.  You're correct.  So using KEY_UNKNOWN should not be the
preferred way, then.

> Alternatively, we could generate a keycode and then let the user map 
> that to an X keysym. We've even already got code to do this.

Well, I also would appreciate bumping up KEY_MAX and a nice shiny set of
KEY_FN that covered all the missing ones for ThinkPads.  It is Dmitry you
have to convince about it.

That still doesn't make KEY_UNKNOWN without a scan code useful, so either
way, I think KEY_UNKNOWN should be limited to drivers that can remap
keycodes *and* which send MSC_SCAN events along with KEY_UNKNOWN, so that
you know what key to remap.  I don't care if it is easy or not to be nice to
the user and ask for a key remap, at least it will not be *impossible* like
it currently is.  Otherwise, we would be better off removing KEY_UNKNOWN
altogether (which I wouldn't mind much, either).

> > > I think using positional keycodes would also be a mistake. We just need 
> > > a slightly larger set of keycodes representing user-definable keys. 
> > > There's 4 of them already - I really can't imagine there being many 
> > > keyboards with a significantly larger set of unlabelled keys.
> > 
> > I had this exact PoV, too, until Dmitry reminded me that keycodes are
> > *global* to the system in practice, and that different keys (as in keys that
> > have no correlation between their position, labels or lack thereof, and
> > function) in different input devices would end up mapped to KEY_PROGx by
> > default.
> 
> That's a ridiculously niche case, and can be handled in userspace. Just 
> have udev do remapping when it detects multiple keyboards that both have 
> KEY_PROG* layers, or let X have different keymaps for different input 
> devices. We shouldn't make the (by far) common case significantly more 
> difficult to deal with this one.

Dmitry?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
