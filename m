From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: RFC: making the aiptek.c tablet driver xf86-input-wacom
 compatible
Date: Fri, 28 Jun 2013 07:01:32 +1000
Message-ID: <20130627210132.GA12372@yabbi.redhat.com>
References: <1448859.K0oxtlBRpL@pebbles>
 <CAN+gG=FxW40WxY1eSi=UzCKnmPipZ3HZw8sjNPbAgfi0P+D1bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:19049 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab3F0VBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jun 2013 17:01:22 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=FxW40WxY1eSi=UzCKnmPipZ3HZw8sjNPbAgfi0P+D1bw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>, linux-input <linux-input@vger.kernel.org>

On Wed, Jun 26, 2013 at 10:17:30AM +0200, Benjamin Tissoires wrote:
> Hi Stephan,
>=20
> On Wed, Jun 26, 2013 at 12:02 AM, Stefan Br=FCns
> <stefan.bruens@rwth-aachen.de> wrote:
> > Hi everyone,
> >
> > I have started to modify the aiptek tablet driver to be compatible =
with the
> > xf86-input-wacom driver.
> >
> > Motivation:
> > First, as wacom dominates the market, most configuration frontends =
are for
> > wacom, desktop integration only exists for wacom, and most applicat=
ion
> > developers only test with wacom tablets.
> > Second, the xf86-input-aiptek driver seems to be unmaintained, at l=
east
> > opensuse has dropped it from distribution, and xf86-input-evdev is =
no
> > sufficient replacement.
>=20
> Yes the fact is that xf86-input-aiptek is unmaintained due to lack of
> testers with the device. xf86-input-evdev is not a sufficient
> replacement because it aims at forwarding the raw events from the
> kernel without any processing. For tablets, the de facto natural way
> is to use the wacom driver, which should be called now "tablet" but i=
s
> still called "wacom" for historical reasons.

fwiw, wacom is still very much centered around wacom devices. it will w=
ork
from a technical perspective with any tablet but there may be the odd t=
hing
here and there that may look different. we'll have to fix that up as we=
 go
in the X driver, but there are already non-wacom tablets that work fine=
=2E

specifically, test your tablet with libwacom as well (or the GNOME stac=
k) as
this covers parts of the device-specific client stack for tablets.
=20
> > So for me there are two possibilities, either replicating all the w=
ork done
> > for the wacom driver in the xorg stack and above, or just making th=
e the
> > aiptek driver mimic the output of the wacom kernel driver - I have =
taken the
> > second option.
>=20
> thanks for choosing the second solution :) I think Peter will join me
> on this thank you.

yes, indeed. less xorg drivers is the future :)

Cheers,
   Peter

> I just gave a quick look at the xf86-input-aiptek sources, and there
> is nothing which prevents you to port this device to the wacom driver=
=2E
>=20
> >
> > Currently, I am cleaning up my changes, and I am investigating some=
 bugs in
> > the original driver parsing the reports from the device.
>=20
> The device seems to be a HID declared one. I'd be curious to have a
> look at the report descriptors to know if the parsing is really
> necessary. The reports descriptor can be retrieved by calling "lsusb
> -v" when the device is not bound to its usb driver.
>=20
> >
> > I have tested my Aiptek 6000U with the xf86-input-wacom driver, and=
 it is
> > working fine in Krita, Inkscape and The Gimp, configuring the table=
t via
> > kcm_wacomtablet (KDE configuration module).
>=20
> great!
>=20
> >
> > If anyone is interested, I will send my patches to this list after =
the
> > cleanup.
>=20
> I think we are. And I think you will also get some advantages in
> pushing those patches upstream so you will not have to manually
> maintain your own branch :)
>=20
> Cheers,
> Benjamin
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
