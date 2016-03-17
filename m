From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: hid-multitouch stuck taps, possibly 4.5 regression?
Date: Thu, 17 Mar 2016 10:06:12 +0200
Message-ID: <20160317080612.GN1793@lahna.fi.intel.com>
References: <CALCETrXDiW4ZyHhqt2gWwwgVYmdup27f3MsyEY9y+=EjrgJBJg@mail.gmail.com>
 <20160316084716.GR22340@mail.corp.redhat.com>
 <CALCETrWRi8nM6h234ppeQZ3VaAqL4d37VmZvt6HSYwDYddO3Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6800 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754662AbcCQIGR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Mar 2016 04:06:17 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrWRi8nM6h234ppeQZ3VaAqL4d37VmZvt6HSYwDYddO3Kw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Benjamin Tissoires <btissoir@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pratyush Anand <pratyush.anand@gmail.com>

On Wed, Mar 16, 2016 at 02:59:48PM -0700, Andy Lutomirski wrote:
> [add i2c-designware maintainers]
> 
> On Wed, Mar 16, 2016 at 1:47 AM, Benjamin Tissoires <btissoir@redhat.com> wrote:
> > Hi Andy,
> >
> > On Mar 15 2016 or thereabouts, Andy Lutomirski wrote:
> >> Hi-
> >>
> >> In 4.5 and several 4.5 rcs, I see occasional stuck taps (I think) on
> >> my XPS 13 9350's touchpad.  The effect is that trying to left-click
> >> ends up middle-clicking.  I think it's a kernel issue and not a
> >> hardware or libinput issue, but I'm not 100% sure.  I don't think I
> >> had this issue in 4.4.
> >>
> >> I've attached what I think is an evtest issue of my fixing the issue
> >> by pressing three fingers down in sequence and then releasing them.
> >> After doing that, left-clicks worked.
> >
> > I think I already have been reported the issue here:
> > https://bugs.freedesktop.org/show_bug.cgi?id=93948
> >
> > The result was that it was more likely an I2C transport bug than a
> > hid-multitouch one (see comment #8 in the fdo bug).
> >
> > You can try to run hid-recorder when you see the problems, and then
> > parse the output (or just send it to me). There is huge chances that
> > there will be no events from I2C sending the release.
> >
> > And again, I am not sure how we could end up debugging this in the
> > i2c-designware driver :(
> >
> 
> Does this ring a bell?

i2c-designware usually prints errors to dmesg if it fails to transfer
messages. Can you include dmesg of the failure as well?
