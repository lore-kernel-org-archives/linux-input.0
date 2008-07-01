From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [rft]power management for usbtouch
Date: Tue, 1 Jul 2008 15:03:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0807011459510.6796-100000@iolanthe.rowland.org>
References: <20080701173937.GA7132@sci.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37761 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754194AbYGATDM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Jul 2008 15:03:12 -0400
In-Reply-To: <20080701173937.GA7132@sci.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, daniel.ritz@gmx.ch, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, 1 Jul 2008, Ville Syrj=E4l=E4 wrote:

> > > That is the thing with the forced suspend - it leaves device out =
of
> > > sync with the rest of the system. If user really does not want to=
 use
> > > the device it should probably be completely disconnected?
> >=20
> > Yes, therefore I suggested doing the logical disconnect.
>=20
> Would the persistence flag affect this? That is would the forced
> suspend cause a reset_resume instead if the driver supports it?

There are only two reasons why a reset-resume might occur:

	A normal resume couldn't be carried out (for example, if
	the USB host controller had to be reset) or failed;

	The RESET_RESUME quirk flag is set for the device.

The first reason doesn't apply if the usb_persist flag isn't set, but=20
the second reason does.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
