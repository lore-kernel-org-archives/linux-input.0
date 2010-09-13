From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HIDDEV: potential NULL dereference
Date: Mon, 13 Sep 2010 17:02:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009131701590.26813@pobox.suse.cz>
References: <4C82419C.3050903@suse.cz> <AANLkTikyW6q3tufYwwX4QEAkV0JGCWcvGr4EJyNGJOpk@mail.gmail.com> <AANLkTik0hZzwKU6QokgA5B7GzWtTDQWxhfog902ZS9XZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52090 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836Ab0IMPCd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 11:02:33 -0400
In-Reply-To: <AANLkTik0hZzwKU6QokgA5B7GzWtTDQWxhfog902ZS9XZ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: anil joshi <anilsjoshi123@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, arnd@arndb.de, =?ISO-8859-15?Q?Peter_J=FAno=A8?= <petoju@gmail.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, markus@trippelsdorf.de

On Thu, 9 Sep 2010, anil joshi wrote:

>=20
>=20
> On Thu, Sep 9, 2010 at 7:59 PM, anil joshi <anilsjoshi123@gmail.com> =
wrote:
>       =A0hid->dev.parent is "usb_interfae" =A0pointer is kfree =A0in =
=A0usb_release_interfece=A0
> hid_to_usb_dev(dev) accessing=A0hid->dev.parent=A0
>=20
> I have tested this,while=A0removing=A0 hid device =A0
>=20
> usb_release_interfece is belonging to=A0khubd =A0process=A0
>=20
> I get many use full information =A0from =A0Jiri Kosina,=A0Markus Trip=
pelsdorf,=A0regarding this issue
> from=A0http://kerneltrap.org/mailarchive/linux-kernel/2010/8/12/46061=
55/thread#mid-4606155
>=20
> To=A0avoid=A0=A0NULL deference problem=A0
>=20
> hiddev->exist is zero before usb_deregister_dev =A0call in =A0hiddev_=
disconnected =A0function there fore
> we could use
> static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigne=
d long arg)
> {
>=20
>=20
> =A0=A0 =A0 if (hiddev->exist) {
> =A0=A0 =A0 =A0 =A0=A0hid_to_usb_dev(dev);
> =A0=A0 =A0 =A0 } else {
> =A0=A0 =A0 =A0 =A0 =A0 =A0return -EIO
> =A0=A0 }
>=20
>=20
> Thanks to=A0Markus Trippelsdorf=A0, Jiri Kosina=A0

Hi Anil,

could you please send a proper patch (diff against current kernel) and =
a=20
short changelog entry with the explanation, so that I could easily=20
understand what you are proposing?

Thanks!

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
