From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v2] input: wacom_w8001 - cleanup 2FG touch code
Date: Fri, 15 Jul 2016 22:33:53 -0700
Message-ID: <20160716053353.GA40160@dtor-ws>
References: <1468625185-17820-1-git-send-email-pingc@wacom.com>
 <20160715235138.GH27847@dtor-ws>
 <CAF8JNhJ4wRnH+f2beOuip=M1cUums7nB-uu6NWTcN91EVTCs+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33262 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcGPFd5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jul 2016 01:33:57 -0400
Received: by mail-pa0-f66.google.com with SMTP id q2so7241587pap.0
        for <linux-input@vger.kernel.org>; Fri, 15 Jul 2016 22:33:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF8JNhJ4wRnH+f2beOuip=M1cUums7nB-uu6NWTcN91EVTCs+Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ping Cheng <pingc@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Fri, Jul 15, 2016 at 06:19:41PM -0700, Ping Cheng wrote:
> On Friday, July 15, 2016, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Fri, Jul 15, 2016 at 04:26:25PM -0700, Ping Cheng wrote:
> > > input_mt_sync_frame is used by other wacom devices in wacom_wac.c
> > > to close the frame and emulate pointer events. Let's follow them.
> > >
> > > Touch events aren't multiplexed over the same device anymore, the
> > > use of ABS_MT_TOOL_TYPE is superfluous.
> >
> > All of our touchscreen report the finger tool events, even if it is the
> > only "tool" that is being used. Does it cause problems?
> >
> 
> No, it does not cause problem, with/without ABS_MT_TOOL_TYPE being set.
> Testing result shows all touch data are reported whether we explicitly set
> ABS_MT_TOOL_TYPE upfront or not. Plus, ABS_MT_TOOL_TYPE is not set in
> wacom.ko. We'd like to be in sync with wacom.ko.
> 
> The following comments for input_mt_report_slot_state in input-mt.c
> explains the reason:
> 
> "* Reports a contact via ABS_MT_TRACKING_ID, and optionally
>  * ABS_MT_TOOL_TYPE. If active is true and the slot is currently
>  * inactive, or if the tool type is changed, a new tracking id is
>  * assigned to the slot. The tool type is only reported if the
>  * corresponding absbit field is set."
> 
> MT_TOOL_TYPE is necessary if we report both pen and touch on the same
> interface. That is not true for this series of devices any more..
> 
> 
> > >
> > > Signed-off-by: Ping Cheng <pingc@wacom.com>
> > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > > ---
> > > v2: moved input_abs_set_res into a separate patch, as suggested by
> > > Dmitry.
> > > ---
> > >  drivers/input/touchscreen/wacom_w8001.c | 15 ++-------------
> > >  1 file changed, 2 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/input/touchscreen/wacom_w8001.c
> > b/drivers/input/touchscreen/wacom_w8001.c
> > > index 7e807af..541a8df 100644
> > > --- a/drivers/input/touchscreen/wacom_w8001.c
> > > +++ b/drivers/input/touchscreen/wacom_w8001.c
> > > @@ -170,16 +170,8 @@ static void parse_multi_touch(struct w8001 *w8001)
> > >               }
> > >       }
> > >
> > > -     /* emulate single touch events when stylus is out of proximity.
> > > -      * This is to make single touch backward support consistent
> > > -      * across all Wacom single touch devices.
> > > -      */
> > > -     if (w8001->type != BTN_TOOL_PEN &&
> > > -                         w8001->type != BTN_TOOL_RUBBER) {
> > > -             w8001->type = count == 1 ? BTN_TOOL_FINGER : KEY_RESERVED;
> > > -             input_mt_report_pointer_emulation(dev, true);
> > > -     }
> > > -
> > > +     w8001->type = KEY_RESERVED;
> > > +     input_mt_sync_frame(dev);
> > >       input_sync(dev);
> > >  }
> > >
> > > @@ -508,7 +500,6 @@ static int w8001_setup_touch(struct w8001 *w8001,
> > char *basename,
> > >       case 5:
> > >               w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
> > >
> > > -             __set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
> >
> > Who is setting this bit then?
> >
> 
> All MT related bits are set by input_mt_init_slots in input-mt.c, including
> BTN_TOOL_DOUBLETAP, if necessary.

Doesn't this only happen if you call input_mt_init_slots with
INPUT_MT_POINTER flag?

Thanks.

-- 
Dmitry
