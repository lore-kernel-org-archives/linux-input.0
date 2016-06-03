From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Fri, 03 Jun 2016 16:00:44 +0300
Message-ID: <1464958844.1767.50.camel@linux.intel.com>
References: <20160513144927.GZ23234@mail.corp.redhat.com>
 <1463155787.17131.351.camel@linux.intel.com>
 <1463156908.17131.353.camel@linux.intel.com>
 <20160520075835.GJ23234@mail.corp.redhat.com>
 <20160531160741.GX23234@mail.corp.redhat.com>
 <1464717399.1767.1.camel@linux.intel.com>
 <20160602141127.GZ23234@mail.corp.redhat.com>
 <1464878415.1767.27.camel@linux.intel.com>
 <20160603093855.GC6063@mail.corp.redhat.com>
 <1464955145.1767.44.camel@linux.intel.com>
	 <20160603122305.GH6063@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64478 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbcFCM73 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Jun 2016 08:59:29 -0400
In-Reply-To: <20160603122305.GH6063@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2016-06-03 at 14:23 +0200, Benjamin Tissoires wrote:

> On Jun 03 2016 or thereabouts, Andy Shevchenko wrote:
> > On Fri, 2016-06-03 at 11:38 +0200, Benjamin Tissoires wrote:
> > > On Jun 02 2016 or thereabouts, Andy Shevchenko wrote:
> > > > On Thu, 2016-06-02 at 16:11 +0200, Benjamin Tissoires wrote:


> > > > I take linux-next + your two patches from this thread (+ some
> > > > unrelated
> > > > to HID patches).
> > >=20
> > > OK. I think I know what happened:
> > > - Microsoft forgot to put the Win 8 certification blob in this
> > > =C2=A0 particular device (of course, because Microsoft)
> > > - we do not detect it as a Win 8 certified and do not set the
> > > =C2=A0 HID_QUIRK_NO_INIT_REPORTS flag
> > > - your dmesg should show some error on plug, and then hid can't
> > > set
> > > the
> > > =C2=A0 input mode
> > > - I can't add a "if win 8 then show the mouse collection" because
> > > your
> > > =C2=A0 device doesn't report itself as win 8 :)
> > >=20
> > > Anyway, could you try applying this small diff after my 2 patches
> > > and
> > > report if you now have a working touchpad?:
> >=20
> > Nope. There is still no /dev/input/eventX associated with touchpad.
>=20
> Weird. On my system, if I replay your logs, I see 4 new nodes:
> /dev/input/event21:	Microsoft Surface Keyboard Keyboard
> /dev/input/event22:	Microsoft Surface Keyboard Consumer Control
> /dev/input/event23:	Microsoft Surface Keyboard Touchpad
> /dev/input/event24:	Microsoft Surface Keyboard Keyboard

I had a line in dmesg that input8 is allocated to Touchpad, but no
eventX (0..6 IIRC) from /dev/input reflects Touchpad events. I can get
them only via /dev/usb/hiddev0.

>=20
> Can you attach the dmesg when plugging in the type cover?
>=20

I will do later, but there is no such thing 'plugging in'. It's a part
of the notebook, so, I can do detach-attach cycle, though it shouldn't
matter, it should work immediately after boot I suppose.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
