From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: byd - use DMI detection
Date: Sat, 12 Nov 2016 16:04:42 +0100
Message-ID: <201611121604.43032@pali>
References: <20161111235759.11988-1-chris@diamand.org> <58270744.cf3fc20a.1e77d.30f0@mx.google.com> <20161112144814.wt3yct4iztil6a3e@peridot.local.diamand.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2048912.FgdCuZeYRM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36573 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965837AbcKLPFB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 12 Nov 2016 10:05:01 -0500
Received: by mail-wm0-f48.google.com with SMTP id g23so26734360wme.1
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 07:04:45 -0800 (PST)
In-Reply-To: <20161112144814.wt3yct4iztil6a3e@peridot.local.diamand.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Diamand <chris@diamand.org>
Cc: Richard Pospesel <pospeselr@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

--nextPart2048912.FgdCuZeYRM
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 12 November 2016 15:48:14 Chris Diamand wrote:
> Hi, and thanks for your reply.
>=20
> > Hi! This looks very fragile. We really cannot test presence of some
> > device by DMI string "To Be Filled By O.E.M." or by "WhiteTip
> > Mountain1 Fab2". Look at other dmi detection code. We match full
> > device and vendor.
>=20
> Do you think it's likely to match too many or too few machines? I can
> match the device and vendor instead, but I think that would have
> more false positives (DMI_SYS_VENDOR and DMI_PRODUCT_NAME are "Intel
> Corporation" and "Sharkbay Platform").
>=20
> Here are all the DMI fields we can use, with their values on my
> (former) BYD machine. As you can see, none of them are particularly
> helpful. However, I *hope* that most other manufacturers fill them
> in, so I'd be surprised if there are many false positives.
>=20
> DMI_BIOS_VENDOR: American Megatrends Inc.
> DMI_BIOS_VERSION: 5.6.5
> DMI_BIOS_DATE: 06/30/2015
> DMI_SYS_VENDOR: Intel Corporation
> DMI_PRODUCT_NAME: Sharkbay Platform
> DMI_PRODUCT_VERSION: 0.1
> DMI_PRODUCT_SERIAL: System Serial Number
> DMI_PRODUCT_UUID: 03000200-0400-0500-0006-000700080009
> DMI_BOARD_VENDOR: Topstar
> DMI_BOARD_NAME: WhiteTip Mountain1 Fab2
> DMI_BOARD_VERSION: Fab2
> DMI_BOARD_SERIAL: 1
> DMI_BOARD_ASSET_TAG: Base Board Asset Tag
> DMI_CHASSIS_VENDOR: To Be Filled By O.E.M.
> DMI_CHASSIS_TYPE: Laptop
> DMI_CHASSIS_VERSION: To Be Filled By O.E.M.
> DMI_CHASSIS_SERIAL: To Be Filled By O.E.M.
> DMI_CHASSIS_ASSET_TAG: To Be Filled By O.E.M.

Sorry, but this DMI information does not tell anything about presense of=20
BYD touchpad. Moreover such generic matches like "Sharkbay Platform" or=20
"To Be Filled By O.E.M." can be found on any other non-BYD touchpad=20
devices and it just cause lot of other problems... Also what about=20
devices which do not have "To Be Filled By O.E.M." and have BYD=20
touchpad? You basically break support for such devices. I'm sure such=20
logic just cause problems in future...

How is windows detecting presence of BYD touchpads? Should we use=20
something similar? Or are not there some (public) documentation about=20
it?

> > If we really have a problem when byd detect incorrect detect some
> > non-byd device as byd, we either needs:
> >=20
> > 1) extend detect code to include also parts of init sequence (this
> > should
> >=20
> >    fix problem on wrongly detected non-byd devices, but init code
> >    on them will take longer)
>=20
> I agree. What I am trying to achieve with this patch is to fix 99% of
> cases where we wrongly detect a non-BYD device.

Still I think this is just ugly and non-working hack, not a proper=20
solution. But I'm not in position to decide, so wait what will Dmitry=20
(as maintainer) wrote about it...

> There may still be a
> few false positives, but for those we can apply Richard's patch,
> which moves the whole init sequence to byd_detect().
> http://www.spinics.net/lists/linux-input/msg45539.html
>=20
> This will slow down detection of normal mice, but if my DMI patch is
> also applied, it will only affect a tiny fraction of users.

Maybe you should check if there is device or port DMI information?=20
dmidecode will print it, but I sceptic about it...

> Also, Richard's patch would fix the even rarer case of someone trying
> to use a mis-detected mouse on an actual BYD device.

I would prefer slower, but correct detection. Not just some nonsense=20
heuristic based on "To Be Filled By O.E.M.".

> > 2) or use another detection technique, which will address above
> > problem (
> >=20
> >    your "To Be Filled By O.E.M." is not good; maybe looking at
> >    ACPI?)
>=20
> That could also work, but I wouldn't be able to write such a patch as
> I no longer have access to the device.

Then we need acpi DSDT dumps from those machines... And check if acpi=20
based enumeration is more useful or not...

> Anyway, in summary; the ideal solution seems to be DMI matching +
> extended detection sequence - this patch is the first part.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2048912.FgdCuZeYRM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlgnL4sACgkQi/DJPQPkQ1IgCACfZJEL1APYmmbyQaXofPe9Xkc2
1AsAoJFjvmviIsV2JA3rJO128O/7mvsA
=AjlU
-----END PGP SIGNATURE-----

--nextPart2048912.FgdCuZeYRM--
