From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Fri, 13 May 2016 19:28:28 +0300
Message-ID: <1463156908.17131.353.camel@linux.intel.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
	 <1463149818.17131.349.camel@linux.intel.com>
	 <20160513144927.GZ23234@mail.corp.redhat.com>
	 <1463155787.17131.351.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50467 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbcEMQ1V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 12:27:21 -0400
In-Reply-To: <1463155787.17131.351.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2016-05-13 at 19:09 +0300, Andy Shevchenko wrote:
> On Fri, 2016-05-13 at 16:49 +0200, Benjamin Tissoires wrote:
> >=20
> > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > >=20
> > >=20
> > > On Thu, 2016-05-12 at 16:12 +0200, Benjamin Tissoires wrote:
> > > >=20
> > > >=20
> > > > There is no reasons to filter out keyboard and consumer control
> > > > collections
> > > > in hid-multitouch.
> > > > With the previous hid-input fix, there is now a full support of
> > > > the
> > > > Type
> > > > Cover and we can remove all specific bits from hid-core and hid=
-
> > > > microsoft.
> > > >=20
> > > > hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPORTS
> > > > so
> > > > we
> > > > can
> > > > also remove it from the list of ushbid quirks.
> > > >=20
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.co=
m
> > > > >
> > > > ---
> > > >=20
> > > > Andy, would you mind checking if this series is sufficient to
> > > > enable
> > > > the
> > > > TypeCover of the Surface Book?
> > > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >=20
> > > Noticed little difference that there is no event for the device
> > > anymore,
> > > just /dev/usb/hiddev0. Would it work properly under X?
> > Not sure what you mean.
> > I get 3 input nodes:
> > Microsoft Surface Type Cover Keyboard
> > Microsoft Surface Type Cover Consumer Control
> > Microsoft Surface Type Cover Touchpad
> >=20
> > Each on this input device is properly assigned an event node and X
> > works
> > with them.
> >=20
> > If there is no /dev/input/eventX created for your cover, then this
> > is
> > not normal and needs to be investigated.
> There is no /dev/input/eventX for the touchpad.=C2=A0
> It prints that input device is under /usb.../input8, but the actual
> node
> I got events from is /dev/usb/hiddev0.

Correction, it seems the event node is there (event6), but I got nothin=
g
from it

total 0
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 event0 ->
=2E./../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0/event0
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 event1 ->
=2E./../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1/event1
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 event2 ->
=2E./../devices/LNXSYSTM:00/LNXPWRBN:00/input/input2/event2
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 event3 ->
=2E./../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:18/PNP0C09:00=
/MS
HW0040:00/input/input3/event3
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:19 event4 ->
=2E./../devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-
1.4:1.0/0003:045E:07CD.0001/input/input4/event4
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:19 event5 ->
=2E./../devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-
1.4:1.0/0003:045E:07CD.0001/input/input6/event5
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:19 event6 ->
=2E./../devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-
1.4:1.0/0003:045E:07CD.0001/input/input8/event6
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 input0 ->
=2E./../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 input1 ->
=2E./../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input1
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 input2 ->
=2E./../devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 input3 ->
=2E./../devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:18/PNP0C09:00=
/MS
HW0040:00/input/input3
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:19 input4 ->
=2E./../devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-
1.4:1.0/0003:045E:07CD.0001/input/input4
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:19 input6 ->
=2E./../devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-
1.4:1.0/0003:045E:07CD.0001/input/input6
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:19 input8 ->
=2E./../devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-
1.4:1.0/0003:045E:07CD.0001/input/input8
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:17 mice ->
=2E./../devices/virtual/input/mice
lrwxrwxrwx=C2=A0=C2=A0=C2=A0=C2=A01 root=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r=
oot=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00 May 13 19:19 mouse0 ->
=2E./../devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1.4/1-
1.4:1.0/0003:045E:07CD.0001/input/input8/mouse0


I tried today's linux-next + your patches.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
