From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ati_remote2 autorepeat and loadable keymap support
Date: Tue, 4 Mar 2008 16:07:07 +0200
Message-ID: <20080304140707.GB531@sci.fi>
References: <200802161622.43223.linux@dadeos.co.uk> <20080304124715.GK8473@sci.fi> <Pine.LNX.4.64.0803041412240.18589@twin.jikos.cz> <20080304134751.GA531@sci.fi> <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:50405 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbYCDOHJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Mar 2008 09:07:09 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0803041457200.15209@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Peter Stokes <linux@dadeos.co.uk>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 04, 2008 at 03:01:44PM +0100, Jiri Kosina wrote:
> On Tue, 4 Mar 2008, Ville Syrj=E4l=E4 wrote:
>=20
> > > I don't seem to see you in MAINTAINERS entry, so that's probably =
why you=20
> > > didn't receive confirmation when Andrew has put this patch into -=
mm.
> > I guess MODULE_AUTHOR() isn't enough then. I'll send a patch for
> > MAINTAINERS.
>=20
> I don't know the exact algorithm Andrew uses to send out CCs when pat=
ch is=20
> merged, but MAINTAINERS entry would definitely help.
>=20
> > Hmm. IIRC I had one USB mouse which also sent repeat events and the=
=20
> > driver didn't seem to filter them out which is why I added checks t=
o=20
> > DirectFB's input driver to filter them in user space. Was that a bu=
g in=20
> > the usbhid driver or does it depend on the actual hardware? I still=
 have=20
> > that mouse so I can re-test the behavior if needed.=20
>=20
> Button events from mice definitely shouldn't be auto-repeated, if the=
y are=20
> reported probably by the hardware (i.e. HID_UP_BUTTON usage page,=20
> MOUSE/POINTER application).
>=20
> If you could recompile your kernel with CONFIG_HID_DEBUG, modprobe th=
e=20
> 'hid' module with 'debug=3D1' parameter, and send me the output that =
appears=20
> in kernel log when you press (and hold) the button, I will look into =
it.

I'll do that tonight.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
