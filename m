From: Matthew Garrett <mjg@redhat.com>
Subject: Re: suspend / hibernate nomenclature
Date: Sun, 8 Mar 2009 14:41:45 +0000
Message-ID: <20090308144145.GB26233@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090307154842.GA3947@srcf.ucam.org> <20090307164151.GB24668@khazad-dum.debian.net> <20090307164840.GA4800@srcf.ucam.org> <15e53e180903071225h47bcdbaj83986b50f06135c3@mail.gmail.com> <20090307203946.GA9942@srcf.ucam.org> <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>
List-Id: linux-input@vger.kernel.org

On Sun, Mar 08, 2009 at 08:45:59AM +0000, Richard Hughes wrote:
> On Sat, Mar 7, 2009 at 8:39 PM, Matthew Garrett <mjg@redhat.com> wrot=
e:
> > We don't have to at all - as far as I've been able to tell, the ker=
nel
> > is utterly consistent in its current usage. The only drivers that e=
mit
> > KEY_SLEEP are either embedded-specific (where it's clearly suspend =
to
> > RAM and not hibernate), the ACPI driver (where usage in other opera=
ting
> > systems is consistent with it being suspent to RAM) and the panason=
ic
> > and thinkpad drivers which use it consistently. If there's any
> > confusion, it's over the fact that KEY_SUSPEND is is used for suspe=
nd to
> > RAM in a (smaller) number of places.
>=20
> The fact that we're mapping x->y and y->x is the reason people keep
> getting it wrong.

Sure, doing things differently would have made sense several years ago=20
when nobody was relying on this behaviour. We don't have that option no=
w=20
- making this change will break things, and we've got no idea how much=20
it'll break.

> > I'd suggest reverting these current patches and doing something lik=
e the
> > following and then changing any drivers where it's worth clarifying
> > things. This has exactly the same effect with the advantage that no
> > userspace needs to be changed.
>=20
> So how do we specify a sleep button where policy is to be decided by
> userspace? For instance, the sleep button on a remote control? Do we
> hardcode policy in the kernel?

Just carry on using KEY_SLEEP for that. We've already got the UI for it=
=2E

> > -#define KEY_SLEEP =A0 =A0 =A0 =A0 =A0 =A0 =A0142 =A0 =A0 /* SC Sys=
tem Sleep */
> > +#define KEY_SUSPEND_TO_RAM =A0 =A0 142 =A0 =A0 /* SC System Sleep =
*/
>=20
> I deliberately avoided using the terms DISK and RAM in the key define=
s
> used in my patch.

Why? This isn't user-visible. The aim is to reduce confusion amongst=20
driver authors, not be consistent with userspace terminology.

> > +/* Deprecated - use KEY_SUSPEND_TO_RAM and KEY_HIBERNATE instead *=
/
> > +#define KEY_SLEEP =A0 =A0 =A0 =A0 =A0 =A0 =A0KEY_SUSPEND_TO_RAM
> > +#define KEY_SUSPEND =A0 =A0 =A0 =A0 =A0 =A0KEY_HIBERNATE
>=20
> Yet more confusion. Can't we sort this mess out once and for all? If
> you're that bothered about userspace using the bodged mappings, I
> would suggest changing my patch so that KEY_SLEEP is 247,
> KEY_HIBERNATE is 205 and KEY_SUSPEND is 142.

No, then the behaviour of userspace would depend on whether it had been=
=20
recompiled or not.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
