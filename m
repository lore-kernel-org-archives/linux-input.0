From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [rft]power management for usbtouch
Date: Sat, 28 Jun 2008 12:52:38 +0200
Message-ID: <200806281252.39386.oliver@neukum.org>
References: <200806261557.19095.oliver@neukum.org> <200806272257.41319.oliver@neukum.org> <20080627212830.GJ19430@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:55492 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbYF1KwL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2008 06:52:11 -0400
In-Reply-To: <20080627212830.GJ19430@sci.fi>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: daniel.ritz@gmx.ch, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Freitag 27 Juni 2008 23:28:30 schrieb Ville Syrj=E4l=E4:
> > > Which will also fail the open() itself. Isn't that bad? That is, =
you can
> > > suspend an already open device without the users the device notic=
ing
> > > but you can't open it if you happen to suspend it at just the rig=
ht time.
> > > That doesn't strike me as good behaviour for a driver.
> >=20
> > Root can also unbind the driver.
>=20
> Sure, but in that case the behavior is consistent ie. the device
> disappears.

Sorry, I chose a bad example. Root can do stupid things like sending
control requests that change the configuration, setting or address of
a device. The effects are undefined and will differ from driver to driv=
er
and open or closedness.
=46orcibly suspending a device is a testing feature. If root abuses it,
he'll have to take the consequences.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
