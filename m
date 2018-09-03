From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: enforce
 I2C_HID_QUIRK_RESEND_REPORT_DESCR
Date: Mon, 3 Sep 2018 15:13:21 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1809031512420.25787@cbobk.fhfr.pm>
References: <20180831095417.8541-1-benjamin.tissoires@redhat.com> <4687e76a-d9a8-4a20-194b-526bb345cf73@redhat.com> <CAO-hwJKABBJExKciVt5R-8bjBtUe+uSc0Z_ikc35jbf1zrNpog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJKABBJExKciVt5R-8bjBtUe+uSc0Z_ikc35jbf1zrNpog@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, kai.heng.feng@canonical.com
List-Id: linux-input@vger.kernel.org

On Mon, 3 Sep 2018, Benjamin Tissoires wrote:

> > > The spec states that the HID devices should allow
> > > the host to query the HID descriptor at any time.
> > >
> > > Some devices require the HID descriptor to be set
> > > on resume, or they will fail.
> > >
> > > Instead of having a growing list of blacklisted devices
> > > make the call part of the general resume process
> > > so we can remove this list.
> > >
> > > Tested on a Dell XPS 9360 and a Surface 3.
> > >
> > > link: https://bugzilla.redhat.com/show_bug.cgi?id=1622695
> > >
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > I agree we should just do this everywhere:
> >
> > Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> Jiri, please hold with this patch, Canonical might have found a better
> solution. Simply not resetting the device after S3 might be the trick.

Thanks for the heads up.

In case that's the case, please also send a reference to the subsititute 
patch submission into this thread, so that archives to pick it up :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
