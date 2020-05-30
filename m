Return-Path: <SRS0=LIAa=7M=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB99DC433DF
	for <linux-input@archiver.kernel.org>; Sat, 30 May 2020 01:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A282077D
	for <linux-input@archiver.kernel.org>; Sat, 30 May 2020 01:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNc28tJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgE3BXG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 29 May 2020 21:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE3BXE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 29 May 2020 21:23:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80DC08C5CA
        for <linux-input@vger.kernel.org>; Fri, 29 May 2020 18:23:02 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c35so3105688edf.5
        for <linux-input@vger.kernel.org>; Fri, 29 May 2020 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjszT2JE6xMGIXm75nxby+Q8WfWVB5aq51B6VNJEz/M=;
        b=TNc28tJDwppaFCuyJp1+ty2uKeDrRPpf8C6ZqyG9itPq2QOwDnsXc+OfMFxW+JZCj3
         xE7HSv22wI3UD4ZvtUs+CWyPr4PBEnN8Yd4VIyFVsDT8fcJeEYzRkHT/m2qs9/UGNYUL
         9pGhZwE8B18KsdOaOni52XIoO7EMOpGQdlaSAXDDNOp8JJDsDYfKKMX7vx/18FkiRvdI
         43peBEDngxdpG4b9cByUtiZT6XM1tmsN9XrYfvct0sKSBNl7waHDx/F1Rmq/cFWLEZJ/
         uHQUFccP5gNwq2YUfkA3pjZVnW8lZSSYWgT6JJCtJ66cpLPYvH7Bb8FI/Ady5clHIVYK
         +RXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjszT2JE6xMGIXm75nxby+Q8WfWVB5aq51B6VNJEz/M=;
        b=LEMNo9VyF6CCzH1GZZ7VZKHytoqgFIqrzCt0+TYUXi2yg36YPzv5AGQiG0Rv1bMabS
         hzu54bt+yx5y1WiNID7wfJKevPFnIHJizoiA0si36dIDra0SLPofSxpFSEDj6rdT4hQI
         BVvgji+lAz4hNQRHbevd49tbJKdEH6XjKI/vfN7F9z4eDk6bnjuNEA0HKP95AKpFVksj
         yWq9HFtCq1NkbF+29l5OaheSVgZt3GFGppkNbw8KCM3dmrGM6aJLbdONW4LzzRBjodeA
         Fxm7pOsuo9XfkNj9gs9PK0sjtou5I+IG44RAV8cAR8Qjj4gVtJ9o3G3WgZ23P1jUXOr/
         V9rg==
X-Gm-Message-State: AOAM531r9b6DgXPJczTil44PHUyYLwE7w3LbVlqxqmUFG+OSgo87YCMQ
        p5AhHkYs6qM+kN4CvbMAVJV/e70mmVQy4ZlkiVo0fA==
X-Google-Smtp-Source: ABdhPJzP1HlJIj2RUeIOTEHyYDQpbUUV85l3JuWPg83HE74RfhFht73sFTEF53WG+P8ac8s27jdSoae8Cmvo9ahhjP8=
X-Received: by 2002:a50:ed0e:: with SMTP id j14mr11400971eds.52.1590801780783;
 Fri, 29 May 2020 18:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200529195951.GA3767@dtor-ws> <CANMq1KDDa8jGwo9BNneJ=8y1HunM9hiRS2c0i5ASJ6+X4qvodw@mail.gmail.com>
 <CABXOdTeTHUtWyutfQ3oO7c_g=q5GrDsdKZbSe1dwLWSeNFi-sQ@mail.gmail.com> <20200530010926.GM89269@dtor-ws>
In-Reply-To: <20200530010926.GM89269@dtor-ws>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 29 May 2020 18:22:49 -0700
Message-ID: <CABXOdTexbFqvHNALBeXrU5djbrLaK93fBTd6_rTCOhbEadYRgg@mail.gmail.com>
Subject: Re: [PATCH] HID: usbhid: do not sleep when opening device
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Guenter Roeck <groeck@chromium.org>, linux-usb@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Fri, May 29, 2020 at 6:09 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Fri, May 29, 2020 at 05:48:26PM -0700, Guenter Roeck wrote:
> > On Fri, May 29, 2020 at 4:50 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > On Sat, May 30, 2020 at 3:59 AM Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > usbhid tries to give the device 50 milliseconds to drain its queues
> > > > when opening the device, but does it naively by simply sleeping in open
> > > > handler, which slows down device probing (and thus may affect overall
> > > > boot time).
> > > >
> > > > However we do not need to sleep as we can instead mark a point of time
> > > > in the future when we should start processing the events.
> > > >
> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > >  drivers/hid/usbhid/hid-core.c | 27 +++++++++++++++------------
> > > >  drivers/hid/usbhid/usbhid.h   |  1 +
> > > >  2 files changed, 16 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > > > index c7bc9db5b192..e69992e945b2 100644
> > > > --- a/drivers/hid/usbhid/hid-core.c
> > > > +++ b/drivers/hid/usbhid/hid-core.c
> > > > @@ -95,6 +95,19 @@ static int hid_start_in(struct hid_device *hid)
> > > >                                 set_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> > > >                 } else {
> > > >                         clear_bit(HID_NO_BANDWIDTH, &usbhid->iofl);
> > > > +
> > > > +                       if (test_and_clear_bit(HID_RESUME_RUNNING,
> > > > +                                              &usbhid->iofl)) {
> > > > +                               /*
> > > > +                                * In case events are generated while nobody was
> > > > +                                * listening, some are released when the device
> > > > +                                * is re-opened. Wait 50 msec for the queue to
> > > > +                                * empty before allowing events to go through
> > > > +                                * hid.
> > > > +                                */
> > > > +                               usbhid->input_start_time = jiffies +
> > > > +                                                          msecs_to_jiffies(50);
> > > > +                       }
> > > >                 }
> > > >         }
> > > >         spin_unlock_irqrestore(&usbhid->lock, flags);
> > > > @@ -280,7 +293,8 @@ static void hid_irq_in(struct urb *urb)
> > > >                 if (!test_bit(HID_OPENED, &usbhid->iofl))
> > > >                         break;
> > > >                 usbhid_mark_busy(usbhid);
> > > > -               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
> > > > +               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl) &&
> > > > +                   time_after(jiffies, usbhid->input_start_time)) {
> > >
> > > Are we worried about jiffies overflowing (32-bit@1000Hz is "only" 49.7 days...)
> > >
> >
> > time_after() is overflow-safe. That is why it is used and jiffies is
> > not compared directly.
>
> Well, it is overflow safe, but still can not measure more than 50 days,
> so if you have a device open for 50+ days there will be a 50msec gap
> where it may lose events.
>

Or you could explicitly use 64-bit jiffies.

Guenter

> I guess we can switch to ktime(). A bit more expensive on 32 bits, but
> in reality I do not think anyone would care.
>
> Thanks.
>
> --
> Dmitry
