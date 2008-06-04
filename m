From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: [PATCH 2/2] ati_remote2: Add autosuspend support
Date: Wed, 4 Jun 2008 11:20:21 +0300
Message-ID: <20080604082021.GH5067@sci.fi>
References: <1212518747-23000-1-git-send-email-syrjala@sci.fi> <1212518747-23000-2-git-send-email-syrjala@sci.fi> <200806032211.10052.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806032211.10052.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Stokes <linux-2UcvvYt7w9fQXOPxS62xeg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 03, 2008 at 10:11:09PM +0200, Oliver Neukum wrote:
> Am Dienstag 03 Juni 2008 20:45:47 schrieb Ville Syrjala:
> > +static int ati_remote2_open(struct input_dev *idev)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct ati_remote2 *ar2 =3D input_get_drvdata=
(idev);
> > +=A0=A0=A0=A0=A0=A0=A0int r;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0dev_dbg(&ar2->intf[0]->dev, "%s()\n", __FUNCT=
ION__);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0r =3D usb_autopm_get_interface(ar2->intf[0]);
> > +=A0=A0=A0=A0=A0=A0=A0if (r) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(&ar2->intf[0]=
->dev,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0"%s(): usb_autopm_get_interface() =3D %d\n", __FUNCTION__, r);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail1;
> > +=A0=A0=A0=A0=A0=A0=A0}
> > +=A0=A0=A0=A0=A0=A0=A0r =3D usb_autopm_get_interface(ar2->intf[1]);
> > +=A0=A0=A0=A0=A0=A0=A0if (r) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(&ar2->intf[1]=
->dev,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0"%s(): usb_autopm_get_interface() =3D %d\n", __FUNCTION__, r);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto fail2;
> > +=A0=A0=A0=A0=A0=A0=A0}
>=20
> If you have two interfaces on one device upping the count for one of =
them
> is enough.

OK. But now I wonder why do I even bother calling this function. It
doesn't seem to do anything particularly useful.

> > +
> > +=A0=A0=A0=A0=A0=A0=A0mutex_lock(&ati_remote2_mutex);
>=20
> Too late. You can race with disconnect()

Hmm. Do you mean open() vs. disconnect()? Doesn't the input_dev's locki=
ng
take care of that? ati_remote2_mutex is there just to make ar2->flags
handling and urb submitting/killing atomic, it didn't even exist before
this autosuspend patch. Or perhaps I'm missing something...

> And you should set needs_remote_wakeup.

What exactly does that do? As I said remote wakeup isn't enabled on the
device but it still wakes up just fine.

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
