From: Oliver Neukum <oneukum@suse.de>
Subject: Re: which handlers should bind to a device
Date: Fri, 11 Mar 2011 16:43:45 +0100
Message-ID: <201103111643.45917.oneukum@suse.de>
References: <201103111624.50552.oneukum@suse.de> <1299857944.25856.32.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:32925 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736Ab1CKPnT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 10:43:19 -0500
In-Reply-To: <1299857944.25856.32.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

Am Freitag, 11. M=E4rz 2011, 16:39:02 schrieb Bastien Nocera:
> On Fri, 2011-03-11 at 16:24 +0100, Oliver Neukum wrote:
> > Hi,
> >=20
> > I have a set of USB speakers which also implement HID:
> <snip>
> > According to the Usage Page the device is not a keyboard, yet the k=
eyboard handler
> > binds. Is this really sensible?
> > I: Bus=3D0003 Vendor=3D0471 Product=3D0104 Version=3D0100
> > N: Name=3D"Philips Electronics Philips USB Digital Speaker System"
> > P: Phys=3Dusb-0000:00:1d.0-1/input2
> > S: Sysfs=3D/devices/pci0000:00/0000:00:1d.0/usb6/6-1/6-1:1.2/input/=
input15
> > U: Uniq=3D
> > H: Handlers=3Dkbd event11=20
> > B: PROP=3D0
> > B: EV=3D13
> > B: KEY=3De000000000000 0
> > B: MSC=3D10
>=20
> As long as it's not the only thing that binds. We're just missing ude=
v
> level information to be able to match the audio device and the sound
> device, so that pressing the buttons would change the volume on that
> device. See:
> https://bugzilla.gnome.org/show_bug.cgi?id=3D340720

Well then it would seem than binding to only an event interface should
make things easier for X.

	Regards
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
