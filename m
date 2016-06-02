From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Thu, 02 Jun 2016 17:40:15 +0300
Message-ID: <1464878415.1767.27.camel@linux.intel.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
 <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
 <1463149818.17131.349.camel@linux.intel.com>
 <20160513144927.GZ23234@mail.corp.redhat.com>
 <1463155787.17131.351.camel@linux.intel.com>
 <1463156908.17131.353.camel@linux.intel.com>
 <20160520075835.GJ23234@mail.corp.redhat.com>
 <20160531160741.GX23234@mail.corp.redhat.com>
 <1464717399.1767.1.camel@linux.intel.com>
	 <20160602141127.GZ23234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12792 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbcFBOjI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jun 2016 10:39:08 -0400
In-Reply-To: <20160602141127.GZ23234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2016-06-02 at 16:11 +0200, Benjamin Tissoires wrote:
> > > > >=C2=A0
> On May 31 2016 or thereabouts, Andy Shevchenko wrote:
> > On Tue, 2016-05-31 at 18:07 +0200, Benjamin Tissoires wrote:
> > > On May 20 2016 or thereabouts, Benjamin Tissoires wrote:
> > > > On May 13 2016 or thereabouts, Andy Shevchenko wrote:
> > > > Would you mind sending me a hid-recorder[1] trace of the device
> > > > while
> > > > typing few keys and using the touchpad?
> > >=C2=A0

> OK, so it looks like your touchpad stays in the mouse emulation mode
> for
> some reasons. Did you do the recordings with hid-multitouch patched,
> or
> with plain hid-generic or an other one?

I take linux-next + your two patches from this thread (+ some unrelated
to HID patches).

>=20
> After further thoughts, I think it should be acceptable to enable the
> mouse collection for Win 8 certified devices. Touchscreens are not
> supposed to expose such a mouse emulation, so that would mean that
> only
> touchpad will export one.
>=20

> I'll come with a patch by the end of the week (hopefully).

Cc me and I will test 'em.


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
