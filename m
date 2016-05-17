From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Tue, 17 May 2016 10:23:09 +0200
Message-ID: <20160517082309.GZ29844@pali>
References: <87eg9j6zf7.fsf@smart-cactus.org>
 <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM>
 <87bn45gr0e.fsf@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37287 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbcEQIXN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 04:23:13 -0400
Received: by mail-wm0-f53.google.com with SMTP id a17so16998902wme.0
        for <linux-input@vger.kernel.org>; Tue, 17 May 2016 01:23:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87bn45gr0e.fsf@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: Allen_Hung@Dell.com, Mario_Limonciello@Dell.com, linux-input@vger.kernel.org

On Tuesday 17 May 2016 08:03:45 Ben Gamari wrote:
> Allen_Hung@Dell.com writes:
>=20
> > Dell - Internal Use - Confidential
> > Hi Ben,
> >
> > We have just confirmed the touchpad on Latitude E7470 is a PS/2
> > device, not an I2C-HID input device. The code you listed is common
> > among many Dell products and the value of SDS0 should be provided
> > somewhere (I can't find it out) to specify a PS/2 device.
> >
> Thanks Allen,
>=20
> I rather suspected this; I suppose it's probably hard to find I2C-HID
> hardware that integrates a touchstick. This explains why SDS0 is 0 on=
 my
> hardware.
>=20
> In this case I suppose this is yet another Alps device? I've tried
> bringing it up with all of the recent Alps protocols supported by the
> alps.ko driver but sadly nothing seems to emit multitouch events, so
> it seems likely that there is yet another protocol variant waiting to=
 be
> implemented. Is there any chance you could see whether Alps might now=
 be
> more willing to provide protocol documentation? If not, perhaps there=
's
> a Linux binary driver available?
>=20
> Cheers,
>=20
> - Ben

Hi Ben!

Maybe it could help you, look at my email sent to linux-input ML year
ago: http://thread.gmane.org/gmane.linux.kernel.input/41210

Also try to look at dell drivers page, there could be linux package for
your laptop with drivers. Lot of them used to be in dkms format
(upstream source code with dell changes).

ALPS code from Dell were open source, it was just hard to find it and
compile it on other then one kernel version. And harder to generate
patch (like I did in above email)...

If you need help with ALPS touchpad, I could try to help.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
