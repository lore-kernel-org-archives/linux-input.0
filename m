From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend / hibernate nomenclature
Date: Sun, 8 Mar 2009 21:56:45 +0100
Message-ID: <200903082156.46219.rjw@sisk.pl>
References: <1235992429.3858.58.camel@hughsie-work.lan> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com> <20090308144145.GB26233@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20090308144145.GB26233@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Richard Hughes <hughsient@gmail.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-input@vger.kernel.org

On Sunday 08 March 2009, Matthew Garrett wrote:
> On Sun, Mar 08, 2009 at 08:45:59AM +0000, Richard Hughes wrote:
> > On Sat, Mar 7, 2009 at 8:39 PM, Matthew Garrett <mjg@redhat.com> wrote:
> > > We don't have to at all - as far as I've been able to tell, the kernel
> > > is utterly consistent in its current usage. The only drivers that emit
> > > KEY_SLEEP are either embedded-specific (where it's clearly suspend to
> > > RAM and not hibernate), the ACPI driver (where usage in other operating
> > > systems is consistent with it being suspent to RAM) and the panasonic
> > > and thinkpad drivers which use it consistently. If there's any
> > > confusion, it's over the fact that KEY_SUSPEND is is used for suspend to
> > > RAM in a (smaller) number of places.
> > 
> > The fact that we're mapping x->y and y->x is the reason people keep
> > getting it wrong.
> 
> Sure, doing things differently would have made sense several years ago 
> when nobody was relying on this behaviour. We don't have that option now 
> - making this change will break things, and we've got no idea how much 
> it'll break.

Which is a good enough reason to avoid it.

Alternatively, we can add completely new definitions _along_ _with_ the old
ones, mark the old ones as obsolete (after some time) and try to make the
user space start using the new ones only (that may be difficult, though).

I said I liked the names, but I didn't realize that changing them would break
things.

Thanks,
Rafael
