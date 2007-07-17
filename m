From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] appletouch powersaving - please apply for 2.6.23-rc1
Date: Tue, 17 Jul 2007 15:03:44 +0200
Message-ID: <1184677424.3773.87.camel@johannes.berg>
References: <1184656218.14051.43.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ltW17/tmw41IOYBdWxxf"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764342AbXGQNFd@vger.kernel.org>
In-Reply-To: <1184656218.14051.43.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Matthew Garrett <mjg59@srcf.ucam.org>, Nicolas Boichat <nicolas@boichat.ch>, Michael Hanselmann <linux-kernel@hansmi.ch>, Peter Osterlund <petero2@telia.com>, Frank Arnold <frank@scirocco-5v-turbo.de>, Stelian Pop <stelian@popies.net>, Greg Kroah-Hartman <greg@kroah.com>
List-Id: linux-input@vger.kernel.org


--=-ltW17/tmw41IOYBdWxxf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Good stuff :)

> +	int                     idlecount;      /* number of empty packets */

should probably use tabs here.

> +	size =3D usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> +			       ATP_GEYSER3_MODE_WRITE_REQUEST_ID,
> +			       USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
> +			       ATP_GEYSER3_MODE_REQUEST_VALUE,
> +			       ATP_GEYSER3_MODE_REQUEST_INDEX, &data, 8, 5000);
> +	<eol>

trailing whitespace.

=20
> +	input_report_key(dev->input, BTN_LEFT, dev->data[dev->datalen-1] & 1);
> +


> @@ -449,10 +511,19 @@ static void atp_complete(struct urb* urb)
> =20
>  		/* reset the accumulator on release */
>  		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
> -	}
> =20
> -	input_report_key(dev->input, BTN_LEFT,
> -			 !!dev->data[dev->datalen - 1]);

Any hint as to why you move this? The different test, yes, ok, you
explained that, but moving it?

johannes

--=-ltW17/tmw41IOYBdWxxf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGnL4w/ETPhpq3jKURAkBNAJ4piCS61A4pde11xfdb3/JOhxONFACgq0J2
/vet92dmqmBJAScDM999TQE=
=10ID
-----END PGP SIGNATURE-----

--=-ltW17/tmw41IOYBdWxxf--
