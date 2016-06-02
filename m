From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Thu, 2 Jun 2016 16:11:27 +0200
Message-ID: <20160602141127.GZ23234@mail.corp.redhat.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
 <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
 <1463149818.17131.349.camel@linux.intel.com>
 <20160513144927.GZ23234@mail.corp.redhat.com>
 <1463155787.17131.351.camel@linux.intel.com>
 <1463156908.17131.353.camel@linux.intel.com>
 <20160520075835.GJ23234@mail.corp.redhat.com>
 <20160531160741.GX23234@mail.corp.redhat.com>
 <1464717399.1767.1.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464717399.1767.1.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On May 31 2016 or thereabouts, Andy Shevchenko wrote:
> On Tue, 2016-05-31 at 18:07 +0200, Benjamin Tissoires wrote:
> > On May 20 2016 or thereabouts, Benjamin Tissoires wrote:
> > > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > > > On Fri, 2016-05-13 at 19:09 +0300, Andy Shevchenko wrote:
> > > > > On Fri, 2016-05-13 at 16:49 +0200, Benjamin Tissoires wrote:
> > > > > >=20
> > > > > > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > > > > > >=20
> > > > > > >=20
> > > > > > > On Thu, 2016-05-12 at 16:12 +0200, Benjamin Tissoires wro=
te:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > There is no reasons to filter out keyboard and consumer
> > > > > > > > control
> > > > > > > > collections
> > > > > > > > in hid-multitouch.
> > > > > > > > With the previous hid-input fix, there is now a full
> > > > > > > > support of
> > > > > > > > the
> > > > > > > > Type
> > > > > > > > Cover and we can remove all specific bits from hid-core
> > > > > > > > and hid-
> > > > > > > > microsoft.
> > > > > > > >=20
> > > > > > > > hid-multitouch will automatically set
> > > > > > > > HID_QUIRK_NO_INIT_REPORTS
> > > > > > > > so
> > > > > > > > we
> > > > > > > > can
> > > > > > > > also remove it from the list of ushbid quirks.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@r=
edh
> > > > > > > > at.com
> > > > > > > > >=20
> > > > > > > > ---
> > > > > > > >=20
> > > > > > > > Andy, would you mind checking if this series is suffici=
ent
> > > > > > > > to
> > > > > > > > enable
> > > > > > > > the
> > > > > > > > TypeCover of the Surface Book?
> > > > > > > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel=
=2Eco
> > > > > > > m>
> > > > > > >=20
> > > > > > > Noticed little difference that there is no event for the
> > > > > > > device
> > > > > > > anymore,
> > > > > > > just /dev/usb/hiddev0. Would it work properly under X?
> > > > > > Not sure what you mean.
> > > > > > I get 3 input nodes:
> > > > > > Microsoft Surface Type Cover Keyboard
> > > > > > Microsoft Surface Type Cover Consumer Control
> > > > > > Microsoft Surface Type Cover Touchpad
> > > > > >=20
> > > > > > Each on this input device is properly assigned an event nod=
e
> > > > > > and X
> > > > > > works
> > > > > > with them.
> > > > > >=20
> > > > > > If there is no /dev/input/eventX created for your cover, th=
en
> > > > > > this
> > > > > > is
> > > > > > not normal and needs to be investigated.
> > > > > There is no /dev/input/eventX for the touchpad.=C2=A0
> > > > > It prints that input device is under /usb.../input8, but the
> > > > > actual
> > > > > node
> > > > > I got events from is /dev/usb/hiddev0.
> > > >=20
> > > > Correction, it seems the event node is there (event6), but I go=
t
> > > > nothing
> > > > from it
> > >=20
> > > Would you mind sending me a hid-recorder[1] trace of the device
> > > while
> > > typing few keys and using the touchpad?
> >=20
> > Ping?
> >=20
> > Without those logs, I can not do further debugging and Jiri can't t=
ake
> > the
> > series...
>=20
> Sorry for delay.

No worries.

OK, so it looks like your touchpad stays in the mouse emulation mode fo=
r
some reasons. Did you do the recordings with hid-multitouch patched, or
with plain hid-generic or an other one?

After further thoughts, I think it should be acceptable to enable the
mouse collection for Win 8 certified devices. Touchscreens are not
supposed to expose such a mouse emulation, so that would mean that only
touchpad will export one.

I'll come with a patch by the end of the week (hopefully).

Cheers,
Benjamin
