From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Wed, 4 Jun 2008 10:32:57 +0200
Message-ID: <200806041032.58237.oliver@neukum.org>
References: <1212518747-23000-1-git-send-email-syrjala@sci.fi> <200806032211.10052.oliver@neukum.org> <20080604082021.GH5067@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:56453 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbYFDIcr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jun 2008 04:32:47 -0400
In-Reply-To: <20080604082021.GH5067@sci.fi>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Peter Stokes <linux@dadeos.co.uk>

Am Mittwoch 04 Juni 2008 10:20:21 schrieb Ville Syrj=E4l=E4:
> On Tue, Jun 03, 2008 at 10:11:09PM +0200, Oliver Neukum wrote:
> > Am Dienstag 03 Juni 2008 20:45:47 schrieb Ville Syrjala:
> > > +static int ati_remote2_open(struct input_dev *idev)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0struct ati_remote2 *ar2 =3D input_get_drvda=
ta(idev);
> > > +=A0=A0=A0=A0=A0=A0=A0int r;
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUN=
CTION__);
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0r =3D usb_autopm_get_interface(ar2->intf[0]=
);
> > > +=A0=A0=A0=A0=A0=A0=A0if (r) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(&ar2->intf[=
0]->dev,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0"%s(): usb_autopm_get_interface() =3D %d\n", __FUNCTION__, r);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail1;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> > > +=A0=A0=A0=A0=A0=A0=A0r =3D usb_autopm_get_interface(ar2->intf[1]=
);
> > > +=A0=A0=A0=A0=A0=A0=A0if (r) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(&ar2->intf[=
1]->dev,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0"%s(): usb_autopm_get_interface() =3D %d\n", __FUNCTION__, r);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail2;
> > > +=A0=A0=A0=A0=A0=A0=A0}
> >=20
> > If you have two interfaces on one device upping the count for one o=
f them
> > is enough.
>=20
> OK. But now I wonder why do I even bother calling this function. It
> doesn't seem to do anything particularly useful.

You call it for two reasons

1. To safely enable remote wakeup
2. To make sure the device starts out awake

> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0mutex_lock(&ati_remote2_mutex);
> >=20
> > Too late. You can race with disconnect()
>=20
> Hmm. Do you mean open() vs. disconnect()? Doesn't the input_dev's loc=
king
> take care of that? ati_remote2_mutex is there just to make ar2->flags
> handling and urb submitting/killing atomic, it didn't even exist befo=
re
> this autosuspend patch. Or perhaps I'm missing something...

Hm. Anybody on the list an expert on locking in the input layer?

> > And you should set needs_remote_wakeup.
>=20
> What exactly does that do? As I said remote wakeup isn't enabled on t=
he
> device but it still wakes up just fine.

Strictly speaking, it shouldn't. We should do it correctly to
a) make sure it works with all versions
b) make sure it can handle the command correctly

	Regards
		Oliver


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
