From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Fri, 03 Jun 2016 14:59:05 +0300
Message-ID: <1464955145.1767.44.camel@linux.intel.com>
References: <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
 <1463149818.17131.349.camel@linux.intel.com>
 <20160513144927.GZ23234@mail.corp.redhat.com>
 <1463155787.17131.351.camel@linux.intel.com>
 <1463156908.17131.353.camel@linux.intel.com>
 <20160520075835.GJ23234@mail.corp.redhat.com>
 <20160531160741.GX23234@mail.corp.redhat.com>
 <1464717399.1767.1.camel@linux.intel.com>
 <20160602141127.GZ23234@mail.corp.redhat.com>
 <1464878415.1767.27.camel@linux.intel.com>
	 <20160603093855.GC6063@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603093855.GC6063@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2016-06-03 at 11:38 +0200, Benjamin Tissoires wrote:
> On Jun 02 2016 or thereabouts, Andy Shevchenko wrote:
> > On Thu, 2016-06-02 at 16:11 +0200, Benjamin Tissoires wrote:
> > > > > > > =C2=A0
> > > On May 31 2016 or thereabouts, Andy Shevchenko wrote:
> > > > On Tue, 2016-05-31 at 18:07 +0200, Benjamin Tissoires wrote:
> > > > > On May 20 2016 or thereabouts, Benjamin Tissoires wrote:
> > > > > > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > > > > > Would you mind sending me a hid-recorder[1] trace of the
> > > > > > device
> > > > > > while
> > > > > > typing few keys and using the touchpad?
> > > > > =C2=A0
> >=20
> > > OK, so it looks like your touchpad stays in the mouse emulation
> > > mode
> > > for
> > > some reasons. Did you do the recordings with hid-multitouch
> > > patched,
> > > or
> > > with plain hid-generic or an other one?
> >=20
> > I take linux-next + your two patches from this thread (+ some
> > unrelated
> > to HID patches).
>=20
> OK. I think I know what happened:
> - Microsoft forgot to put the Win 8 certification blob in this
> =C2=A0 particular device (of course, because Microsoft)
> - we do not detect it as a Win 8 certified and do not set the
> =C2=A0 HID_QUIRK_NO_INIT_REPORTS flag
> - your dmesg should show some error on plug, and then hid can't set
> the
> =C2=A0 input mode
> - I can't add a "if win 8 then show the mouse collection" because you=
r
> =C2=A0 device doesn't report itself as win 8 :)
>=20
> Anyway, could you try applying this small diff after my 2 patches and
> report if you now have a working touchpad?:

Nope. There is still no /dev/input/eventX associated with touchpad.

>=20
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-
> multitouch.c
> index ac35731..e51a753 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -1379,6 +1379,10 @@ static const struct hid_device_id mt_devices[]
> =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0USB_DEVICE_ID_ILITEK_MULTITOUCH) },
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Microsoft */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .driver_data =3D MT_CLS_=
WIN_8,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x07cd) },
> +




--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
