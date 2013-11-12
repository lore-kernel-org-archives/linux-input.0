From: Ping Cheng <pinglinux@gmail.com>
Subject: Fwd: [PATCH v2 2/2] Input: wacom - add support for three new Intuos devices
Date: Tue, 12 Nov 2013 09:29:39 -0800
Message-ID: <CAF8JNhKSd7CEASKPSh7VcS1eH0ROJ-YK8HTu9oncKwcvT74wwA@mail.gmail.com>
References: <1381439866-1161-1-git-send-email-pingc@wacom.com>
	<CAGzDe_a_VF7697u66LsWoV+C6+VLRzQJ8FWnct9SGK6DQurULQ@mail.gmail.com>
	<CAF8JNh+Vh3FswdDYPffi603iJmnnSgQDtfiJVfP=mqCqTW8dXQ@mail.gmail.com>
	<CAGzDe_ZFYV1RmzB=5fBLts0vJmjQ1-W0X-nz9Yt7S6g_zHfBsw@mail.gmail.com>
	<CAF8JNhJb8oT9ZKD+QL1sYpJWGC9=JMMogxnK5cToWD9KK9MVdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:55887 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592Ab3KLR3l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Nov 2013 12:29:41 -0500
Received: by mail-la0-f46.google.com with SMTP id eh20so103167lab.5
        for <linux-input@vger.kernel.org>; Tue, 12 Nov 2013 09:29:39 -0800 (PST)
In-Reply-To: <CAF8JNhJb8oT9ZKD+QL1sYpJWGC9=JMMogxnK5cToWD9KK9MVdg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

On Monday, November 11, 2013, Chris Bagwell wrote:
>
> On Fri, Nov 8, 2013 at 1:13 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > On Thu, Nov 7, 2013 at 6:25 PM, Chris Bagwell <chris@cnpbagwell.com> wrote:
> >> On Thu, Oct 10, 2013 at 4:17 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> >>> This series of models added a hardware switch to turn touch
> >>> data on/off. To report the state of the switch, SW_TOUCH
> >>> is added in include/uapi/linux/input.h.
> >>
> >> So I guess the big point is this patch can't go in until a SW_TOUCH
> >> goes in first.
> >>
> >> Since the 1/2 or this 2/2 series has already gone in, would you mind
> >> breaking this
> >> remaining patch up into the basic support for new Intuos (without the
> >> SW_TOUCH) and
> >> then a separate patch to add SW_TOUCH support on top of that?  Then
> >> the basic support can go in ASAP.
> >
> > Chris, thank you for pushing the process forward.
> >
> > SW_TOUCH is truly part of the basic support for the new series. The
> > main new feature of this series is touch switch. If we do not report
> > its status in the same patch, it means we are not reporting a complete
> > set of data.
> >
> >> I only have comments on this patch related to the SW_TOUCH part... things like:
> >>
> >>  * should the SW_TOUCH be reported against the wireless interface or
> >> the touch interface... userland apps may have an opinion on which is
> >> best.
> >
> > We can not report SW_TOUCH status from touch interface since once
> > touch is turned off (by end users), no events can go on touch
> > interface. Plus, we do not know when a user may switch touch on.
> > That's why SW_TOUCH are regularly updated and reported through
> > wireless interface for wireless connection.
>
> I think I made wrong assumption of HW.  Does HW stop sending touch
> events when switch is toggled or is switch an indication to ignore
> touch events in either driver or userland?

Yes, tablet stops sending touch events when user turns touch off by
the hardware. It's a hardware switch, as stated in commit comments,
which is controlled by end users. Drivers can not do much about it
except reporting its status.

> I was thinking it was for later case.  When userland has to ignore, it
> is not easy to know switch value on /dev/input/foo really means what
> to do related to events on /dev/input/bar.  So thats were my thoughts
> were about moving it to input that needs to be disabled.  In former
> case, it just status so not so important to decide which input to
> report over.

It is the former case.

> >>  * the part with updating SW_TOUCH from unrelated interfaces could use
> >
> > It is not unrelated interface. It is how it works.
> >
> >> a review by someone like Dmitry for possible issues.
>
> I meant any issues with parsing data in context of /dev/input/foo but
> doing an input_sync(/dev/input/bar) in that same context.  Probably no
> issue but I don't know kernel internals to be sure.

Anyway, I'll split the patch for you. Thank you for reviewing it.

Ping

> >>  * It would be better if you didn't add that EV_SW for HW that will
> >> not report the SW_TOUCH.
> >
> > I can consider that in the next version.
> >
> >> If you break the patch into 2, you can add my line for the basic
> >
> > I'd like to know your opinion about my comments before updating the
> > patch. IMO, using two patches to process one set of raw data
> > complicates the support.
>
> Assuming SW_TOUCH for this device is only for status reporting, I
> don't have much opinion.  If it because a request to disable touch
> events in userland then I think it should move to device its related
> to.
>
> Chris
>
> >
> > Ping
> >
> >> support without SW_TOUCH:
> >>
> >> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
> >>
> >> Chris
> >>
> >>>
> >>> The driver is also updated to process wireless devices that do
> >>> not support touch interface.
> >>>
> >>> Tested-by: Jason Gerecke <killertofu@gmail.com>
> >>> Signed-off-by: Ping Cheng <pingc@wacom.com>
> >>> ---
> >>> v2: Change SW_TOUCH_ENABLED to SW_TOUCH and clear BTN_TOUCH bit
> >>> for button only interfaces as suggested by Peter Hutterer.
> >>> ---
> >>>  drivers/input/tablet/wacom_sys.c | 16 +++++++-
> >>>  drivers/input/tablet/wacom_wac.c | 87 ++++++++++++++++++++++++++++++++--------
> >>>  drivers/input/tablet/wacom_wac.h |  7 ++++
> >>>  include/uapi/linux/input.h       |  1 +
> >>>  4 files changed, 93 insertions(+), 18 deletions(-)
> >>>
> >>> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> >>> index 7bdb5e9..efd9729 100644
> >>> --- a/drivers/input/tablet/wacom_sys.c
> >>> +++ b/drivers/input/tablet/wacom_sys.c
> >>> @@ -1190,12 +1190,15 @@ static void wacom_wireless_work(struct work_struct *work)
> >>>                 wacom_wac1->features.device_type = BTN_TOOL_PEN;
> >>>                 snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
> >>>                          wacom_wac1->features.name);
> >>> +               wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
> >>> +               wacom_wac1->shared->type = wacom_wac1->features.type;
> >>>                 error = wacom_register_input(wacom1);
> >>>                 if (error)
> >>>                         goto fail;
> >>>
> >>>                 /* Touch interface */
> >>> -               if (wacom_wac1->features.touch_max) {
> >>> +               if (wacom_wac1->features.touch_max ||
> >>> +                   wacom_wac1->features.type == INTUOS_HT) {
> >>>                         wacom_wac2->features =
> >>>                                 *((struct wacom_features *)id->driver_info);
> >>>                         wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
> >>> @@ -1210,6 +1213,10 @@ static void wacom_wireless_work(struct work_struct *work)
> >>>                         error = wacom_register_input(wacom2);
> >>>                         if (error)
> >>>                                 goto fail;
> >>> +
> >>> +                       if (wacom_wac1->features.type == INTUOS_HT &&
> >>> +                           wacom_wac1->features.touch_max)
> >>> +                               wacom_wac->shared->touch_input = wacom_wac2->input;
> >>>                 }
> >>>
> >>>                 error = wacom_initialize_battery(wacom);
> >>> @@ -1318,7 +1325,7 @@ static int wac
