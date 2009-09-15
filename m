From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using EV_MSC or extending KEY_*
Date: Tue, 15 Sep 2009 11:34:06 -0700
Message-ID: <20090915183406.GA5696@core.coreip.homeip.net>
References: <aac07123ee2b14a0ac25d1652dbe0780.squirrel@intranet.cs.nmsu.edu> <5d5443650909151011k4b21a6d0n28ac6142c3d7161d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5d5443650909151011k4b21a6d0n28ac6142c3d7161d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>, Linux USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 15, 2009 at 10:41:30PM +0530, Trilok Soni wrote:
> Adding linux-input.
> 
> On Tue, Sep 15, 2009 at 9:49 PM, Rick L. Vinyard, Jr.
> <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org> wrote:
> > On the Logitech G13 there are a set of 10 special keys at the top of the
> > device.
> >
> > I've written the driver so that it maintains a map from the general keys
> > (G1-G22) to Linux' input subsystem keys.
> >
> > The map can be changed on the fly, allowing multiple keymaps to be loaded.
> >
> > As a side note I haven't provided for this functionality (multiple
> > keymaps) in the driver since this can be maintained from userspace, but it
> > does need to know about the currently loaded keymap so that when the raw
> > HID events are parsed the appropriate EV_KEY events can be input.
> >
> > I could set it up so that the special keys also map to a KEY_* code.
> > However, I'd prefer to set things up so that any G1-G22 key can be mapped
> > to any input subsystem KEY_* code and not reserve a set of 10 from the
> > current KEY_* codes for the 10 special keys.
> >
> > One way I was thinking of approaching this was to generate EV_MSC type
> > events (with a MSC_RAW code) using the value to indicate the state
> > (pressed/released) and special key.

Doesn't HID already generate EV_MSC/MSC_SCAN for exactly this purpose
so userspace knows what keys can be remapped? You may initially map all
keys you don't know the usage to KEY_UNKNOWN.

> >
> > Another way to approach this would be to extend the KEY_* #defines with a
> > special set of 10 codes for the 10 special keys.
> >

No, please don't do this.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
