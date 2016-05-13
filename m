From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Fri, 13 May 2016 18:21:37 +0200
Message-ID: <20160513162137.GB23234@mail.corp.redhat.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
 <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
 <1463149818.17131.349.camel@linux.intel.com>
 <20160513144927.GZ23234@mail.corp.redhat.com>
 <1463155787.17131.351.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43240 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbcEMQVm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 12:21:42 -0400
Content-Disposition: inline
In-Reply-To: <1463155787.17131.351.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> On Fri, 2016-05-13 at 16:49 +0200, Benjamin Tissoires wrote:
> > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > >=20
> > > On Thu, 2016-05-12 at 16:12 +0200, Benjamin Tissoires wrote:
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
> > > > hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPORTS=
 so
> > > > we
> > > > can
> > > > also remove it from the list of ushbid quirks.
> > > >=20
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.co=
m>
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
> > If there is no /dev/input/eventX created for your cover, then this =
is
> > not normal and needs to be investigated.
>=20
> There is no /dev/input/eventX for the touchpad.=C2=A0
> It prints that input device is under /usb.../input8, but the actual n=
ode
> I got events from is /dev/usb/hiddev0.
>=20

Hmm, have you also applied 1/2?

If so, please can you provide me the hid-recorder[1] output of the type
cover?

Cheers,
Benjamin

[1] http://bentiss.github.io/hid-replay-docs/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
