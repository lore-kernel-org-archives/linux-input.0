From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Fri, 20 May 2016 09:58:35 +0200
Message-ID: <20160520075835.GJ23234@mail.corp.redhat.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
 <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
 <1463149818.17131.349.camel@linux.intel.com>
 <20160513144927.GZ23234@mail.corp.redhat.com>
 <1463155787.17131.351.camel@linux.intel.com>
 <1463156908.17131.353.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463156908.17131.353.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> On Fri, 2016-05-13 at 19:09 +0300, Andy Shevchenko wrote:
> > On Fri, 2016-05-13 at 16:49 +0200, Benjamin Tissoires wrote:
> > >=20
> > > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > > >=20
> > > >=20
> > > > On Thu, 2016-05-12 at 16:12 +0200, Benjamin Tissoires wrote:
> > > > >=20
> > > > >=20
> > > > > There is no reasons to filter out keyboard and consumer contr=
ol
> > > > > collections
> > > > > in hid-multitouch.
> > > > > With the previous hid-input fix, there is now a full support =
of
> > > > > the
> > > > > Type
> > > > > Cover and we can remove all specific bits from hid-core and h=
id-
> > > > > microsoft.
> > > > >=20
> > > > > hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPOR=
TS
> > > > > so
> > > > > we
> > > > > can
> > > > > also remove it from the list of ushbid quirks.
> > > > >=20
> > > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.=
com
> > > > > >
> > > > > ---
> > > > >=20
> > > > > Andy, would you mind checking if this series is sufficient to
> > > > > enable
> > > > > the
> > > > > TypeCover of the Surface Book?
> > > > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >=20
> > > > Noticed little difference that there is no event for the device
> > > > anymore,
> > > > just /dev/usb/hiddev0. Would it work properly under X?
> > > Not sure what you mean.
> > > I get 3 input nodes:
> > > Microsoft Surface Type Cover Keyboard
> > > Microsoft Surface Type Cover Consumer Control
> > > Microsoft Surface Type Cover Touchpad
> > >=20
> > > Each on this input device is properly assigned an event node and =
X
> > > works
> > > with them.
> > >=20
> > > If there is no /dev/input/eventX created for your cover, then thi=
s
> > > is
> > > not normal and needs to be investigated.
> > There is no /dev/input/eventX for the touchpad.=C2=A0
> > It prints that input device is under /usb.../input8, but the actual
> > node
> > I got events from is /dev/usb/hiddev0.
>=20
> Correction, it seems the event node is there (event6), but I got noth=
ing
> from it

Would you mind sending me a hid-recorder[1] trace of the device while
typing few keys and using the touchpad?

Not receiving events from the actual touchpad node means that the
device did not switch to the mutlitouch mode, or that something else
is going on. I should be able to see that in the hid-recorder log.


[1] http://bentiss.github.io/hid-replay-docs/

Cheers,
Benjamin
