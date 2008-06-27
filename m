From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [rft]power management for usbtouch
Date: Sat, 28 Jun 2008 00:28:30 +0300
Message-ID: <20080627212830.GJ19430@sci.fi>
References: <200806261557.19095.oliver@neukum.org> <200806272241.22513.oliver@neukum.org> <20080627205147.GI19430@sci.fi> <200806272257.41319.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:53206 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455AbYF0V2b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Jun 2008 17:28:31 -0400
Content-Disposition: inline
In-Reply-To: <200806272257.41319.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Jun 27, 2008 at 10:57:39PM +0200, Oliver Neukum wrote:
> Am Freitag 27 Juni 2008 22:51:47 schrieben Sie:
> > > > Ah, so it resumes the device even if it was not autosuspended b=
ut
> > > > suspended for another reason?
> > >=20
> > > The other reason is either system wide, in which case nobody can =
call open,
> > > or it is forcibly suspended via sysfs, causing usb_submit_urb() t=
o fail later
> > > on.
> >=20
> > Which will also fail the open() itself. Isn't that bad? That is, yo=
u can
> > suspend an already open device without the users the device noticin=
g
> > but you can't open it if you happen to suspend it at just the right=
 time.
> > That doesn't strike me as good behaviour for a driver.
>=20
> Root can also unbind the driver.

Sure, but in that case the behavior is consistent ie. the device
disappears.

> There is no behavior pleasing everybody.

I would just prefer all drivers of the same subsystem to behave in a
consistent manner. It would even make sense to document the desired
behavior so future driver writers wouldn't have to come up with their
own private rules for such things.

As it stands the open can fail in seemingly random fashion which would
be bad for the users. And my opinion (if it counts) is to allow the ope=
n
to succeed for suspended devices since already opened devices would not
notice the suspend either. I don't think there's any downside to handli=
ng
this issue apart from adding a couple of lines of code.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
