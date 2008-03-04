From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 22:32:12 +0200
Message-ID: <20080304203212.GE531@sci.fi>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi> <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz> <20080304134751.GA531@sci.fi> <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz> <20080304184004.GC531@sci.fi> <Pine.LNX.4.64.0803041949560.15209@jikos.suse.cz> <20080304195320.GD531@sci.fi> <Pine.LNX.4.64.0803042126360.15209@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:46829 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933588AbYCDUcN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 15:32:13 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803042126360.15209@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 04, 2008 at 09:28:56PM +0100, Jiri Kosina wrote:
> On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:
>=20
> > > Thanks. So between these two events:
> > > you got autorepeated Key.LeftBtn?
> > I'm not sure actually. I made a new log and tried to actually read =
it=20
> > this time :)
>=20
> Actually, this is the very same issue we discussed with respect to=20
> ati_remote2 changes ... this device has Keyboard usages as well as=20
> Mouse/Pointer. As we set the EV_REP (because of the Keyboard usage), =
this=20
> inputdevice-wide flag applies also to the mouse button events and the=
y get=20
> repeated.

Except this device does actually register two input devices since the
endpoints for the keyboard and mouse are separate, and here it even
makes sense since they are physically separate devices.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
