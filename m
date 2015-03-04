From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v3 2/6] HID: uclogic: merge hid-huion driver in
 hid-uclogic
Date: Wed, 4 Mar 2015 11:06:56 -0500
Message-ID: <20150304160656.GB25087@mail.corp.redhat.com>
References: <1425404645-20134-1-git-send-email-benjamin.tissoires@redhat.com>
 <1425404645-20134-3-git-send-email-benjamin.tissoires@redhat.com>
 <alpine.LNX.2.00.1503041643360.26925@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1503041643360.26925@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>
List-Id: linux-input@vger.kernel.org

On Mar 04 2015 or thereabouts, Jiri Kosina wrote:
> On Tue, 3 Mar 2015, Benjamin Tissoires wrote:
> 
> > From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> > 
> > Merge the hid-huion driver into hid-uclogic as all the devices supported
> > by hid-huion are in fact UC-Logic devices.
> > 
> > Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> > 
> > no changes in v3
> > no changes in v2
> > 
> >  drivers/hid/Kconfig       |   8 +-
> >  drivers/hid/Makefile      |   1 -
> >  drivers/hid/hid-huion.c   | 290 ----------------------------------------------
> >  drivers/hid/hid-uclogic.c | 229 +++++++++++++++++++++++++++++++++++-
> >  4 files changed, 229 insertions(+), 299 deletions(-)
> >  delete mode 100644 drivers/hid/hid-huion.c
> > 
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 152b006..8a55fd7 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -286,12 +286,6 @@ config HID_GT683R
> >  	Currently the following devices are know to be supported:
> >  	  - MSI GT683R
> >  
> > -config HID_HUION
> > -	tristate "Huion tablets"
> > -	depends on USB_HID
> > -	---help---
> > -	Support for Huion 580 tablet.
> > -
> 
> The dependency on USB_HID was there actually on purpose, as the huion 
> driver contained quite some USB-isms. Those now got merged to uclogic, but 
> uclogic doesn't have USB_HID dependency.

Oops, my bad.

> 
> Could you guys please sort this out?

Sure, I'll send a fix ASAP.

Cheers,
Benjamin
