From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] Fwd:  autosuspend for appletouch driver
Date: Thu, 27 Sep 2007 20:43:50 +0200
Message-ID: <200709272043.51904.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0709271436240.7735-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.44L0.0709271436240.7735-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Richard Guenther <rguenther@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Soeren Sonnenburg <kernel@nn7.de>, Thomas Rohwer <tr@tng.de>
List-Id: linux-input@vger.kernel.org

Am Donnerstag 27 September 2007 schrieb Alan Stern:
> > mechanism the same way the version for generic hid does. In fact, it is
> > only necessary because there's no nice API call for setting
> > needs_remote_wakeup.
>=20
> That's okay; even if there were a nice API call for setting=20
> needs_remote_wakeup you would still have to call
> usb_autopm_get_interface(). =A0This is because we don't keep track of=20
> whether or not remote wakeup is currently enabled on a suspended

Is it worth doing so?

	Regards
		Oliver
