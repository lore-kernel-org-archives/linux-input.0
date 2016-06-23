From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Thu, 23 Jun 2016 10:24:06 +0300
Message-ID: <1466666646.30123.248.camel@linux.intel.com>
References: <20160531160741.GX23234@mail.corp.redhat.com>
 <1464717399.1767.1.camel@linux.intel.com>
 <20160602141127.GZ23234@mail.corp.redhat.com>
 <1464878415.1767.27.camel@linux.intel.com>
 <20160603093855.GC6063@mail.corp.redhat.com>
 <1464955145.1767.44.camel@linux.intel.com>
 <20160603122305.GH6063@mail.corp.redhat.com>
 <1464958844.1767.50.camel@linux.intel.com>
 <20160603133224.GI6063@mail.corp.redhat.com>
 <1465821156.30123.12.camel@linux.intel.com>
	 <20160615142813.GA24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2903 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbcFWHYN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 03:24:13 -0400
In-Reply-To: <20160615142813.GA24234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2016-06-15 at 16:28 +0200, Benjamin Tissoires wrote:
> On Jun 13 2016 or thereabouts, Andy Shevchenko wrote:
> > On Fri, 2016-06-03 at 15:32 +0200, Benjamin Tissoires wrote:
> > > On Jun 03 2016 or thereabouts, Andy Shevchenko wrote:
> > > > On Fri, 2016-06-03 at 14:23 +0200, Benjamin Tissoires wrote:
> > > >=20
> > > > > On Jun 03 2016 or thereabouts, Andy Shevchenko wrote:
> > > > > > On Fri, 2016-06-03 at 11:38 +0200, Benjamin Tissoires wrote=
:
> > > > > > > On Jun 02 2016 or thereabouts, Andy Shevchenko wrote:
> > > > > > > > On Thu, 2016-06-02 at 16:11 +0200, Benjamin Tissoires
> > > > > > > > wrote:
> > > >=20
> > > >=20
> > > > > > > > I take linux-next + your two patches from this thread (=
+
> > > > > > > > some
> > > > > > > > unrelated
> > > > > > > > to HID patches).
> > > > > > >=20
> > > > > > > OK. I think I know what happened:
> > > > > > > - Microsoft forgot to put the Win 8 certification blob in
> > > > > > > this
> > > > > > > =C2=A0 particular device (of course, because Microsoft)
> > > > > > > - we do not detect it as a Win 8 certified and do not set
> > > > > > > the
> > > > > > > =C2=A0 HID_QUIRK_NO_INIT_REPORTS flag
> > > > > > > - your dmesg should show some error on plug, and then hid
> > > > > > > can't
> > > > > > > set
> > > > > > > the
> > > > > > > =C2=A0 input mode
> > > > > > > - I can't add a "if win 8 then show the mouse collection"
> > > > > > > because
> > > > > > > your
> > > > > > > =C2=A0 device doesn't report itself as win 8 :)
> > > > > > >=20
> > > > > > > Anyway, could you try applying this small diff after my 2
> > > > > > > patches
> > > > > > > and
> > > > > > > report if you now have a working touchpad?:
> > > > > >=20
> > > > > > Nope. There is still no /dev/input/eventX associated with
> > > > > > touchpad.
> > > > >=20
> > > > > Weird. On my system, if I replay your logs, I see 4 new nodes=
:
> > > > > /dev/input/event21:	Microsoft Surface Keyboard Keyboard
> > > > > /dev/input/event22:	Microsoft Surface Keyboard Consumer
> > > > > Control
> > > > > /dev/input/event23:	Microsoft Surface Keyboard Touchpad
> > > > > /dev/input/event24:	Microsoft Surface Keyboard Keyboard
> > > >=20
> > > > I had a line in dmesg that input8 is allocated to Touchpad, but
> > > > no
> > > > eventX (0..6 IIRC) from /dev/input reflects Touchpad events. I
> > > > can
> > > > get
> > > > them only via /dev/usb/hiddev0.
> > > >=20
> > > > >=20
> > > > > Can you attach the dmesg when plugging in the type cover?
> > > > >=20
> > > >=20
> > > > I will do later, but there is no such thing 'plugging in'. It's
> > > > a
> > > > part
> > > > of the notebook, so, I can do detach-attach cycle, though it
> > > > shouldn't
> > > > matter, it should work immediately after boot I suppose.
> > > >=20
> > >=20
> > > Actually, if the touchpad doesn't want to be set to the multitouc=
h
> > > mode,
> > > we might as well take your v2 of your patch in addition to this
> > > series.
> > > This should hopefully make the caps lock LED happy and at least
> > > enable
> > > the mouse collection. If someone wants to debug why the device
> > > doesn't
> > > want to switch to mt, I'd be happy to help/review patches, but I
> > > think
> > > we might as well take the easiest path :)
> > >=20
> > > So Andy, if you still have the energy for this:
> > > please apply this series and yours
> > > (https://patchwork.kernel.org/patch/9069371/)
> > >=20
> > > And report if this is sufficient enough.
> >=20
> > Attached dmesg and hid-recorder files. Doesn't work. In dmesg it
> > complained on USB transfer at some point during boot.
> >=20
>=20
> Could you please double check your tree? The error in the dmesg can't
> happen if you applied https://patchwork.kernel.org/patch/9069371/
> which
> sets the quirk HID_QUIRK_NO_INIT_REPORTS.
>=20
> In usbhid_start(), we check for this quirk before entering the only
> function that contains the error "timeout initializing reports\n".
> (hiddev has an ioctl that can call it, but I assume you don't have an=
y
> userspace tool calling it, that would be insane).
>=20
> So, your tree should have:
> - latest Jiri's for-next branch (I usually merge it with the latest
> =C2=A0 official rc)
> - https://patchwork.kernel.org/patch/9081731/
> - https://patchwork.kernel.org/patch/9081761/
> - https://patchwork.kernel.org/patch/9069371/

Yes, that's how it looks like.

Actually the branch I'm using is public=C2=A0https://bitbucket.org/andy=
-shev/
linux/branch/topic%2Fdw%2Fqrk


P.S. Let me couple of days I will test once more to be sure.

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
