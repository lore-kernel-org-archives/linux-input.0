From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Mon, 16 Aug 2010 16:03:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008161602410.1019@pobox.suse.cz>
References: <m339wl2ug6.fsf@pullcord.laptop.org> <m3hbiz8m11.fsf@pullcord.laptop.org> <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz> <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr> <m362zd6hzp.fsf_-_@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:53604 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab0HPODC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 10:03:02 -0400
In-Reply-To: <m362zd6hzp.fsf_-_@pullcord.laptop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, tito@bankiz.org

On Fri, 13 Aug 2010, Chris Ball wrote:

>    > has this patch been really tested?
>    >
>    > I am almost certain that we need to have the device ID to be add=
ed to
>    > hid_blacklist[] in drivers/hid/hid-core.c as well. Otherwise the
>    > hid-egalax driver wouldn't bind to the device automatically in a
>    > proper way.
>=20
> Thanks for noticing that; you're right, it's necessary.  I only teste=
d
> CONFIG_HID_EGALAX=3Dy, which doesn't seem to require the blacklist en=
try.
> I've tested that using the blacklist with =3Dm works now.
>=20
> St=C3=A9phane wrote:
>    > My suggestions:
>    >   - accept the patch, after adding a few comments in the code ab=
out
>    > this device requiring future care for its 'serial' protocol.
>    >   - start thinking about what changes are required in hid-input =
and/
>    > or hid-core for a more generic management of multitouch devices.
>=20
> I've added a comment, feel free to reword it if you'd like to.  Thank=
s
> for the excellent research!

Thanks indeed.

I have now applied the patch.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
