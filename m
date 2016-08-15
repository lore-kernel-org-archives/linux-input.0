From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 5/7] iio: hid-sensors: use asynchronous resume
Date: Mon, 15 Aug 2016 10:53:20 -0700
Message-ID: <20160815175320.GA23694@dtor-ws>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <alpine.LNX.2.00.1608071214500.22028@cbobk.fhfr.pm>
 <884e74df-569e-8218-fbda-f9c7ecfe1e5a@kernel.org>
 <af2d1c90-a0ec-0888-8048-76463bf98ece@kernel.org>
 <CAKdAkRS-sVHqQ1tUZWVxNTfX5=ZxFzbCAxvsJPHV4=85mdEeRA@mail.gmail.com>
 <1471279360.20508.20.camel@linux.intel.com>
 <CAKdAkRRjh+21qOzq28=vSX59RcZsMOAt3pTUhjw4wXdpXXQg-w@mail.gmail.com>
 <1471282163.20508.21.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34248 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbcHORxZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2016 13:53:25 -0400
Content-Disposition: inline
In-Reply-To: <1471282163.20508.21.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org

On Mon, Aug 15, 2016 at 10:29:23AM -0700, Srinivas Pandruvada wrote:
> On Mon, 2016-08-15 at 10:14 -0700, Dmitry Torokhov wrote:
> > On Mon, Aug 15, 2016 at 9:42 AM, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > > 
> > > On Mon, 2016-08-15 at 08:45 -0700, Dmitry Torokhov wrote:
> > > > 
> > > > On Mon, Aug 15, 2016 at 7:52 AM, Jonathan Cameron <jic23@kernel.o
> > > > rg>
> > > > wrote:
> > > > > 
> > > > > 
> > > > > On 15/08/16 15:07, Jonathan Cameron wrote:
> > > > > > 
> > > > > > 
> > > > > > On 07/08/16 11:15, Jiri Kosina wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On Sun, 7 Aug 2016, Srinivas Pandruvada wrote:
> > > > > > > 
> > > > > > > > 
> > > > > > > > 
> > > > > > > > Some platforms power off sensor hubs during S3 suspend,
> > > > > > > > which
> > > > > > > > will require
> > > > > > > > longer time to resume. This hurts system resume time, so
> > > > > > > > resume
> > > > > > > > asynchronously.
> > > > > > > > 
> > > > > > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@l
> > > > > > > > inux
> > > > > > > > .intel.com>
> > > > > > > Jonathan, are you going to cherry-pick this patch from the
> > > > > > > series?
> > > > > > > Alternatively, if you're okay with it, I can pull it in
> > > > > > > together with the
> > > > > > > whole set with your Acked-by or Reviewed-by.
> > > > > > > 
> > > > > > I'll take it via IIO. Got a bit of catching up to do (been on
> > > > > > holiday)
> > > > > Applied to the togreg branch of iio.git - initially pushed out
> > > > > as
> > > > > testing for the autobuilders to play with it.
> > > > > This one is not really connected to the others so makes sense
> > > > > to
> > > > > take it separately.
> > > > > 
> > > > > I'm out of my depth on the rest of the patches in this series
> > > > > and don't have time to learn enough to follow them! Sorry I
> > > > > can't help on that front.
> > > > About this patch: me sees a new work, me does not see new calls
> > > > to
> > > > cancel_work_sync() or flush_work() anywhere, me gets worried.
> > > This work is scheduled during resume and is not delayed call. Only
> > > time
> > > really we need to cancel or flush if module is unloaded before
> > > resume
> > > work, not sure if this case realistic. Do you see any other case
> > > possible?
> > Runtime resume can happen at any time, I can unload module or unbind
> > it at any time. I also wasn't aware that our implementation goal for
> > locking rules/lifetime rules/etc was "realistic" instead of
> > "correct".
> This is not for runtime_resume, this is for regular S3 suspend. But I
> agree, I will submit a patch for correctness.

Thinking about it some more: if you are off-loading powering up the hub
to work structure it means that the hub is not actually powered up when
the rest of the system thinks it is, which may cause subsequent requests
to it fail.

You need to make sure noone is actually interacting with the device
until you are done powering it up.

Thanks.

-- 
Dmitry
