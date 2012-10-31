From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 11/11] HID: hid-multitouch: get rid of usbhid
 depedency for general path
Date: Wed, 31 Oct 2012 20:18:49 +0100
Message-ID: <20121031191849.GA1780@polaris.bitmath.org>
References: <1351241067-9521-1-git-send-email-benjamin.tissoires@gmail.com>
 <1351241067-9521-12-git-send-email-benjamin.tissoires@gmail.com>
 <20121029225748.GA15632@polaris.bitmath.org>
 <CAN+gG=GNucfg4-wCBZQtz0yJDjpTD_56Js3d68nm8VFi1UhZAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:51190 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718Ab2JaTN7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 15:13:59 -0400
Content-Disposition: inline
In-Reply-To: <CAN+gG=GNucfg4-wCBZQtz0yJDjpTD_56Js3d68nm8VFi1UhZAA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > In my drawer, I have a patchset that aims to remove all usbhid
> > dependence, from all the drivers. Perhaps the attached patch is
> > something to consider here?
> 
> yep, removing usbhid dependencies is a good thing.
> See my review below :)
> 
> > From 5d9a791e0a9e41bcea0fcb286e2849b403675f37 Mon Sep 17 00:00:00 2001
> > From: Henrik Rydberg <rydberg@euromail.se>
> > Date: Mon, 2 Jul 2012 20:38:21 +0200
> > Subject: [PATCH 3/7] hid: extend interface with report requests
> >
> > ---
> >  drivers/hid/usbhid/hid-core.c | 14 ++++++++++++++
> >  include/linux/hid.h           | 33 +++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > index de1f9ac..3c618da 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -1251,6 +1251,18 @@ static int usbhid_power(struct hid_device *hid, int lvl)
> >         return r;
> >  }
> >
> > +static void usbhid_send(struct hid_device *hid, struct hid_report *rep, int req)
> > +{
> > +       switch (req) {
> > +       case HID_REQ_GET_REPORT:
> > +               usbhid_submit_report(hid, rep, USB_DIR_IN);
> > +               break;
> > +       case HID_REQ_SET_REPORT:
> > +               usbhid_submit_report(hid, rep, USB_DIR_OUT);
> > +               break;
> > +       }
> > +}
> > +
> >  static struct hid_ll_driver usb_hid_driver = {
> >         .parse = usbhid_parse,
> >         .start = usbhid_start,
> > @@ -1259,6 +1271,8 @@ static struct hid_ll_driver usb_hid_driver = {
> >         .close = usbhid_close,
> >         .power = usbhid_power,
> >         .hidinput_input_event = usb_hidinput_input_event,
> > +       .send = usbhid_send,
> 
> the name here is a little bit misleading. You are using "send" to also
> "get" reports...
> Maybe "hid_request" is a better name. This will allows us to add the
> missing function:
> Get_Descriptor, Set_Descriptor, Get_Report Request, Set_Report
> Request, Get_Idle, Set_Idle, Get_Protocol, Set_Protocol and maybe
> others - even WAIT for instance :)

Sounds good, I'll ponder this a bit.

> 
> > +       .wait = usbhid_wait_io,
> 
> is it really necessary to wait for IO? (I think it will not be one
> line for hid over i2c...).

We can certainly skip it for the scope of your patchset, but last time
I checked, it was needed in quite a few places.

Thanks,
Henrik
