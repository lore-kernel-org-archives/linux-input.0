From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom_w8001 - drop use of ABS_MT_TOOL_TYPE
Date: Wed, 13 Jul 2016 17:22:30 -0700
Message-ID: <CAF8JNhJb4pxLjkdH7_X+AKTkBVtUD1Fbe9v_C2=q_sHptrvZgQ@mail.gmail.com>
References: <20160111035151.GA24743@jelly.redhat.com> <20160111081233.GA27512@dtor-ws>
 <CAKdAkRRtYyd37_-5LiVCBX=ajWF9O+hupk=4uw6Juc7LQxNdsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:32936 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbcGNAWu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 20:22:50 -0400
Received: by mail-it0-f68.google.com with SMTP id d65so3840466ith.0
        for <linux-input@vger.kernel.org>; Wed, 13 Jul 2016 17:22:50 -0700 (PDT)
In-Reply-To: <CAKdAkRRtYyd37_-5LiVCBX=ajWF9O+hupk=4uw6Juc7LQxNdsQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>

On Wednesday, July 13, 2016, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Mon, Jan 11, 2016 at 12:12 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Jan 11, 2016 at 01:51:51PM +1000, Peter Hutterer wrote:
> >> As of e0361b70175f0cd6199dd9ed6679632de73973d4
> >>   Input: wacom_w8001 - split the touch and pen devices into two devices
> >> the touch events aren't multiplexed over the same device anymore, the use of
> >> ABS_MT_TOOL_TYPE is superfluous. And even before then it only ever sent
> >> MT_TOOL_TYPE_FINGER anyway.
> >>
> >> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> >
> > Applied, thank you.
>
> Hmm, so I applied that but removal of input_mt_report_slot_state()
> means that we do not generate tacking IDs for the contacts.

You are right. I have a set of patches to clean up the code. It is
still under testing/reviewing...

>
> Revert?

It may be quicker to revert this one now. I'll submit the clean up set later.

Thanks,

Ping

>
> >
> >> ---
> >>  drivers/input/touchscreen/wacom_w8001.c | 3 ---
> >>  1 file changed, 3 deletions(-)
> >>
> >> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> >> index fe983e7..bab3c6a 100644
> >> --- a/drivers/input/touchscreen/wacom_w8001.c
> >> +++ b/drivers/input/touchscreen/wacom_w8001.c
> >> @@ -155,7 +155,6 @@ static void parse_multi_touch(struct w8001 *w8001)
> >>               bool touch = data[0] & (1 << i);
> >>
> >>               input_mt_slot(dev, i);
> >> -             input_mt_report_slot_state(dev, MT_TOOL_FINGER, touch);
> >>               if (touch) {
> >>                       x = (data[6 * i + 1] << 7) | data[6 * i + 2];
> >>                       y = (data[6 * i + 3] << 7) | data[6 * i + 4];
> >> @@ -514,8 +513,6 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
> >>                                       0, touch.x, 0, 0);
> >>               input_set_abs_params(dev, ABS_MT_POSITION_Y,
> >>                                       0, touch.y, 0, 0);
> >> -             input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
> >> -                                     0, MT_TOOL_MAX, 0, 0);
> >>
> >>               strlcat(basename, " 2FG", basename_sz);
> >>               if (w8001->max_pen_x && w8001->max_pen_y)
> >> --
> >> 2.5.0
> >>
> >
> > --
> > Dmitry
>
>
>
> --
> Dmitry
