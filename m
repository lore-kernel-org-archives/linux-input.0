From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: linux-next: USB mouse won't work after resume.
Date: Tue, 17 Feb 2009 10:12:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902171011240.3195-100000@iolanthe.rowland.org>
References: <499ABD80.9020904@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <499ABD80.9020904@free.fr>
Sender: linux-next-owner@vger.kernel.org
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, 17 Feb 2009, Laurent Riffard wrote:

> Le 17.02.2009 11:35, Oliver Neukum a =C3=A9crit :
> > Am Tuesday 17 February 2009 10:55:57 schrieb Laurent Riffard:
> >> My USB mouse won't work after suspend to disk and resume. I must u=
nload and reload the ohci_hcd module to get it back.
> >=20
> > Please recompile your kernel with CONFIG_USB_DEBUG and
> > send me your dmesg.
> >=20
> > 	Regards
> > 		Oliver
> >=20
>=20
> Here is it:

Maybe there's a bug in the way the HID autosuspend patch cooperates=20
with reset-resume.

Alan Stern
