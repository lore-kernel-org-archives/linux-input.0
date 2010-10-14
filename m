From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [RFC, PATCH] HID: hid-sony, override usbhid_output_raw_report
 for Sixaxis
Date: Thu, 14 Oct 2010 09:48:40 +0200
Message-ID: <20101014094840.e215ef88.ospite@studenti.unina.it>
References: <4CB62F69.1070809@signal11.us>
	<1287010481-8356-1-git-send-email-ospite@studenti.unina.it>
	<4CB63F88.9080300@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__14_Oct_2010_09_48_40_+0200_FV2Z207xHaExLZtL"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:35916 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807Ab0JNHsy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 03:48:54 -0400
In-Reply-To: <4CB63F88.9080300@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, falktx@gmail.com

--Signature=_Thu__14_Oct_2010_09_48_40_+0200_FV2Z207xHaExLZtL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Oct 2010 19:23:52 -0400
Alan Ott <alan@signal11.us> wrote:

> On 10/13/2010 06:54 PM, Antonio Ospite wrote:
> > Sony Sixaxis wants output reports on the control endpoint rather than
> > interrupt endpoint, so override usbhid_output_raw_report in order to
> > force this behaviour.
> >
> > Signed-off-by: Antonio Ospite<ospite@studenti.unina.it>
> > ---
[...]
> > +static int sixaxis_usb_output_raw_report(struct hid_device *hid, __u8 =
*buf,
> > +		size_t count, unsigned char report_type)
> > +{
> > +	struct usb_interface *intf =3D to_usb_interface(hid->dev.parent);
> > +	struct usb_device *dev =3D interface_to_usbdev(intf);
> > +	struct usb_host_interface *interface =3D intf->cur_altsetting;
> > +
> > +	int ret;
> > +	int skipped_report_id =3D 0;
> > +	int report_id =3D buf[0];
> > +
> > +	printk(KERN_DEBUG "%s: Overriding usbhid_output_raw_report\n", __func=
__);
> > +
> > +	if (buf[0] =3D=3D 0x0) {
> > +		/* Don't send the Report ID */
> > +		buf++;
> > +		count--;
> > +		skipped_report_id =3D 1;
> > +	}
> > +	ret =3D usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
> > +		HID_REQ_SET_REPORT,
> > +		USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> > +		((report_type + 1)<<  8) | report_id,
> > +		interface->desc.bInterfaceNumber, buf, count,
> > +		USB_CTRL_SET_TIMEOUT);
> > +	/* count also the report id, if this was a numbered report. */
> > +	if (ret>  0&&  skipped_report_id)
> > +		ret++;
> > +
> > +	return ret;
> > +}
> > +
[...]  =20
>=20
> I think as far as code duplication goes, you can get rid of the=20
> skipped_report stuff and the buf[0] =3D 0x0 section (since you _know_ the=
=20
> sixaxis uses numbered reports). Once you've done that, you're basically=20
> down to one function call.
>

That's right thanks a lot.

> I think maybe I'm confused a bit. Is this patch against Jiri's hid tree=20
> in the for-next branch[1]? If so is there another patch which is=20
> required for this to make sense (I looked in linux-input, but didn't see=
=20
> any appropriate ones)? In Jiri's tree, sixaxis_set_operational_usb()=20
> already calls usb_control_msg() instead of hid_output_raw_report(), so I=
=20
> clearly must be looking at the wrong thing. Please help me understand=20
> what I'm supposed to be looking at.
>

I am working on linus tree with some patches applied, namely your
hidraw feature report patches and this one from Jiri's hid/for-next
branch:
http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dcommit;h=3D81=
6651a7d4a32664261e5f9f88ad0d558faed4cc

The point about overriding hid_output_raw_report() is not about
sixaxis_set_operational_usb() sending a control message, but about any
_output_ (not feature) report the user would like to send via
hidraw_write(), the sixaxis will accept those only if sent on the
control endpoint (it will discard them if sent on the interrupt ep,
like the current usbhid code does) maybe I didn't state that clearly,
sorry.

About sixaxis_set_operational_usb(), I don't remember _any_ change to
it except its name, but I guess we can very well make it call
hid_output_raw_report(), just only after your hidraw feature report
patches land to mainline.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__14_Oct_2010_09_48_40_+0200_FV2Z207xHaExLZtL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky2tdgACgkQ5xr2akVTsAEIKQCfZG1e+gztN2vvvExfef9ECuLS
ItIAn2U9QwHw6/+v8RmD3MBxOAlx0EK9
=dAAx
-----END PGP SIGNATURE-----

--Signature=_Thu__14_Oct_2010_09_48_40_+0200_FV2Z207xHaExLZtL--
