From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: Re: QUANTA touchscreen controller integrated in HP2310ti no longer recognised (regression in 3.5 and later as compared to 3.3)
Date: Wed, 22 Aug 2012 10:40:48 +0100
Message-ID: <4162927.yOU3A7SJAr@f17simon>
References: <1700293.Y8yBuPUG33@f17simon> <20120821190626.GA1260@polaris.bitmath.org> <2303254.RzNp9y400f@f17simon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1873465.y5ja55cG0p"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp03.uk.clara.net ([195.8.89.36]:44888 "EHLO
	claranet-outbound-smtp03.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758775Ab2HVJk6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 05:40:58 -0400
In-Reply-To: <2303254.RzNp9y400f@f17simon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>


--nextPart1873465.y5ja55cG0p
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 22 August 2012 10:00:12 Simon Farnsworth wrote:
> On Tuesday 21 August 2012 21:06:26 Henrik Rydberg wrote:
> > Hi Simon,
> > 
> > > We're going through our collection of touch screens, making sure that they all 
> > > work with current kernels, and we've found one that doesn't work with today's 
> > > Linus master.
> > > 
> > > lsusb describes the screen as:
> > > Bus 006 Device 002: ID 0408:3001 Quanta Computer, Inc. Optical Touch Screen
> > 
> > What about 0408:3008, does that one work?
> > 
> I don't have a sample of 0408:3008 to try.
> 
> > > Any ideas on the best way to resolve this regression?
> > 
> > What does 'cat /sys/bus/hid/devices/0003:0408:3001.0001/modalias' say?
> 
> It's the same whether or not I revert the patch:
> 
> # cat /sys/bus/hid/devices/0003:0408:3001.0001/modalias
> hid:b0003g0000v00000408p00003001
> 
A look at the code said that the only way this could happen is if
hid_have_special_driver is set for this device, and no special driver claimed
it.

I've confirmed this by setting hid.ignore_special_devices to 1; it then works
unpatched.

The entry in the table is:

	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },

This matches the device I have, and causes the problem behaviour.

It looks like the right thing to do is to audit the hid_have_special_driver
table, and confirm that there is an in-kernel special driver for every device
that has an entry.
-- 
Simon Farnsworth
Software Engineer
ONELAN Ltd
http://www.onelan.com

--nextPart1873465.y5ja55cG0p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAABAgAGBQJQNKklAAoJEIKsye9/dtRW60sH/R3OS5Dytch3JC/18fLoWrpI
8TPPOfWywgm3ntatbvPKY72tw/MBhW/W0UewG0TSdxJjcxiIX1XVu43UFhA1/ngZ
wXUe4nvDJTAySiJSThnk7NZmFYOqg0RoyaJ6IpZ85ukSJ4mKPEWRdo506uoPFogx
M3H2UrgHOaOgB7DaOMjNhoWHEhzlgb6jDj0ptkfKR/8IvJf12kV0b9XGPvf98Mww
/+DcpLW4KVXrc3mjeWTzD8PHvvl1ZZ8nlljMq6ebWhxsnNgu6BkzS33Ql6r+9LhJ
l0HP14jyLURA86RTAX9ZJVEbBwKw3UR04GEN3Yr6EJIV0/zxjis18YFitW9T7KQ=
=UDAB
-----END PGP SIGNATURE-----

--nextPart1873465.y5ja55cG0p--

