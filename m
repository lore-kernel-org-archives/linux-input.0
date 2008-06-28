From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [rft]power management for usbtouch
Date: Sat, 28 Jun 2008 14:22:58 +0300
Message-ID: <20080628112258.GK19430@sci.fi>
References: <200806261557.19095.oliver@neukum.org> <200806272257.41319.oliver@neukum.org> <20080627212830.GJ19430@sci.fi> <200806281252.39386.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:60241 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265AbYF1LXC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2008 07:23:02 -0400
Content-Disposition: inline
In-Reply-To: <200806281252.39386.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Jun 28, 2008 at 12:52:38PM +0200, Oliver Neukum wrote:
> Am Freitag 27 Juni 2008 23:28:30 schrieb Ville Syrj=E4l=E4:
> > > > Which will also fail the open() itself. Isn't that bad? That is=
, you can
> > > > suspend an already open device without the users the device not=
icing
> > > > but you can't open it if you happen to suspend it at just the r=
ight time.
> > > > That doesn't strike me as good behaviour for a driver.
> > >=20
> > > Root can also unbind the driver.
> >=20
> > Sure, but in that case the behavior is consistent ie. the device
> > disappears.
>=20
> Sorry, I chose a bad example. Root can do stupid things like sending
> control requests that change the configuration, setting or address of
> a device. The effects are undefined and will differ from driver to dr=
iver
> and open or closedness.
> Forcibly suspending a device is a testing feature. If root abuses it,
> he'll have to take the consequences.

Typically when you're testing something you expect a certain result. Th=
e
code as it stands adds another very subtle failure point.

I don't quite understand why you're so against handling this issue.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
