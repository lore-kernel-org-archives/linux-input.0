From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/3] HID: i2c-hid: Read wMaxInputLength of input report
 instead of bufsize
Date: Tue, 24 Feb 2015 09:05:22 +0200
Message-ID: <20150224070522.GE1758@lahna.fi.intel.com>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
 <1424699565-138045-3-git-send-email-mika.westerberg@linux.intel.com>
 <20150223152630.GE27578@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48472 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbbBXHF1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 02:05:27 -0500
Content-Disposition: inline
In-Reply-To: <20150223152630.GE27578@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 23, 2015 at 10:26:35AM -0500, Benjamin Tissoires wrote:
> On Feb 23 2015 or thereabouts, Mika Westerberg wrote:
> > Wacom digitizer (WCOM0008) on Lenovo Thinkpad 10 seems to allow rea=
ding of
> > subsequent reports (or part of them) if we read more than wMaxInput=
Length
> > of data at the time. This data is not always aligned so that the ne=
xt
> > report would start right after another.
> >=20
> > For example we might get following sequence:
> >=20
> >  i2c_hid i2c-WCOM0008:00: input: 0a 00 02 21 20 17 ad 22 11 03
> >  i2c_hid i2c-WCOM0008:00: input: ad 22 11 03 0a 00 02 21 20 17
> >                                  ad 22 11 03 0a 00 02 21 20 17
> >                                  ad 22 11 03 0a 00 02 21 20 17
> >                                  ad 22 11 03 0a 00 02 21 20 17
> >                                  ad 22 11 03 0a 00 02 21 20 17
> >                                  ad 22 11 03 0a 00 02 21 20 17
> >                                  ad 22 11 03
> >  i2c_hid i2c-WCOM0008:00: input: 02 21 20 17 ad 22 11 03 0a 00
> >                                  02 21 20 17 ad 22 11 03 0a 00
> >                                  02 21 20 17 ad 22 11 03 0a 00
> >                                  02 21 20 17 ad 22 11 03 0a 00
> >                                  02 21 20 17 ad 22 11 03 0a 00
> >                                  02 21 20 17 ad 22 11 03 0a 00
> >                                  02 21 20 17
> >  i2c_hid i2c-WCOM0008:00: i2c_hid_get_input: incomplete report (76/=
8450)
> >=20
> > The bufsize is 76 and wMaxInputLength is 10. In above example the f=
irst
> > read gets right amount of data. The second and third reads get full=
 bufsize
> > (76 bytes) but the report is missing a start already. This causes t=
he
> > driver to reject the report because we got less than was expected b=
y the
> > report length (0x2102 =3D 8450).
> >=20
> > If we read only wMaxInputLength at the time this does not happen at=
 all and
> > the digitizer works fine.
> >=20
> > Based on this change the driver to read wMaxInputLength bytes inste=
ad of
> > bufsize if the value looks sane.
> >=20
> > Reported-by: S=E9bastien Bourdeauducq <sb@m-labs.hk>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
>=20
> We can actually drop this one. Jiri already applied a patch sent last
> week which does the exact same thing:
> https://patchwork.kernel.org/patch/5857521/ (should appear shortly in
> Jiri's tree I guess).

Indeed looks like it does the same. Thanks for letting me know.

> But thanks for confirming that it was really needed for other devices=
=2E

No problem :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
