From: Oliver Neukum <oliver@neukum.org>
Subject: Re: linux-next: USB mouse won't work after resume.
Date: Wed, 18 Feb 2009 18:06:17 +0100
Message-ID: <200902181806.18622.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0902181150370.17341-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0902181150370.17341-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Laurent Riffard <laurent.riffard@free.fr>, linux-input@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Am Wednesday 18 February 2009 17:51:29 schrieb Alan Stern:
> On Tue, 17 Feb 2009, Oliver Neukum wrote:
>=20
> > Am Tuesday 17 February 2009 14:37:04 schrieb Laurent Riffard:
> > > Le 17.02.2009 11:35, Oliver Neukum a =C3=A9crit :
> > > > Am Tuesday 17 February 2009 10:55:57 schrieb Laurent Riffard:
> > > >> My USB mouse won't work after suspend to disk and resume. I mu=
st unload and reload the ohci_hcd module to get it back.
> > > >=20
> > > > Please recompile your kernel with CONFIG_USB_DEBUG and
> > > > send me your dmesg.
> > > >=20
> > > > 	Regards
> > > > 		Oliver
> > > >=20
> > >=20
> > > Here is it:
> > >=20
> >=20
> > Please try the attached patch.
>=20
> By the way, have you tested to see if the post_reset method needs an=20
> equivalent change?

How could that be? usb_reset_device() refuses to work on a suspended
device.

	Regards
		Oliver
