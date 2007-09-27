From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Fwd:  autosuspend for appletouch driver
Date: Thu, 27 Sep 2007 14:54:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0709271453010.7735-100000@iolanthe.rowland.org>
References: <200709272043.51904.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200709272043.51904.oliver@neukum.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Richard Guenther <rguenther@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Soeren Sonnenburg <kernel@nn7.de>, Thomas Rohwer <tr@tng.de>
List-Id: linux-input@vger.kernel.org

On Thu, 27 Sep 2007, Oliver Neukum wrote:

> Am Donnerstag 27 September 2007 schrieb Alan Stern:
> > > mechanism the same way the version for generic hid does. In fact, i=
t is
> > > only necessary because there's no nice API call for setting
> > > needs_remote_wakeup.
> >=20
> > That's okay; even if there were a nice API call for setting=20
> > needs_remote_wakeup you would still have to call
> > usb_autopm_get_interface(). =A0This is because we don't keep track of=
=20
> > whether or not remote wakeup is currently enabled on a suspended
>=20
> Is it worth doing so?

If enough drivers need it.  ("Enough" might mean >=3D 1.)

Alan Stern
