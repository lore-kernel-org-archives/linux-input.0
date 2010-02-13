From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: S2R resume crash in 2.6.33-rc7 - NULL pointer dereference in
 dev_get_drvdata() for usbhid
Date: Sat, 13 Feb 2010 19:36:09 +0100
Message-ID: <20100213193609.3337b3f0@neptune.home>
References: <20100213135720.603e5f64@neptune.home>
	<Pine.LNX.4.44L0.1002131238580.23844-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppp-157-177.adsl.restena.lu ([158.64.157.177]:48439 "EHLO
	bonbons.gotdns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab0BMSgk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Feb 2010 13:36:40 -0500
In-Reply-To: <Pine.LNX.4.44L0.1002131238580.23844-100000@netrider.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, Oliver Neukum <oliver@neukum.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Marcel Holtmann <marcel@holtmann.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 13 February 2010 Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, 13 Feb 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:
>=20
> > On Mon, 08 February 2010 Alan Stern <stern@rowland.harvard.edu>
> > wrote:
> > > Clearly something is setting usbhid->intf to NULL.  But I don't
> > > see any code that would do it.  You may have to resort to putting
> > > printk() statements at various strategic places to find out where
> > > it happens. You could start with the beginnings and ends of
> > > hid_suspend, hid_resume, and hid_reset_resume.  Maybe also
> > > usbhid_disconnect(), just in case.
> >=20
> > I did add a few printk()s and WARN_ON()s to get a better idea of
> > why/when usbhid->intf is NULL and it is already since probe time of
> > the second interface anounced by the USB keyboard (hid.debug=3D1):
>=20
> ...
>=20
> > This lets me guess that hid_add_device() is doing something wrong
> > here when report parsing fails... (as that one is the only one whic=
h
> > could be doing the initialization of usbhid which does work for the
> > first interface announced by my keyboard)
>=20
> I don't know about doing anything wrong...  However it does appear
> that in this case the interface is registered on the HID bus but
> doesn't get bound to a driver.  Jiri will know whether or not that's
> the desired outcome.
>=20
> On the other hand, I don't think there would be anything wrong with=20
> moving the
>=20
> 	usbhid->intf =3D intf;
> 	usbhid->ifnum =3D interface->desc.bInterfaceNumber;
>=20
> lines from usbhid_start() to usbhid_probe(), just before the call to
> hid_add_device().  It should fix the bug, and those lines do belong i=
n
> the probe routine.  Jiri, any problems with doing this?

With the below patch (which is only half of the move work) I don't
get crashes anymore. Though I wonder if other initialization steps
(like the spin_lock_init() right before setting usbhid->intf) would
need to be moved as well.

Bruno

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
index e2997a8..690ca75 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1154,6 +1154,8 @@ static int usbhid_probe(struct usb_interface *int=
f, const struct usb_device_id *
=20
 	hid->driver_data =3D usbhid;
 	usbhid->hid =3D hid;
+	usbhid->intf =3D intf;
+	usbhid->ifnum =3D interface->desc.bInterfaceNumber;
=20
 	ret =3D hid_add_device(hid);
 	if (ret) {
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
