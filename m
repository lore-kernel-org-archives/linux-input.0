From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Do not add SYN_REPORT in between a single packet
 data
Date: Fri, 1 Apr 2016 14:51:28 -0700
Message-ID: <20160401215128.GA5216@dtor-ws>
References: <1457372672-884-1-git-send-email-a.mathur@samsung.com>
 <CAKdAkRQT0R6peS8iO8PhQ4YoPMowt6voZJez4EubK7R0ZV_m4Q@mail.gmail.com>
 <56E17A73.8090901@bitmath.org>
 <CADYu30-b+5TFh2yy2SrGTJJ7FzvcezWut1XL3Ypno5R29hyYww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34566 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbcDAVve (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Apr 2016 17:51:34 -0400
Content-Disposition: inline
In-Reply-To: <CADYu30-b+5TFh2yy2SrGTJJ7FzvcezWut1XL3Ypno5R29hyYww@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Aniroop Mathur <a.mathur@samsung.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

On Fri, Mar 11, 2016 at 12:26:57AM +0530, Aniroop Mathur wrote:
> Hi Henrik,
> 
> On Thu, Mar 10, 2016 at 7:15 PM, Henrik Rydberg <rydberg@bitmath.org> wrote:
> > Hi Dmitry,
> >
> >>> diff --git a/drivers/input/input.c b/drivers/input/input.c
> >>> index 8806059..262ef77 100644
> >>> --- a/drivers/input/input.c
> >>> +++ b/drivers/input/input.c
> >>> @@ -401,8 +401,7 @@ static void input_handle_event(struct input_dev *dev,
> >>>                 if (dev->num_vals >= 2)
> >>>                         input_pass_values(dev, dev->vals, dev->num_vals);
> >>>                 dev->num_vals = 0;
> >>> -       } else if (dev->num_vals >= dev->max_vals - 2) {
> >>> -               dev->vals[dev->num_vals++] = input_value_sync;
> >>> +       } else if (dev->num_vals >= dev->max_vals - 1) {
> >>>                 input_pass_values(dev, dev->vals, dev->num_vals);
> >>>                 dev->num_vals = 0;
> >>>         }
> >>
> >> This makes sense to me. Henrik?
> >
> > I went through the commits that made these changes, and I cannot see any strong
> > reason to keep it. However, this code path only triggers if no SYN events are
> > seen, as in a driver that fails to emit them and consequently fills up the
> > buffer. In other words, this change would only affect a device that is already,
> > to some degree, broken.
> >
> > So, the question to Aniroop is: do you see this problem in practise, and in that
> > case, for what driver?
> >
> 
> Nope. So far I have not dealt with any such driver.
> I made this change because it is breaking protocol of SYN_REPORT event code.
> 
> Further from the code, I could deduce that max_vals is just an estimation of
> packet_size and it does not guarantee that packet_size is same as max_vals.
> So real packet_size can be more than max_vals value and hence we could not
> insert SYN_REPORT until packet ends really.
> Further, if we consider that there exists a driver or will exist in future
> which sets capability of x event code according to which max_value comes out to
> y and the real packet size is z i.e. driver wants to send same event codes
> again in the same packet, so input event reader would be expecting SYN_REPORT
> after z events but due to current code SYN_REPORT will get inserted
> automatically after y events, which is a wrong behaviour.

Well, I think I agree with Aniroop that even if driver is to a degree
broken we should not be inserting random SYN_REPORT events into the
stream. I wonder if we should not add WARN_ONCE() there to highlight
potential problems with the way we estimate the number of events.

However I think there is an issue with the patch. If we happen to pass
values just before the final SYN_REPORT sent by the driver then we reset
dev->num_vals to 0 and will essentially suppress the final SYN_REPORT
event, which is not good either.

Thanks.

-- 
Dmitry
