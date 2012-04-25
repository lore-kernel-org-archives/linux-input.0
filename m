From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: wacom - retrieve maximum number of touch
 points
Date: Tue, 24 Apr 2012 22:05:47 -0700
Message-ID: <20120425050547.GA27843@core.coreip.homeip.net>
References: <1334530224-8395-1-git-send-email-chris@cnpbagwell.com>
 <1334530224-8395-2-git-send-email-chris@cnpbagwell.com>
 <20120421055603.GA27551@core.coreip.homeip.net>
 <CAF8JNh+t4fnsigjta1xoRQ565NU6+rf8zDDCte=4d68MwdVK6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52786 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab2DYFFz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 01:05:55 -0400
Received: by pbbro12 with SMTP id ro12so976044pbb.19
        for <linux-input@vger.kernel.org>; Tue, 24 Apr 2012 22:05:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNh+t4fnsigjta1xoRQ565NU6+rf8zDDCte=4d68MwdVK6A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: chris@cnpbagwell.com, linux-input@vger.kernel.org

On Tue, Apr 24, 2012 at 01:46:15PM -0700, Ping Cheng wrote:
> On Fri, Apr 20, 2012 at 10:56 PM, Dmitry Torokhov <dmitry.torokhov@gmail.com
> > wrote:
> 
> > Hi Chris, Ping,
> >
> > On Sun, Apr 15, 2012 at 05:50:23PM -0500, chris@cnpbagwell.com wrote:
> > > From: Ping Cheng <pinglinux@gmail.com>
> > >
> > > From the HID usage table when it is supported.
> > >
> > > Tested-by: Jason Gerecke <killertofu@gmail.com>
> > > Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
> > > Signed-off-by: Ping Cheng <pingc@wacom.com>
> > > ---
> > >  drivers/input/tablet/wacom_sys.c |   22 +++++++++++++-
> > >  drivers/input/tablet/wacom_wac.c |   59
> > +++++++++++++++++++++++---------------
> > >  drivers/input/tablet/wacom_wac.h |    1 +
> > >  3 files changed, 58 insertions(+), 24 deletions(-)
> > >
> > > diff --git a/drivers/input/tablet/wacom_sys.c
> > b/drivers/input/tablet/wacom_sys.c
> > > index 1c874ad..469f6ce 100644
> > > --- a/drivers/input/tablet/wacom_sys.c
> > > +++ b/drivers/input/tablet/wacom_sys.c
> > > @@ -28,6 +28,7 @@
> > >  #define HID_USAGE_Y_TILT             0x3e
> > >  #define HID_USAGE_FINGER             0x22
> > >  #define HID_USAGE_STYLUS             0x20
> > > +#define HID_USAGE_CONTACTMAX         0x55
> > >  #define HID_COLLECTION                       0xa1
> > >  #define HID_COLLECTION_LOGICAL               0x02
> > >  #define HID_COLLECTION_END           0xc0
> > > @@ -201,6 +202,20 @@ static int wacom_parse_logical_collection(unsigned
> > char *report,
> > >       return length;
> > >  }
> > >
> > > +static void wacom_retrieve_report_data(struct usb_interface *intf,
> > > +                                    struct wacom_features *features)
> > > +{
> > > +     int result = 0;
> > > +     unsigned char rep_data[2];
> >
> > You can't use on-stack buffers with USB. I see we allocating memory
> > elsewhere but I wonder if we should simply piggyback on wacom_wac->data
> > in all these interrogation methods.
> >
> 
> When you say piggyback on wacom_wac->data, I guess you meant using the same
> wacom_wac->data instead of creating a new entry for the others. However,
> wacom_wac->data has a sizeof(struct wacom_usbdev_data). The existing
> kzalloc requests in wacom_sys.c range from 2 to 259, assuming we do not
> consider those kzallocs that handle variable sizes, such as
> hid_desc->wDescriptorLength.
> 
> What size would be reasonable for the new data? I feel we need to introduce
> a new entry in wacom_wac if we want to unify the kzalloc request a bit.

Hmm, maybe piggybacking was not such a good idea. We want to keep
buffers used by leds separate since these operations can appen
simultaneously and since we also have to deal with variable length of
hid descriptors I think we should just kmalloc memory in
wacom_retrieve_report_data() and be done with it.

-- 
Dmitry
