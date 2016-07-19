From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 2/2 v2] input: wacom_w8001 - cleanup 2FG touch code
Date: Tue, 19 Jul 2016 13:07:12 -0700
Message-ID: <CAF8JNhLxUA5RZ8ZyLj=JRRD2mABDmGKfd95-4FZndSrC8pUxyg@mail.gmail.com>
References: <1468625185-17820-1-git-send-email-pingc@wacom.com>
 <20160715235138.GH27847@dtor-ws> <CAF8JNhJ4wRnH+f2beOuip=M1cUums7nB-uu6NWTcN91EVTCs+Q@mail.gmail.com>
 <20160716053353.GA40160@dtor-ws> <CAF8JNh+fDOktK39uaXa8Fdq7v058RrwMd7rmKv8b2V_sXCXRLA@mail.gmail.com>
 <7724C52C-780C-4B7C-81BF-9A1EC8E78B71@gmail.com> <CAF8JNhKzzV7Px3ZJU_Tp7H0VgO47aWQXCYDhN0S25+vE15X3yw@mail.gmail.com>
 <20160719183753.GA19250@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34468 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbcGSUHc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jul 2016 16:07:32 -0400
Received: by mail-io0-f193.google.com with SMTP id g86so2127996ioj.1
        for <linux-input@vger.kernel.org>; Tue, 19 Jul 2016 13:07:32 -0700 (PDT)
In-Reply-To: <20160719183753.GA19250@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@who-t.net>

On Tue, Jul 19, 2016 at 11:37 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, Jul 16, 2016 at 03:33:12PM -0700, Ping Cheng wrote:
>> On Sat, Jul 16, 2016 at 2:58 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On July 16, 2016 2:32:27 PM PDT, Ping Cheng <pinglinux@gmail.com> wrote:
>> >>On Fri, Jul 15, 2016 at 10:33 PM, Dmitry Torokhov
>> >><dmitry.torokhov@gmail.com> wrote:
>> >>> On Fri, Jul 15, 2016 at 06:19:41PM -0700, Ping Cheng wrote:
>> >>>> On Friday, July 15, 2016, Dmitry Torokhov
>> >><dmitry.torokhov@gmail.com> wrote:
>> >>>>
>> >>>> > On Fri, Jul 15, 2016 at 04:26:25PM -0700, Ping Cheng wrote:
>> >>>> > > input_mt_sync_frame is used by other wacom devices in
>> >>wacom_wac.c
>> >>>> > > to close the frame and emulate pointer events. Let's follow
>> >>them.
>> >>>> > >
>> >>>> > > Touch events aren't multiplexed over the same device anymore,
>> >>the
>> >>>> > > use of ABS_MT_TOOL_TYPE is superfluous.
>> >>>> >
>> >>>> > All of our touchscreen report the finger tool events, even if it
>> >>is the
>> >>>> > only "tool" that is being used. Does it cause problems?
>> >>>> >
>> >>>>
>> >>>> No, it does not cause problem, with/without ABS_MT_TOOL_TYPE being
>> >>set.
>> >>>> Testing result shows all touch data are reported whether we
>> >>explicitly set
>> >>>> ABS_MT_TOOL_TYPE upfront or not. Plus, ABS_MT_TOOL_TYPE is not set
>> >>in
>> >>>> wacom.ko. We'd like to be in sync with wacom.ko.
>> >>>>
>> >>>> The following comments for input_mt_report_slot_state in input-mt.c
>> >>>> explains the reason:
>> >>>>
>> >>>> "* Reports a contact via ABS_MT_TRACKING_ID, and optionally
>> >>>>  * ABS_MT_TOOL_TYPE. If active is true and the slot is currently
>> >>>>  * inactive, or if the tool type is changed, a new tracking id is
>> >>>>  * assigned to the slot. The tool type is only reported if the
>> >>>>  * corresponding absbit field is set."
>> >>>>
>> >>>> MT_TOOL_TYPE is necessary if we report both pen and touch on the
>> >>same
>> >>>> interface. That is not true for this series of devices any more..
>> >>>>
>> >>>>
>> >>>> > >
>> >>>> > > Signed-off-by: Ping Cheng <pingc@wacom.com>
>> >>>> > > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
>> >>>> > > ---
>> >>>> > > v2: moved input_abs_set_res into a separate patch, as suggested
>> >>by
>> >>>> > > Dmitry.
>> >>>> > > ---
>> >>>> > >  drivers/input/touchscreen/wacom_w8001.c | 15 ++-------------
>> >>>> > >  1 file changed, 2 insertions(+), 13 deletions(-)
>> >>>> > >
>> >>>> > > diff --git a/drivers/input/touchscreen/wacom_w8001.c
>> >>>> > b/drivers/input/touchscreen/wacom_w8001.c
>> >>>> > > index 7e807af..541a8df 100644
>> >>>> > > --- a/drivers/input/touchscreen/wacom_w8001.c
>> >>>> > > +++ b/drivers/input/touchscreen/wacom_w8001.c
>> >>>> > > @@ -170,16 +170,8 @@ static void parse_multi_touch(struct w8001
>> >>*w8001)
>> >>>> > >               }
>> >>>> > >       }
>> >>>> > >
>> >>>> > > -     /* emulate single touch events when stylus is out of
>> >>proximity.
>> >>>> > > -      * This is to make single touch backward support
>> >>consistent
>> >>>> > > -      * across all Wacom single touch devices.
>> >>>> > > -      */
>> >>>> > > -     if (w8001->type != BTN_TOOL_PEN &&
>> >>>> > > -                         w8001->type != BTN_TOOL_RUBBER) {
>> >>>> > > -             w8001->type = count == 1 ? BTN_TOOL_FINGER :
>> >>KEY_RESERVED;
>> >>>> > > -             input_mt_report_pointer_emulation(dev, true);
>> >>>> > > -     }
>> >>>> > > -
>> >>>> > > +     w8001->type = KEY_RESERVED;
>> >>>> > > +     input_mt_sync_frame(dev);
>> >>>> > >       input_sync(dev);
>> >>>> > >  }
>> >>>> > >
>> >>>> > > @@ -508,7 +500,6 @@ static int w8001_setup_touch(struct w8001
>> >>*w8001,
>> >>>> > char *basename,
>> >>>> > >       case 5:
>> >>>> > >               w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
>> >>>> > >
>> >>>> > > -             __set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
>> >>>> >
>> >>>> > Who is setting this bit then?
>> >>>> >
>> >>>>
>> >>>> All MT related bits are set by input_mt_init_slots in input-mt.c,
>> >>including
>> >>>> BTN_TOOL_DOUBLETAP, if necessary.
>> >>>
>> >>> Doesn't this only happen if you call input_mt_init_slots with
>> >>> INPUT_MT_POINTER flag?
>> >>
>> >>You are right. And that is what we want this driver to do - to be in
>> >>sync with wacom.ko and rely on input-mt for common actions.
>> >
>> > But unless I missed some other patch from you this driver passes 0 as flags to input_mt_init_slots() and by removing the double-tap bit we are breaking the driver.
>>
>> Oh, I see where you are ;). I assumed INPUT_MT_DIRECT was there. My
>> bad eyes ;-)!  We'd be better to change
>>
>> input_mt_init_slots(dev, 2, 0);
>>
>> to
>>
>> input_mt_init_slots(dev, 2, INPUT_MT_DIRECT);
>>
>> Do you want me to submit a new version or can you update it locally?
>
> Ping,
>
> If you look at input_mt_init_slots() we only set the doubletap bit
> if we are using INPUT_MT_POINTER, but you are asking me to set
> INPUT_MT_DIRECT (which is correct property given that we are dealing
> with the touchscreen). Also, input_mt_sync_frame() passes use_count ==
> true to input_mt_report_pointer_emulation() (which would enable
> reporting of <n>-tap events) only if device has INPUT_MT_POINTER
> property.
>
> The while premise of this patch seems wrong. wacom.ko deals with
> tablets, wacom_w8001 is for a touchscreen. They behave differently.

