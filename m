From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: input: Fix TransducerSerialNumber implementation
Date: Tue, 28 Oct 2014 15:58:19 -0400
Message-ID: <20141028195819.GF14393@mail.corp.redhat.com>
References: <6B3C86448604A642A31AAD3F8C07EA7724F0B8CD@Exchange1.wacom.com>
 <1411495768-5956-1-git-send-email-killertofu@gmail.com>
 <CANRwn3QbH-Jt4L7W-qOikX_JaeKs-vu_5XeK8TgzowyXLh_=qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58129 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbaJ1T61 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Oct 2014 15:58:27 -0400
Content-Disposition: inline
In-Reply-To: <CANRwn3QbH-Jt4L7W-qOikX_JaeKs-vu_5XeK8TgzowyXLh_=qg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jkosina@suse.cz" <jkosina@suse.cz>, "pinglinux@gmail.com" <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Oct 28 2014 or thereabouts, Jason Gerecke wrote:
> On Tue, Sep 23, 2014 at 11:09 AM, Jason Gerecke <killertofu@gmail.com> wrote:
> > The commit which introduced TransducerSerialNumber (368c966) is missing
> > two crucial implementation details. Firstly, the commit does not set the
> > type/code/bit/max fields as expected later down the code which can cause
> > the driver to crash when a tablet with this usage is connected. Secondly,
> > the call to 'set_bit' causes MSC_PULSELED to be sent instead of the
> > expected MSC_SERIAL. This commit addreses both issues.
> >
> > Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> > ---
> >  drivers/hid/hid-input.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 2619f7f..cb1b3fa 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -689,7 +689,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
> >                         break;
> >
> >                 case 0x5b: /* TransducerSerialNumber */
> > -                       set_bit(MSC_SERIAL, input->mscbit);
> > +                       usage->type = EV_MSC;
> > +                       usage->code = MSC_SERIAL;
> > +                       bit = input->mscbit;
> > +                       max = MSC_MAX;
> >                         break;
> >
> >                 default:  goto unknown;
> > --
> > 2.1.0
> >
> 
> This patch still seems to be in limbo. Anyone (Ping? Benjamin?) care
> to provide an ACK or review?
> 

Sorry for that, I was persuaded I already have answered to this one.

The patch makes sense, but I think it will be better to extend
hid_map_usage() with MSC bits and define map_msc_clear(). The code will
be more consistent with the rest this way.

Anyway, if Jiri does not find this to be mandatory, then this code is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

