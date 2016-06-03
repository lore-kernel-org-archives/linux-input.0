From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Fri, 3 Jun 2016 11:38:55 +0200
Message-ID: <20160603093855.GC6063@mail.corp.redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46215 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782AbcFCJjA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Jun 2016 05:39:00 -0400
Content-Disposition: inline
In-Reply-To: <1464878415.1767.27.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Jun 02 2016 or thereabouts, Andy Shevchenko wrote:
> On Thu, 2016-06-02 at 16:11 +0200, Benjamin Tissoires wrote:
> > > > > >=C2=A0
> > On May 31 2016 or thereabouts, Andy Shevchenko wrote:
> > > On Tue, 2016-05-31 at 18:07 +0200, Benjamin Tissoires wrote:
> > > > On May 20 2016 or thereabouts, Benjamin Tissoires wrote:
> > > > > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > > > > Would you mind sending me a hid-recorder[1] trace of the devi=
ce
> > > > > while
> > > > > typing few keys and using the touchpad?
> > > >=C2=A0
>=20
> > OK, so it looks like your touchpad stays in the mouse emulation mod=
e
> > for
> > some reasons. Did you do the recordings with hid-multitouch patched=
,
> > or
> > with plain hid-generic or an other one?
>=20
> I take linux-next + your two patches from this thread (+ some unrelat=
ed
> to HID patches).

OK. I think I know what happened:
- Microsoft forgot to put the Win 8 certification blob in this
  particular device (of course, because Microsoft)
- we do not detect it as a Win 8 certified and do not set the
  HID_QUIRK_NO_INIT_REPORTS flag
- your dmesg should show some error on plug, and then hid can't set the
  input mode
- I can't add a "if win 8 then show the mouse collection" because your
  device doesn't report itself as win 8 :)

Anyway, could you try applying this small diff after my 2 patches and
report if you now have a working touchpad?:

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index ac35731..e51a753 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1379,6 +1379,10 @@ static const struct hid_device_id mt_devices[] =3D=
 {
                MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
                        USB_DEVICE_ID_ILITEK_MULTITOUCH) },
=20
+       /* Microsoft */
+       { .driver_data =3D MT_CLS_WIN_8,
+               MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x07cd) },
+
        /* MosArt panels */
        { .driver_data =3D MT_CLS_CONFIDENCE_MINUS_ONE,
                MT_USB_DEVICE(USB_VENDOR_ID_ASUS,

---

Cheers,
Benjamin

>=20
> >=20
> > After further thoughts, I think it should be acceptable to enable t=
he
> > mouse collection for Win 8 certified devices. Touchscreens are not
> > supposed to expose such a mouse emulation, so that would mean that
> > only
> > touchpad will export one.
> >=20
>=20
> > I'll come with a patch by the end of the week (hopefully).
>=20
> Cc me and I will test 'em.
>=20
>=20
> --=20
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
