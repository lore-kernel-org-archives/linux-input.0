From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 1/5] input: event-codes: reserve some space for
 REL_MISC events
Date: Wed, 21 Jun 2017 14:05:17 +0200
Message-ID: <20170621120517.GD23046@mail.corp.redhat.com>
References: <cover.1491917052.git.mchehab@s-opensource.com>
 <34b4f3e6baedde818516ceb1d009f6568b953345.1491917052.git.mchehab@s-opensource.com>
 <20170415175502.GC33447@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdFUMFZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 21 Jun 2017 08:05:25 -0400
Content-Disposition: inline
In-Reply-To: <20170415175502.GC33447@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Stuart Yoder <stuart.yoder@nxp.com>, Ingo Tuchscherer <ingo.tuchscherer@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Florian Fainelli <f.fainelli@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Hans Verkuil <hans.verkuil@cisco.com>, Kamil Debski <kamil@wypas.org>, Douglas Anderson <dianders@chromium.org>

On Apr 15 2017 or thereabouts, Dmitry Torokhov wrote:
> On Tue, Apr 11, 2017 at 10:29:38AM -0300, Mauro Carvalho Chehab wrote:
> > The HID input layer has a tendency to map usages to REL_MISC
> > +1, +2, +3, etc... When it doesn't know how to map an
> > usage, the core layer maps it to the next one.
> 
> We should wean HID off this habit. We should not be adding placeholder
> events without defined meaning.

See https://patchwork.kernel.org/patch/9795625/ for such patch.

Feedbacks welcome :)

Cheers,
Benjamin

> 
> > 
> > So, reserve some space for such events.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> > ---
> >  include/linux/mod_devicetable.h        | 2 +-
> >  include/uapi/linux/input-event-codes.h | 8 +++++++-
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> > index 8850fcaf50db..a3e8c572a046 100644
> > --- a/include/linux/mod_devicetable.h
> > +++ b/include/linux/mod_devicetable.h
> > @@ -286,7 +286,7 @@ struct pcmcia_device_id {
> >  #define INPUT_DEVICE_ID_EV_MAX		0x1f
> >  #define INPUT_DEVICE_ID_KEY_MIN_INTERESTING	0x71
> >  #define INPUT_DEVICE_ID_KEY_MAX		0x2ff
> > -#define INPUT_DEVICE_ID_REL_MAX		0x0f
> > +#define INPUT_DEVICE_ID_REL_MAX		0x1f
> >  #define INPUT_DEVICE_ID_ABS_MAX		0x3f
> >  #define INPUT_DEVICE_ID_MSC_MAX		0x07
> >  #define INPUT_DEVICE_ID_LED_MAX		0x0f
> > diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> > index f5a8d96e1e09..444956ba832c 100644
> > --- a/include/uapi/linux/input-event-codes.h
> > +++ b/include/uapi/linux/input-event-codes.h
> > @@ -704,7 +704,13 @@
> >  #define REL_DIAL		0x07
> >  #define REL_WHEEL		0x08
> >  #define REL_MISC		0x09
> > -#define REL_MAX			0x0f
> > +#define REL_MISC_1		0x0a
> > +#define REL_MISC_2		0x0b
> > +#define REL_MISC_3		0x0c
> > +#define REL_MISC_4		0x0d
> > +#define REL_MISC_5		0x0e
> > +#define REL_MISC_6		0x0f
> > +#define REL_MAX			0x1f
> >  #define REL_CNT			(REL_MAX+1)
> >  
> >  /*
> > -- 
> > 2.9.3
> > 
> 
> -- 
> Dmitry
