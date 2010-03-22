From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 1/6] hid: new driver for PicoLCD device
Date: Mon, 22 Mar 2010 09:54:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003220951440.18642@pobox.suse.cz>
References: <20100320170014.440959a8@neptune.home> <20100320170241.55258b0d@neptune.home> <20100321034600.GE29360@core.coreip.homeip.net> <20100321173737.5fcf3580@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:43699 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753656Ab0CVIyT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Mar 2010 04:54:19 -0400
In-Reply-To: <20100321173737.5fcf3580@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

On Sun, 21 Mar 2010, Bruno Pr=E9mont wrote:

> > > +	}
> > > +	data->status |=3D PICOLCD_BUSY;
> > > +	data->pending =3D work;
> > > +	for (i =3D k =3D 0; i < report->maxfield; i++)
> > > +		for (j =3D 0; j < report->field[i]->report_count; j++) {
> > > +			hid_set_field(report->field[i], j, k < size ? raw_data[k] : 0=
);
> > > +			k++;
> > > +		}
> > > +	usbhid_submit_report(data->hdev, report, USB_DIR_OUT);
> > > +	complete_all(&data->ready);
> > > +	INIT_COMPLETION(data->ready);
> >=20
> > Umm, what does this do, exactly?
> >
> It wakes up anyone waiting on the completion and then resets the comp=
letion
> as otherwise any future attempt to wait on it would succeed immediate=
ly.
>=20
> The complete_all() instead of just complete() comes from the reset() =
function.
> I can probably reduce it here.
>=20
> Will check this combined with your mutex suggestion above.

I am afraid this code is racy as is. You can't be sure that whoever has=
=20
been waiting on the completion has been notified already between=20
complete_all() and INIT_COMPLETION(), can you?

Thanks for the driver!

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
