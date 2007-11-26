From: Pascal Terjan <pterjan@mandriva.com>
Subject: Re: [Linuxwacom-devel] [PATCH] Use hid blacklist in usbmouse/usbkbd
Date: Mon, 26 Nov 2007 13:46:14 +0100
Message-ID: <1196081174.12642.13.camel@plop>
References: <1196074688.12642.10.camel@plop>
	 <20071126111328.GA9235@homer.shelbyville.oz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ryu.zarb.org ([212.85.153.228]:35916 "EHLO ryu.zarb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbXKZMqW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2007 07:46:22 -0500
In-Reply-To: <20071126111328.GA9235@homer.shelbyville.oz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ron <ron@debian.org>
Cc: linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net


On lun, 2007-11-26 at 21:43 +1030, Ron wrote:
> Hi Pascal,
>=20
> There is a less intrusive way to handle this for any reasonably moder=
n
> 2.6 kernel...  see the check_driver script in the Debian package.
>=20
> It's called from udev when the device is plugged and if it is a wacom
> tablet, it will repossess it from any other driver and bind it to the
> wacom one.
>=20
> We had a more brutal hack that did this for 2.4 too, but this method
> is I believe the recommended one now (or at least supported without
> further kernel patching since about 2.6.13-ish).

Yes this can be workarounded in userspace, but why having a blacklist i=
n
HID if the individual usbhid drivers still take the device ? And why
having a driver to handle a device when a better one exists ?

--=20
Pascal Terjan
Ing=E9nieur Conseil
Mandriva (ex Mandrakesoft)
Tel +33 (0) 1 40 41 17 51 - Fax +33 (0) 1 40 41 92 00

-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
