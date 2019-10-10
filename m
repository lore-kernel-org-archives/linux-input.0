From: Candle Sun <candlesea@gmail.com>
Subject: Re: [PATCH v2] HID: core: check whether usage page item is after
 usage id item
Date: Thu, 10 Oct 2019 11:19:28 +0800
Message-ID: <CAPnx3XNGBw+SKSFA3DhhHFZZ17f54DMfYjKOcqYTb3N-PWGKpw@mail.gmail.com>
References: <1570625609-11083-1-git-send-email-candlesea@gmail.com>
 <d739f691b677fb3ed88a23476d221527a87c363d.camel@suse.de> <nycvar.YFH.7.76.1910091958120.13160@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1910091958120.13160@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, orson.zhai@unisoc.com, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Candle Sun <candle.sun@unisoc.com>, Nianfu Bai <nianfu.bai@unisoc.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 10, 2019 at 2:00 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 9 Oct 2019, Nicolas Saenz Julienne wrote:
>
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 3eaee2c..3394222 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -35,6 +35,8 @@
> > >
> > >  #include "hid-ids.h"
> > >
> > > +#define GET_COMPLETE_USAGE(page, id) (((page) << 16) + ((id) & 0xffff))
> >
> > Not sure I like the macro. I'd rather have the explicit code. That said, lets
> > see what Benjamin has to say.
>
> Not sure about Benjamin :) but I personally would ask for putting it
> somewhere into hid.h as static inline.
>
> And even if it's for some reason insisted on this staying macro, please at
> least put it as close to the place(s) it's being used as possible, in
> order to maintain some code sanity.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Thanks Nicolas and Jiri,
If macro is not good, I will change it to static function. But the
funciton is only used in hid-core.c,
maybe placing it into hid.h is not good?

Regards,
Candle
