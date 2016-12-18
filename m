From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mouse: synaptics - change msleep to usleep_range
 for small msecs
Date: Sun, 18 Dec 2016 15:30:01 -0800
Message-ID: <20161218233001.GB31941@dtor-ws>
References: <1480362924-5224-1-git-send-email-a.mathur@samsung.com>
 <CAOXgUe0FPkByE-0piMeNLaU3iTd_k0Nj_pZzEU4pv_9WzBzt1w@mail.gmail.com>
 <bd65a3e5-8178-cfc9-2d29-c86b7e300297@compulab.co.il>
 <CADYu309AF_NK4jmo5fqYF843vtQ9oKHjaM2uE96nXO38G8LZ5g@mail.gmail.com>
 <f9eebdf0-547e-533a-c7f4-4746c9bfc379@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34622 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbcLRXaE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Dec 2016 18:30:04 -0500
Content-Disposition: inline
In-Reply-To: <f9eebdf0-547e-533a-c7f4-4746c9bfc379@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Aniroop Mathur <aniroop.mathur@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, SAMUEL SEQUEIRA <s.samuel@samsung.com>, Rahul Mahale <r.mahale@samsung.com>, Aniroop Mathur <a.mathur@samsung.com>

On Sun, Dec 18, 2016 at 09:35:48AM +0200, Igor Grinberg wrote:
> Hi Aniroop Mathur,
> 
> 
> On 12/04/16 15:05, Aniroop Mathur wrote:
> > Hello Mr. Igor Grinberg
> > 
> > On Sun, Dec 4, 2016 at 1:32 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> >> Hi Aniroop Mathur,
> >>
> >> On 11/29/16 23:02, Aniroop Mathur wrote:
> >>> Dear Mike Rapoport, Igor Grinberg,
> >>> Greetings!
> >>>
> >>> I am Aniroop Mathur from Samsung R&D Institute, India.
> >>>
> >>> I have submitted one patch as below for review to Linux Open Source.
> >>> The problem is that we do not have the hardware available with us to
> >>> test it and we would like to test it before actually applying it.
> >>> As you are the author of this driver, I am contacting you to request you
> >>> provide your feedback upon this patch.
> >>>
> >>> Also if you have the hardware available, could you please help to
> >>> test this patch on your hardware? or could you provide contact points
> >>> of individuals who could support to test it?
> >>
> >> This touchpad and the driver was used on an old PXA270 based PDA.
> >> I currently don't have those at hand to test the patch.
> >>
> >>>
> >>> Thank you!
> >>>
> >>> BR,
> >>> Aniroop Mathur
> >>>
> >>> On Tue, Nov 29, 2016 at 1:25 AM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> >>>> msleep(1~20) may not do what the caller intends, and will often sleep longer.
> >>>> (~20 ms actual sleep for any value given in the 1~20ms range)
> >>
> >> Well, it should be at least 1ms as stated in my comment just before the define.
> >> So, from the correctness perspective larger values will also do the job.
> >> Additionally, since I've taken a spare 2ms, and you are making it even more
> >> precise (3000us + 100us) - it will still do the job and stay correct.
> >> So, there should be no issue from correctness POV.
> >>
> > 
> > Alright, Thanks!
> > 
> >>>> This is not the desired behaviour for many cases like device resume time,
> >>>> device suspend time, device enable time, retry logic, etc.
> >>>> Thus, change msleep to usleep_range for precise wakeups.
> >>
> >> This is a human interface touchpad device, even having 20ms soft reset
> >> sleep time will not impact the responsiveness for humans.
> >> IMHO, there is no need for precise wakeups for this device, so I wouldn't
> >> bother.
> >>
> > 
> > Well, from the point of view of device working and responsiveness for "humans",
> > I agree that it is okay to sleep for 20 / 40 ms or even 100 ms. However, this
> > patch is not trying to solve any such issues. This patch is only trying to make
> > the process sleep for appropriate time as mentioned in the parameter and does
> > not cause any harm here. I could see that this function is called during device
> > resume and device probe time. So this change will improve the resume and probe
> > time for this device and doing the same change in other drivers will
> > contribute to
> > improvement in overall kernel resume and boot time a little bit so response time
> > increases a little bit. Plus, it is recommended and mentioned in kernel
> > documentation to use usleep_range for delays between 1-10 ms.
> > So usleep_range should serve better here.
> > Explained originally here to why not use msleep for 1 - 20 ms:
> > http://lkml.org/lkml/2007/8/3/250
> 
> I have absolutely 0 objections to this.
> So, as I already have said, it will be hard for me to test it currently, but
> if you want it and Dmitry wants to apply it, my ack is below.

OK, it does not matter much either way, but let's apply it.

> 
> >>>>
> >>>> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks.

-- 
Dmitry