I see your point and I understand your concern. But, wacom.ko also
supports touchscreen under USB connection. It supports display tablets
with touch as well, which are direct touch devices (in absolute
movement). Those two types of tablets are initialized with
INPUT_MT_DIRECT in wacom.ko.

There was a bit of history in the idea of only emulating pointer
events for INPUT_MT_POINTR. Those devices are in relative
movement/mode. When we started to support type B MT in kernel 2.6.38,
we treated both absolute and relative mode devices the same. That is,
both types of devices would report emulated pointer events. At that
time, most of the common code in input-mt.c now were in individual
drivers.

Later in kernel 3.7, when we tried to unify the common code, we
realized that direct touch should be treated differently. That's why
and when pointer emulation was disabled for direct touch.

However, not all drivers were updated to fully utilize the unified
routines. I submitted two patches [1] [2] in 2012 to bring wacom.ko in
sync with input-mt.c. By default, Henrik made the routine backward
compatible with 0 as the value for the new entry of
input_mt_init_slots. So, unless someone explicitly updated a driver,
the last entry of input_mt_init_slots would be 0, by default. That is
where wacom_w8001.c stays.

I would have kept wacom_w8001.c as is if it didn't have the real issue
in patch 1. Since I was on the page, it felt bad for not cleaning it
up (another OCD symptom ;-).

I am fine if we don't merge this patch.

Thank you.

Ping

[1] https://sourceforge.net/p/linuxwacom/input-wacom/ci/dff630c2ccb4a91bebbd8ddf181f8b549d63bccb/

[2] https://sourceforge.net/p/linuxwacom/input-wacom/ci/f1467294120ba8d0c10c2aa6d05272dfdbc1cef0/
