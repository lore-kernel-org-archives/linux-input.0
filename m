From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: hid-thingm: kernel panic on remove
Date: Wed, 3 Sep 2014 23:47:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409032346210.12309@pobox.suse.cz>
References: <20140902174659.GA1811@datura.dylex.net> <54062150.2010800@gmail.com> <CAN+gG=HZfXp5dEdsRRcmia9Da0p8VT1Rj9TLB-cahiUDkCQujA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44667 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925AbaICVrT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2014 17:47:19 -0400
In-Reply-To: <CAN+gG=HZfXp5dEdsRRcmia9Da0p8VT1Rj9TLB-cahiUDkCQujA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dylan Alex Simon <dylan-kernel@dylex.net>, linux-input <linux-input@vger.kernel.org>

On Wed, 3 Sep 2014, Benjamin Tissoires wrote:

> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Date: Tue, 2 Sep 2014 15:50:43 -0400
> > Subject: [PATCH] HID: thingm: set the proper error code before leaving
> >
> > In case of an unsupported firmware, the driver bails out without setting
> > the LEDs interfaces, but forget to set the proper error code.
> > err is then still equal to 0 and the hid subsytem consider the device
> > to be in perfect shape.
> > When removing it, thingm_remove() tries to unbind the rgb LEDs which
> > has not been created, leading to a segfault.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > ---
> >  drivers/hid/hid-thingm.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> > index 134be89..f91f971 100644
> > --- a/drivers/hid/hid-thingm.c
> > +++ b/drivers/hid/hid-thingm.c
> > @@ -250,6 +250,7 @@ static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
> >
> >         if (!tdev->fwinfo) {
> >                 hid_err(hdev, "unsupported firmware %c\n", tdev->version.major);
> > +               err = -ENODEV;
> >                 goto stop;
> >         }
> 
> Jiri, could you still consider including this one? If Thingm decides
> to create a firmware with 3.X, it will fail, so I guess this is still
> required, even if it does not fix Dylan's problem.

It's now queued in for-3.17/upstream-fixes. I don't think it justifies 
pull request to Linus by itself, but if there is anything else that does, 
it'll piggy-back. Otherwise it'll go into 3.18. Please shout if it's not 
okay.

Thanks,

-- 
Jiri Kosina
SUSE Labs
