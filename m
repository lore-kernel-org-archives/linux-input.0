From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using EV_MSC or extending KEY_*
Date: Mon, 28 Sep 2009 10:03:14 -0700
Message-ID: <20090928170314.GI21455@core.coreip.homeip.net>
References: <aac07123ee2b14a0ac25d1652dbe0780.squirrel@intranet.cs.nmsu.edu> <5d5443650909151011k4b21a6d0n28ac6142c3d7161d@mail.gmail.com> <20090915183406.GA5696@core.coreip.homeip.net> <0debc76f26fe85e28adf642396233928.squirrel@intranet.cs.nmsu.edu> <20090916034642.GC2756@core.coreip.homeip.net> <2c0ac825ebe78da99328b896faae04a2.squirrel@intranet.cs.nmsu.edu> <20090917175707.GB789@khazad-dum.debian.net> <20090918064627.GG18668@core.coreip.homeip.net> <20090918135601.GA25109@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090918135601.GA25109-ZGHd14iZgfaRjzvQDGKj+xxZW9W5cXbT@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 18, 2009 at 10:56:01AM -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 17 Sep 2009, Dmitry Torokhov wrote:
> > On Thu, Sep 17, 2009 at 02:57:07PM -0300, Henrique de Moraes Holschuh wrote:
> > > On Wed, 16 Sep 2009, Rick L. Vinyard, Jr. wrote:
> > > > The M* keys are intended to provide a quick way to switch between key
> > > > mappings, with each mode having their own user-defined mappings.
> > > 
> > > What I'd do in this case would be this:
> > > 
> > > 1. Initially have the M* level-shift keys assigned KEY_RESERVED
> > > 
> > > 2. Have a big enough keymap to map all keys in all M*-level shift states
> > > possible.
> > > 
> > > Eg:
> > >    START OF KEYMAP
> > >    M* keys
> > >    1st set of G* keys
> > >    2nd set of G* keys
> > >    3rd set of G* keys...
> > >    ...
> > >    last set of G* keys
> > >    END OF KEYMAP
> > > 
> > > 3. Have the driver special-process M* level-shift keys *as long as they are
> > > still set to KEY_RESERVED* to select which part of the keymap is used to
> > > translate the other keys.  Note that this likely means pressing a M* key
> > > would be transparent to userspace in this case, i.e. no events would be
> > > issued when a M* key is doing a level shift.
> > > 
> > > So, you'd be able to set all mappings you want in the driver, and the M*
> > > keys would do what they're expected to do without any userland help at all,
> > > but you'd still be able to program the M* keys to be normal keys if you
> > > want.
> > > 
> > > Of course, this assumes you don't do chording on multiple M* keys to end up
> > > with a huge number of keymaps :p
> > 
> > Actually I think that the device should just emit KEY_PROG1..KEY_PROG4
> > for the M keys and have userspace daemon load alternate keymaps on the
> > fly in resaponse to KEY_PROGx. The device is just a set of completely
> > generic buttons... User will have to tell the kernel what to map them
> > to.
> 
> It would work, but it is a big trip through userspace.  If quickly pressing
> M#+G# is a common use pattern (and it will be, for gaming), i.e. you often
> want to access quickly a function on one level then another on a different
> level, asking userspace to upload a new keymap to switch levels at every M#
> press is going to be way too racy.

I'd say it should be pretty quick, compared to what a game needs to do
to render a single frame.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
